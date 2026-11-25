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
 *  \brief   Contains module definition of the 'codix_berkelium_ca_core_ex_mul_div_t' functional unit.
 */

module codix_berkelium_ca_core_ex_mul_div_t(
    input  wire CLK,
    input  wire RST,
    input  wire ACT,
    input  wire [3:0] s_ex_alu_function_Q0,
    input  wire s_ex_aluop1_signed_Q0,
    input  wire s_ex_aluop2_signed_Q0,
    input  wire s_ex_mulh_Q0,
    input  wire s_ex_raw_hazard_Q0,
    input  wire [31:0] s_ex_rs1_data_bypassed_Q0,
    input  wire [31:0] s_ex_rs2_data_bypassed_Q0,
    input  wire s_sleep_Q0,
    input  wire s_wb_exc_Q0,
    input  wire s_wb_irq_Q0,
    input  wire s_wb_mret_Q0,
    input  wire s_wb_stall_wb_Q0,
    output wire [31:0] s_ex_mul_div_result_D0,
    output wire s_ex_mul_div_stall_D0
);
    // type, wire and constant declarations:
    // signal/wire (inner)
    wire [31:0] aluop1_abs_B0;
    // signal/wire (inner)
    wire aluop1_sign_B0;
    // signal/wire (inner)
    wire [31:0] aluop2_abs_B0;
    // signal/wire (inner)
    wire aluop2_sign_B0;
    // signal/wire (inner)
    wire codasip_tmp_var_0;
    // signal/wire (inner)
    wire [1:0] codasip_tmp_var_1;
    // signal/wire (inner)
    wire codasip_tmp_var_2;
    // signal/wire (inner)
    wire codasip_tmp_var_3;
    // signal/wire (inner)
    wire codasip_tmp_var_4;
    // signal/wire (inner)
    wire codasip_tmp_var_5;
    // signal/wire (inner)
    wire codasip_tmp_var_6;
    // signal/wire (inner)
    wire codasip_tmp_var_7;
    // signal/wire (inner)
    wire div_by_zero_B0;
    // signal/wire (inner)
    wire [63:0] result_final_B0;
    // signal/wire (inner)
    wire [63:0] result_muxed_B0;

    // additional declarations:
    wire r_a_result_WE0;
    wire [31:0] r_a_result_D0;
    wire [31:0] r_a_result_Q0;
    wire r_b_WE0;
    wire [63:0] r_b_D0;
    wire [63:0] r_b_Q0;
    wire r_counter_WE0;
    wire [6:0] r_counter_D0;
    wire [6:0] r_counter_Q0;
    wire r_mul_function_WE0;
    wire r_mul_function_D0;
    wire r_mul_function_Q0;
    wire r_mulh_WE0;
    wire r_mulh_D0;
    wire r_mulh_Q0;
    wire r_negate_output_WE0;
    wire r_negate_output_D0;
    wire r_negate_output_Q0;
    wire r_result_WE0;
    wire [63:0] r_result_D0;
    wire [63:0] r_result_Q0;
    wire r_state_WE0;
    wire [1:0] r_state_D0;
    wire [1:0] r_state_Q0;
    wire signed [31:0] tmp_codasip_conv_TERNARY_2070_1;
    wire [31:0] tmp_codasip_conv_MINUS_2487_2;

    // child instances inside 'ex_mul_div' functional unit:
    // instance of 'r_a_result' register:
    d_ff_plain_rst_we_t #(
        .bit_width(32'd32),
        .default_value(32'b0),
        .reset_level(1'b0),
        .reset_sync(1'b0)
    ) r_a_result (
        .CLK(CLK),
        .RST(RST),
        .WE0(r_a_result_WE0),
        .D0(r_a_result_D0),
        .Q0(r_a_result_Q0)
    );

    // instance of 'r_b' register:
    d_ff_plain_rst_we_t #(
        .bit_width(32'd64),
        .default_value(64'b0),
        .reset_level(1'b0),
        .reset_sync(1'b0)
    ) r_b (
        .CLK(CLK),
        .RST(RST),
        .WE0(r_b_WE0),
        .D0(r_b_D0),
        .Q0(r_b_Q0)
    );

    // instance of 'r_counter' register:
    d_ff_plain_rst_we_t #(
        .bit_width(32'd7),
        .default_value(7'b0),
        .reset_level(1'b0),
        .reset_sync(1'b0)
    ) r_counter (
        .CLK(CLK),
        .RST(RST),
        .WE0(r_counter_WE0),
        .D0(r_counter_D0),
        .Q0(r_counter_Q0)
    );

    // instance of 'r_mul_function' register:
    d_ff_plain_rst_we_t #(
        .bit_width(32'd1),
        .default_value(1'b0),
        .reset_level(1'b0),
        .reset_sync(1'b0)
    ) r_mul_function (
        .CLK(CLK),
        .RST(RST),
        .WE0(r_mul_function_WE0),
        .D0(r_mul_function_D0),
        .Q0(r_mul_function_Q0)
    );

    // instance of 'r_mulh' register:
    d_ff_plain_rst_we_t #(
        .bit_width(32'd1),
        .default_value(1'b0),
        .reset_level(1'b0),
        .reset_sync(1'b0)
    ) r_mulh (
        .CLK(CLK),
        .RST(RST),
        .WE0(r_mulh_WE0),
        .D0(r_mulh_D0),
        .Q0(r_mulh_Q0)
    );

    // instance of 'r_negate_output' register:
    d_ff_plain_rst_we_t #(
        .bit_width(32'd1),
        .default_value(1'b0),
        .reset_level(1'b0),
        .reset_sync(1'b0)
    ) r_negate_output (
        .CLK(CLK),
        .RST(RST),
        .WE0(r_negate_output_WE0),
        .D0(r_negate_output_D0),
        .Q0(r_negate_output_Q0)
    );

    // instance of 'r_result' register:
    d_ff_plain_rst_we_t #(
        .bit_width(32'd64),
        .default_value(64'b0),
        .reset_level(1'b0),
        .reset_sync(1'b0)
    ) r_result (
        .CLK(CLK),
        .RST(RST),
        .WE0(r_result_WE0),
        .D0(r_result_D0),
        .Q0(r_result_Q0)
    );

    // instance of 'r_state' register:
    d_ff_plain_rst_we_t #(
        .bit_width(32'd2),
        .default_value(2'b0),
        .reset_level(1'b0),
        .reset_sync(1'b0)
    ) r_state (
        .CLK(CLK),
        .RST(RST),
        .WE0(r_state_WE0),
        .D0(r_state_D0),
        .Q0(r_state_Q0)
    );

    // conversions for data-path:
    assign tmp_codasip_conv_TERNARY_2070_1 = $signed((((s_ex_alu_function_Q0 == 4'd11)) ? 32'sd0 : 32'sd31));
    assign tmp_codasip_conv_MINUS_2487_2 = $unsigned(({{25{1'b0}}, r_counter_Q0} - 32'd1));
    // data-path code:
    assign aluop1_abs_B0 = (((s_ex_aluop1_signed_Q0 && s_ex_rs1_data_bypassed_Q0[31])) ? (-s_ex_rs1_data_bypassed_Q0) : s_ex_rs1_data_bypassed_Q0);
    assign aluop2_abs_B0 = (((s_ex_aluop2_signed_Q0 && s_ex_rs2_data_bypassed_Q0[31])) ? (-s_ex_rs2_data_bypassed_Q0) : s_ex_rs2_data_bypassed_Q0);
    assign aluop1_sign_B0 = (s_ex_aluop1_signed_Q0 & s_ex_rs1_data_bypassed_Q0[31]);
    assign aluop2_sign_B0 = (s_ex_aluop2_signed_Q0 & s_ex_rs2_data_bypassed_Q0[31]);
    assign div_by_zero_B0 = ((s_ex_alu_function_Q0 == 4'd12) && (s_ex_rs2_data_bypassed_Q0 == 32'd0));
    assign result_muxed_B0 = (((s_ex_alu_function_Q0 == 4'd13)) ? {{32{1'b0}}, r_a_result_Q0} : r_result_Q0);
    assign result_final_B0 = ((r_negate_output_Q0) ? (-result_muxed_B0) : result_muxed_B0);
    assign codasip_tmp_var_0 = (((s_wb_exc_Q0 || s_wb_mret_Q0) || s_wb_irq_Q0) || s_sleep_Q0);
    assign codasip_tmp_var_1 = (!codasip_tmp_var_0) ? r_state_Q0 : 2'd0;
    assign r_negate_output_D0 = (((s_ex_alu_function_Q0 == 4'd13)) ? aluop1_sign_B0 : ((div_by_zero_B0) ? 1'd0 : (aluop1_sign_B0 ^ aluop2_sign_B0)));
    assign r_negate_output_WE0 = ((ACT == 1'd1) && ((codasip_tmp_var_1 == 2'd0) && (!codasip_tmp_var_0))) ? 1'd1 : 1'd0;
    assign r_mul_function_WE0 = ((ACT == 1'd1) && ((codasip_tmp_var_1 == 2'd0) && (!codasip_tmp_var_0))) ? 1'd1 : 1'd0;
    assign r_mul_function_D0 = (s_ex_alu_function_Q0 == 4'd11);
    assign r_mulh_WE0 = ((ACT == 1'd1) && ((codasip_tmp_var_1 == 2'd0) && (!codasip_tmp_var_0))) ? 1'd1 : 1'd0;
    assign r_mulh_D0 = s_ex_mulh_Q0;
    assign codasip_tmp_var_2 = ((codasip_tmp_var_1 == 2'd0) && (!codasip_tmp_var_0)) ? ((!s_ex_raw_hazard_Q0) && div_by_zero_B0) : 1'd0;
    assign codasip_tmp_var_3 = (((!codasip_tmp_var_2) && (codasip_tmp_var_1 == 2'd0)) && (!codasip_tmp_var_0)) ? ((!s_ex_raw_hazard_Q0) && (((s_ex_alu_function_Q0 == 4'd11) || (s_ex_alu_function_Q0 == 4'd12)) || (s_ex_alu_function_Q0 == 4'd13))) : 1'd0;
    assign codasip_tmp_var_4 = (codasip_tmp_var_1 == 2'd1) ? r_mul_function_Q0 : 1'd0;
    assign codasip_tmp_var_5 = ((!codasip_tmp_var_4) && (codasip_tmp_var_1 == 2'd1)) ? ({{32{1'b0}}, r_a_result_Q0} >= r_b_Q0) : 1'd0;
    assign r_a_result_WE0 = ((ACT == 1'd1) && ((codasip_tmp_var_1 == 2'd0) && (!codasip_tmp_var_0))) ? 1'd1 :
        ((ACT == 1'd1) && codasip_tmp_var_5) ? 1'd1 : 1'd0;
    assign r_a_result_D0 = ((codasip_tmp_var_1 == 2'd0) && (!codasip_tmp_var_0)) ? aluop1_abs_B0 :
        codasip_tmp_var_5 ? (r_a_result_Q0 - r_b_Q0[31:0]) : 32'd0;
    assign r_b_WE0 = ((ACT == 1'd1) && ((codasip_tmp_var_1 == 2'd0) && (!codasip_tmp_var_0))) ? 1'd1 :
        ((ACT == 1'd1) && (codasip_tmp_var_1 == 2'd1)) ? 1'd1 : 1'd0;
    assign r_b_D0 = ((codasip_tmp_var_1 == 2'd0) && (!codasip_tmp_var_0)) ? {{1{1'b0}}, (((s_ex_alu_function_Q0 == 4'd11)) ? {{31{1'b0}}, aluop2_abs_B0} : {aluop2_abs_B0,31'd0})} :
        (codasip_tmp_var_1 == 2'd1) ? (r_b_Q0 >>> 32'sd1) : 64'd0;
    assign codasip_tmp_var_6 = (codasip_tmp_var_1 == 2'd1) ? (r_counter_Q0 != 7'd0) : 1'd0;
    assign r_counter_WE0 = ((ACT == 1'd1) && ((codasip_tmp_var_1 == 2'd0) && (!codasip_tmp_var_0))) ? 1'd1 :
        ((ACT == 1'd1) && codasip_tmp_var_6) ? 1'd1 : 1'd0;
    assign r_counter_D0 = ((codasip_tmp_var_1 == 2'd0) && (!codasip_tmp_var_0)) ? tmp_codasip_conv_TERNARY_2070_1[6:0] :
        codasip_tmp_var_6 ? tmp_codasip_conv_MINUS_2487_2[6:0] : 7'd0;
    assign r_result_D0 = ((codasip_tmp_var_1 == 2'd0) && (!codasip_tmp_var_0)) ? ((div_by_zero_B0) ? 64'd18446744073709551615 : 64'd0) :
        codasip_tmp_var_4 ? (r_a_result_Q0 * r_b_Q0[31:0]) :
        codasip_tmp_var_5 ? {{32{1'b0}}, ((32'd1 <<< r_counter_Q0) | r_result_Q0[31:0])} :
        (codasip_tmp_var_1 == 2'd2) ? result_final_B0 : 64'd0;
    assign r_result_WE0 = ((ACT == 1'd1) && ((codasip_tmp_var_1 == 2'd0) && (!codasip_tmp_var_0))) ? 1'd1 :
        ((ACT == 1'd1) && codasip_tmp_var_4) ? 1'd1 :
        ((ACT == 1'd1) && codasip_tmp_var_5) ? 1'd1 :
        ((ACT == 1'd1) && (codasip_tmp_var_1 == 2'd2)) ? 1'd1 : 1'd0;
    assign codasip_tmp_var_7 = (codasip_tmp_var_1 == 2'd3) ? (!s_wb_stall_wb_Q0) : 1'd0;
    assign r_state_D0 = codasip_tmp_var_0 ? 2'd0 :
        codasip_tmp_var_2 ? 2'd2 :
        codasip_tmp_var_3 ? 2'd1 :
        codasip_tmp_var_6 ? 2'd1 :
        (codasip_tmp_var_1 == 2'd1) ? 2'd2 :
        (codasip_tmp_var_1 == 2'd2) ? 2'd3 :
        (codasip_tmp_var_7 || (codasip_tmp_var_1 == 2'd0)) ? 2'd0 : 2'd0;
    assign r_state_WE0 = ((ACT == 1'd1) && codasip_tmp_var_0) ? 1'd1 :
        ((ACT == 1'd1) && codasip_tmp_var_2) ? 1'd1 :
        ((ACT == 1'd1) && codasip_tmp_var_3) ? 1'd1 :
        ((ACT == 1'd1) && codasip_tmp_var_6) ? 1'd1 :
        ((ACT == 1'd1) && (codasip_tmp_var_1 == 2'd1)) ? 1'd1 :
        ((ACT == 1'd1) && (codasip_tmp_var_1 == 2'd2)) ? 1'd1 :
        ((ACT == 1'd1) && (codasip_tmp_var_7 || (codasip_tmp_var_1 == 2'd0))) ? 1'd1 : 1'd0;
    assign s_ex_mul_div_result_D0 = (ACT == 1'd1) ? ((r_mulh_Q0) ? r_result_Q0[63:32] : r_result_Q0[31:0]) : 32'd0;
    assign s_ex_mul_div_stall_D0 = (ACT == 1'd1) ? ((((s_ex_alu_function_Q0 == 4'd11) || (s_ex_alu_function_Q0 == 4'd12)) || (s_ex_alu_function_Q0 == 4'd13)) && (r_state_Q0 != 2'd3)) : 1'd0;
endmodule
