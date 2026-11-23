 /*
 * Copyright (c) 2026. All rights reserved.
 *
 * Unauthorized copying, modification, distribution, or use
 * of this code is strictly prohibited without prior
 * written permission from the copyright owner.
 *
 * Date: 2026-11-11
 */
 

module machine_timer (
    axi_lite_intf.slave axis,
    axi_lite_intf.master axim,
    output reg mtip
);

parameter TIMER_ADDR = 32'h48001000;
parameter TIMER_MASK = 32'h000000ff;

parameter TIMER_L = 8'h0;
parameter TIMER_H = 8'h4;
parameter TIMER_CMP_L = 8'h8;
parameter TIMER_CMP_H = 8'hc;

reg [63:0] mtime;
reg [63:0] mtimecmp;
 
wire rd_timer = axis.arvalid && ((axis.araddr & ~TIMER_MASK) == TIMER_ADDR);
reg rd_timer_d;

always @(posedge axis.a_clk or negedge axis.a_reset_n)
    if (!axis.a_reset_n)
        rd_timer_d <= 1'b0;
    else
        rd_timer_d <= rd_timer;

reg [31:0] timer_rdata;

always @(posedge axis.a_clk or negedge axis.a_reset_n)
    if (!axis.a_reset_n)
        timer_rdata <= 32'b0;
    else
        case (axis.araddr[7:0])
        TIMER_L: timer_rdata <= mtime[31:0];
        TIMER_H: timer_rdata <= mtime[63:32];
        TIMER_CMP_L: timer_rdata <= mtimecmp[31:0];
        TIMER_CMP_H: timer_rdata <= mtimecmp[63:32];
        default: timer_rdata <= 32'h0;
        endcase

wire wr_timer = axis.awvalid && ((axis.awaddr & ~TIMER_MASK) == TIMER_ADDR);

reg [7:0] woffset;
reg [31:0] wdata;
reg wr_en;

always @(posedge axis.a_clk or negedge axis.a_reset_n)
    if (!axis.a_reset_n)
        wr_en <= 1'b0;
    else if (wr_timer && axis.awready)
        wr_en <= 1'b1;
    else if (axis.bvalid && axis.bready)
        wr_en <= 1'b0;

always @(posedge axis.a_clk or negedge axis.a_reset_n)
    if (!axis.a_reset_n)
        woffset <= 8'h0;
    else if (axis.awvalid && axis.awready)
        woffset <= axis.awaddr[7:0];

always @(posedge axis.a_clk or negedge axis.a_reset_n)
    if (!axis.a_reset_n)
        wdata <= 32'h0;
    else if (axis.wvalid && axis.wready)
        wdata <= axis.wdata[31:0];

always @(posedge axis.a_clk or negedge axis.a_reset_n)
    if (!axis.a_reset_n)
        mtime <= 64'b0;
    else if (wr_en && axis.bvalid && axis.bready)
        case (woffset)
        TIMER_L: mtime[31:0] <= wdata;
        TIMER_H: mtime[63:32] <= wdata;
        default: mtime <= mtime + 64'h1;
        endcase
    else
        mtime <= mtime + 64'h1;

always @(posedge axis.a_clk or negedge axis.a_reset_n)
    if (!axis.a_reset_n)
        mtimecmp <= 64'h0;
    else if (wr_en && axis.bvalid && axis.bready)
        case (woffset)
        TIMER_CMP_L: mtimecmp[31:0] <= wdata;
        TIMER_CMP_H: mtimecmp[63:32] <= wdata;
        endcase

always @(posedge axis.a_clk or negedge axis.a_reset_n)
    if (!axis.a_reset_n)
        mtip <= 1'b0;
    else
        mtip <= (mtimecmp != 64'h0) && (mtime >= mtimecmp);

assign axim.awvalid = axis.awvalid && !wr_timer;
assign axim.awaddr = axis.awaddr;
assign axim.awprot = axis.awprot;
assign axim.wvalid = axis.awvalid ? (wr_timer ? 1'b0 : axis.wvalid) : (wr_en ? 1'b0 : axis.wvalid);
assign axim.wdata = axis.wdata;
assign axim.wstrb = axis.wstrb;
assign axim.bready = !wr_en && axis.bready;
assign axim.arvalid = axis.arvalid && !rd_timer;
assign axim.araddr = axis.araddr;
assign axim.arprot = axis.arprot;
assign axim.rready = ~rd_timer_d && axis.rready;
assign axis.awready = wr_timer ? 1'b1 : axim.awready;
assign axis.wready = wr_en ? axis.wvalid : axim.wready;
assign axis.bvalid = wr_en ? 1'b1 : axim.bvalid;
assign axis.bresp = wr_en ? 2'h0 : axim.bresp;
assign axis.arready = rd_timer ? 1'b1 : axim.arready;
assign axis.rvalid = rd_timer_d ? 1'b1 : axim.rvalid;
assign axis.rdata = rd_timer_d ? timer_rdata : axim.rdata;
assign axis.rresp = rd_timer_d ? 2'h0 : axim.rresp;

endmodule
