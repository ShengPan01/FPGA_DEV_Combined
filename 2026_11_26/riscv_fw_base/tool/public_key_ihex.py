#!/usr/bin/env python3
"""Convert a raw 48-byte LMS SHA256/192 public key to a separate Flash IHEX."""
import argparse
from pathlib import Path
import sys

sys.path.insert(0, str(Path(__file__).resolve().parents[1] / 'tools'))
from flash_upload import PUBLIC_KEY_ADDRESS, PUBLIC_KEY_BYTES, record


def convert(public):
    if len(public) != PUBLIC_KEY_BYTES:
        raise ValueError(f'Expected {PUBLIC_KEY_BYTES} raw public-key bytes, got {len(public)}')
    lms_type = int.from_bytes(public[:4], 'big')
    ots_type = int.from_bytes(public[4:8], 'big')
    if not (10 <= lms_type <= 14 and 5 <= ots_type <= 8):
        raise ValueError('Unsupported LMS/LMOTS types; expected SHA256/192 raw LMS key (no HSS header)')
    lines = [record(0, 4, (PUBLIC_KEY_ADDRESS >> 16).to_bytes(2, 'big'))]
    for offset in range(0, len(public), 32):
        lines.append(record((PUBLIC_KEY_ADDRESS + offset) & 65535, 0, public[offset:offset+32]))
    lines.append(record(0, 1, b''))
    return '\n'.join(lines) + '\n'


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('input', nargs='?', type=Path,
                        default=Path(__file__).resolve().parents[1] / 'output/test_signed.pub.bin')
    parser.add_argument('-o', '--output', type=Path, help='Default: input filename with .ihex suffix')
    args = parser.parse_args()
    output = args.output if args.output else args.input.with_suffix('.ihex')
    try:
        if output.resolve() == args.input.resolve():
            raise ValueError('Output must differ from the input public key')
        content = convert(args.input.read_bytes())
        output.write_text(content, encoding='ascii')
    except (OSError, ValueError) as error:
        parser.error(str(error))
    print(f'{output}: {PUBLIC_KEY_BYTES} public-key bytes at Flash {PUBLIC_KEY_ADDRESS:#08x}')


if __name__ == '__main__':
    main()
