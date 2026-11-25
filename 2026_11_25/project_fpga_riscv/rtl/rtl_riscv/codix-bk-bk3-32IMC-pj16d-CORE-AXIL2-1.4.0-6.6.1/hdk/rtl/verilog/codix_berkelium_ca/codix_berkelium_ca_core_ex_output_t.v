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
 *  \brief   Contains module definition of the 'codix_berkelium_ca_core_ex_output_t' functional unit.
 */

module codix_berkelium_ca_core_ex_output_t(
    input  wire ACT,
    input  wire r_ex_16b_instr_Q0,
    input  wire [3:0] r_ex_exc_code_Q0,
    input  wire [31:0] r_ex_exc_instr_addr_Q0,
    input  wire r_ex_exc_Q0,
    input  wire [24:0] r_ex_instr_Q0,
    input  wire r_ex_instr_val_Q0,
    input  wire [31:0] r_ex_pc_Q0,
    input  wire [1:0] r_ex_pred_bits_Q0,
    input  wire [30:0] r_ex_pred_taddr_Q0,
    input  wire [15:0] r_pred_valid_bits_Q0,
    input  wire [31:0] s_ex_add_result_Q0,
    input  wire [3:0] s_ex_alu_function_Q0,
    input  wire s_ex_branch_Q0,
    input  wire s_ex_cmp_true_Q0,
    input  wire [2:0] s_ex_csr_funct_Q0,
    input  wire s_ex_csr_read_Q0,
    input  wire s_ex_csr_write_Q0,
    input  wire s_ex_ilegal_instr_Q0,
    input  wire s_ex_inv_all_instr_Q0,
    input  wire s_ex_jal_Q0,
    input  wire s_ex_jalr_Q0,
    input  wire [2:0] s_ex_mem_cmd_Q0,
    input  wire s_ex_mem_error_Q0,
    input  wire [2:0] s_ex_mem_type_Q0,
    input  wire s_ex_memop_Q0,
    input  wire s_ex_mul_div_stall_Q0,
    input  wire [53:0] s_ex_pred_data_Q0,
    input  wire s_ex_raw_hazard_Q0,
    input  wire s_ex_reg_write_Q0,
    input  wire s_ex_request_stall_Q0,
    input  wire [31:0] s_ex_result_Q0,
    input  wire [31:0] s_ex_rs1_data_bypassed_Q0,
    input  wire [31:0] s_ex_rs2_data_bypassed_Q0,
    input  wire s_sleep_Q0,
    input  wire s_wb_exc_Q0,
    input  wire s_wb_mret_Q0,
    input  wire s_wb_stall_wb_Q0,
    output wire [7:0] predictor_mem_if_write_A0,
    output wire predictor_mem_if_write_BC0,
    output wire predictor_mem_if_write_BI0,
    output wire [53:0] predictor_mem_if_write_D0,
    output wire [1:0] predictor_mem_if_write_REQUEST0,
    output wire [15:0] r_pred_valid_bits_D0,
    output wire r_pred_valid_bits_WE0,
    output wire r_wb_16b_instr_D0,
    output wire r_wb_16b_instr_WE0,
    output wire [4:0] r_wb_addrW_D0,
    output wire r_wb_addrW_WE0,
    output wire r_wb_branch_ex_D0,
    output wire r_wb_branch_ex_WE0,
    output wire [11:0] r_wb_csr_addr_D0,
    output wire r_wb_csr_addr_WE0,
    output wire [31:0] r_wb_csr_data_D0,
    output wire r_wb_csr_data_WE0,
    output wire [2:0] r_wb_csr_funct_D0,
    output wire r_wb_csr_funct_WE0,
    output wire r_wb_csr_read_D0,
    output wire r_wb_csr_read_WE0,
    output wire r_wb_csr_write_D0,
    output wire r_wb_csr_write_WE0,
    output wire [3:0] r_wb_exc_code_D0,
    output wire r_wb_exc_code_WE0,
    output wire r_wb_exc_D0,
    output wire [31:0] r_wb_exc_instr_addr_D0,
    output wire r_wb_exc_instr_addr_WE0,
    output wire r_wb_exc_WE0,
    output wire r_wb_halt_D0,
    output wire r_wb_halt_WE0,
    output wire r_wb_instr_fin_D0,
    output wire r_wb_instr_fin_WE0,
    output wire r_wb_instr_val_D0,
    output wire r_wb_instr_val_WE0,
    output wire [2:0] r_wb_mem_cmd_D0,
    output wire r_wb_mem_cmd_WE0,
    output wire [2:0] r_wb_mem_type_D0,
    output wire r_wb_mem_type_WE0,
    output wire r_wb_memop_D0,
    output wire r_wb_memop_WE0,
    output wire [31:0] r_wb_pc_D0,
    output wire r_wb_pc_WE0,
    output wire r_wb_reg_write_D0,
    output wire r_wb_reg_write_WE0,
    output wire [31:0] r_wb_result_D0,
    output wire r_wb_result_WE0,
    output wire r_wb_save_return_addr_D0,
    output wire r_wb_save_return_addr_WE0,
    output wire r_wb_wfi_D0,
    output wire r_wb_wfi_WE0,
    output wire [31:0] r_wb_writedata_D0,
    output wire r_wb_writedata_WE0,
    output wire [4:0] r_wb_zimm_D0,
    output wire r_wb_zimm_WE0,
    output wire [31:0] s_ex_jump_addr_D0,
    output wire s_ex_pc_we_D0,
    output wire [59:0] s_ex_pred_data_D0
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
    wire s_ex_branch_taken_B0;
    // signal/wire (CodAL)
    wire [31:0] s_ex_inc_const;
    // signal/wire (inner)
    wire s_ex_jump_B0;
    // signal/wire (CodAL)
    wire [1:0] s_ex_pred_bits;
    // signal/wire (inner)
    wire s_ex_pred_branch_taken_B0;
    // signal/wire (CodAL)
    wire [3:0] s_ex_pred_index;
    // signal/wire (CodAL)
    wire [30:0] s_ex_pred_taddr;
    // signal/wire (inner)
    wire s_ex_pred_taddr_hit_B0;
    // signal/wire (CodAL)
    wire [26:0] s_ex_pred_tag;

    // additional declarations:
    wire [31:0] tmp_codasip_conv_PLUS_6517_1;
    wire [31:0] tmp_codasip_conv_MINUS_6510_2;
    wire signed [31:0] tmp_codasip_conv_TERNARY_6801_3;

    // conversions for data-path:
    assign tmp_codasip_conv_PLUS_6517_1 = $unsigned(({{30{1'b0}}, r_ex_pred_bits_Q0} + 32'd1));
    assign tmp_codasip_conv_MINUS_6510_2 = $unsigned(({{30{1'b0}}, r_ex_pred_bits_Q0} - 32'd1));
    assign tmp_codasip_conv_TERNARY_6801_3 = $signed((((s_ex_mem_cmd_Q0 == 3'd2)) ? 32'sd7 : 32'sd5));
    // data-path code:
    assign s_ex_pred_branch_taken_B0 = r_ex_pred_bits_Q0[1];
    assign s_ex_pred_index = r_ex_pc_Q0[4:1];
    assign s_ex_pred_taddr_hit_B0 = (r_ex_pred_taddr_Q0 == s_ex_add_result_Q0[31:1]);
    assign s_ex_branch_taken_B0 = ((s_ex_jal_Q0 || s_ex_jalr_Q0) || (s_ex_branch_Q0 && s_ex_cmp_true_Q0));
    assign s_ex_jump_B0 = (((s_ex_pred_branch_taken_B0 && ((!s_ex_branch_taken_B0) || (!s_ex_pred_taddr_hit_B0))) || ((!s_ex_pred_branch_taken_B0) && s_ex_branch_taken_B0)) && r_ex_instr_val_Q0);
    assign s_ex_pred_bits = (((s_ex_branch_taken_B0 && (r_ex_pred_bits_Q0 != 2'd3))) ? ((s_ex_jal_Q0) ? 2'd3 : tmp_codasip_conv_PLUS_6517_1[1:0]) : ((((!s_ex_branch_taken_B0) && (r_ex_pred_bits_Q0 != 2'd0))) ? tmp_codasip_conv_MINUS_6510_2[1:0] : r_ex_pred_bits_Q0));
    assign s_ex_pred_tag = r_ex_pc_Q0[31:5];
    assign s_ex_pred_taddr = ((s_ex_branch_taken_B0) ? s_ex_add_result_Q0[31:1] : r_ex_pred_taddr_Q0);
    assign codasip_tmp_var_0 = ((s_ex_branch_taken_B0 || s_ex_jump_B0) && (!s_ex_raw_hazard_Q0));
    assign s_ex_inc_const = ((r_ex_16b_instr_Q0) ? 32'd2 : 32'd4);
    assign codasip_tmp_var_1 = (s_ex_ilegal_instr_Q0 && r_ex_instr_val_Q0);
    assign codasip_tmp_var_2 = (!codasip_tmp_var_1) ? s_ex_mem_error_Q0 : 1'd0;
    assign codasip_tmp_var_3 = ((s_ex_alu_function_Q0 == 4'd2) && (!s_sleep_Q0));
    assign predictor_mem_if_write_A0 = {{4{1'b0}}, s_ex_pred_index};
    assign predictor_mem_if_write_BC0 = 1'd1;
    assign predictor_mem_if_write_BI0 = 1'd0;
    assign predictor_mem_if_write_D0 = s_ex_pred_data_Q0;
    assign predictor_mem_if_write_REQUEST0 = ((ACT == 1'd1) && codasip_tmp_var_0) ? 2'd2 : 2'd0;
    assign r_pred_valid_bits_D0 = ((16'd1 <<< s_ex_pred_index) | r_pred_valid_bits_Q0);
    assign r_pred_valid_bits_WE0 = ((ACT == 1'd1) && codasip_tmp_var_0) ? 1'd1 : 1'd0;
    assign r_wb_16b_instr_D0 = r_ex_16b_instr_Q0;
    assign r_wb_16b_instr_WE0 = (ACT == 1'd1) ? 1'd1 : 1'd0;
    assign r_wb_addrW_D0 = r_ex_instr_Q0[4:0];
    assign r_wb_addrW_WE0 = (ACT == 1'd1) ? 1'd1 : 1'd0;
    assign r_wb_branch_ex_D0 = ((s_ex_jal_Q0 || s_ex_jalr_Q0) || (s_ex_branch_Q0 && s_ex_cmp_true_Q0));
    assign r_wb_branch_ex_WE0 = (ACT == 1'd1) ? 1'd1 : 1'd0;
    assign r_wb_csr_addr_D0 = r_ex_instr_Q0[24:13];
    assign r_wb_csr_addr_WE0 = (ACT == 1'd1) ? 1'd1 : 1'd0;
    assign r_wb_csr_data_D0 = s_ex_rs1_data_bypassed_Q0;
    assign r_wb_csr_data_WE0 = (ACT == 1'd1) ? 1'd1 : 1'd0;
    assign r_wb_csr_funct_D0 = s_ex_csr_funct_Q0;
    assign r_wb_csr_funct_WE0 = (ACT == 1'd1) ? 1'd1 : 1'd0;
    assign r_wb_csr_read_D0 = s_ex_csr_read_Q0;
    assign r_wb_csr_read_WE0 = (ACT == 1'd1) ? 1'd1 : 1'd0;
    assign r_wb_csr_write_D0 = s_ex_csr_write_Q0;
    assign r_wb_csr_write_WE0 = (ACT == 1'd1) ? 1'd1 : 1'd0;
    assign r_wb_exc_code_D0 = codasip_tmp_var_1 ? 4'd2 :
        codasip_tmp_var_2 ? tmp_codasip_conv_TERNARY_6801_3[3:0] : r_ex_exc_code_Q0;
    assign r_wb_exc_code_WE0 = (ACT == 1'd1) ? 1'd1 : 1'd0;
    assign r_wb_exc_D0 = codasip_tmp_var_1 ? 1'd1 :
        codasip_tmp_var_2 ? 1'd1 : r_ex_exc_Q0;
    assign r_wb_exc_instr_addr_D0 = r_ex_exc_instr_addr_Q0;
    assign r_wb_exc_instr_addr_WE0 = (ACT == 1'd1) ? 1'd1 : 1'd0;
    assign r_wb_exc_WE0 = (ACT == 1'd1) ? 1'd1 : 1'd0;
    assign r_wb_halt_D0 = 1'd1;
    assign r_wb_halt_WE0 = ((ACT == 1'd1) && codasip_tmp_var_3) ? 1'd1 : 1'd0;
    assign r_wb_instr_fin_D0 = (!((s_ex_request_stall_Q0 || s_ex_raw_hazard_Q0) || s_ex_mul_div_stall_Q0));
    assign r_wb_instr_fin_WE0 = (ACT == 1'd1) ? 1'd1 : 1'd0;
    assign r_wb_instr_val_D0 = r_ex_instr_val_Q0;
    assign r_wb_instr_val_WE0 = (ACT == 1'd1) ? 1'd1 : 1'd0;
    assign r_wb_mem_cmd_D0 = s_ex_mem_cmd_Q0;
    assign r_wb_mem_cmd_WE0 = (ACT == 1'd1) ? 1'd1 : 1'd0;
    assign r_wb_mem_type_D0 = s_ex_mem_type_Q0;
    assign r_wb_mem_type_WE0 = (ACT == 1'd1) ? 1'd1 : 1'd0;
    assign r_wb_memop_D0 = s_ex_memop_Q0;
    assign r_wb_memop_WE0 = (ACT == 1'd1) ? 1'd1 : 1'd0;
    assign r_wb_pc_D0 = r_ex_pc_Q0;
    assign r_wb_pc_WE0 = (ACT == 1'd1) ? 1'd1 : 1'd0;
    assign r_wb_reg_write_D0 = s_ex_reg_write_Q0;
    assign r_wb_reg_write_WE0 = (ACT == 1'd1) ? 1'd1 : 1'd0;
    assign r_wb_result_D0 = s_ex_result_Q0;
    assign r_wb_result_WE0 = (ACT == 1'd1) ? 1'd1 : 1'd0;
    assign r_wb_save_return_addr_D0 = (s_ex_jal_Q0 || s_ex_jalr_Q0);
    assign r_wb_save_return_addr_WE0 = (ACT == 1'd1) ? 1'd1 : 1'd0;
    assign r_wb_wfi_D0 = (s_ex_alu_function_Q0 == 4'd3);
    assign r_wb_wfi_WE0 = (ACT == 1'd1) ? 1'd1 : 1'd0;
    assign r_wb_writedata_D0 = s_ex_rs2_data_bypassed_Q0;
    assign r_wb_writedata_WE0 = (ACT == 1'd1) ? 1'd1 : 1'd0;
    assign r_wb_zimm_D0 = r_ex_instr_Q0[12:8];
    assign r_wb_zimm_WE0 = (ACT == 1'd1) ? 1'd1 : 1'd0;
    assign s_ex_jump_addr_D0 = (ACT == 1'd1) ? (((s_ex_pred_branch_taken_B0 && (!s_ex_branch_taken_B0))) ? (r_ex_pc_Q0 + s_ex_inc_const) : s_ex_add_result_Q0) : 32'd0;
    assign s_ex_pc_we_D0 = (ACT == 1'd1) ? ((((s_ex_jump_B0 && ((!s_wb_stall_wb_Q0) && (!s_ex_raw_hazard_Q0))) || s_ex_inv_all_instr_Q0) || s_wb_exc_Q0) || s_wb_mret_Q0) : 1'd0;
    assign s_ex_pred_data_D0 = (ACT == 1'd1) ? {{s_ex_pred_taddr,s_ex_pred_tag},s_ex_pred_bits} : 60'd0;
endmodule
