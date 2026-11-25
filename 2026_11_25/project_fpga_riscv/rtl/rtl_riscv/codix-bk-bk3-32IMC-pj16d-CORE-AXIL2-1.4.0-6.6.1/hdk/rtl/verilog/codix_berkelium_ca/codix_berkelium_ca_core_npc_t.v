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
 *  \brief   Contains module definition of the 'codix_berkelium_ca_core_npc_t' functional unit.
 */

module codix_berkelium_ca_core_npc_t(
    input  wire CLK,
    input  wire RST,
    input  wire ACT,
    input  wire [1:0] if_fetch_STATUS0,
    input  wire [31:0] r_csr_mepc_Q0,
    input  wire [31:0] r_csr_mtvec_Q0,
    input  wire [31:0] r_ex_pc_Q0,
    input  wire r_fe_inv_all_pending_Q0,
    input  wire [31:0] r_PC_Q0,
    input  wire s_ex_inv_all_instr_Q0,
    input  wire [31:0] s_ex_jump_addr_Q0,
    input  wire s_ex_pc_we_Q0,
    input  wire s_ex_stall_ex_Q0,
    input  wire s_fe_16b_instr_en_Q0,
    input  wire s_fe_inc_pc_align_Q0,
    input  wire s_fe_inc_pc_Q0,
    input  wire [30:0] s_fe_pred_taddr_Q0,
    input  wire s_fe_pred_taken_align_Q0,
    input  wire s_fe_pred_taken_Q0,
    input  wire s_fe_rc_fin_ack_ok_Q0,
    input  wire s_sleep_Q0,
    input  wire s_wb_exc_Q0,
    input  wire s_wb_mret_Q0,
    input  wire s_wb_stall_wb_Q0,
    output wire [31:0] if_fetch_A0,
    output wire [2:0] if_fetch_BC0,
    output wire [1:0] if_fetch_BI0,
    output wire [2:0] if_fetch_REQUEST0,
    output wire [7:0] predictor_mem_if_read_A0,
    output wire predictor_mem_if_read_BC0,
    output wire predictor_mem_if_read_BI0,
    output wire [1:0] predictor_mem_if_read_REQUEST0,
    output wire [3:0] r_fe_exc_code_D0,
    output wire r_fe_exc_code_WE0,
    output wire r_fe_exc_D0,
    output wire [31:0] r_fe_exc_instr_addr_D0,
    output wire r_fe_exc_instr_addr_WE0,
    output wire r_fe_exc_WE0,
    output wire r_fe_inv_all_pending_D0,
    output wire r_fe_inv_all_pending_WE0,
    output wire r_fe_request_ready_D0,
    output wire r_fe_request_ready_WE0,
    output wire [31:0] r_PC_D0,
    output wire r_PC_WE0,
    output wire s_ex_clear_D0,
    output wire s_ex_stall_D0,
    output wire s_wb_clear_D0,
    output wire s_wb_stall_D0
);
    // type, wire and constant declarations:
    // signal/wire (inner)
    wire [7:0] STATEMENT_STATIC_CAST_3363_STATEMENT_AST_3364_wire;
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
    wire [1:0] fe_request_rc_B0;
    // signal/wire (inner)
    wire i_mem_rq_stall_B0;
    // signal/wire (inner)
    wire [2:0] if_fetch_REQUEST0_ACT_wire;
    // signal/wire (inner)
    wire [31:0] s_npc_inc_const_B0;
    // signal/wire (CodAL)
    wire [31:0] s_npc_instr_addr;
    // signal/wire (CodAL)
    wire [31:0] s_npc_pc;
    // signal/wire (CodAL)
    wire [31:0] s_npc_pc_align;

    // additional declarations:
    wire r_pc_align_WE0;
    wire [31:0] r_pc_align_D0;
    wire [31:0] r_pc_align_Q0;

    // child instances inside 'npc' functional unit:
    // instance of 'r_pc_align' register:
    d_ff_plain_rst_we_t #(
        .bit_width(32'd32),
        .default_value(32'b00000000000000000001000000000000),
        .reset_level(1'b0),
        .reset_sync(1'b0)
    ) r_pc_align (
        .CLK(CLK),
        .RST(RST),
        .WE0(r_pc_align_WE0),
        .D0(r_pc_align_D0),
        .Q0(r_pc_align_Q0)
    );

    // data-path code:
    assign s_npc_inc_const_B0 = ((s_fe_16b_instr_en_Q0) ? 32'd2 : 32'd4);
    assign s_npc_pc = ((s_wb_exc_Q0) ? r_csr_mtvec_Q0 : ((s_wb_mret_Q0) ? r_csr_mepc_Q0 : ((s_ex_pc_we_Q0) ? s_ex_jump_addr_Q0 : (((s_fe_inc_pc_Q0 && s_fe_pred_taken_Q0)) ? ({{1{1'b0}}, s_fe_pred_taddr_Q0} <<< 32'sd1) : ((s_fe_inc_pc_Q0) ? (r_PC_Q0 + s_npc_inc_const_B0) : r_PC_Q0)))));
    assign s_npc_pc_align = ((s_wb_exc_Q0) ? (r_csr_mtvec_Q0 & 32'd4294967292) : ((s_wb_mret_Q0) ? (r_csr_mepc_Q0 & 32'd4294967292) : ((s_ex_pc_we_Q0) ? (s_ex_jump_addr_Q0 & 32'd4294967292) : (((s_fe_inc_pc_align_Q0 && s_fe_pred_taken_align_Q0)) ? (({{1{1'b0}}, s_fe_pred_taddr_Q0} <<< 32'sd1) & 32'd4294967292) : ((s_fe_inc_pc_align_Q0) ? (r_pc_align_Q0 + 32'd4) : r_pc_align_Q0)))));
    assign s_npc_instr_addr = s_npc_pc_align;
    assign r_pc_align_WE0 = (ACT == 1'd1) ? 1'd1 : 1'd0;
    assign r_pc_align_D0 = ((((s_sleep_Q0 && (!s_wb_exc_Q0)) && (!s_wb_mret_Q0))) ? (r_ex_pc_Q0 & 32'd4294967292) : s_npc_pc_align);
    assign codasip_tmp_var_0 = r_fe_inv_all_pending_Q0;
    assign fe_request_rc_B0 = codasip_tmp_var_0 ? if_fetch_STATUS0 : if_fetch_STATUS0;
    assign i_mem_rq_stall_B0 = (fe_request_rc_B0 != 2'd1);
    assign codasip_tmp_var_1 = s_ex_inv_all_instr_Q0;
    assign codasip_tmp_var_2 = (!codasip_tmp_var_1) ? (!i_mem_rq_stall_B0) : 1'd0;
    assign codasip_tmp_var_3 = s_sleep_Q0;
    assign codasip_tmp_var_4 = (!codasip_tmp_var_3) ? (s_ex_inv_all_instr_Q0 || r_fe_inv_all_pending_Q0) : 1'd0;
    assign codasip_tmp_var_5 = ((!codasip_tmp_var_4) && (!codasip_tmp_var_3)) ? (!i_mem_rq_stall_B0) : 1'd0;
    assign codasip_tmp_var_6 = (((!codasip_tmp_var_5) && (!codasip_tmp_var_4)) && (!codasip_tmp_var_3)) ? (s_fe_rc_fin_ack_ok_Q0 || s_ex_pc_we_Q0) : 1'd0;
    assign codasip_tmp_var_7 = ((((!codasip_tmp_var_6) && (!codasip_tmp_var_5)) && (!codasip_tmp_var_4)) && (!codasip_tmp_var_3)) ? (s_fe_inc_pc_Q0 && s_fe_pred_taken_align_Q0) : 1'd0;
    assign codasip_tmp_var_8 = ((fe_request_rc_B0 != 2'd1) && (fe_request_rc_B0 != 2'd0));
    assign codasip_tmp_var_9 = s_ex_pc_we_Q0;
    assign STATEMENT_STATIC_CAST_3363_STATEMENT_AST_3364_wire = {{4{1'b0}}, s_npc_pc[4:1]};
    assign if_fetch_REQUEST0_ACT_wire = codasip_tmp_var_0 ? 3'd5 : 3'd1;
    assign if_fetch_A0 = codasip_tmp_var_0 ? 32'd2147483648 : s_npc_instr_addr;
    assign if_fetch_BC0 = codasip_tmp_var_0 ? 3'd4 : 3'd4;
    assign if_fetch_BI0 = codasip_tmp_var_0 ? 2'd0 : 2'd0;
    assign if_fetch_REQUEST0 = (ACT == 1'd1) ? if_fetch_REQUEST0_ACT_wire : 3'd0;
    assign predictor_mem_if_read_A0 = STATEMENT_STATIC_CAST_3363_STATEMENT_AST_3364_wire;
    assign predictor_mem_if_read_BC0 = 1'd1;
    assign predictor_mem_if_read_BI0 = 1'd0;
    assign predictor_mem_if_read_REQUEST0 = (ACT == 1'd1) ? 2'd1 : 2'd0;
    assign r_fe_exc_code_D0 = 4'd1;
    assign r_fe_exc_code_WE0 = ((ACT == 1'd1) && codasip_tmp_var_8) ? 1'd1 : 1'd0;
    assign r_fe_exc_D0 = codasip_tmp_var_8 ? 1'd1 : 1'd0;
    assign r_fe_exc_instr_addr_D0 = r_ex_pc_Q0;
    assign r_fe_exc_instr_addr_WE0 = ((ACT == 1'd1) && codasip_tmp_var_9) ? 1'd1 : 1'd0;
    assign r_fe_exc_WE0 = (ACT == 1'd1) ? 1'd1 : 1'd0;
    assign r_fe_inv_all_pending_D0 = codasip_tmp_var_1 ? 1'd1 :
        codasip_tmp_var_2 ? 1'd0 : 1'd0;
    assign r_fe_inv_all_pending_WE0 = ((ACT == 1'd1) && codasip_tmp_var_1) ? 1'd1 :
        ((ACT == 1'd1) && codasip_tmp_var_2) ? 1'd1 : 1'd0;
    assign r_fe_request_ready_D0 = codasip_tmp_var_3 ? 1'd0 :
        codasip_tmp_var_4 ? 1'd0 :
        codasip_tmp_var_5 ? 1'd1 :
        codasip_tmp_var_6 ? 1'd0 :
        codasip_tmp_var_7 ? 1'd0 : 1'd0;
    assign r_fe_request_ready_WE0 = ((ACT == 1'd1) && codasip_tmp_var_3) ? 1'd1 :
        ((ACT == 1'd1) && codasip_tmp_var_4) ? 1'd1 :
        ((ACT == 1'd1) && codasip_tmp_var_5) ? 1'd1 :
        ((ACT == 1'd1) && codasip_tmp_var_6) ? 1'd1 :
        ((ACT == 1'd1) && codasip_tmp_var_7) ? 1'd1 : 1'd0;
    assign r_PC_D0 = ((((s_sleep_Q0 && (!s_wb_exc_Q0)) && (!s_wb_mret_Q0))) ? r_ex_pc_Q0 : s_npc_pc);
    assign r_PC_WE0 = (ACT == 1'd1) ? 1'd1 : 1'd0;
    assign s_ex_clear_D0 = (ACT == 1'd1) ? (s_sleep_Q0 && (!s_wb_stall_wb_Q0)) : 1'd0;
    assign s_ex_stall_D0 = (ACT == 1'd1) ? (s_ex_stall_ex_Q0 || s_wb_stall_wb_Q0) : 1'd0;
    assign s_wb_clear_D0 = (ACT == 1'd1) ? ((((s_ex_stall_ex_Q0 || s_wb_stall_wb_Q0) || s_wb_exc_Q0) || s_wb_mret_Q0) || s_sleep_Q0) : 1'd0;
    assign s_wb_stall_D0 = (ACT == 1'd1) ? s_wb_stall_wb_Q0 : 1'd0;
endmodule
