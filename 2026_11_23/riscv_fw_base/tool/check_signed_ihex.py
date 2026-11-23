#!/usr/bin/env python3
"""Host integration check using the firmware's actual C LMS verifier.

First compile:
gcc -shared -fPIC -O2 -Iinc/lms source/lms/{lms,sha256,endian}.c -o /tmp/fw_lms_verify.so
Then run from the firmware directory: python3 tool/check_signed_ihex.py
"""
import ctypes
import json
from pathlib import Path
import sys
import tempfile

from sign_ihex import padded_image, prepare, sign, IMEM, FLASH_SIGNATURE, CERT_SIZE
from flash_upload import record


def main():
    root = Path(__file__).resolve().parents[1]
    library = ctypes.CDLL(sys.argv[1] if len(sys.argv) > 1 else '/tmp/fw_lms_verify.so')
    verify = library.lms_verify
    verify.argtypes = [ctypes.c_char_p, ctypes.c_size_t, ctypes.c_char_p,
                       ctypes.c_size_t, ctypes.c_char_p, ctypes.c_size_t]
    verify.restype = ctypes.c_int
    message, used = padded_image(root / 'output/test.ihex')
    base = root / 'output/test_signed'
    public = base.with_suffix('.pub.bin').read_bytes()
    signature = base.with_suffix('.sig.bin').read_bytes()
    assert verify(public, len(public), message, len(message), signature, len(signature)) == 1
    changed = bytes([message[0] ^ 1]) + message[1:]
    assert verify(public, len(public), changed, len(changed), signature, len(signature)) == 0
    assert verify(public, len(public), message, len(message), signature[:-1], len(signature)-1) == 0
    wrong_public = public[:-1] + bytes([public[-1] ^ 1])
    assert verify(wrong_public, 48, message, len(message), signature, len(signature)) == 0
    commands, size = prepare(base.with_suffix('.ihex'))
    actual = {}
    upper = 0
    for line in commands:
        b = bytes.fromhex(line[1:])
        if b[3] == 4:
            upper = int.from_bytes(b[4:6], 'big') << 16
        elif b[3] == 0:
            start = upper + int.from_bytes(b[1:3], 'big')
            actual.update((start+i, value) for i, value in enumerate(b[4:-1]))
    assert size == len(message) + CERT_SIZE
    assert sorted(actual) == list(range(IMEM, IMEM+size))
    assert bytes(actual[a] for a in range(IMEM, IMEM+size)) == message + signature + b'\xff' * (CERT_SIZE-len(signature))
    assert FLASH_SIGNATURE == IMEM + len(message)
    meta = json.loads(base.with_suffix('.lms.json').read_text())
    assert meta['public_key_hex'] == public.hex()
    assert meta['signature_bytes'] == len(signature)
    # Check both edges of the reserved regions before any UART erase is sent.
    with tempfile.TemporaryDirectory(prefix='flash-address-test-') as directory:
        path = Path(directory) / 'boundary.ihex'
        for address, valid in ((0xfff, False), (0x1000, True),
                               (0x20fff, True), (0x21000, True),
                               (0x24fff, True), (0x25000, True),
                               (0x25fff, True), (0x26000, True),
                               (0x2602f, True), (0x26030, False), (0x27000, False),
                               (0x3fffff, False), (0x7ff80000, True),
                               (0x7ff83fff, True), (0x7ff84000, False)):
            path.write_text('\n'.join((record(0, 4, (address >> 16).to_bytes(2, 'big')),
                                       record(address & 65535, 0, b'\x5a'),
                                       record(0, 1, b''))) + '\n')
            try:
                prepare(path)
            except ValueError:
                assert not valid, f'Allowed address rejected: {address:#x}'
            else:
                assert valid, f'Reserved address accepted: {address:#x}'
    # Exercise every supported Winternitz chain/checksum configuration.
    for w in (1, 2, 4, 8):
        pub, sig = sign(b'host cross-check', w=w)
        assert verify(pub, len(pub), b'host cross-check', 16, sig, len(sig)) == 1
    print(f'PASS: firmware C verification, tamper rejection, W1/W2/W4/W8, '
          f'UART HEX validation, reserved-region boundaries and full Flash payload; source bytes={used}')


if __name__ == '__main__':
    main()
