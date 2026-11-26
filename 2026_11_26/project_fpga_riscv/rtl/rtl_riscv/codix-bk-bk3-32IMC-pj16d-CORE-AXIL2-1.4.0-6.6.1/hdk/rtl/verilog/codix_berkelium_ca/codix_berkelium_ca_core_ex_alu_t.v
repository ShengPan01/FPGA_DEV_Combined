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
 *  \brief   Contains module definition of the 'codix_berkelium_ca_core_ex_alu_t' functional unit.
 */

module codix_berkelium_ca_core_ex_alu_t(
    input  wire ACT,
    input  wire [31:0] codasip_return2_barrel_shifter_32_inline_1_inline_1_Q0,
    input  wire [24:0] r_ex_instr_Q0,
    input  wire [31:0] r_ex_pc_Q0,
    input  wire [3:0] s_ex_alu_function_Q0,
    input  wire [1:0] s_ex_aluop1_mux_Q0,
    input  wire s_ex_aluop2_mux_Q0,
    input  wire [31:0] s_ex_mul_div_result_Q0,
    input  wire [31:0] s_ex_rs1_data_bypassed_Q0,
    input  wire [31:0] s_ex_rs2_data_bypassed_Q0,
    input  wire [3:0] s_ex_sel_imm_Q0,
    output wire barrel_shifter_32_inline_1_inline_1_ACT,
    output wire [3:0] barrel_shifter_32_inline_1_inline_1_codasip_param_0,
    output wire [31:0] barrel_shifter_32_inline_1_inline_1_codasip_param_1,
    output wire [4:0] barrel_shifter_32_inline_1_inline_1_codasip_param_2,
    output wire [31:0] s_ex_add_result_D0,
    output wire [31:0] s_ex_result_D0
);
    // type, wire and constant declarations:
    // signal/wire (inner)
    wire codasip_tmp_var_0;
    // signal/wire (inner)
    wire [3:0] codasip_tmp_var_1;
    // signal/wire (inner)
    wire [31:0] ex_add_result_B0;
    // signal/wire (inner)
    wire [31:0] ex_alu_adder_op2_B0B0;
    // signal/wire (inner)
    wire [31:0] ex_aluop1_B0;
    // signal/wire (inner)
    wire [31:0] ex_aluop2_B0;
    // signal/wire (inner)
    wire ex_carry_B0B0;
    // signal/wire (inner)
    wire ex_cmp_op1_sext_B0;
    // signal/wire (inner)
    wire ex_cmp_op2_sext_B0;
    // signal/wire (inner)
    wire [31:0] ex_imm_B0;
    // signal/wire (inner)
    wire [31:0] ex_result_B0;
    // signal/wire (inner)
    wire [31:0] ex_shift_result_B0;
    // signal/wire (inner)
    wire [31:0] imm_i_B0;
    // signal/wire (inner)
    wire [31:0] imm_s_B0;
    // signal/wire (inner)
    wire [31:0] imm_sb_B0;
    // signal/wire (inner)
    wire [31:0] imm_u_B0;
    // signal/wire (inner)
    wire [31:0] imm_uj_B0;

    // additional declarations:
    wire signed [31:0] tmp_codasip_conv_STATIC_CAST_3844_1;
    wire signed [31:0] tmp_codasip_conv_STATIC_CAST_3852_2;
    wire signed [31:0] tmp_codasip_conv_STATIC_CAST_3872_3;
    wire signed [31:0] tmp_codasip_conv_STATIC_CAST_3891_4;
    // temporal variable for multiplexer, should not be synthesized as register
    reg [31:0] tmp_codasip_conv_cs_ex_result_B0_D0_mux_5;

    // conversions for data-path:
    assign tmp_codasip_conv_STATIC_CAST_3844_1 = $signed(r_ex_instr_Q0[24:13]);
    assign tmp_codasip_conv_STATIC_CAST_3852_2 = $signed({r_ex_instr_Q0[24:18],r_ex_instr_Q0[4:0]});
    assign tmp_codasip_conv_STATIC_CAST_3872_3 = $signed({{{{r_ex_instr_Q0[24],r_ex_instr_Q0[0]},r_ex_instr_Q0[23:18]},r_ex_instr_Q0[4:1]},1'd0});
    assign tmp_codasip_conv_STATIC_CAST_3891_4 = $signed({{{{r_ex_instr_Q0[24],r_ex_instr_Q0[12:5]},r_ex_instr_Q0[13]},r_ex_instr_Q0[23:14]},1'd0});
    // data-path code:
    assign imm_i_B0 = $unsigned(tmp_codasip_conv_STATIC_CAST_3844_1);
    assign imm_s_B0 = $unsigned(tmp_codasip_conv_STATIC_CAST_3852_2);
    assign imm_u_B0 = $unsigned($signed({r_ex_instr_Q0[24:5],12'd0}));
    assign imm_sb_B0 = $unsigned(tmp_codasip_conv_STATIC_CAST_3872_3);
    assign imm_uj_B0 = $unsigned(tmp_codasip_conv_STATIC_CAST_3891_4);
    assign ex_imm_B0 = (((s_ex_sel_imm_Q0 == 4'd4)) ? imm_i_B0 : (((s_ex_sel_imm_Q0 == 4'd0)) ? imm_s_B0 : (((s_ex_sel_imm_Q0 == 4'd2)) ? imm_u_B0 : (((s_ex_sel_imm_Q0 == 4'd1)) ? imm_sb_B0 : (((s_ex_sel_imm_Q0 == 4'd3)) ? imm_uj_B0 : 32'd4)))));
    assign ex_aluop1_B0 = (((s_ex_aluop1_mux_Q0 == 2'd1)) ? s_ex_rs1_data_bypassed_Q0 : (((s_ex_aluop1_mux_Q0 == 2'd2)) ? r_ex_pc_Q0 : 32'd0));
    assign ex_aluop2_B0 = (((s_ex_aluop2_mux_Q0 == 1'd1)) ? ex_imm_B0 : s_ex_rs2_data_bypassed_Q0);
    assign codasip_tmp_var_0 = (s_ex_alu_function_Q0 == 4'd10);
    assign ex_alu_adder_op2_B0B0 = codasip_tmp_var_0 ? (~ex_aluop2_B0) : ex_aluop2_B0;
    assign ex_carry_B0B0 = codasip_tmp_var_0 ? 1'd1 : 1'd0;
    assign ex_add_result_B0 = ((ex_aluop1_B0 + ex_alu_adder_op2_B0B0) + {{31{1'b0}}, ex_carry_B0B0});
    assign ex_shift_result_B0 = codasip_return2_barrel_shifter_32_inline_1_inline_1_Q0;
    assign ex_cmp_op1_sext_B0 = (((s_ex_alu_function_Q0 == 4'd5)) ? ex_aluop1_B0[31] : 1'd0);
    assign ex_cmp_op2_sext_B0 = (((s_ex_alu_function_Q0 == 4'd5)) ? ex_aluop2_B0[31] : 1'd0);
    assign codasip_tmp_var_1 = s_ex_alu_function_Q0;
    always @(*) begin
        case ( codasip_tmp_var_1 )
            4'd0: tmp_codasip_conv_cs_ex_result_B0_D0_mux_5 = ex_add_result_B0;
            4'd1: tmp_codasip_conv_cs_ex_result_B0_D0_mux_5 = ex_shift_result_B0;
            4'd4: tmp_codasip_conv_cs_ex_result_B0_D0_mux_5 = (ex_aluop1_B0 ^ ex_aluop2_B0);
            4'd5: tmp_codasip_conv_cs_ex_result_B0_D0_mux_5 = {{31{1'b0}}, ($signed({ex_cmp_op1_sext_B0,ex_aluop1_B0}) < $signed({ex_cmp_op2_sext_B0,ex_aluop2_B0}))};
            4'd6: tmp_codasip_conv_cs_ex_result_B0_D0_mux_5 = {{31{1'b0}}, ($signed({ex_cmp_op1_sext_B0,ex_aluop1_B0}) < $signed({ex_cmp_op2_sext_B0,ex_aluop2_B0}))};
            4'd7: tmp_codasip_conv_cs_ex_result_B0_D0_mux_5 = ex_shift_result_B0;
            4'd8: tmp_codasip_conv_cs_ex_result_B0_D0_mux_5 = (ex_aluop1_B0 | ex_aluop2_B0);
            4'd9: tmp_codasip_conv_cs_ex_result_B0_D0_mux_5 = (ex_aluop1_B0 & ex_aluop2_B0);
            4'd10: tmp_codasip_conv_cs_ex_result_B0_D0_mux_5 = ex_add_result_B0;
            4'd11: tmp_codasip_conv_cs_ex_result_B0_D0_mux_5 = s_ex_mul_div_result_Q0;
            4'd12: tmp_codasip_conv_cs_ex_result_B0_D0_mux_5 = s_ex_mul_div_result_Q0;
            4'd13: tmp_codasip_conv_cs_ex_result_B0_D0_mux_5 = s_ex_mul_div_result_Q0;
            4'd14: tmp_codasip_conv_cs_ex_result_B0_D0_mux_5 = ex_shift_result_B0;
            default: tmp_codasip_conv_cs_ex_result_B0_D0_mux_5 = 32'd0;
        endcase
    end
    assign ex_result_B0 = tmp_codasip_conv_cs_ex_result_B0_D0_mux_5;
    assign barrel_shifter_32_inline_1_inline_1_ACT = (ACT == 1'd1) ? 1'd1 : 1'd0;
    assign barrel_shifter_32_inline_1_inline_1_codasip_param_0 = (ACT == 1'd1) ? s_ex_alu_function_Q0 : 4'd0;
    assign barrel_shifter_32_inline_1_inline_1_codasip_param_1 = (ACT == 1'd1) ? ex_aluop1_B0 : 32'd0;
    assign barrel_shifter_32_inline_1_inline_1_codasip_param_2 = (ACT == 1'd1) ? ex_aluop2_B0[4:0] : 5'd0;
    assign s_ex_add_result_D0 = (ACT == 1'd1) ? ex_add_result_B0 : 32'd0;
    assign s_ex_result_D0 = (ACT == 1'd1) ? ex_result_B0 : 32'd0;
endmodule
