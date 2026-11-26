`ifndef CHIP_VERSION_VH
`define CHIP_VERSION_VH

// Each version component must be a 4-bit value (0..15).
// Override at compile time or update the defaults for a new hardware release.
`ifndef CHIP_VERSION_MAJOR
`define CHIP_VERSION_MAJOR 4'h0
`endif
`ifndef CHIP_VERSION_MINOR
`define CHIP_VERSION_MINOR 4'h4
`endif

`define CHIP_VERSION_MCU_ADDR 16'h00C0

`endif
