Hardware configuration registers
===============================

MCU addresses 0xC0..0xCF map to CPU addresses 0x80000300..0x8000033C
with a four-byte stride. Each register contains eight bits.

- 0xC0: read-only version, bits 7:4 major, bits 3:0 minor. Writes are ignored.
  Defaults are 0.3, defined in rtl/chip_version.vh.
- 0xC1..0xCF: read/write, synchronous active-low reset clears all to zero.

The firmware prints the version after InitMCU initializes the UART.

Run the bus/register regression from the workspace root (Verilator and g++):

```sh
verilator --cc --exe --top-module tb_hw_cfg -Wno-fatal \
  -Iproject_fpga_riscv/rtl --Mdir /tmp/hw_cfg_obj \
  project_fpga_riscv/sim/tb_hw_cfg.sv \
  project_fpga_riscv/rtl/rtl_hw_cfg/hw_cfg.v \
  "$PWD/project_fpga_riscv/sim/test_hw_cfg.cpp"
make -C /tmp/hw_cfg_obj -f Vtb_hw_cfg.mk -j2
/tmp/hw_cfg_obj/Vtb_hw_cfg
```

The regression checks the default version 0.2, ignored version writes,
all fifteen writable registers, reset after writes, write-strobe gating,
address isolation, SHA-256 window decoding and strobes, and existing SPI/I2C/SPI buffer decode paths.
