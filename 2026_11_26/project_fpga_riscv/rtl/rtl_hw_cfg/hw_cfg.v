 /*
 * Copyright (c) 2026. All rights reserved.
 *
 * Unauthorized copying, modification, distribution, or use
 * of this code is strictly prohibited without prior
 * written permission from the copyright owner.
 * Author: Sheng Pan
 * Date: 2026-11-11
 * Description: This module is for h/w chip version registers
 */

`include "chip_version.vh"

module hw_cfg_top ( 
    input        reg_clk                    ,
    input        reg_reset_n                 ,
    input        mcus_rd_en,   // Read strobe, active high
    input        mcus_wr_en,   // Write strobe, active high
    input [15:0] mcus_addr,   // Address
    input [7:0] mcus_wdata,   // Write data
    output [7:0] mcus_rdata,   // Read data

    inout [3:0]  mode_gpio,
    output       gpio_0
);


// Local offset 0 is the read-only hardware version; offsets 1..15 are RW.
reg [7:0] cfg_regs [1:15];
integer i;
assign gpio_0 = cfg_regs[1][0];
assign mode_gpio[0] = cfg_regs[2][0];
assign mode_gpio[1] = cfg_regs[2][1];
assign mode_gpio[2] = cfg_regs[2][2];
assign mode_gpio[3] = cfg_regs[2][3];

always @(posedge reg_clk)
begin
    if (!reg_reset_n) begin
        for (i = 1; i < 16; i = i + 1)
            cfg_regs[i] <= 8'h00;
    end else if (mcus_wr_en && (mcus_addr >= 16'h0001) &&
                 (mcus_addr <= 16'h000f)) begin
        cfg_regs[mcus_addr[3:0]] <= mcus_wdata;
    end
end

// Combinational readback matches the SPI and IMU register bus timing.
assign mcus_rdata = (mcus_addr == 16'h0000) ?
                   {`CHIP_VERSION_MAJOR, `CHIP_VERSION_MINOR} :
                   ((mcus_addr <= 16'h000f) ? cfg_regs[mcus_addr[3:0]] : 8'h00);

endmodule
