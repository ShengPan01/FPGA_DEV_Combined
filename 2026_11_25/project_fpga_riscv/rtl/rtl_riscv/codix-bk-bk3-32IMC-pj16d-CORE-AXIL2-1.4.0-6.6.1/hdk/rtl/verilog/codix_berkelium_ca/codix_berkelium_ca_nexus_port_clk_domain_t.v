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
 *  \brief   Contains module definition of the 'codix_berkelium_ca_nexus_port_clk_domain_t' select Nexus client connected to Nexus Port (global clock domain).
 */

module codix_berkelium_ca_nexus_port_clk_domain_t(
    input  wire CLK,
    input  wire RST,
    input  wire [7:0] sync_addr_from_tck_CLK,
    input  wire sync_addr_from_tck_DONE_CLK,
    input  wire [31:0] sync_data_from_tck_CLK,
    input  wire sync_data_from_tck_DONE_CLK,
    input  wire [31:0] if_ldst_NEXUS_CLIENT_Q0,
    input  wire [31:0] nexus_client_NEXUS_CLIENT_Q0,
    output wire [6:0] NEXUS_RRS,
    output wire [31:0] sync_data_from_clk_CLK,
    output wire sync_data_from_clk_READY_CLK,
    output wire if_ldst_NEXUS_CLIENT_CAPTURE,
    output wire [31:0] if_ldst_NEXUS_CLIENT_D0,
    output wire if_ldst_NEXUS_CLIENT_UPDATE,
    output wire nexus_client_NEXUS_CLIENT_CAPTURE,
    output wire [31:0] nexus_client_NEXUS_CLIENT_D0,
    output wire nexus_client_NEXUS_CLIENT_UPDATE
);
    // type, wire and constant declarations:
    // signal/wire (inner)
    wire client_select_enable_wire;
    // signal/wire (inner)
    wire client_select_1_wire;
    // signal/wire (inner)
    wire client_select_0_wire;

    // additional declarations:
    wire nrrs_reg_WE0;
    wire [7:0] nrrs_reg_D0;
    wire [7:0] nrrs_reg_Q0;
    wire csc_reg_WE0;
    wire [7:0] csc_reg_D0;
    wire [7:0] csc_reg_Q0;
    wire data_status_reg_WE0;
    wire data_status_reg_D0;
    wire data_status_reg_Q0;
    wire data_out_reg_WE0;
    wire [31:0] data_out_reg_D0;
    wire [31:0] data_out_reg_Q0;
    wire addr_done_delay_reg_D0;
    wire addr_done_delay_reg_Q0;

    // child instances inside 'clk_domain' select Nexus client connected to Nexus Port (global clock domain):
    // instance of 'nrrs_reg' register:
    d_ff_plain_rst_we_t #(
        .bit_width(32'd8),
        .default_value(8'b0),
        .reset_level(1'b0),
        .reset_sync(1'b0)
    ) nrrs_reg (
        .CLK(CLK),
        .RST(RST),
        .WE0(nrrs_reg_WE0),
        .D0(nrrs_reg_D0),
        .Q0(nrrs_reg_Q0)
    );

    // instance of 'csc_reg' register:
    d_ff_plain_rst_we_t #(
        .bit_width(32'd8),
        .default_value(8'b0),
        .reset_level(1'b0),
        .reset_sync(1'b0)
    ) csc_reg (
        .CLK(CLK),
        .RST(RST),
        .WE0(csc_reg_WE0),
        .D0(csc_reg_D0),
        .Q0(csc_reg_Q0)
    );

    // instance of 'data_status_reg' register:
    d_ff_plain_rst_we_t #(
        .bit_width(32'd1),
        .default_value(1'b0),
        .reset_level(1'b0),
        .reset_sync(1'b0)
    ) data_status_reg (
        .CLK(CLK),
        .RST(RST),
        .WE0(data_status_reg_WE0),
        .D0(data_status_reg_D0),
        .Q0(data_status_reg_Q0)
    );

    // instance of 'data_out_reg' register:
    d_ff_plain_rst_we_t #(
        .bit_width(32'd32),
        .default_value(32'b0),
        .reset_level(1'b0),
        .reset_sync(1'b0)
    ) data_out_reg (
        .CLK(CLK),
        .RST(RST),
        .WE0(data_out_reg_WE0),
        .D0(data_out_reg_D0),
        .Q0(data_out_reg_Q0)
    );

    // instance of 'addr_done_delay_reg' register:
    d_ff_plain_rst_t #(
        .bit_width(32'd1),
        .default_value(1'b0),
        .reset_level(1'b0),
        .reset_sync(1'b0)
    ) addr_done_delay_reg (
        .CLK(CLK),
        .RST(RST),
        .D0(addr_done_delay_reg_D0),
        .Q0(addr_done_delay_reg_Q0)
    );

    // data-path code:
    assign addr_done_delay_reg_D0 = sync_addr_from_tck_DONE_CLK;
    assign nrrs_reg_D0 = sync_addr_from_tck_CLK;
    assign nrrs_reg_WE0 = sync_addr_from_tck_DONE_CLK;
    assign csc_reg_D0 = sync_data_from_tck_CLK[31:24];
    assign csc_reg_WE0 = ((sync_data_from_tck_DONE_CLK == 1'd1) && (nrrs_reg_Q0 == 8'd3));
    assign data_status_reg_D0 = addr_done_delay_reg_Q0;
    assign data_status_reg_WE0 = (addr_done_delay_reg_Q0 | sync_data_from_tck_DONE_CLK);
    assign client_select_enable_wire = (nrrs_reg_Q0[7:2] != 6'd0);
    assign client_select_1_wire = ((client_select_enable_wire == 1'd1) && (csc_reg_Q0 == 8'd1));
    assign client_select_0_wire = ((client_select_enable_wire == 1'd1) && (csc_reg_Q0 == 8'd0));
    assign data_out_reg_D0 = (nrrs_reg_Q0[0] == 1'd1) ? 32'd0 :
        (nrrs_reg_Q0[7:1] == 7'd0) ? 32'd1946918914 :
        (nrrs_reg_Q0[7:1] == 7'd1) ? {24'd0,csc_reg_Q0} :
        (client_select_1_wire == 1'd1) ? if_ldst_NEXUS_CLIENT_Q0 :
        (client_select_0_wire == 1'd1) ? nexus_client_NEXUS_CLIENT_Q0 : 32'd0;
    assign data_out_reg_WE0 = addr_done_delay_reg_Q0;
    assign NEXUS_RRS = ((client_select_1_wire | client_select_0_wire) == 1'd1) ? nrrs_reg_Q0[7:1] : 7'd0;
    assign sync_data_from_clk_CLK = data_out_reg_Q0;
    assign sync_data_from_clk_READY_CLK = data_status_reg_Q0;
    assign if_ldst_NEXUS_CLIENT_CAPTURE = (client_select_1_wire & ((~nrrs_reg_Q0[0]) & addr_done_delay_reg_Q0));
    assign if_ldst_NEXUS_CLIENT_UPDATE = (client_select_1_wire & (nrrs_reg_Q0[0] & sync_data_from_tck_DONE_CLK));
    assign if_ldst_NEXUS_CLIENT_D0 = (client_select_1_wire == 1'd1) ? sync_data_from_tck_CLK : 32'd0;
    assign nexus_client_NEXUS_CLIENT_CAPTURE = (client_select_0_wire & ((~nrrs_reg_Q0[0]) & addr_done_delay_reg_Q0));
    assign nexus_client_NEXUS_CLIENT_UPDATE = (client_select_0_wire & (nrrs_reg_Q0[0] & sync_data_from_tck_DONE_CLK));
    assign nexus_client_NEXUS_CLIENT_D0 = (client_select_0_wire == 1'd1) ? sync_data_from_tck_CLK : 32'd0;
endmodule
