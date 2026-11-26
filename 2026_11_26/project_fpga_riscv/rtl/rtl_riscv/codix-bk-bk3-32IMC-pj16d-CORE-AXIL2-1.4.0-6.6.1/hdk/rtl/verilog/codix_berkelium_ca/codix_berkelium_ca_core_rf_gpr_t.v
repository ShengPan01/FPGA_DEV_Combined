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
 *  \brief   Contains module definition of the 'codix_berkelium_ca_core_rf_gpr_t' register file with BSC.
 */

module codix_berkelium_ca_core_rf_gpr_t(
    input  wire CLK,
    input  wire RST,
    input  wire [31:0] BSC_D0,
    input  wire [1:0] BSC_UPDATE0,
    input  wire [31:0] D0,
    input  wire DEBUG_MODE,
    input  wire [4:0] RA0,
    input  wire [4:0] RA1,
    input  wire RE0,
    input  wire RE1,
    input  wire [4:0] WA0,
    input  wire WE0,
    output wire [31:0] BSC_Q0,
    output wire [31:0] Q0,
    output wire [31:0] Q1
);
    // type, wire and constant declarations:

    // additional declarations:
    wire inner_rf_gpr_RE0;
    wire [4:0] inner_rf_gpr_RA0;
    wire inner_rf_gpr_RE1;
    wire [4:0] inner_rf_gpr_RA1;
    wire inner_rf_gpr_WE0;
    wire [4:0] inner_rf_gpr_WA0;
    wire [31:0] inner_rf_gpr_D0;
    wire [31:0] inner_rf_gpr_Q0;
    wire [31:0] inner_rf_gpr_Q1;
    wire A0_reg_WE0;
    wire [4:0] A0_reg_D0;
    wire [4:0] A0_reg_Q0;

    // child instances inside 'rf_gpr' CodAL register file with boundary scan-chain support:
    // instance of 'inner_rf_gpr' CodAL register file:
    codix_berkelium_ca_core_rf_gpr_inner_rf_gpr_t inner_rf_gpr (
        .CLK(CLK),
        .RST(RST),
        .RE0(inner_rf_gpr_RE0),
        .RA0(inner_rf_gpr_RA0),
        .RE1(inner_rf_gpr_RE1),
        .RA1(inner_rf_gpr_RA1),
        .WE0(inner_rf_gpr_WE0),
        .WA0(inner_rf_gpr_WA0),
        .D0(inner_rf_gpr_D0),
        .Q0(inner_rf_gpr_Q0),
        .Q1(inner_rf_gpr_Q1)
    );

    // instance of 'A0_reg' register:
    d_ff_plain_rst_we_t #(
        .bit_width(32'd5),
        .default_value(5'b0),
        .reset_level(1'b0),
        .reset_sync(1'b0)
    ) A0_reg (
        .CLK(CLK),
        .RST(RST),
        .WE0(A0_reg_WE0),
        .D0(A0_reg_D0),
        .Q0(A0_reg_Q0)
    );

    // data-path code:
    assign A0_reg_D0 = BSC_D0[31:27];
    assign A0_reg_WE0 = BSC_UPDATE0[0];
    assign inner_rf_gpr_RE0 = (DEBUG_MODE == 1'd1) ? 1'd1 : RE0;
    assign inner_rf_gpr_RA0 = (DEBUG_MODE == 1'd1) ? A0_reg_Q0 : RA0;
    assign Q0 = inner_rf_gpr_Q0;
    assign inner_rf_gpr_WE0 = (DEBUG_MODE == 1'd1) ? BSC_UPDATE0[1] : WE0;
    assign inner_rf_gpr_WA0 = (DEBUG_MODE == 1'd1) ? A0_reg_Q0 : WA0;
    assign inner_rf_gpr_D0 = (DEBUG_MODE == 1'd1) ? BSC_D0 : D0;
    assign inner_rf_gpr_RE1 = RE1;
    assign inner_rf_gpr_RA1 = RA1;
    assign Q1 = inner_rf_gpr_Q1;
    assign BSC_Q0 = inner_rf_gpr_Q0;
endmodule
