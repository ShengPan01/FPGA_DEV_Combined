#!/usr/bin/env python3
"""Run the same SHA-256 and LMS vectors on the RISC-V core in three modes."""
import os
from pathlib import Path
import subprocess
import tempfile

from ihex_to_mem import convert

sim = Path(__file__).resolve().parent
rtl = sim.parent / "rtl"
fw = sim.parents[1] / "riscv_fw_base"
prefix = os.environ.get("RISCV_PREFIX", "riscv32-unknown-elf-")


def run(*args):
    subprocess.run(args, check=True)


with tempfile.TemporaryDirectory(prefix="sha256-cpu-") as directory:
    build = Path(directory)
    images = {}
    for mode, enable in (("sw", 0), ("hw", 1)):
        elf, ihex, mem = (build / f"{mode}.{suffix}" for suffix in ("elf", "ihex", "mem"))
        run(prefix + "gcc", "-march=rv32imc_zicsr", "-mabi=ilp32",
            "-O2", "-msmall-data-limit=0", "-mno-relax", "-ffunction-sections",
            "-fdata-sections", "-nostartfiles", "-Wl,--gc-sections,--oformat=elf32-littleriscv",
            "-T", fw / "default.lds", "-DLMS_VERIFY_ONLY=1", f"-DLMS_SHA256_ACCEL={enable}",
            "-I", fw / "inc", "-I", fw / "inc/lms", sim / "test_sha256_fw.c",
            *(fw / "source/lms" / name for name in ("sha256.c", "endian.c", "lms.c", "lms_selftest.c")),
            "-o", elf)
        run(prefix + "objcopy", "-O", "ihex", elf, ihex)
        mem.write_text(convert(ihex.read_text()))
        images[mode] = mem

    cpu_rtl = rtl / "rtl_riscv"
    sources = sorted(p for p in cpu_rtl.rglob("*") if p.suffix in {".v", ".sv"})
    run("verilator", "--cc", "--exe", "-Wno-fatal", "--top-module", "tb_sha256_cpu",
        "--Mdir", build, "-I" + str(rtl), "-I" + str(cpu_rtl / "uart"), *sources,
        rtl / "rtl_sha256/sha256_accel.v", sim / "tb_sha256_cpu.sv", sim / "test_sha256_cpu.cpp")
    run("make", "-C", build, "-f", "Vtb_sha256_cpu.mk", "-j4")
    for mode in ("hw", "sw", "timeout"):
        run(build / "Vtb_sha256_cpu", images["sw" if mode == "sw" else "hw"], mode)
