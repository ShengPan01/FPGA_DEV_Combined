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
 *  \brief   Contains module definition of the 'codix_berkelium_ca_core_fe_output_t' functional unit.
 */

module codix_berkelium_ca_core_fe_output_t(
    input  wire ACT,
    input  wire [3:0] r_fe_exc_code_Q0,
    input  wire [31:0] r_fe_exc_instr_addr_Q0,
    input  wire r_fe_exc_Q0,
    input  wire r_fe_instr_buf1_full_Q0,
    input  wire r_fe_reload_Q0,
    input  wire r_fe_request_ready_Q0,
    input  wire [31:0] r_PC_Q0,
    input  wire s_debug_mode_req_Q0,
    input  wire s_ex_pc_we_Q0,
    input  wire s_fe_16b_instr_en_Q0,
    input  wire s_fe_16b_instr_inval_imm_Q0,
    input  wire s_fe_16b_instr_inval_Q0,
    input  wire s_fe_16b_instr_inval_reg_Q0,
    input  wire [31:0] s_fe_32b_instr_Q0,
    input  wire [2:0] s_fe_func3_imm_Q0,
    input  wire [6:0] s_fe_func7_imm_Q0,
    input  wire s_fe_instr_load_Q0,
    input  wire [6:0] s_fe_opcode_Q0,
    input  wire [4:0] s_fe_rd_imm_Q0,
    input  wire [31:0] s_fe_response_rc_Q0,
    input  wire [4:0] s_fe_rs1_imm_Q0,
    input  wire [4:0] s_fe_rs2_imm_Q0,
    output wire r_ex_16b_instr_D0,
    output wire r_ex_16b_instr_WE0,
    output wire [3:0] r_ex_exc_code_D0,
    output wire r_ex_exc_code_WE0,
    output wire r_ex_exc_D0,
    output wire [31:0] r_ex_exc_instr_addr_D0,
    output wire r_ex_exc_instr_addr_WE0,
    output wire r_ex_exc_WE0,
    output wire [31:0] r_ex_instr_D0,
    output wire r_ex_instr_val_D0,
    output wire r_ex_instr_val_WE0,
    output wire r_ex_instr_WE0,
    output wire [31:0] r_ex_pc_D0,
    output wire r_ex_pc_WE0,
    output wire r_ex_valid_D0,
    output wire r_ex_valid_WE0,
    output wire r_fe_reload_D0,
    output wire r_fe_reload_WE0
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
    wire fe_16b_instr_inval_exc_B0;
    // signal/wire (inner)
    wire [31:0] fe_decomp_instr_B0;
    // signal/wire (inner)
    wire fe_unaligned_addr_B0;
    // signal/wire (inner)
    wire insert_nop_B0;
    // signal/wire (inner)
    wire rc_fin_ack_B0;
    // signal/wire (inner)
    wire rc_fin_unaligned_B0;
    // signal/wire (inner)
    wire rc_fin_wait_B0;

    // data-path code:
    assign fe_16b_instr_inval_exc_B0 = ((s_fe_16b_instr_inval_Q0 || s_fe_16b_instr_inval_imm_Q0) || s_fe_16b_instr_inval_reg_Q0);
    assign fe_unaligned_addr_B0 = r_PC_Q0[1];
    assign fe_decomp_instr_B0 = {{{{{s_fe_func7_imm_Q0,s_fe_rs2_imm_Q0},s_fe_rs1_imm_Q0},s_fe_func3_imm_Q0},s_fe_rd_imm_Q0},s_fe_opcode_Q0};
    assign insert_nop_B0 = (((((!s_ex_pc_we_Q0) && ((!s_fe_16b_instr_en_Q0) || (!fe_16b_instr_inval_exc_B0))) && ((s_fe_16b_instr_en_Q0 && (r_fe_instr_buf1_full_Q0 || s_fe_instr_load_Q0)) || ((fe_unaligned_addr_B0 && (r_fe_instr_buf1_full_Q0 && s_fe_instr_load_Q0)) || ((!fe_unaligned_addr_B0) && (r_fe_instr_buf1_full_Q0 || s_fe_instr_load_Q0)))))) ? 1'd0 : 1'd1);
    assign codasip_tmp_var_0 = s_debug_mode_req_Q0;
    assign codasip_tmp_var_1 = (!codasip_tmp_var_0) ? (!insert_nop_B0) : 1'd0;
    assign rc_fin_ack_B0 = (s_fe_response_rc_Q0 == 32'd1);
    assign rc_fin_wait_B0 = (s_fe_response_rc_Q0 == 32'd2);
    assign rc_fin_unaligned_B0 = (s_fe_response_rc_Q0 == 32'd4);
    assign codasip_tmp_var_2 = s_ex_pc_we_Q0;
    assign codasip_tmp_var_3 = (!codasip_tmp_var_2) ? r_fe_request_ready_Q0 : 1'd0;
    assign codasip_tmp_var_4 = codasip_tmp_var_3 ? rc_fin_unaligned_B0 : 1'd0;
    assign codasip_tmp_var_5 = ((!codasip_tmp_var_4) && codasip_tmp_var_3) ? ((!rc_fin_ack_B0) && (!rc_fin_wait_B0)) : 1'd0;
    assign codasip_tmp_var_6 = (((!codasip_tmp_var_5) && (!codasip_tmp_var_4)) && codasip_tmp_var_3) ? ((s_fe_16b_instr_en_Q0 && fe_16b_instr_inval_exc_B0) && (r_fe_instr_buf1_full_Q0 || s_fe_instr_load_Q0)) : 1'd0;
    assign r_ex_16b_instr_D0 = s_fe_16b_instr_en_Q0;
    assign r_ex_16b_instr_WE0 = (ACT == 1'd1) ? 1'd1 : 1'd0;
    assign r_ex_exc_code_D0 = codasip_tmp_var_4 ? 4'd0 :
        codasip_tmp_var_5 ? 4'd1 :
        codasip_tmp_var_6 ? 4'd2 :
        codasip_tmp_var_3 ? r_fe_exc_code_Q0 :
        ((!codasip_tmp_var_3) && (!codasip_tmp_var_2)) ? r_fe_exc_code_Q0 : 4'd0;
    assign r_ex_exc_code_WE0 = ((ACT == 1'd1) && codasip_tmp_var_4) ? 1'd1 :
        ((ACT == 1'd1) && codasip_tmp_var_5) ? 1'd1 :
        ((ACT == 1'd1) && codasip_tmp_var_6) ? 1'd1 :
        ((ACT == 1'd1) && codasip_tmp_var_3) ? 1'd1 :
        ((ACT == 1'd1) && ((!codasip_tmp_var_3) && (!codasip_tmp_var_2))) ? 1'd1 : 1'd0;
    assign r_ex_exc_D0 = codasip_tmp_var_2 ? 1'd0 :
        codasip_tmp_var_4 ? 1'd1 :
        codasip_tmp_var_5 ? 1'd1 :
        codasip_tmp_var_6 ? 1'd1 :
        codasip_tmp_var_3 ? r_fe_exc_Q0 : r_fe_exc_Q0;
    assign r_ex_exc_instr_addr_D0 = r_fe_exc_instr_addr_Q0;
    assign r_ex_exc_instr_addr_WE0 = (ACT == 1'd1) ? 1'd1 : 1'd0;
    assign r_ex_exc_WE0 = (ACT == 1'd1) ? 1'd1 : 1'd0;
    assign r_ex_instr_D0 = ((insert_nop_B0) ? 32'd19 : ((s_fe_16b_instr_en_Q0) ? fe_decomp_instr_B0 : s_fe_32b_instr_Q0));
    assign r_ex_instr_val_D0 = (!insert_nop_B0);
    assign r_ex_instr_val_WE0 = (ACT == 1'd1) ? 1'd1 : 1'd0;
    assign r_ex_instr_WE0 = (ACT == 1'd1) ? 1'd1 : 1'd0;
    assign r_ex_pc_D0 = r_PC_Q0;
    assign r_ex_pc_WE0 = (ACT == 1'd1) ? 1'd1 : 1'd0;
    assign r_ex_valid_D0 = ((!r_fe_reload_Q0) && (!insert_nop_B0));
    assign r_ex_valid_WE0 = (ACT == 1'd1) ? 1'd1 : 1'd0;
    assign r_fe_reload_D0 = codasip_tmp_var_0 ? 1'd1 :
        codasip_tmp_var_1 ? 1'd0 : 1'd0;
    assign r_fe_reload_WE0 = ((ACT == 1'd1) && codasip_tmp_var_0) ? 1'd1 :
        ((ACT == 1'd1) && codasip_tmp_var_1) ? 1'd1 : 1'd0;
endmodule
