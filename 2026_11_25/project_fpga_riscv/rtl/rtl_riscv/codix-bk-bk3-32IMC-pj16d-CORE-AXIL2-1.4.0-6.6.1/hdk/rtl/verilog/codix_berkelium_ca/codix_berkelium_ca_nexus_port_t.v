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
 *  \date    2017-05-25 15:05:01
 *  \author  Codasip (c) HW generator
 *  \version 6.6.1-0.centos.6.7
 *  \brief   Contains module definition of the 'codix_berkelium_ca_nexus_port_t' Nexus port.
 */

module codix_berkelium_ca_nexus_port_t(
    input  wire CLK,
    input  wire TCK,
    input  wire RST,
    input  wire TRST,
    input  wire TMS,
    input  wire TDI,
    input  wire DEBUG_MODE,
    input  wire [31:0] if_ldst_NEXUS_CLIENT_Q0,
    input  wire [31:0] nexus_client_NEXUS_CLIENT_Q0,
    output wire TDO,
    output wire NEXUS_BAR,
    output wire [6:0] NEXUS_RRS,
    output wire if_ldst_NEXUS_CLIENT_CAPTURE,
    output wire [31:0] if_ldst_NEXUS_CLIENT_D0,
    output wire if_ldst_NEXUS_CLIENT_UPDATE,
    output wire nexus_client_NEXUS_CLIENT_CAPTURE,
    output wire [31:0] nexus_client_NEXUS_CLIENT_D0,
    output wire nexus_client_NEXUS_CLIENT_UPDATE
);
    // type, wire and constant declarations:

    // additional declarations:
    wire [7:0] sync_addr_from_tck_CLK_0;
    wire sync_addr_from_tck_DONE_CLK_1;
    wire [31:0] sync_data_from_tck_CLK_2;
    wire sync_data_from_tck_DONE_CLK_3;
    wire [31:0] clk_domain_sync_data_from_clk_CLK_4;
    wire clk_domain_sync_data_from_clk_READY_CLK_5;
    wire tck_domain_NEXUS_TDO_6;
    wire sync_DEBUG_MODE_TCK_7;
    wire tap_NEXUS_BAR_8;
    wire tap_NEXUS_CAPTURE_9;
    wire tap_NEXUS_SEL_10;
    wire tap_NEXUS_SHIFT_11;
    wire tap_NEXUS_UPDATE_12;
    wire tap_NEXUS_TDI_13;
    wire sync_data_from_clk_DONE_TCK_14;
    wire [31:0] sync_data_from_clk_TCK_15;
    wire tck_domain_sync_addr_from_tck_READY_TCK_16;
    wire [7:0] tck_domain_sync_addr_from_tck_TCK_17;
    wire tck_domain_sync_data_from_tck_READY_TCK_18;
    wire [31:0] tck_domain_sync_data_from_tck_TCK_19;

    // child instances inside 'nexus_port' Nexus port:
    // instance of 'clk_domain' select Nexus client connected to Nexus Port (global clock domain):
    codix_berkelium_ca_nexus_port_clk_domain_t clk_domain (
        .CLK(CLK),
        .RST(RST),
        .sync_addr_from_tck_CLK(sync_addr_from_tck_CLK_0),
        .sync_addr_from_tck_DONE_CLK(sync_addr_from_tck_DONE_CLK_1),
        .sync_data_from_tck_CLK(sync_data_from_tck_CLK_2),
        .sync_data_from_tck_DONE_CLK(sync_data_from_tck_DONE_CLK_3),
        .if_ldst_NEXUS_CLIENT_Q0(if_ldst_NEXUS_CLIENT_Q0),
        .nexus_client_NEXUS_CLIENT_Q0(nexus_client_NEXUS_CLIENT_Q0),
        .NEXUS_RRS(NEXUS_RRS),
        .sync_data_from_clk_CLK(clk_domain_sync_data_from_clk_CLK_4),
        .sync_data_from_clk_READY_CLK(clk_domain_sync_data_from_clk_READY_CLK_5),
        .if_ldst_NEXUS_CLIENT_CAPTURE(if_ldst_NEXUS_CLIENT_CAPTURE),
        .if_ldst_NEXUS_CLIENT_D0(if_ldst_NEXUS_CLIENT_D0),
        .if_ldst_NEXUS_CLIENT_UPDATE(if_ldst_NEXUS_CLIENT_UPDATE),
        .nexus_client_NEXUS_CLIENT_CAPTURE(nexus_client_NEXUS_CLIENT_CAPTURE),
        .nexus_client_NEXUS_CLIENT_D0(nexus_client_NEXUS_CLIENT_D0),
        .nexus_client_NEXUS_CLIENT_UPDATE(nexus_client_NEXUS_CLIENT_UPDATE)
    );

    // instance of 'tap' JTAG Test Access Port:
    codix_berkelium_ca_nexus_port_tap_t tap (
        .TCK(TCK),
        .TRST(TRST),
        .TMS(TMS),
        .TDI(TDI),
        .NEXUS_TDO(tck_domain_NEXUS_TDO_6),
        .DEBUG_MODE(sync_DEBUG_MODE_TCK_7),
        .TDO(TDO),
        .NEXUS_BAR(tap_NEXUS_BAR_8),
        .NEXUS_CAPTURE(tap_NEXUS_CAPTURE_9),
        .NEXUS_SEL(tap_NEXUS_SEL_10),
        .NEXUS_SHIFT(tap_NEXUS_SHIFT_11),
        .NEXUS_UPDATE(tap_NEXUS_UPDATE_12),
        .NEXUS_TDI(tap_NEXUS_TDI_13)
    );

    // instance of 'tck_domain' Internal logic of Nexus Port running on JTAG clock domain (TCK):
    codix_berkelium_ca_nexus_port_tck_domain_t tck_domain (
        .TCK(TCK),
        .TRST(TRST),
        .NEXUS_CAPTURE(tap_NEXUS_CAPTURE_9),
        .NEXUS_SEL(tap_NEXUS_SEL_10),
        .NEXUS_SHIFT(tap_NEXUS_SHIFT_11),
        .NEXUS_UPDATE(tap_NEXUS_UPDATE_12),
        .NEXUS_TDI(tap_NEXUS_TDI_13),
        .sync_data_from_clk_DONE_TCK(sync_data_from_clk_DONE_TCK_14),
        .sync_data_from_clk_TCK(sync_data_from_clk_TCK_15),
        .NEXUS_TDO(tck_domain_NEXUS_TDO_6),
        .sync_addr_from_tck_READY_TCK(tck_domain_sync_addr_from_tck_READY_TCK_16),
        .sync_addr_from_tck_TCK(tck_domain_sync_addr_from_tck_TCK_17),
        .sync_data_from_tck_READY_TCK(tck_domain_sync_data_from_tck_READY_TCK_18),
        .sync_data_from_tck_TCK(tck_domain_sync_data_from_tck_TCK_19)
    );

    // instance of 'sync' clock domain crossing synchronization - encapsulation unit:
    codix_berkelium_ca_nexus_port_sync_t sync (
        .CLK(CLK),
        .TCK(TCK),
        .RST(RST),
        .TRST(TRST),
        .addr_from_tck_READY_TCK(tck_domain_sync_addr_from_tck_READY_TCK_16),
        .addr_from_tck_TCK(tck_domain_sync_addr_from_tck_TCK_17),
        .data_from_clk_CLK(clk_domain_sync_data_from_clk_CLK_4),
        .data_from_clk_READY_CLK(clk_domain_sync_data_from_clk_READY_CLK_5),
        .data_from_tck_READY_TCK(tck_domain_sync_data_from_tck_READY_TCK_18),
        .data_from_tck_TCK(tck_domain_sync_data_from_tck_TCK_19),
        .NEXUS_BAR_TCK(tap_NEXUS_BAR_8),
        .DEBUG_MODE_CLK(DEBUG_MODE),
        .addr_from_tck_CLK(sync_addr_from_tck_CLK_0),
        .addr_from_tck_DONE_CLK(sync_addr_from_tck_DONE_CLK_1),
        .data_from_clk_DONE_TCK(sync_data_from_clk_DONE_TCK_14),
        .data_from_clk_TCK(sync_data_from_clk_TCK_15),
        .data_from_tck_CLK(sync_data_from_tck_CLK_2),
        .data_from_tck_DONE_CLK(sync_data_from_tck_DONE_CLK_3),
        .NEXUS_BAR_CLK(NEXUS_BAR),
        .DEBUG_MODE_TCK(sync_DEBUG_MODE_TCK_7)
    );

endmodule
