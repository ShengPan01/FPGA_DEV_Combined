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
 *  \brief   Contains module definition of the 'codix_berkelium_ca_core_ex_cmp_t' functional unit.
 */

module codix_berkelium_ca_core_ex_cmp_t(
    input  wire ACT,
    input  wire [2:0] s_ex_cmp_function_Q0,
    input  wire [31:0] s_ex_rs1_data_bypassed_Q0,
    input  wire [31:0] s_ex_rs2_data_bypassed_Q0,
    output wire s_ex_cmp_true_D0
);
    // type, wire and constant declarations:
    // signal/wire (inner)
    wire [2:0] codasip_tmp_var_0;
    // signal/wire (CodAL)
    wire ex_cmp_op1_sext;
    // signal/wire (CodAL)
    wire ex_cmp_op2_sext;
    // signal/wire (inner)
    wire ex_cmp_true_B0;

    // additional declarations:
    // temporal variable for multiplexer, should not be synthesized as register
    reg tmp_codasip_conv_cs_ex_cmp_true_B0_D0_mux_1;

    // data-path code:
    assign ex_cmp_op1_sext = ((((s_ex_cmp_function_Q0 == 3'd2) || (s_ex_cmp_function_Q0 == 3'd3))) ? s_ex_rs1_data_bypassed_Q0[31] : 1'd0);
    assign ex_cmp_op2_sext = ((((s_ex_cmp_function_Q0 == 3'd2) || (s_ex_cmp_function_Q0 == 3'd3))) ? s_ex_rs2_data_bypassed_Q0[31] : 1'd0);
    assign codasip_tmp_var_0 = s_ex_cmp_function_Q0;
    always @(*) begin
        case ( codasip_tmp_var_0 )
            3'd0: tmp_codasip_conv_cs_ex_cmp_true_B0_D0_mux_1 = (s_ex_rs1_data_bypassed_Q0 == s_ex_rs2_data_bypassed_Q0);
            3'd1: tmp_codasip_conv_cs_ex_cmp_true_B0_D0_mux_1 = (s_ex_rs1_data_bypassed_Q0 != s_ex_rs2_data_bypassed_Q0);
            3'd2: tmp_codasip_conv_cs_ex_cmp_true_B0_D0_mux_1 = ($signed({ex_cmp_op1_sext,s_ex_rs1_data_bypassed_Q0}) < $signed({ex_cmp_op2_sext,s_ex_rs2_data_bypassed_Q0}));
            3'd3: tmp_codasip_conv_cs_ex_cmp_true_B0_D0_mux_1 = ($signed({ex_cmp_op1_sext,s_ex_rs1_data_bypassed_Q0}) >= $signed({ex_cmp_op2_sext,s_ex_rs2_data_bypassed_Q0}));
            3'd4: tmp_codasip_conv_cs_ex_cmp_true_B0_D0_mux_1 = ($signed({ex_cmp_op1_sext,s_ex_rs1_data_bypassed_Q0}) < $signed({ex_cmp_op2_sext,s_ex_rs2_data_bypassed_Q0}));
            3'd5: tmp_codasip_conv_cs_ex_cmp_true_B0_D0_mux_1 = ($signed({ex_cmp_op1_sext,s_ex_rs1_data_bypassed_Q0}) >= $signed({ex_cmp_op2_sext,s_ex_rs2_data_bypassed_Q0}));
            default: tmp_codasip_conv_cs_ex_cmp_true_B0_D0_mux_1 = 1'd0;
        endcase
    end
    assign ex_cmp_true_B0 = tmp_codasip_conv_cs_ex_cmp_true_B0_D0_mux_1;
    assign s_ex_cmp_true_D0 = (ACT == 1'd1) ? ex_cmp_true_B0 : 1'd0;
endmodule
