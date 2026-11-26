/**
 *  Codasip Ltd
 * 
 *  Copyright 2017 Codasip Ltd
 * 
 *  All Rights Reserved.
 *  This file is part of the Codasip Studio product. No part of the Studio product, including this
 *  file, may be use, copied, modified, or distributed except in accordance with the terms contained
 *  in Codasip license agreement under which you obtained this file.
 * 
 *  \file
 *  \date    2017-05-25 15:05:42
 *  \author  Codasip (c) HW generator
 *  \version 6.6.1-0.centos.6.7
 *  \brief   Contains module definition of the 'codix_berkelium_top_ca' top level.
 */

module codix_berkelium_top_ca(
    input  wire CLK,
    input  wire TCK,
    input  wire RST,
    input  wire TRST,
    input  wire TMS,
    input  wire TDI,
    input  wire D_ARREADY,
    input  wire D_AWREADY,
    input  wire [1:0] D_BRESP,
    input  wire D_BVALID,
    input  wire [31:0] D_RDATA,
    input  wire [1:0] D_RRESP,
    input  wire D_RVALID,
    input  wire D_WREADY,
    input  wire I_ARREADY,
    input  wire I_AWREADY,
    input  wire [1:0] I_BRESP,
    input  wire I_BVALID,
    input  wire [31:0] I_RDATA,
    input  wire [1:0] I_RRESP,
    input  wire I_RVALID,
    input  wire I_WREADY,
    input  wire p_meip,
    input  wire p_msip,
    input  wire p_mtip,
    output wire TDO,
    output wire [31:0] D_ARADDR,
    output wire [2:0] D_ARPROT,
    output wire D_ARVALID,
    output wire [31:0] D_AWADDR,
    output wire [2:0] D_AWPROT,
    output wire D_AWVALID,
    output wire D_BREADY,
    output wire D_RREADY,
    output wire [31:0] D_WDATA,
    output wire [3:0] D_WSTRB,
    output wire D_WVALID,
    output wire [31:0] I_ARADDR,
    output wire [2:0] I_ARPROT,
    output wire I_ARVALID,
    output wire [31:0] I_AWADDR,
    output wire [2:0] I_AWPROT,
    output wire I_AWVALID,
    output wire I_BREADY,
    output wire I_RREADY,
    output wire [31:0] I_WDATA,
    output wire [3:0] I_WSTRB,
    output wire I_WVALID
);
    // type, wire and constant declarations:

    // additional declarations:
    wire [31:0] codix_berkelium_if_ldst_A0_0;
    wire [2:0] codix_berkelium_if_ldst_BC0_1;
    wire [1:0] codix_berkelium_if_ldst_BI0_2;
    wire [31:0] codix_berkelium_if_ldst_D0_3;
    wire [2:0] codix_berkelium_if_ldst_REQUEST0_4;
    wire [31:0] d_clb2axilite_if_clb_Q0_5;
    wire [2:0] d_clb2axilite_if_clb_RESPONSE0_6;
    wire [1:0] d_clb2axilite_if_clb_STATUS0_7;
    wire [31:0] codix_berkelium_if_fetch_A0_8;
    wire [2:0] codix_berkelium_if_fetch_BC0_9;
    wire [1:0] codix_berkelium_if_fetch_BI0_10;
    wire [31:0] codix_berkelium_if_fetch_D0_11;
    wire [2:0] codix_berkelium_if_fetch_REQUEST0_12;
    wire [31:0] i_clb2axilite_if_clb_Q0_13;
    wire [2:0] i_clb2axilite_if_clb_RESPONSE0_14;
    wire [1:0] i_clb2axilite_if_clb_STATUS0_15;

    // child instances inside 'codix_berkelium_top' top level:
    // instance of 'd_clb2axilite' CodAL component:
    clb2axilite #(
        .K(32),
        .N(2)
    ) d_clb2axilite (
        .CLK(CLK),
        .RST(RST),
        .ARREADY(D_ARREADY),
        .AWREADY(D_AWREADY),
        .BRESP(D_BRESP),
        .BVALID(D_BVALID),
        .if_clb_A0(codix_berkelium_if_ldst_A0_0),
        .if_clb_BC0(codix_berkelium_if_ldst_BC0_1),
        .if_clb_BI0(codix_berkelium_if_ldst_BI0_2),
        .if_clb_D0(codix_berkelium_if_ldst_D0_3),
        .if_clb_REQUEST0(codix_berkelium_if_ldst_REQUEST0_4),
        .RDATA(D_RDATA),
        .RRESP(D_RRESP),
        .RVALID(D_RVALID),
        .WREADY(D_WREADY),
        .ARADDR(D_ARADDR),
        .ARPROT(D_ARPROT),
        .ARVALID(D_ARVALID),
        .AWADDR(D_AWADDR),
        .AWPROT(D_AWPROT),
        .AWVALID(D_AWVALID),
        .BREADY(D_BREADY),
        .if_clb_Q0(d_clb2axilite_if_clb_Q0_5),
        .if_clb_RESPONSE0(d_clb2axilite_if_clb_RESPONSE0_6),
        .if_clb_STATUS0(d_clb2axilite_if_clb_STATUS0_7),
        .RREADY(D_RREADY),
        .WDATA(D_WDATA),
        .WSTRB(D_WSTRB),
        .WVALID(D_WVALID)
    );

    // instance of 'i_clb2axilite' CodAL component:
    clb2axilite #(
        .K(32),
        .N(2)
    ) i_clb2axilite (
        .CLK(CLK),
        .RST(RST),
        .ARREADY(I_ARREADY),
        .AWREADY(I_AWREADY),
        .BRESP(I_BRESP),
        .BVALID(I_BVALID),
        .if_clb_A0(codix_berkelium_if_fetch_A0_8),
        .if_clb_BC0(codix_berkelium_if_fetch_BC0_9),
        .if_clb_BI0(codix_berkelium_if_fetch_BI0_10),
        .if_clb_D0(codix_berkelium_if_fetch_D0_11),
        .if_clb_REQUEST0(codix_berkelium_if_fetch_REQUEST0_12),
        .RDATA(I_RDATA),
        .RRESP(I_RRESP),
        .RVALID(I_RVALID),
        .WREADY(I_WREADY),
        .ARADDR(I_ARADDR),
        .ARPROT(I_ARPROT),
        .ARVALID(I_ARVALID),
        .AWADDR(I_AWADDR),
        .AWPROT(I_AWPROT),
        .AWVALID(I_AWVALID),
        .BREADY(I_BREADY),
        .if_clb_Q0(i_clb2axilite_if_clb_Q0_13),
        .if_clb_RESPONSE0(i_clb2axilite_if_clb_RESPONSE0_14),
        .if_clb_STATUS0(i_clb2axilite_if_clb_STATUS0_15),
        .RREADY(I_RREADY),
        .WDATA(I_WDATA),
        .WSTRB(I_WSTRB),
        .WVALID(I_WVALID)
    );

    // instance of 'codix_berkelium' ASIP:
    codix_berkelium_ca codix_berkelium (
        .CLK(CLK),
        .TCK(TCK),
        .RST(RST),
        .TRST(TRST),
        .TMS(TMS),
        .TDI(TDI),
        .if_fetch_Q0(i_clb2axilite_if_clb_Q0_13),
        .if_fetch_RESPONSE0(i_clb2axilite_if_clb_RESPONSE0_14),
        .if_fetch_STATUS0(i_clb2axilite_if_clb_STATUS0_15),
        .if_ldst_Q0(d_clb2axilite_if_clb_Q0_5),
        .if_ldst_RESPONSE0(d_clb2axilite_if_clb_RESPONSE0_6),
        .if_ldst_STATUS0(d_clb2axilite_if_clb_STATUS0_7),
        .p_meip(p_meip),
        .p_msip(p_msip),
        .p_mtip(p_mtip),
        .TDO(TDO),
        .if_fetch_A0(codix_berkelium_if_fetch_A0_8),
        .if_fetch_BC0(codix_berkelium_if_fetch_BC0_9),
        .if_fetch_BI0(codix_berkelium_if_fetch_BI0_10),
        .if_fetch_D0(codix_berkelium_if_fetch_D0_11),
        .if_fetch_REQUEST0(codix_berkelium_if_fetch_REQUEST0_12),
        .if_ldst_A0(codix_berkelium_if_ldst_A0_0),
        .if_ldst_BC0(codix_berkelium_if_ldst_BC0_1),
        .if_ldst_BI0(codix_berkelium_if_ldst_BI0_2),
        .if_ldst_D0(codix_berkelium_if_ldst_D0_3),
        .if_ldst_REQUEST0(codix_berkelium_if_ldst_REQUEST0_4),
        .p_wfi()
    );

endmodule
