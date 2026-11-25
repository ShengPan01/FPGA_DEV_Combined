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
 *  \brief   Contains definition of generic boundary-scan register with synchronous write, configurable reset and with write enable signal.
 */

module bsc_d_ff_plain_rst_we_t #(
    parameter integer bit_width = 32'sd8,
    parameter [bit_width-1:0] default_value = {bit_width{1'b0}},
    parameter [0:0] reset_level = 1'b0,
    parameter [0:0] reset_sync = 1'b0
) (
    input  wire CLK,
    input  wire RST,
    input  wire [bit_width-1:0] BSC_D0,
    input  wire BSC_UPDATE0,
    input  wire [bit_width-1:0] D0,
    input  wire DEBUG_MODE,
    input  wire WE0,
    output wire [bit_width-1:0] BSC_Q0,
    output wire [bit_width-1:0] Q0
);

    // type, wire and constant declarations:

    // additional declarations:
    wire data_reg_WE0;
    wire [bit_width-1:0] data_reg_D0;
    wire [bit_width-1:0] data_reg_Q0;

    // child instances inside 'r_PC' register with boundary-scan support:
    // instance of 'data_reg' register:
    d_ff_plain_rst_we_t #(
        .bit_width(bit_width),
        .default_value(default_value),
        .reset_level(reset_level),
        .reset_sync(reset_sync)
    ) data_reg (
        .CLK(CLK),
        .RST(RST),
        .WE0(data_reg_WE0),
        .D0(data_reg_D0),
        .Q0(data_reg_Q0)
    );

    // data-path code:
    assign data_reg_D0 = (DEBUG_MODE == 1'd1) ? BSC_D0 : D0;
    assign data_reg_WE0 = (DEBUG_MODE == 1'd1) ? BSC_UPDATE0 : WE0;
    assign Q0 = data_reg_Q0;
    assign BSC_Q0 = data_reg_Q0;
endmodule
