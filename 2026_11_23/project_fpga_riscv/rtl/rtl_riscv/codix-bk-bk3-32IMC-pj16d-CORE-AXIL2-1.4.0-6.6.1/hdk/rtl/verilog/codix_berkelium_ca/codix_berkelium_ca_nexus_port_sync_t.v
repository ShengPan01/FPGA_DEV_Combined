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
 *  \brief   Contains module definition of the 'codix_berkelium_ca_nexus_port_sync_t' clock domain crossing synchronization - encapsulation unit.
 */

module codix_berkelium_ca_nexus_port_sync_t(
    input  wire CLK,
    input  wire TCK,
    input  wire RST,
    input  wire TRST,
    input  wire addr_from_tck_READY_TCK,
    input  wire [7:0] addr_from_tck_TCK,
    input  wire [31:0] data_from_clk_CLK,
    input  wire data_from_clk_READY_CLK,
    input  wire data_from_tck_READY_TCK,
    input  wire [31:0] data_from_tck_TCK,
    input  wire NEXUS_BAR_TCK,
    input  wire DEBUG_MODE_CLK,
    output wire [7:0] addr_from_tck_CLK,
    output wire addr_from_tck_DONE_CLK,
    output wire data_from_clk_DONE_TCK,
    output wire [31:0] data_from_clk_TCK,
    output wire [31:0] data_from_tck_CLK,
    output wire data_from_tck_DONE_CLK,
    output wire NEXUS_BAR_CLK,
    output wire DEBUG_MODE_TCK
);
    // type, wire and constant declarations:

    // additional declarations:
    wire DEBUG_MODE_CLK_sync_reg_Q0_0;
    wire addr_from_tck_READY_CLK_sync_reg_Q0_1;
    wire data_from_clk_READY_TCK_sync_reg_Q0_2;
    wire data_from_tck_READY_CLK_sync_reg_Q0_3;

    // child instances inside 'sync' clock domain crossing synchronization - encapsulation unit:
    // instance of 'NEXUS_BAR_CLK_sync_reg' register:
    shift_reg_rst_t #(
        .bit_width(32'd2),
        .default_value(2'b11),
        .reset_level(1'b0),
        .reset_sync(1'b0)
    ) NEXUS_BAR_CLK_sync_reg (
        .CLK(CLK),
        .RST(RST),
        .D0(NEXUS_BAR_TCK),
        .Q0(NEXUS_BAR_CLK)
    );

    // instance of 'DEBUG_MODE_CLK_sync_reg' register:
    d_ff_plain_rst_t #(
        .bit_width(32'd1),
        .default_value(1'b0),
        .reset_level(1'b0),
        .reset_sync(1'b0)
    ) DEBUG_MODE_CLK_sync_reg (
        .CLK(CLK),
        .RST(RST),
        .D0(DEBUG_MODE_CLK),
        .Q0(DEBUG_MODE_CLK_sync_reg_Q0_0)
    );

    // instance of 'DEBUG_MODE_TCK_sync_reg' register:
    shift_reg_rst_t #(
        .bit_width(32'd2),
        .default_value(2'b0),
        .reset_level(1'b0),
        .reset_sync(1'b0)
    ) DEBUG_MODE_TCK_sync_reg (
        .CLK(TCK),
        .RST(TRST),
        .D0(DEBUG_MODE_CLK_sync_reg_Q0_0),
        .Q0(DEBUG_MODE_TCK)
    );

    // instance of 'addr_from_tck_READY_CLK_sync_reg' register:
    shift_reg_edge_rst_t #(
        .bit_width(32'd3),
        .default_value(3'b0),
        .reset_level(1'b0),
        .reset_sync(1'b0)
    ) addr_from_tck_READY_CLK_sync_reg (
        .CLK(CLK),
        .RST(RST),
        .D0(addr_from_tck_READY_TCK),
        .Q0(addr_from_tck_READY_CLK_sync_reg_Q0_1)
    );

    // instance of 'addr_from_tck_CLK_sync_reg' register:
    d_ff_plain_rst_we_t #(
        .bit_width(32'd8),
        .default_value(8'b0),
        .reset_level(1'b0),
        .reset_sync(1'b0)
    ) addr_from_tck_CLK_sync_reg (
        .CLK(CLK),
        .RST(RST),
        .WE0(addr_from_tck_READY_CLK_sync_reg_Q0_1),
        .D0(addr_from_tck_TCK),
        .Q0(addr_from_tck_CLK)
    );

    // instance of 'addr_from_tck_DONE_CLK_sync_reg' register:
    d_ff_plain_rst_t #(
        .bit_width(32'd1),
        .default_value(1'b0),
        .reset_level(1'b0),
        .reset_sync(1'b0)
    ) addr_from_tck_DONE_CLK_sync_reg (
        .CLK(CLK),
        .RST(RST),
        .D0(addr_from_tck_READY_CLK_sync_reg_Q0_1),
        .Q0(addr_from_tck_DONE_CLK)
    );

    // instance of 'data_from_clk_READY_TCK_sync_reg' register:
    shift_reg_edge_rst_t #(
        .bit_width(32'd3),
        .default_value(3'b0),
        .reset_level(1'b0),
        .reset_sync(1'b0)
    ) data_from_clk_READY_TCK_sync_reg (
        .CLK(TCK),
        .RST(TRST),
        .D0(data_from_clk_READY_CLK),
        .Q0(data_from_clk_READY_TCK_sync_reg_Q0_2)
    );

    // instance of 'data_from_clk_TCK_sync_reg' register:
    d_ff_plain_rst_we_t #(
        .bit_width(32'd32),
        .default_value(32'b0),
        .reset_level(1'b0),
        .reset_sync(1'b0)
    ) data_from_clk_TCK_sync_reg (
        .CLK(TCK),
        .RST(TRST),
        .WE0(data_from_clk_READY_TCK_sync_reg_Q0_2),
        .D0(data_from_clk_CLK),
        .Q0(data_from_clk_TCK)
    );

    // instance of 'data_from_clk_DONE_TCK_sync_reg' register:
    d_ff_plain_rst_t #(
        .bit_width(32'd1),
        .default_value(1'b0),
        .reset_level(1'b0),
        .reset_sync(1'b0)
    ) data_from_clk_DONE_TCK_sync_reg (
        .CLK(TCK),
        .RST(TRST),
        .D0(data_from_clk_READY_TCK_sync_reg_Q0_2),
        .Q0(data_from_clk_DONE_TCK)
    );

    // instance of 'data_from_tck_READY_CLK_sync_reg' register:
    shift_reg_edge_rst_t #(
        .bit_width(32'd3),
        .default_value(3'b0),
        .reset_level(1'b0),
        .reset_sync(1'b0)
    ) data_from_tck_READY_CLK_sync_reg (
        .CLK(CLK),
        .RST(RST),
        .D0(data_from_tck_READY_TCK),
        .Q0(data_from_tck_READY_CLK_sync_reg_Q0_3)
    );

    // instance of 'data_from_tck_CLK_sync_reg' register:
    d_ff_plain_rst_we_t #(
        .bit_width(32'd32),
        .default_value(32'b0),
        .reset_level(1'b0),
        .reset_sync(1'b0)
    ) data_from_tck_CLK_sync_reg (
        .CLK(CLK),
        .RST(RST),
        .WE0(data_from_tck_READY_CLK_sync_reg_Q0_3),
        .D0(data_from_tck_TCK),
        .Q0(data_from_tck_CLK)
    );

    // instance of 'data_from_tck_DONE_CLK_sync_reg' register:
    d_ff_plain_rst_t #(
        .bit_width(32'd1),
        .default_value(1'b0),
        .reset_level(1'b0),
        .reset_sync(1'b0)
    ) data_from_tck_DONE_CLK_sync_reg (
        .CLK(CLK),
        .RST(RST),
        .D0(data_from_tck_READY_CLK_sync_reg_Q0_3),
        .Q0(data_from_tck_DONE_CLK)
    );

endmodule
