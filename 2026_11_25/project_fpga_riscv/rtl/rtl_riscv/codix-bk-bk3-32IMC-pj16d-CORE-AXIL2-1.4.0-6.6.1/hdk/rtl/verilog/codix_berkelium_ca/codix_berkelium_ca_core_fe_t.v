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
 *  \brief   Contains module definition of the 'codix_berkelium_ca_core_fe_t' functional unit.
 */

module codix_berkelium_ca_core_fe_t(
    input  wire CLK,
    input  wire RST,
    input  wire ACT,
    input  wire decompressor_16b32b_codasip_param_1,
    input  wire [31:0] if_fetch_Q0,
    input  wire [2:0] if_fetch_RESPONSE0,
    input  wire [53:0] predictor_mem_if_read_Q0,
    input  wire r_fe_instr_buf0_full_Q0,
    input  wire r_fe_instr_buf1_full_Q0,
    input  wire [31:0] r_fe_instr_buf1_Q0,
    input  wire r_fe_request_ready_Q0,
    input  wire [30:0] r_PC_Q0,
    input  wire [15:0] r_pred_valid_bits_Q0,
    input  wire s_ex_pc_we_Q0,
    input  wire s_ex_stall_ex_Q0,
    input  wire s_fe_16b_instr_en_Q0,
    input  wire [15:0] s_fe_16b_instr_Q0,
    input  wire [15:0] s_fe_32b_instr_Q0,
    input  wire s_fe_instr_load_Q0,
    input  wire [31:0] s_fe_mem_instr_Q0,
    input  wire [59:0] s_fe_pred_data_Q0,
    input  wire [30:0] s_fe_pred_taddr_Q0,
    input  wire s_fe_pred_taken_Q0,
    input  wire s_fe_rc_fin_ack_ok_Q0,
    input  wire [31:0] s_fe_response_rc_Q0,
    input  wire s_sleep_Q0,
    input  wire s_wb_stall_wb_Q0,
    output wire decompressor_16b32b_ACT,
    output wire [15:0] decompressor_16b32b_codasip_param_0,
    output wire fe_output_ACT,
    output wire [1:0] r_ex_pred_bits_D0,
    output wire r_ex_pred_bits_WE0,
    output wire [30:0] r_ex_pred_taddr_D0,
    output wire r_ex_pred_taddr_WE0,
    output wire r_fe_instr_buf0_full_D0,
    output wire r_fe_instr_buf0_full_WE0,
    output wire [31:0] r_fe_instr_buf1_D0,
    output wire r_fe_instr_buf1_full_D0,
    output wire r_fe_instr_buf1_full_WE0,
    output wire r_fe_instr_buf1_WE0,
    output wire [15:0] s_fe_16b_instr_D0,
    output wire s_fe_16b_instr_en_D0,
    output wire s_fe_16b_instr_inval_D0,
    output wire [31:0] s_fe_32b_instr_D0,
    output wire s_fe_inc_pc_align_D0,
    output wire s_fe_inc_pc_D0,
    output wire s_fe_instr_load_D0,
    output wire [31:0] s_fe_mem_instr_D0,
    output wire [59:0] s_fe_pred_data_D0,
    output wire [30:0] s_fe_pred_taddr_D0,
    output wire s_fe_pred_taken_align_D0,
    output wire s_fe_pred_taken_D0,
    output wire s_fe_rc_fin_ack_ok_D0,
    output wire [31:0] s_fe_response_rc_D0
);
    // type, wire and constant declarations:
    // signal/wire (inner)
    wire codasip_tmp_var_0;
    // signal/wire (inner)
    wire codasip_tmp_var_1;
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
    wire codasip_tmp_var_8;
    // signal/wire (inner)
    wire codasip_tmp_var_9;
    // signal/wire (inner)
    wire [47:0] fe_instr_B0;
    // signal/wire (inner)
    wire [15:0] fe_instr_high_B0;
    // signal/wire (inner)
    wire [31:0] fe_instr_low_B0;
    // signal/wire (inner)
    wire fe_pipe_run_B0;
    // signal/wire (inner)
    wire fe_pipe_stall_B0;
    // signal/wire (inner)
    wire fe_unaligned_addr_B0;
    // signal/wire (inner)
    wire rc_fin_ack_B0;
    // signal/wire (inner)
    wire s_fe_inc_pc_D0_ACT_wire;
    // signal/wire (inner)
    wire s_fe_inc_pc_align_D0_ACT_wire;
    // signal/wire (CodAL)
    wire [31:0] s_fe_mem_instr_int;
    // signal/wire (CodAL)
    wire [1:0] s_fe_pred_bits;
    // signal/wire (CodAL)
    wire s_fe_pred_hit;
    // signal/wire (CodAL)
    wire [3:0] s_fe_pred_index;
    // signal/wire (CodAL)
    wire [26:0] s_fe_pred_tag;
    // signal/wire (inner)
    wire s_fe_pred_taken_align_D0_ACT_wire;

    // additional declarations:
    wire r_fe_instr_buf0_WE0;
    wire [31:0] r_fe_instr_buf0_D0;
    wire [31:0] r_fe_instr_buf0_Q0;
    wire [31:0] tmp_codasip_conv_SHIFT_RIGHT_8003_1;
    wire [47:0] tmp_codasip_conv_SHIFT_RIGHT_8003_2;

    // child instances inside 'fe' functional unit:
    // instance of 'r_fe_instr_buf0' register:
    d_ff_plain_rst_we_t #(
        .bit_width(32'd32),
        .default_value(32'b0),
        .reset_level(1'b0),
        .reset_sync(1'b0)
    ) r_fe_instr_buf0 (
        .CLK(CLK),
        .RST(RST),
        .WE0(r_fe_instr_buf0_WE0),
        .D0(r_fe_instr_buf0_D0),
        .Q0(r_fe_instr_buf0_Q0)
    );

    // conversions for data-path:
    assign tmp_codasip_conv_SHIFT_RIGHT_8003_2 = $unsigned((fe_instr_B0 >>> 32'sd16));
    assign tmp_codasip_conv_SHIFT_RIGHT_8003_1 = tmp_codasip_conv_SHIFT_RIGHT_8003_2[31:0];
    // data-path code:
    assign s_fe_pred_index = r_PC_Q0[3:0];
    assign s_fe_pred_bits = s_fe_pred_data_Q0[1:0];
    assign s_fe_pred_tag = s_fe_pred_data_Q0[28:2];
    assign s_fe_pred_hit = ((r_PC_Q0[30:4] == s_fe_pred_tag) && ((r_pred_valid_bits_Q0 & (16'd1 <<< s_fe_pred_index)) != 16'd0));
    assign s_fe_mem_instr_int = if_fetch_Q0;
    assign rc_fin_ack_B0 = (s_fe_response_rc_Q0 == 32'd1);
    assign fe_pipe_stall_B0 = (s_ex_stall_ex_Q0 || s_wb_stall_wb_Q0);
    assign fe_pipe_run_B0 = ((!s_ex_stall_ex_Q0) && (!s_wb_stall_wb_Q0));
    assign fe_instr_low_B0 = ((r_fe_instr_buf1_full_Q0) ? r_fe_instr_buf1_Q0 : s_fe_mem_instr_Q0);
    assign fe_instr_high_B0 = s_fe_mem_instr_Q0[15:0];
    assign fe_instr_B0 = {fe_instr_high_B0,fe_instr_low_B0};
    assign fe_unaligned_addr_B0 = r_PC_Q0[0];
    assign codasip_tmp_var_0 = (s_sleep_Q0 || s_ex_pc_we_Q0);
    assign codasip_tmp_var_1 = (!codasip_tmp_var_0) ? (!r_fe_instr_buf1_full_Q0) : 1'd0;
    assign codasip_tmp_var_2 = codasip_tmp_var_1 ? s_fe_instr_load_Q0 : 1'd0;
    assign s_fe_inc_pc_D0_ACT_wire = codasip_tmp_var_0 ? 1'd0 :
        codasip_tmp_var_1 ? (((s_fe_16b_instr_en_Q0 || (!fe_unaligned_addr_B0)) && s_fe_instr_load_Q0) && fe_pipe_run_B0) : (((s_fe_16b_instr_en_Q0 || (!fe_unaligned_addr_B0)) || s_fe_instr_load_Q0) && fe_pipe_run_B0);
    assign s_fe_inc_pc_align_D0_ACT_wire = codasip_tmp_var_0 ? 1'd0 :
        codasip_tmp_var_1 ? s_fe_rc_fin_ack_ok_Q0 : (((!r_fe_instr_buf0_full_Q0) && s_fe_rc_fin_ack_ok_Q0) || s_fe_pred_taken_Q0);
    assign codasip_tmp_var_3 = codasip_tmp_var_1 ? (((((!s_fe_16b_instr_en_Q0) && fe_unaligned_addr_B0) || ((s_fe_16b_instr_en_Q0 && (!fe_unaligned_addr_B0)) && (!s_fe_pred_taken_Q0))) || fe_pipe_stall_B0) && s_fe_instr_load_Q0) : 1'd0;
    assign codasip_tmp_var_4 = ((!codasip_tmp_var_1) && (!codasip_tmp_var_0)) ? ((((!s_fe_16b_instr_en_Q0) || fe_unaligned_addr_B0) && fe_pipe_run_B0) && s_fe_instr_load_Q0) : 1'd0;
    assign s_fe_pred_taken_align_D0_ACT_wire = codasip_tmp_var_1 ? ((s_fe_16b_instr_en_Q0 || (!fe_unaligned_addr_B0)) && s_fe_pred_taken_Q0) :
        ((!codasip_tmp_var_1) && (!codasip_tmp_var_0)) ? s_fe_pred_taken_Q0 : 1'd0;
    assign codasip_tmp_var_5 = ((!codasip_tmp_var_1) && (!codasip_tmp_var_0)) ? (((s_fe_pred_taken_Q0 && ((s_fe_16b_instr_en_Q0 || (!fe_unaligned_addr_B0)) || s_fe_instr_load_Q0)) || ((((!s_fe_16b_instr_en_Q0) && (!fe_unaligned_addr_B0)) || (s_fe_16b_instr_en_Q0 && fe_unaligned_addr_B0)) && (!s_fe_instr_load_Q0))) && fe_pipe_run_B0) : 1'd0;
    assign codasip_tmp_var_6 = (s_ex_pc_we_Q0 || (s_fe_pred_taken_Q0 && fe_pipe_run_B0));
    assign codasip_tmp_var_7 = (!codasip_tmp_var_6) ? ((((!r_fe_instr_buf0_full_Q0) && r_fe_instr_buf1_full_Q0) && s_fe_rc_fin_ack_ok_Q0) && (fe_pipe_stall_B0 || (s_fe_16b_instr_en_Q0 && (!fe_unaligned_addr_B0)))) : 1'd0;
    assign r_fe_instr_buf0_WE0 = ((ACT == 1'd1) && codasip_tmp_var_7) ? 1'd1 : 1'd0;
    assign r_fe_instr_buf0_D0 = s_fe_mem_instr_int;
    assign codasip_tmp_var_8 = ((!codasip_tmp_var_7) && (!codasip_tmp_var_6)) ? (fe_pipe_run_B0 && ((!s_fe_16b_instr_en_Q0) || fe_unaligned_addr_B0)) : 1'd0;
    assign codasip_tmp_var_9 = s_fe_16b_instr_en_Q0;
    assign decompressor_16b32b_ACT = ((ACT == 1'd1) && codasip_tmp_var_9) ? 1'd1 : 1'd0;
    assign decompressor_16b32b_codasip_param_0 = ((ACT == 1'd1) && codasip_tmp_var_9) ? s_fe_16b_instr_Q0 : 16'd0;
    assign fe_output_ACT = (ACT == 1'd1) ? 1'd1 : 1'd0;
    assign r_ex_pred_bits_D0 = ((s_fe_pred_hit) ? s_fe_pred_bits : 2'd0);
    assign r_ex_pred_bits_WE0 = (ACT == 1'd1) ? 1'd1 : 1'd0;
    assign r_ex_pred_taddr_D0 = s_fe_pred_taddr_Q0;
    assign r_ex_pred_taddr_WE0 = (ACT == 1'd1) ? 1'd1 : 1'd0;
    assign r_fe_instr_buf0_full_D0 = codasip_tmp_var_6 ? 1'd0 :
        codasip_tmp_var_7 ? 1'd1 :
        codasip_tmp_var_8 ? 1'd0 : 1'd0;
    assign r_fe_instr_buf0_full_WE0 = ((ACT == 1'd1) && codasip_tmp_var_6) ? 1'd1 :
        ((ACT == 1'd1) && codasip_tmp_var_7) ? 1'd1 :
        ((ACT == 1'd1) && codasip_tmp_var_8) ? 1'd1 : 1'd0;
    assign r_fe_instr_buf1_D0 = s_fe_mem_instr_Q0;
    assign r_fe_instr_buf1_full_D0 = codasip_tmp_var_0 ? 1'd0 :
        codasip_tmp_var_3 ? 1'd1 :
        codasip_tmp_var_5 ? 1'd0 : 1'd0;
    assign r_fe_instr_buf1_full_WE0 = ((ACT == 1'd1) && codasip_tmp_var_0) ? 1'd1 :
        ((ACT == 1'd1) && codasip_tmp_var_3) ? 1'd1 :
        ((ACT == 1'd1) && codasip_tmp_var_5) ? 1'd1 : 1'd0;
    assign r_fe_instr_buf1_WE0 = ((ACT == 1'd1) && (codasip_tmp_var_2 || codasip_tmp_var_4)) ? 1'd1 : 1'd0;
    assign s_fe_16b_instr_D0 = (ACT == 1'd1) ? s_fe_32b_instr_Q0 : 16'd0;
    assign s_fe_16b_instr_en_D0 = (ACT == 1'd1) ? (s_fe_16b_instr_Q0[1:0] != 2'd3) : 1'd0;
    assign s_fe_16b_instr_inval_D0 = ((ACT == 1'd1) && codasip_tmp_var_9) ? decompressor_16b32b_codasip_param_1 : 1'd0;
    assign s_fe_32b_instr_D0 = (ACT == 1'd1) ? ((fe_unaligned_addr_B0) ? tmp_codasip_conv_SHIFT_RIGHT_8003_1 : fe_instr_B0[31:0]) : 32'd0;
    assign s_fe_inc_pc_align_D0 = (ACT == 1'd1) ? s_fe_inc_pc_align_D0_ACT_wire : 1'd0;
    assign s_fe_inc_pc_D0 = (ACT == 1'd1) ? s_fe_inc_pc_D0_ACT_wire : 1'd0;
    assign s_fe_instr_load_D0 = (ACT == 1'd1) ? ((s_fe_rc_fin_ack_ok_Q0 || r_fe_instr_buf0_full_Q0) && (!s_ex_pc_we_Q0)) : 1'd0;
    assign s_fe_mem_instr_D0 = (ACT == 1'd1) ? ((r_fe_instr_buf0_full_Q0) ? r_fe_instr_buf0_Q0 : s_fe_mem_instr_int) : 32'd0;
    assign s_fe_pred_data_D0 = (ACT == 1'd1) ? {{6{1'b0}}, predictor_mem_if_read_Q0} : 60'd0;
    assign s_fe_pred_taddr_D0 = (ACT == 1'd1) ? s_fe_pred_data_Q0[59:29] : 31'd0;
    assign s_fe_pred_taken_align_D0 = (ACT == 1'd1) ? s_fe_pred_taken_align_D0_ACT_wire : 1'd0;
    assign s_fe_pred_taken_D0 = (ACT == 1'd1) ? (s_fe_pred_hit && s_fe_pred_bits[1]) : 1'd0;
    assign s_fe_rc_fin_ack_ok_D0 = (ACT == 1'd1) ? (r_fe_request_ready_Q0 && rc_fin_ack_B0) : 1'd0;
    assign s_fe_response_rc_D0 = (ACT == 1'd1) ? {{29{1'b0}}, if_fetch_RESPONSE0} : 32'd0;
endmodule
