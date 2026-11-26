#!/usr/bin/env python3
"""Public-key conversion and UART uploader address regression tests."""
from pathlib import Path
import tempfile
import unittest

from public_key_ihex import convert, PUBLIC_KEY_ADDRESS
from flash_upload import prepare, record


class PublicKeyIhexTest(unittest.TestCase):
    def setUp(self):
        self.key = (10).to_bytes(4, 'big') + (7).to_bytes(4, 'big') + bytes(range(40))

    def prepare_text(self, text):
        with tempfile.TemporaryDirectory() as directory:
            path = Path(directory) / 'public.ihex'
            path.write_text(text, encoding='ascii')
            return prepare(path)

    def test_roundtrip_and_sector_isolation(self):
        commands, size = self.prepare_text(convert(self.key))
        self.assertEqual(size, 48)
        image, upper = {}, 0
        for line in commands:
            b = bytes.fromhex(line[1:])
            if b[3] == 4:
                upper = int.from_bytes(b[4:6], 'big') << 16
            elif b[3] == 0:
                start = upper + int.from_bytes(b[1:3], 'big')
                image.update((start+i, v) for i, v in enumerate(b[4:-1]))
        self.assertEqual(sorted(image), list(range(PUBLIC_KEY_ADDRESS, PUBLIC_KEY_ADDRESS+48)))
        self.assertEqual(bytes(image[a] for a in sorted(image)), self.key)
        self.assertEqual({a >> 12 for a in image}, {0x26})

    def test_bad_key_size_or_type(self):
        for key in (b'', self.key[:-1], self.key+b'\x00', b'\x00'*48,
                    self.key[:4]+(9).to_bytes(4, 'big')+self.key[8:]):
            with self.subTest(key=key), self.assertRaises(ValueError):
                convert(key)

    def test_unsupported_flash_addresses(self):
        for address, payload in ((0xfff, b'\x01'), (0x26030, b'\x01'),
                                 (0x2602f, b'\x01\x02'), (0x26fff, b'\x01'),
                                 (0x27000, b'\x01'), (0x3fffff, b'\x01')):
            content = '\n'.join((record(0, 4, (address >> 16).to_bytes(2, 'big')),
                                 record(address & 65535, 0, payload), record(0, 1, b'')))
            with self.subTest(address=hex(address)), self.assertRaises(ValueError):
                self.prepare_text(content)


if __name__ == '__main__':
    unittest.main()
