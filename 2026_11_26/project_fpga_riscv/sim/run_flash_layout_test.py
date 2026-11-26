#!/usr/bin/env python3
"""Check complete boot transfers without vendor IP or firmware dependencies."""
import argparse
from pathlib import Path
import subprocess
import tempfile

parser = argparse.ArgumentParser(description=__doc__)
parser.add_argument('--build-dir', help='Keep generated Verilator files here')
args = parser.parse_args()
root = Path(__file__).resolve().parents[1]

def run(build):
    subprocess.run([
        'verilator', '--cc', '--exe', '--assert', '-Wno-fatal',
        '--top-module', 'tb_flash_layout', '--Mdir', str(build),
        str(root / 'rtl/spi_flash_boot.v'),
        str(root / 'rtl/testbench/tb_flash_layout.sv'),
        str(root / 'sim/test_flash_layout.cpp'),
    ], check=True)
    subprocess.run(['make', '-C', str(build), '-f', 'Vtb_flash_layout.mk', '-j2'], check=True)
    subprocess.run([str(build / 'Vtb_flash_layout')], check=True)

if args.build_dir:
    run(Path(args.build_dir).resolve())
else:
    with tempfile.TemporaryDirectory(prefix='flash-layout-') as directory:
        run(Path(directory))
