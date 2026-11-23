#!/usr/bin/env python3
"""Select, validate and upload firmware or a public-key Intel HEX over UART."""
import argparse
from pathlib import Path
import time

PUBLIC_KEY_ADDRESS = 0x26000
PUBLIC_KEY_BYTES = 48


def record(address, kind, data):
    b = bytes([len(data), address >> 8, address & 255, kind]) + data
    return ':' + (b + bytes([-sum(b) & 255])).hex().upper()


def prepare(path):
    """Validate the entire file before any erase, then emit short ordered records."""
    image = {}
    upper = 0
    eof = False
    for lineno, line in enumerate(Path(path).read_text(encoding='ascii').splitlines(), 1):
        line = line.strip()
        if not line:
            continue
        if eof:
            raise ValueError('Record after EOF')
        if not line.startswith(':'):
            raise ValueError(f'Line {lineno}: missing colon')
        b = bytes.fromhex(line[1:])
        if len(b) < 5 or len(b) != b[0]+5 or sum(b) & 255:
            raise ValueError(f'Line {lineno}: invalid length/checksum')
        size, kind = b[0], b[3]
        address = int.from_bytes(b[1:3], 'big')
        data = b[4:-1]
        if kind == 0:
            if not size or address+size > 0x10000:
                raise ValueError('Invalid data record')
            start = upper+address
            end = start+size
            if not (0x1000 <= start < end <= 0x26000 or
                    PUBLIC_KEY_ADDRESS <= start < end <= PUBLIC_KEY_ADDRESS + PUBLIC_KEY_BYTES or
                    0x7ff80000 <= start < end <= 0x7ff84000):
                raise ValueError(f'Unsupported FW address: {start:08x}')
            for i, value in enumerate(data):
                a = start+i
                if a in image and image[a] != value:
                    raise ValueError(f'Conflicting overlap: {a:08x}')
                image[a] = value
        elif kind in (2, 4):
            if size != 2 or address:
                raise ValueError('Invalid extended address record')
            upper = int.from_bytes(data, 'big') << (4 if kind == 2 else 16)
        elif kind in (3, 5):
            if size != 4 or address:
                raise ValueError('Invalid entry record')
        elif kind == 1:
            if size or address:
                raise ValueError('Invalid EOF')
            eof = True
        else:
            raise ValueError(f'Unsupported record type {kind}')
    if not eof or not image:
        raise ValueError('Missing EOF or empty image')
    commands = []
    addresses = sorted(image)
    pos = 0
    current_upper = None
    while pos < len(addresses):
        start = addresses[pos]
        hi = start >> 16
        if hi != current_upper:
            commands.append(record(0, 4, hi.to_bytes(2, 'big')))
            current_upper = hi
        data = bytearray([image[start]])
        pos += 1
        while (pos < len(addresses) and len(data) < 32 and
               addresses[pos] == start+len(data) and addresses[pos] >> 16 == hi):
            data.append(image[addresses[pos]])
            pos += 1
        commands.append(record(start & 65535, 0, data))
    commands.append(record(0, 1, b''))
    return commands, len(image)


def exchange(port, command, expected):
    port.write(('\\'+command+'\r').encode('ascii'))
    port.flush()
    deadline = time.monotonic()+15
    while time.monotonic() < deadline:
        line = port.readline().decode('ascii', errors='replace').strip()
        if line.startswith('FLASH ERROR'):
            raise RuntimeError(line)
        if line.startswith(expected):
            return line
    raise TimeoutError(f'No {expected} response for {command[:24]} (do not retry automatically)')


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--port', required=True, help='COM3 or /dev/ttyUSB0')
    parser.add_argument('--baud', type=int, default=115200)
    parser.add_argument('--file', help='Omit to open a file selection dialog')
    args = parser.parse_args()
    if not args.file:
        from tkinter import Tk, filedialog
        root = Tk()
        root.withdraw()
        args.file = filedialog.askopenfilename(title='Select firmware or public-key IHEX',
                                              filetypes=[('Intel HEX', '*.ihex *.hex'), ('All', '*')])
        root.destroy()
        if not args.file:
            return
    commands, size = prepare(args.file)
    import serial
    print(f'{size} bytes validated. Erasing touched 4 KB sectors and programming...')
    with serial.Serial(args.port, args.baud, timeout=0.5, write_timeout=5,
                       rtscts=False, dsrdtr=False) as port:
        time.sleep(0.3)
        port.reset_input_buffer()
        try:
            exchange(port, 'flashbegin', 'FLASH READY')
            for i, rec in enumerate(commands):
                answer = exchange(port, 'flashhex '+rec,
                                  'FLASH DONE' if i == len(commands)-1 else 'FLASH OK')
                if i % 100 == 0:
                    print(f'{i+1}/{len(commands)} records')
            print(answer)
        except Exception:
            port.write(b'\\flashabort\r')
            port.flush()
            raise


if __name__ == '__main__':
    main()
