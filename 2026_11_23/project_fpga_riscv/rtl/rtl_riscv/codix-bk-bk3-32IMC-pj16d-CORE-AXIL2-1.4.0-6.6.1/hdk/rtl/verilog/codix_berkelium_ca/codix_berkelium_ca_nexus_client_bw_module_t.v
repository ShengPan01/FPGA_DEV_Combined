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
 *  \brief   Contains module definition of the 'codix_berkelium_ca_nexus_client_bw_module_t' Nexus breakpoint/watchpoint module.
 */

module codix_berkelium_ca_nexus_client_bw_module_t #(
    parameter [6:0] BW_INDEX = 7'd0
) (
    input  wire CLK,
    input  wire RST,
    input  wire [6:0] NEXUS_RRS,
    input  wire NEXUS_UPDATE,
    input  wire [31:0] NEXUS_BREAK_INSTR_A0,
    input  wire NEXUS_BREAK_INSTR_VALID,
    input  wire [31:0] NEXUS_CLIENT_D0,
    output wire NEXUS_SEL,
    output wire NEXUS_BREAK,
    output wire [31:0] NEXUS_CLIENT_Q0
);
    // type, wire and constant declarations:
    // signal/wire (inner)
    wire break_hit_flag_wire;
    // signal/wire (inner)
    wire break_flag_wire;
    // signal/wire (inner)
    wire nexus_rrs_bwc_sel_wire;
    // signal/wire (inner)
    wire nexus_rrs_bwa_sel_wire;

    // additional declarations:
    wire control_reg_WE0;
    wire [31:0] control_reg_D0;
    wire [31:0] control_reg_Q0;
    wire addr_reg_WE0;
    wire [31:0] addr_reg_D0;
    wire [31:0] addr_reg_Q0;

    // child instances inside 'bw0' Nexus breakpoint/watchpoint:
    // instance of 'control_reg' register:
    d_ff_plain_rst_we_t #(
        .bit_width(32'd32),
        .default_value(32'b0),
        .reset_level(1'b0),
        .reset_sync(1'b0)
    ) control_reg (
        .CLK(CLK),
        .RST(RST),
        .WE0(control_reg_WE0),
        .D0(control_reg_D0),
        .Q0(control_reg_Q0)
    );

    // instance of 'addr_reg' register:
    d_ff_plain_rst_we_t #(
        .bit_width(32'd32),
        .default_value(32'b0),
        .reset_level(1'b0),
        .reset_sync(1'b0)
    ) addr_reg (
        .CLK(CLK),
        .RST(RST),
        .WE0(addr_reg_WE0),
        .D0(addr_reg_D0),
        .Q0(addr_reg_Q0)
    );

    // data-path code:
    assign break_flag_wire = (NEXUS_BREAK_INSTR_A0 == addr_reg_Q0);
    assign break_hit_flag_wire = (break_flag_wire & (((~control_reg_Q0[31]) & control_reg_Q0[30]) & NEXUS_BREAK_INSTR_VALID));
    assign nexus_rrs_bwc_sel_wire = (NEXUS_RRS == (BW_INDEX + 7'd22));
    assign nexus_rrs_bwa_sel_wire = (NEXUS_RRS == (BW_INDEX + 7'd30));
    assign control_reg_D0 = NEXUS_CLIENT_D0;
    assign control_reg_WE0 = (NEXUS_UPDATE & nexus_rrs_bwc_sel_wire);
    assign addr_reg_D0 = NEXUS_CLIENT_D0;
    assign addr_reg_WE0 = (NEXUS_UPDATE & nexus_rrs_bwa_sel_wire);
    assign NEXUS_BREAK = break_hit_flag_wire;
    assign NEXUS_SEL = (nexus_rrs_bwc_sel_wire | nexus_rrs_bwa_sel_wire);
    assign NEXUS_CLIENT_Q0 = nexus_rrs_bwa_sel_wire ? addr_reg_Q0 : control_reg_Q0;
endmodule
