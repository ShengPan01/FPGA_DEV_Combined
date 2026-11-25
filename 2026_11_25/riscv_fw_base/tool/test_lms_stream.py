#!/usr/bin/env python3
"""Exercise the streaming C verifier using the existing signed Flash fixture."""
import ctypes as c
from pathlib import Path
import sys

root = Path(__file__).resolve().parents[1]
lib = c.CDLL(sys.argv[1] if len(sys.argv) > 1 else '/tmp/fw_lms_verify.so')
sys.path.insert(0, str(root / 'tool'))
from sign_ihex import padded_image
message, _ = padded_image(root / 'output/test.ihex')
base = root / 'output/test_signed'
pub = base.with_suffix('.pub.bin').read_bytes()
sig = base.with_suffix('.sig.bin').read_bytes()
Reader = c.CFUNCTYPE(c.c_int, c.c_void_p, c.c_size_t, c.c_void_p, c.c_size_t)
verify = lib.lms_verify_stream
verify.argtypes = [c.c_char_p, c.c_size_t, Reader, c.c_void_p, c.c_size_t,
                   c.c_char_p, c.c_size_t]
verify.restype = c.c_int

def check(data, public=pub, signature=sig, fail_at=None):
    offsets = []
    @Reader
    def read(user, offset, dst, length):
        assert length <= 256 and offset + length <= len(data)
        offsets.append(offset)
        if fail_at is not None and offset >= fail_at:
            return 0
        c.memmove(dst, data[offset:offset+length], length)
        return 1
    result = verify(public, len(public), read, None, len(data), signature, len(signature))
    return result, offsets

result, offsets = check(message)
assert result == 1 and offsets == list(range(0, len(message), 256))
for at in (0, 0x1ffff, 0x20000, len(message)-1):
    changed = bytearray(message)
    changed[at] ^= 1
    assert check(bytes(changed))[0] == 0
assert check(message, public=b'\xff'*48)[0] == 0
assert check(message, signature=sig[:-1])[0] == 0
assert check(message, signature=bytes([sig[0]^1])+sig[1:])[0] == 0
assert check(message, fail_at=0)[0] == 0
assert check(message, fail_at=0x20000)[0] == 0
assert check(message, fail_at=len(message)-256)[0] == 0
print('PASS: streaming signed image, IMEM/DRAM tampering, malformed key/signature, read failures')
