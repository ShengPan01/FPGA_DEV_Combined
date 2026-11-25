#!/usr/bin/env python3
"""Sign padded IMEM || DRAM with a fresh, single-use LMS SHA256/192 key."""
import argparse
import hashlib
import json
from pathlib import Path
import secrets
import struct
import sys

sys.path.insert(0, str(Path(__file__).resolve().parents[1] / 'tools'))
from flash_upload import prepare, record

IMEM = 0x1000
DRAM = 0x7ff80000
IMEM_SIZE = 128 * 1024
DRAM_SIZE = 16 * 1024
FLASH_DRAM = IMEM + IMEM_SIZE
FLASH_SIGNATURE = FLASH_DRAM + DRAM_SIZE
CERT_SIZE = 4 * 1024


def u32(x):
    return struct.pack('>I', x)


def h24(data):
    return hashlib.sha256(data).digest()[:24]


def padded_image(path):
    commands, _ = prepare(path)
    image = bytearray(b'\xff' * (IMEM_SIZE + DRAM_SIZE))
    upper = 0
    used = [0, 0]
    for line in commands:
        b = bytes.fromhex(line[1:])
        if b[3] == 4:
            upper = int.from_bytes(b[4:6], 'big') << 16
        elif b[3] == 0:
            start = upper + int.from_bytes(b[1:3], 'big')
            end = start + b[0]
            if IMEM <= start < end <= IMEM + IMEM_SIZE:
                offset, region = start - IMEM, 0
            elif DRAM <= start < end <= DRAM + DRAM_SIZE:
                offset, region = IMEM_SIZE + start - DRAM, 1
            else:
                raise ValueError(f'Input outside IMEM 128 KiB / CPU DRAM 16 KiB: {start:#x}')
            image[offset:offset + b[0]] = b[4:-1]
            used[region] += b[0]
    if not used[0]:
        raise ValueError('Input contains no IMEM data')
    return bytes(image), used


def sign(message, height=5, w=4):
    """RFC 8554 / RFC 9858; discard fresh seed after signing leaf q=0."""
    p, ls, ots_type = {1: (200, 8, 5), 2: (101, 6, 6),
                       4: (51, 4, 7), 8: (26, 0, 8)}[w]
    lms_type = 9 + height // 5
    identifier, seed, c = secrets.token_bytes(16), secrets.token_bytes(24), secrets.token_bytes(24)
    maximum = (1 << w) - 1

    def prefix(q):
        return identifier + u32(q)

    def private(q, i):
        return h24(prefix(q) + struct.pack('>H', i) + b'\xff' + seed)

    def chain(q, i, x, start, stop):
        base = prefix(q) + struct.pack('>H', i)
        for j in range(start, stop):
            x = h24(base + bytes([j]) + x)
        return x

    def coef(a, i):
        return (a[i * w // 8] >> (8 - w - i * w % 8)) & maximum

    tree = [b''] * (2 << height)
    for q in range(1 << height):
        k = h24(prefix(q) + b'\x80\x80' + b''.join(
            chain(q, i, private(q, i), 0, maximum) for i in range(p)))
        r = (1 << height) + q
        tree[r] = h24(prefix(r) + b'\x82\x82' + k)
    for r in range((1 << height) - 1, 0, -1):
        tree[r] = h24(prefix(r) + b'\x83\x83' + tree[2*r] + tree[2*r+1])
    digest = h24(prefix(0) + b'\x81\x81' + c + message)
    checksum = sum(maximum - coef(digest, i) for i in range(192 // w)) << ls
    a = digest + struct.pack('>H', checksum)
    signature = u32(0) + u32(ots_type) + c + b''.join(
        chain(0, i, private(0, i), 0, coef(a, i)) for i in range(p)) + u32(lms_type)
    r = 1 << height
    for _ in range(height):
        signature += tree[r ^ 1]
        r >>= 1
    public = u32(lms_type) + u32(ots_type) + identifier + tree[1]
    return public, signature


def write_ihex(path, payload):
    lines = []
    current_upper = None
    for offset in range(0, len(payload), 32):
        address = IMEM + offset
        upper = address >> 16
        if upper != current_upper:
            lines.append(record(0, 4, upper.to_bytes(2, 'big')))
            current_upper = upper
        lines.append(record(address & 65535, 0, payload[offset:offset+32]))
    lines.append(record(0, 1, b''))
    path.write_text('\n'.join(lines) + '\n', encoding='ascii')


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('input', nargs='?', type=Path,
                        default=Path(__file__).resolve().parents[1] / 'output/test.ihex')
    parser.add_argument('--height', type=int, choices=(5, 10), default=5)
    parser.add_argument('--w', type=int, choices=(1, 2, 4, 8), default=4)
    args = parser.parse_args()
    p = {1: 200, 2: 101, 4: 51, 8: 26}[args.w]
    if 12 + 24 * (1 + p + args.height) > CERT_SIZE:
        parser.error('Signature exceeds 4 KiB certificate region; choose W2/W4/W8')
    message, used = padded_image(args.input)
    public, signature = sign(message, args.height, args.w)
    output = args.input.with_name(args.input.stem + '_signed.ihex')
    if len(signature) > CERT_SIZE:
        raise ValueError('Signature exceeds 4 KiB certificate region')
    base = output.with_suffix('')
    write_ihex(output, message + signature + b'\xff' * (CERT_SIZE - len(signature)))
    base.with_suffix('.pub.bin').write_bytes(public)
    base.with_suffix('.sig.bin').write_bytes(signature)
    header = ('/* Raw LMS public key; provision this through a trusted channel. */\n'
              '#ifndef TEST_SIGNED_LMS_PUBLIC_H\n#define TEST_SIGNED_LMS_PUBLIC_H\n'
              'static const unsigned char test_signed_lms_public[48] = {\n    ' +
              ', '.join(f'0x{x:02x}' for x in public) + '\n};\n#endif\n')
    base.with_suffix('.pub.h').write_text(header, encoding='ascii')
    metadata = dict(hash='SHA-256/192', h=args.height, w=args.w, n=24,
                    lms_type=int.from_bytes(public[:4], 'big'),
                    lmots_type=int.from_bytes(public[4:8], 'big'), q=0,
                    key_policy='fresh key per invocation; seed discarded; no key reuse',
                    public_key_hex=public.hex(), identifier_hex=public[8:24].hex(),
                    root_hex=public[24:].hex(), signature_bytes=len(signature),
                    imem_flash_address=IMEM, imem_bytes=IMEM_SIZE,
                    dram_cpu_address=DRAM, dram_flash_address=FLASH_DRAM,
                    dram_bytes=DRAM_SIZE, signature_flash_address=FLASH_SIGNATURE,
                    certificate_bytes=CERT_SIZE, certificate_format='raw LMS signature followed by FF padding',
                    input_imem_bytes=used[0], input_dram_bytes=used[1], padding_byte=255,
                    signed_message='padded IMEM || padded DRAM (raw bytes, no prehash)',
                    message_sha256=hashlib.sha256(message).hexdigest(),
                    source_sha256=hashlib.sha256(args.input.read_bytes()).hexdigest())
    base.with_suffix('.lms.json').write_text(json.dumps(metadata, indent=2) + '\n', encoding='ascii')
    print(f'{output}: {len(message)} signed bytes, {len(signature)} signature bytes at {FLASH_SIGNATURE:#x}')


if __name__ == '__main__':
    main()
