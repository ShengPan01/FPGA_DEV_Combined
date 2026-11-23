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
 *  \brief   Contains module definition of the 'codix_berkelium_ca_core_barrel_shifter_32_inline_1_inline_1_t' functional unit.
 */

module codix_berkelium_ca_core_barrel_shifter_32_inline_1_inline_1_t(
    input  wire ACT,
    input  wire [3:0] codasip_param_0,
    input  wire [31:0] codasip_param_1,
    input  wire [4:0] codasip_param_2,
    output wire [31:0] RET
);
    // type, wire and constant declarations:
    // signal/wire (inner)
    wire [31:0] codasip_return2_barrel_shifter_32_inline_1_inline_1;
    // signal/wire (inner)
    wire [31:0] op1_inline_1_inline_1;
    // signal/wire (inner)
    wire [31:0] op1_lsb_inline_1_inline_1_B0;
    // signal/wire (inner)
    wire op1_msb_inline_1_inline_1_B0;
    // signal/wire (inner)
    wire [31:0] op1_rev_inline_1_inline_1_B0;
    // signal/wire (inner)
    wire signed [32:0] op1_sh_inline_1_inline_1_B0;
    // signal/wire (inner)
    wire [4:0] op2_inline_1_inline_1;
    // signal/wire (inner)
    wire [3:0] opr_inline_1_inline_1;
    // signal/wire (inner)
    wire [31:0] res_final_inline_1_inline_1_B0;
    // signal/wire (inner)
    wire [31:0] res_inline_1_inline_1_B0;
    // signal/wire (inner)
    wire [31:0] res_rev_inline_1_inline_1_B0;

    // additional declarations:
    wire [31:0] tmp_codasip_conv_SHIFT_RIGHT_2971_1;
    wire signed [32:0] tmp_codasip_conv_SHIFT_RIGHT_2971_2;

    // conversions for data-path:
    assign tmp_codasip_conv_SHIFT_RIGHT_2971_2 = $signed((op1_sh_inline_1_inline_1_B0 >>> op2_inline_1_inline_1));
    assign tmp_codasip_conv_SHIFT_RIGHT_2971_1 = tmp_codasip_conv_SHIFT_RIGHT_2971_2[31:0];
    // data-path code:
    assign opr_inline_1_inline_1 = codasip_param_0;
    assign op1_inline_1_inline_1 = codasip_param_1;
    assign op2_inline_1_inline_1 = codasip_param_2;
    assign op1_rev_inline_1_inline_1_B0 = {{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{op1_inline_1_inline_1[0],op1_inline_1_inline_1[1]},op1_inline_1_inline_1[2]},op1_inline_1_inline_1[3]},op1_inline_1_inline_1[4]},op1_inline_1_inline_1[5]},op1_inline_1_inline_1[6]},op1_inline_1_inline_1[7]},op1_inline_1_inline_1[8]},op1_inline_1_inline_1[9]},op1_inline_1_inline_1[10]},op1_inline_1_inline_1[11]},op1_inline_1_inline_1[12]},op1_inline_1_inline_1[13]},op1_inline_1_inline_1[14]},op1_inline_1_inline_1[15]},op1_inline_1_inline_1[16]},op1_inline_1_inline_1[17]},op1_inline_1_inline_1[18]},op1_inline_1_inline_1[19]},op1_inline_1_inline_1[20]},op1_inline_1_inline_1[21]},op1_inline_1_inline_1[22]},op1_inline_1_inline_1[23]},op1_inline_1_inline_1[24]},op1_inline_1_inline_1[25]},op1_inline_1_inline_1[26]},op1_inline_1_inline_1[27]},op1_inline_1_inline_1[28]},op1_inline_1_inline_1[29]},op1_inline_1_inline_1[30]},op1_inline_1_inline_1[31]};
    assign op1_msb_inline_1_inline_1_B0 = (((opr_inline_1_inline_1 == 4'd14)) ? op1_inline_1_inline_1[31] : 1'd0);
    assign op1_lsb_inline_1_inline_1_B0 = (((opr_inline_1_inline_1 == 4'd1)) ? op1_rev_inline_1_inline_1_B0 : op1_inline_1_inline_1);
    assign op1_sh_inline_1_inline_1_B0 = $signed({op1_msb_inline_1_inline_1_B0,op1_lsb_inline_1_inline_1_B0});
    assign res_inline_1_inline_1_B0 = tmp_codasip_conv_SHIFT_RIGHT_2971_1;
    assign res_rev_inline_1_inline_1_B0 = {{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{res_inline_1_inline_1_B0[0],res_inline_1_inline_1_B0[1]},res_inline_1_inline_1_B0[2]},res_inline_1_inline_1_B0[3]},res_inline_1_inline_1_B0[4]},res_inline_1_inline_1_B0[5]},res_inline_1_inline_1_B0[6]},res_inline_1_inline_1_B0[7]},res_inline_1_inline_1_B0[8]},res_inline_1_inline_1_B0[9]},res_inline_1_inline_1_B0[10]},res_inline_1_inline_1_B0[11]},res_inline_1_inline_1_B0[12]},res_inline_1_inline_1_B0[13]},res_inline_1_inline_1_B0[14]},res_inline_1_inline_1_B0[15]},res_inline_1_inline_1_B0[16]},res_inline_1_inline_1_B0[17]},res_inline_1_inline_1_B0[18]},res_inline_1_inline_1_B0[19]},res_inline_1_inline_1_B0[20]},res_inline_1_inline_1_B0[21]},res_inline_1_inline_1_B0[22]},res_inline_1_inline_1_B0[23]},res_inline_1_inline_1_B0[24]},res_inline_1_inline_1_B0[25]},res_inline_1_inline_1_B0[26]},res_inline_1_inline_1_B0[27]},res_inline_1_inline_1_B0[28]},res_inline_1_inline_1_B0[29]},res_inline_1_inline_1_B0[30]},res_inline_1_inline_1_B0[31]};
    assign res_final_inline_1_inline_1_B0 = (((opr_inline_1_inline_1 == 4'd1)) ? res_rev_inline_1_inline_1_B0 : res_inline_1_inline_1_B0);
    assign codasip_return2_barrel_shifter_32_inline_1_inline_1 = (ACT == 1'd1) ? res_final_inline_1_inline_1_B0 : 32'd0;
    assign RET = codasip_return2_barrel_shifter_32_inline_1_inline_1;
endmodule
