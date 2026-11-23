 /*
 * Copyright (c) 2026. All rights reserved.
 *
 * Unauthorized copying, modification, distribution, or use
 * of this code is strictly prohibited without prior
 * written permission from the copyright owner.
 *
 * Date: 2026-11-11
 */
 

module axi_lite_1_to_2 #(
//    parameter A_WIDTH = 32,
    parameter D_WIDTH = 32,
    parameter MASTER_BASE_0 = 32'h0,
    parameter MASTER_MASK_0 = 32'h000fffff,
    parameter MASTER_BASE_1 = 32'h7ff80000,
    parameter MASTER_MASK_1 = 32'h0007ffff
) (
    axi_lite_intf.slave axis_0,
    axi_lite_intf.master axim_0,
    axi_lite_intf.master axim_1
);

/// read address channel ///

wire [31:0] m0_raddr_tmp = axis_0.araddr - MASTER_BASE_0;
wire m0_r_sel = (m0_raddr_tmp & ~MASTER_MASK_0) == 0;
wire [31:0] m1_raddr_tmp = axis_0.araddr - MASTER_BASE_1;
wire m1_r_sel = !m0_r_sel && ((m1_raddr_tmp & ~MASTER_MASK_1) == 0);

assign axim_0.arvalid = axis_0.arvalid && m0_r_sel;
assign axim_0.araddr = m0_raddr_tmp;//axis_0.araddr;
assign axim_0.arprot = axis_0.arprot;
assign axim_1.arvalid = axis_0.arvalid && m1_r_sel;
assign axim_1.araddr = m1_raddr_tmp;//axis_0.araddr;
assign axim_1.arprot = axis_0.arprot;
assign axis_0.arready = m0_r_sel ? axim_0.arready : m1_r_sel ? axim_1.arready : 1'b1;

reg [1:0] ar_ch_sel; // 00: no sel; 01: select master 0; 10: select master 1
reg ar_err;

always @(posedge axis_0.a_clk or negedge axis_0.a_reset_n)
    if (!axis_0.a_reset_n)
        ar_ch_sel <= 2'h0;
    else if (axis_0.arvalid && axis_0.arready)
        ar_ch_sel <= {m1_r_sel, m0_r_sel};
    else if (ar_ch_sel[0] && axim_0.rvalid && axim_0.rready ||
        ar_ch_sel[1] && axim_1.rvalid && axim_1.rready)
        ar_ch_sel <= 2'h0;

always @(posedge axis_0.a_clk or negedge axis_0.a_reset_n)
    if (!axis_0.a_reset_n)
        ar_err <= 1'b0;
    else if (axis_0.arvalid && axis_0.arready)
        ar_err <= !m1_r_sel && !m0_r_sel;
    else if (axis_0.rvalid && axis_0.rready)
        ar_err <= 1'b0;

/// read data channel ///

assign axis_0.rvalid = ar_ch_sel[0] ? axim_0.rvalid : ar_ch_sel[1] ? axim_1.rvalid : ar_err;
assign axis_0.rdata = ar_ch_sel[0] ? axim_0.rdata : ar_ch_sel[1] ? axim_1.rdata : {D_WIDTH{1'b0}};
assign axis_0.rresp = ar_ch_sel[0] ? axim_0.rresp : ar_ch_sel[1] ? axim_1.rresp : 2'h3;
assign axim_0.rready = ar_ch_sel[0] && axis_0.rready;
assign axim_1.rready = ar_ch_sel[1] && axis_0.rready;

/// write address channel ///

wire [31:0] m0_waddr_tmp = axis_0.awaddr - MASTER_BASE_0;
wire m0_w_sel = (m0_waddr_tmp & ~MASTER_MASK_0) == 0;
wire [31:0] m1_waddr_tmp = axis_0.awaddr - MASTER_BASE_1;
wire m1_w_sel = !m0_w_sel && ((m1_waddr_tmp & ~MASTER_MASK_1) == 0);

assign axim_0.awvalid = axis_0.awvalid && m0_w_sel;
assign axim_0.awaddr = m0_waddr_tmp;//axis_0.awaddr;
assign axim_0.awprot = axis_0.awprot;
assign axim_1.awvalid = axis_0.awvalid && m1_w_sel;
assign axim_1.awaddr = m1_waddr_tmp;//axis_0.awaddr;
assign axim_1.awprot = axis_0.awprot;
assign axis_0.awready = m0_w_sel ? axim_0.awready : m1_w_sel ? axim_1.awready : 1'b1;

reg [1:0] aw_ch_sel; // 00: no sel; 01: select master 0; 10: select master 1
reg aw_err;
reg aw_err_dff;

always @(posedge axis_0.a_clk or negedge axis_0.a_reset_n)
    if (!axis_0.a_reset_n)
        aw_ch_sel <= 2'h0;
    else if (axis_0.awvalid && axis_0.awready)
        aw_ch_sel <= {m1_w_sel, m0_w_sel};
    else if (aw_ch_sel[0] && axim_0.bvalid && axim_0.bready ||
        aw_ch_sel[1] && axim_1.bvalid && axim_1.bready)
        aw_ch_sel <= 2'h0;

always @(posedge axis_0.a_clk or negedge axis_0.a_reset_n)
    if (!axis_0.a_reset_n)
        aw_err <= 1'b0;
    else if (axis_0.awvalid && axis_0.awready)
        aw_err <= !m1_w_sel && !m0_w_sel;
    else if (axis_0.wvalid && axis_0.wready)
        aw_err <= 1'b0;

always @(posedge axis_0.a_clk or negedge axis_0.a_reset_n)
    if (!axis_0.a_reset_n)
        aw_err_dff <= 1'b0;
    else
        aw_err_dff <= aw_err;

/// write data channel ///

assign axim_0.wvalid = axis_0.wvalid && (m0_w_sel && axis_0.awvalid || aw_ch_sel[0]);
assign axim_0.wdata = axis_0.wdata;
assign axim_0.wstrb = axis_0.wstrb;
assign axim_1.wvalid = axis_0.wvalid && (m1_w_sel && axis_0.awvalid || aw_ch_sel[1]);
assign axim_1.wdata = axis_0.wdata;
assign axim_1.wstrb = axis_0.wstrb;
assign axis_0.wready = (m0_w_sel && axis_0.awvalid || aw_ch_sel[0]) ? axim_0.wready : 
    (m1_w_sel && axis_0.awvalid || aw_ch_sel[1]) ? axim_1.wready : 1'b1;

/// write response channel ///

assign axis_0.bvalid = aw_ch_sel[0] ? axim_0.bvalid : aw_ch_sel[1] ? axim_1.bvalid : aw_err_dff;
assign axis_0.bresp = aw_ch_sel[0] ? axim_0.bresp : aw_ch_sel[1] ? axim_1.bresp : 2'h3;
assign axim_0.bready = aw_ch_sel[0] && axis_0.bready;
assign axim_1.bready = aw_ch_sel[1] && axis_0.bready;


endmodule
