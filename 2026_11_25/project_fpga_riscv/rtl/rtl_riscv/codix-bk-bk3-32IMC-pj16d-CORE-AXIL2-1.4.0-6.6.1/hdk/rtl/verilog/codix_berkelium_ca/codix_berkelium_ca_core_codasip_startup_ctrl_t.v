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
 *  \brief   Contains module definition of the 'codix_berkelium_ca_core_codasip_startup_ctrl_t' startup controller.
 */

module codix_berkelium_ca_core_codasip_startup_ctrl_t(
    input  wire CLK,
    input  wire RST,
    input  wire reset_FIN,
    output wire main_ACT,
    output wire reset_ACT
);
    // type, wire and constant declarations:

    // additional declarations:
    wire main_ACT_reg_D0;
    wire main_ACT_reg_Q0;
    wire reset_ACT_reg_D0;
    wire reset_ACT_reg_Q0;
    wire reset_wait_reg_D0;
    wire reset_wait_reg_Q0;

    // child instances inside 'codasip_startup_ctrl' startup controller:
    // instance of 'main_ACT_reg' register:
    d_ff_plain_rst_t #(
        .bit_width(32'd1),
        .default_value(1'b0),
        .reset_level(1'b0),
        .reset_sync(1'b0)
    ) main_ACT_reg (
        .CLK(CLK),
        .RST(RST),
        .D0(main_ACT_reg_D0),
        .Q0(main_ACT_reg_Q0)
    );

    // instance of 'reset_ACT_reg' register:
    d_ff_plain_rst_t #(
        .bit_width(32'd1),
        .default_value(1'b0),
        .reset_level(1'b0),
        .reset_sync(1'b0)
    ) reset_ACT_reg (
        .CLK(CLK),
        .RST(RST),
        .D0(reset_ACT_reg_D0),
        .Q0(reset_ACT_reg_Q0)
    );

    // instance of 'reset_wait_reg' register:
    d_ff_plain_rst_t #(
        .bit_width(32'd1),
        .default_value(1'b0),
        .reset_level(1'b0),
        .reset_sync(1'b0)
    ) reset_wait_reg (
        .CLK(CLK),
        .RST(RST),
        .D0(reset_wait_reg_D0),
        .Q0(reset_wait_reg_Q0)
    );

    // data-path code:
    assign reset_ACT_reg_D0 = (((~main_ACT_reg_Q0) & (~reset_ACT_reg_Q0)) & (~reset_wait_reg_Q0));
    assign reset_wait_reg_D0 = (reset_ACT_reg_Q0 | ((~reset_FIN) & reset_wait_reg_Q0));
    assign main_ACT_reg_D0 = (main_ACT_reg_Q0 | reset_FIN);
    assign main_ACT = main_ACT_reg_Q0;
    assign reset_ACT = reset_ACT_reg_Q0;
endmodule
