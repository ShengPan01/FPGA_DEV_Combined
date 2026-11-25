#!/usr/bin/env python3
# -*- coding: utf-8 -*-
#
# Copyright (c) 2026 . All rights reserved.
#
# Unauthorized copying, modification, distribution, or use
# of this software is prohibited without prior written
# permission from the copyright owner.
#
# Author      : Sheng Pan
# Created     : 2026-11-11
# Description : Python script description
#

"""Validate Intel HEX and emit absolute-address byte pairs for tb_firmware."""
import argparse
from pathlib import Path

def convert(source):
    memory = {}
    base = 0
    eof = False
    for number, line in enumerate(source.splitlines(), 1):
        line = line.strip()
        if not line:
            continue
        if eof:
            raise ValueError(f"line {number}: data after EOF")
        if not line.startswith(":"):
            raise ValueError(f"line {number}: missing colon")
        raw = bytes.fromhex(line[1:])
        if len(raw) < 5 or len(raw) != raw[0] + 5 or sum(raw) & 255:
            raise ValueError(f"line {number}: invalid length/checksum")
        count, offset, kind = raw[0], int.from_bytes(raw[1:3], "big"), raw[3]
        data = raw[4:-1]
        if kind == 0:
            if offset + count > 0x10000:
                raise ValueError(f"line {number}: record crosses segment")
            for i, byte in enumerate(data):
                address = base + offset + i
                if not (0x1000 <= address <= 0x20fff or 0x7ff80000 <= address <= 0x7ff9ffff):
                    raise ValueError(f"line {number}: address {address:08x} outside RAM")
                if address in memory:
                    raise ValueError(f"line {number}: overlapping address {address:08x}")
                memory[address] = byte
        elif kind == 1 and count == 0 and offset == 0:
            eof = True
        elif kind in (2, 4) and count == 2 and offset == 0:
            base = int.from_bytes(data, "big") << (4 if kind == 2 else 16)
        elif kind in (3, 5) and count == 4 and offset == 0:
            pass  # Entry metadata; hardware reset vector is fixed at 0x1000.
        else:
            raise ValueError(f"line {number}: unsupported/malformed record type {kind}")
    if not eof or not all(a in memory for a in range(0x1000, 0x1004)):
        raise ValueError("missing EOF or reset-vector instruction")
    return "".join(f"{a:08x} {v:02x}\n" for a, v in sorted(memory.items()))

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("input", type=Path)
    parser.add_argument("output", type=Path)
    args = parser.parse_args()
    try:
        result = convert(args.input.read_text())
    except ValueError as error:
        parser.exit(1, f"Invalid firmware: {error}\n")
    args.output.write_text(result)
    print(f"Converted {len(result.splitlines())} bytes to {args.output}")
