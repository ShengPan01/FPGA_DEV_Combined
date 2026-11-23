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
 *  \brief   Contains module definition of the 'codix_berkelium_ca_core_dec_t' instruction decoder.
 */

module codix_berkelium_ca_core_dec_t(
    input  wire ACT,
    input  wire [31:0] codasip_param_0,
    output wire codasip_param_1,
    output wire [3:0] s_ex_alu_function_D0,
    output wire [1:0] s_ex_aluop1_mux_D0,
    output wire s_ex_aluop1_signed_D0,
    output wire s_ex_aluop2_mux_D0,
    output wire s_ex_aluop2_signed_D0,
    output wire s_ex_branch_D0,
    output wire [2:0] s_ex_cmp_function_D0,
    output wire [2:0] s_ex_csr_funct_D0,
    output wire s_ex_csr_read_D0,
    output wire s_ex_csr_write_D0,
    output wire s_ex_inv_all_instr_D0,
    output wire s_ex_jal_D0,
    output wire s_ex_jalr_D0,
    output wire [2:0] s_ex_mem_cmd_D0,
    output wire [2:0] s_ex_mem_type_D0,
    output wire s_ex_memop_D0,
    output wire s_ex_mulh_D0,
    output wire s_ex_reg_write_D0,
    output wire [3:0] s_ex_sel_imm_D0
);
    // type, wire and constant declarations:
    // signal/wire (inner)
    wire [9:0] codasip_return_MI17opc_comp_2reg_immIH4_2ex2ex5_3dec3dec20_17opc_comp_2reg_imm3opc;
    // signal/wire (inner)
    wire [16:0] codasip_return_MI23opc_comp_2reg_imm_shiftIH4_2ex2ex5_3dec3dec26_23opc_comp_2reg_imm_shift3opc;
    // signal/wire (inner)
    wire [16:0] codasip_return_MI13opc_comp_3regIH4_2ex2ex5_3dec3dec16_13opc_comp_3reg3opc;
    // signal/wire (inner)
    wire [9:0] codasip_return_MI23opc_control_conditionalIH4_2ex2ex5_3dec3dec26_23opc_control_conditional3opc;
    // signal/wire (inner)
    wire [9:0] codasip_return_MI9opc_loadsIH4_2ex2ex5_3dec3dec11_9opc_loads3opc;
    // signal/wire (inner)
    wire [9:0] codasip_return_MI10opc_storesIH4_2ex2ex5_3dec3dec13_10opc_stores3opc;
    // signal/wire (inner)
    wire [9:0] codasip_return_MI21opc_control_registersIH4_2ex2ex5_3dec3dec24_21opc_control_registers3opc;
    // signal/wire (inner)
    wire invalid_instruction_wire;
    // signal/wire (inner)
    wire cs_0_wire;
    // signal/wire (inner)
    wire cs_1_wire;
    // signal/wire (inner)
    wire cs_3_wire;
    // signal/wire (inner)
    wire cs_5_wire;
    // signal/wire (inner)
    wire cs_6_wire;
    // signal/wire (inner)
    wire cs_7_wire;
    // signal/wire (inner)
    wire cs_8_wire;
    // signal/wire (inner)
    wire cs_9_wire;
    // signal/wire (inner)
    wire cs_10_wire;
    // signal/wire (inner)
    wire cs_11_wire;
    // signal/wire (inner)
    wire cs_12_wire;
    // signal/wire (inner)
    wire cs_13_wire;
    // signal/wire (inner)
    wire cs_14_wire;
    // signal/wire (inner)
    wire cs_15_wire;
    // signal/wire (inner)
    wire cs_16_wire;
    // signal/wire (inner)
    wire cs_17_wire;
    // signal/wire (inner)
    wire cs_18_wire;
    // signal/wire (inner)
    wire cs_19_wire;
    // signal/wire (inner)
    wire cs_20_wire;
    // signal/wire (inner)
    wire cs_21_wire;
    // signal/wire (inner)
    wire cs_22_wire;
    // signal/wire (inner)
    wire cs_23_wire;
    // signal/wire (inner)
    wire cs_24_wire;
    // signal/wire (inner)
    wire cs_25_wire;
    // signal/wire (inner)
    wire cs_26_wire;
    // signal/wire (inner)
    wire cs_27_wire;
    // signal/wire (inner)
    wire cs_28_wire;
    // signal/wire (inner)
    wire cs_29_wire;
    // signal/wire (inner)
    wire cs_31_wire;
    // signal/wire (inner)
    wire cs_32_wire;
    // signal/wire (inner)
    wire cs_33_wire;
    // signal/wire (inner)
    wire cs_34_wire;
    // signal/wire (inner)
    wire cs_35_wire;
    // signal/wire (inner)
    wire cs_36_wire;
    // signal/wire (inner)
    wire cs_37_wire;
    // signal/wire (inner)
    wire cs_38_wire;
    // signal/wire (inner)
    wire cs_39_wire;
    // signal/wire (inner)
    wire cs_40_wire;
    // signal/wire (inner)
    wire cs_41_wire;
    // signal/wire (inner)
    wire cs_42_wire;
    // signal/wire (inner)
    wire cs_43_wire;
    // signal/wire (inner)
    wire cs_44_wire;
    // signal/wire (inner)
    wire cs_45_wire;
    // signal/wire (inner)
    wire cs_46_wire;
    // signal/wire (inner)
    wire cs_47_wire;
    // signal/wire (inner)
    wire cs_48_wire;
    // signal/wire (inner)
    wire cs_49_wire;
    // signal/wire (inner)
    wire cs_50_wire;
    // signal/wire (inner)
    wire cs_51_wire;
    // signal/wire (inner)
    wire cs_52_wire;
    // signal/wire (inner)
    wire cs_53_wire;
    // signal/wire (inner)
    wire cs_54_wire;
    // signal/wire (inner)
    wire cs_55_wire;
    // signal/wire (inner)
    wire cs_56_wire;
    // signal/wire (inner)
    wire cs_57_wire;
    // signal/wire (inner)
    wire cs_58_wire;
    // signal/wire (inner)
    wire cs_59_wire;
    // signal/wire (inner)
    wire cs_60_wire;
    // signal/wire (inner)
    wire cs_61_wire;
    // signal/wire (inner)
    wire cs_62_wire;
    // signal/wire (inner)
    wire cs_63_wire;
    // signal/wire (inner)
    wire cs_64_wire;
    // signal/wire (inner)
    wire cs_65_wire;
    // signal/wire (inner)
    wire cs_66_wire;
    // signal/wire (inner)
    wire cs_67_wire;
    // signal/wire (inner)
    wire vs_0_wire;
    // signal/wire (inner)
    wire i_hw_auipc_ACT;
    // signal/wire (inner)
    wire i_hw_ecall_ACT;
    // signal/wire (inner)
    wire i_hw_fence_ACT;
    // signal/wire (inner)
    wire i_hw_store_ACT;
    // signal/wire (inner)
    wire opc_csrrci_ACT;
    // signal/wire (inner)
    wire opc_csrrsi_ACT;
    // signal/wire (inner)
    wire opc_csrrwi_ACT;
    // signal/wire (inner)
    wire opc_loadbu_ACT;
    // signal/wire (inner)
    wire opc_loadhu_ACT;
    // signal/wire (inner)
    wire opc_mulhsu_ACT;
    // signal/wire (inner)
    wire opc_storeb_ACT;
    // signal/wire (inner)
    wire opc_storeh_ACT;
    // signal/wire (inner)
    wire opc_storew_ACT;
    // signal/wire (inner)
    wire i_hw_ebreak_ACT;
    // signal/wire (inner)
    wire i_hw_fencei_ACT;
    // signal/wire (inner)
    wire i_hw_comp_3reg_ACT;
    // signal/wire (inner)
    wire i_hw_comp_2reg_imm_ACT;
    // signal/wire (inner)
    wire i_hw_control_registers_ACT;
    // signal/wire (inner)
    wire i_hw_comp_2reg_imm_shift_ACT;
    // signal/wire (inner)
    wire i_hw_control_conditional_ACT;
    // signal/wire (inner)
    wire opc_or_ACT;
    // signal/wire (inner)
    wire opc_add_ACT;
    // signal/wire (inner)
    wire opc_and_ACT;
    // signal/wire (inner)
    wire opc_beq_ACT;
    // signal/wire (inner)
    wire opc_bge_ACT;
    // signal/wire (inner)
    wire opc_blt_ACT;
    // signal/wire (inner)
    wire opc_bne_ACT;
    // signal/wire (inner)
    wire opc_div_ACT;
    // signal/wire (inner)
    wire opc_mul_ACT;
    // signal/wire (inner)
    wire opc_ori_ACT;
    // signal/wire (inner)
    wire opc_rem_ACT;
    // signal/wire (inner)
    wire opc_sll_ACT;
    // signal/wire (inner)
    wire opc_slt_ACT;
    // signal/wire (inner)
    wire opc_sra_ACT;
    // signal/wire (inner)
    wire opc_srl_ACT;
    // signal/wire (inner)
    wire opc_sub_ACT;
    // signal/wire (inner)
    wire opc_xor_ACT;
    // signal/wire (inner)
    wire i_hw_jal_ACT;
    // signal/wire (inner)
    wire i_hw_lui_ACT;
    // signal/wire (inner)
    wire i_hw_wfi_ACT;
    // signal/wire (inner)
    wire opc_addi_ACT;
    // signal/wire (inner)
    wire opc_andi_ACT;
    // signal/wire (inner)
    wire opc_bgeu_ACT;
    // signal/wire (inner)
    wire opc_bltu_ACT;
    // signal/wire (inner)
    wire opc_divu_ACT;
    // signal/wire (inner)
    wire opc_mulh_ACT;
    // signal/wire (inner)
    wire opc_remu_ACT;
    // signal/wire (inner)
    wire opc_slli_ACT;
    // signal/wire (inner)
    wire opc_slti_ACT;
    // signal/wire (inner)
    wire opc_sltu_ACT;
    // signal/wire (inner)
    wire opc_srai_ACT;
    // signal/wire (inner)
    wire opc_srli_ACT;
    // signal/wire (inner)
    wire opc_xori_ACT;
    // signal/wire (inner)
    wire i_hw_jalr_ACT;
    // signal/wire (inner)
    wire i_hw_load_ACT;
    // signal/wire (inner)
    wire i_hw_xret_ACT;
    // signal/wire (inner)
    wire opc_csrrc_ACT;
    // signal/wire (inner)
    wire opc_csrrs_ACT;
    // signal/wire (inner)
    wire opc_csrrw_ACT;
    // signal/wire (inner)
    wire opc_loadb_ACT;
    // signal/wire (inner)
    wire opc_loadh_ACT;
    // signal/wire (inner)
    wire opc_loadw_ACT;
    // signal/wire (inner)
    wire opc_mulhu_ACT;
    // signal/wire (inner)
    wire opc_sltiu_ACT;
    // signal/wire (inner)
    wire [3:0] i_hw_auipc_s_ex_sel_imm_D0;
    // signal/wire (inner)
    wire i_hw_auipc_s_ex_reg_write_D0;
    // signal/wire (inner)
    wire [1:0] i_hw_auipc_s_ex_aluop1_mux_D0;
    // signal/wire (inner)
    wire i_hw_auipc_s_ex_aluop2_mux_D0;
    // signal/wire (inner)
    wire [2:0] i_hw_auipc_s_ex_cmp_function_D0;
    // signal/wire (inner)
    wire [2:0] i_hw_auipc_s_ex_mem_type_D0;
    // signal/wire (inner)
    wire [2:0] i_hw_ecall_s_ex_cmp_function_D0;
    // signal/wire (inner)
    wire [2:0] i_hw_ecall_s_ex_mem_type_D0;
    // signal/wire (inner)
    wire [2:0] i_hw_ecall_s_ex_csr_funct_D0;
    // signal/wire (inner)
    wire [2:0] i_hw_fence_s_ex_cmp_function_D0;
    // signal/wire (inner)
    wire [2:0] i_hw_fence_s_ex_mem_type_D0;
    // signal/wire (inner)
    wire [9:0] codasip_tmp_var_0_i_hw_store_dec_dec_ex_ex;
    // signal/wire (inner)
    wire [2:0] i_hw_store_s_ex_mem_type_D0;
    // signal/wire (inner)
    wire [2:0] i_hw_store_s_ex_mem_type_D0_ACT;
    // signal/wire (inner)
    wire [1:0] i_hw_store_s_ex_aluop1_mux_D0;
    // signal/wire (inner)
    wire i_hw_store_s_ex_aluop2_mux_D0;
    // signal/wire (inner)
    wire [2:0] i_hw_store_s_ex_cmp_function_D0;
    // signal/wire (inner)
    wire i_hw_store_s_ex_memop_D0;
    // signal/wire (inner)
    wire [2:0] i_hw_store_s_ex_mem_cmd_D0;
    // signal/wire (inner)
    wire [9:0] opc_csrrci_codasip_return_MI21opc_control_registersIH4_2ex2ex5_3dec3dec24_21opc_control_registers3opc_D0;
    // signal/wire (inner)
    wire [9:0] opc_csrrsi_codasip_return_MI21opc_control_registersIH4_2ex2ex5_3dec3dec24_21opc_control_registers3opc_D0;
    // signal/wire (inner)
    wire [9:0] opc_csrrwi_codasip_return_MI21opc_control_registersIH4_2ex2ex5_3dec3dec24_21opc_control_registers3opc_D0;
    // signal/wire (inner)
    wire [9:0] opc_loadbu_codasip_return_MI9opc_loadsIH4_2ex2ex5_3dec3dec11_9opc_loads3opc_D0;
    // signal/wire (inner)
    wire [9:0] opc_loadhu_codasip_return_MI9opc_loadsIH4_2ex2ex5_3dec3dec11_9opc_loads3opc_D0;
    // signal/wire (inner)
    wire [16:0] opc_mulhsu_codasip_return_MI13opc_comp_3regIH4_2ex2ex5_3dec3dec16_13opc_comp_3reg3opc_D0;
    // signal/wire (inner)
    wire [9:0] opc_storeb_codasip_return_MI10opc_storesIH4_2ex2ex5_3dec3dec13_10opc_stores3opc_D0;
    // signal/wire (inner)
    wire [9:0] opc_storeh_codasip_return_MI10opc_storesIH4_2ex2ex5_3dec3dec13_10opc_stores3opc_D0;
    // signal/wire (inner)
    wire [9:0] opc_storew_codasip_return_MI10opc_storesIH4_2ex2ex5_3dec3dec13_10opc_stores3opc_D0;
    // signal/wire (inner)
    wire [3:0] i_hw_ebreak_s_ex_alu_function_D0;
    // signal/wire (inner)
    wire [2:0] i_hw_ebreak_s_ex_cmp_function_D0;
    // signal/wire (inner)
    wire [2:0] i_hw_ebreak_s_ex_mem_type_D0;
    // signal/wire (inner)
    wire [3:0] i_hw_fencei_s_ex_sel_imm_D0;
    // signal/wire (inner)
    wire [1:0] i_hw_fencei_s_ex_aluop1_mux_D0;
    // signal/wire (inner)
    wire i_hw_fencei_s_ex_aluop2_mux_D0;
    // signal/wire (inner)
    wire [2:0] i_hw_fencei_s_ex_cmp_function_D0;
    // signal/wire (inner)
    wire [2:0] i_hw_fencei_s_ex_mem_type_D0;
    // signal/wire (inner)
    wire i_hw_fencei_s_ex_inv_all_instr_D0;
    // signal/wire (inner)
    wire [16:0] codasip_tmp_var_0_i_hw_comp_3reg_dec_dec_ex_ex;
    // signal/wire (inner)
    wire [3:0] i_hw_comp_3reg_s_ex_alu_function_D0;
    // signal/wire (inner)
    wire [3:0] i_hw_comp_3reg_s_ex_alu_function_D0_ACT;
    // signal/wire (inner)
    wire i_hw_comp_3reg_s_ex_aluop1_signed_D0;
    // signal/wire (inner)
    wire i_hw_comp_3reg_s_ex_aluop2_signed_D0;
    // signal/wire (inner)
    wire i_hw_comp_3reg_s_ex_mulh_D0;
    // signal/wire (inner)
    wire i_hw_comp_3reg_s_ex_reg_write_D0;
    // signal/wire (inner)
    wire [1:0] i_hw_comp_3reg_s_ex_aluop1_mux_D0;
    // signal/wire (inner)
    wire [2:0] i_hw_comp_3reg_s_ex_cmp_function_D0;
    // signal/wire (inner)
    wire [2:0] i_hw_comp_3reg_s_ex_mem_type_D0;
    // signal/wire (inner)
    wire [9:0] codasip_tmp_var_0_i_hw_comp_2reg_imm_dec_dec_ex_ex;
    // signal/wire (inner)
    wire [3:0] i_hw_comp_2reg_imm_s_ex_alu_function_D0;
    // signal/wire (inner)
    wire [3:0] i_hw_comp_2reg_imm_s_ex_alu_function_D0_ACT;
    // signal/wire (inner)
    wire [3:0] i_hw_comp_2reg_imm_s_ex_sel_imm_D0;
    // signal/wire (inner)
    wire i_hw_comp_2reg_imm_s_ex_reg_write_D0;
    // signal/wire (inner)
    wire [1:0] i_hw_comp_2reg_imm_s_ex_aluop1_mux_D0;
    // signal/wire (inner)
    wire i_hw_comp_2reg_imm_s_ex_aluop2_mux_D0;
    // signal/wire (inner)
    wire [2:0] i_hw_comp_2reg_imm_s_ex_cmp_function_D0;
    // signal/wire (inner)
    wire [2:0] i_hw_comp_2reg_imm_s_ex_mem_type_D0;
    // signal/wire (inner)
    wire [9:0] codasip_tmp_var_0_i_hw_control_registers_dec_dec_ex_ex;
    // signal/wire (inner)
    wire i_hw_control_registers_s_ex_reg_write_D0;
    // signal/wire (inner)
    wire [2:0] i_hw_control_registers_s_ex_cmp_function_D0;
    // signal/wire (inner)
    wire [2:0] i_hw_control_registers_s_ex_mem_type_D0;
    // signal/wire (inner)
    wire [2:0] i_hw_control_registers_s_ex_csr_funct_D0;
    // signal/wire (inner)
    wire [2:0] i_hw_control_registers_s_ex_csr_funct_D0_ACT;
    // signal/wire (inner)
    wire i_hw_control_registers_s_ex_csr_read_D0;
    // signal/wire (inner)
    wire i_hw_control_registers_s_ex_csr_write_D0;
    // signal/wire (inner)
    wire [16:0] codasip_tmp_var_0_i_hw_comp_2reg_imm_shift_dec_dec_ex_ex;
    // signal/wire (inner)
    wire [3:0] i_hw_comp_2reg_imm_shift_s_ex_alu_function_D0;
    // signal/wire (inner)
    wire [3:0] i_hw_comp_2reg_imm_shift_s_ex_alu_function_D0_ACT;
    // signal/wire (inner)
    wire [3:0] i_hw_comp_2reg_imm_shift_s_ex_sel_imm_D0;
    // signal/wire (inner)
    wire i_hw_comp_2reg_imm_shift_s_ex_reg_write_D0;
    // signal/wire (inner)
    wire [1:0] i_hw_comp_2reg_imm_shift_s_ex_aluop1_mux_D0;
    // signal/wire (inner)
    wire i_hw_comp_2reg_imm_shift_s_ex_aluop2_mux_D0;
    // signal/wire (inner)
    wire [2:0] i_hw_comp_2reg_imm_shift_s_ex_cmp_function_D0;
    // signal/wire (inner)
    wire [2:0] i_hw_comp_2reg_imm_shift_s_ex_mem_type_D0;
    // signal/wire (inner)
    wire [9:0] codasip_tmp_var_0_i_hw_control_conditional_dec_dec_ex_ex;
    // signal/wire (inner)
    wire [2:0] i_hw_control_conditional_s_ex_cmp_function_D0;
    // signal/wire (inner)
    wire [2:0] i_hw_control_conditional_s_ex_cmp_function_D0_ACT;
    // signal/wire (inner)
    wire [3:0] i_hw_control_conditional_s_ex_sel_imm_D0;
    // signal/wire (inner)
    wire [1:0] i_hw_control_conditional_s_ex_aluop1_mux_D0;
    // signal/wire (inner)
    wire i_hw_control_conditional_s_ex_aluop2_mux_D0;
    // signal/wire (inner)
    wire [2:0] i_hw_control_conditional_s_ex_mem_type_D0;
    // signal/wire (inner)
    wire i_hw_control_conditional_s_ex_branch_D0;
    // signal/wire (inner)
    wire [16:0] opc_or_codasip_return_MI13opc_comp_3regIH4_2ex2ex5_3dec3dec16_13opc_comp_3reg3opc_D0;
    // signal/wire (inner)
    wire [16:0] opc_add_codasip_return_MI13opc_comp_3regIH4_2ex2ex5_3dec3dec16_13opc_comp_3reg3opc_D0;
    // signal/wire (inner)
    wire [16:0] opc_and_codasip_return_MI13opc_comp_3regIH4_2ex2ex5_3dec3dec16_13opc_comp_3reg3opc_D0;
    // signal/wire (inner)
    wire [9:0] opc_beq_codasip_return_MI23opc_control_conditionalIH4_2ex2ex5_3dec3dec26_23opc_control_conditional3opc_D0;
    // signal/wire (inner)
    wire [9:0] opc_bge_codasip_return_MI23opc_control_conditionalIH4_2ex2ex5_3dec3dec26_23opc_control_conditional3opc_D0;
    // signal/wire (inner)
    wire [9:0] opc_blt_codasip_return_MI23opc_control_conditionalIH4_2ex2ex5_3dec3dec26_23opc_control_conditional3opc_D0;
    // signal/wire (inner)
    wire [9:0] opc_bne_codasip_return_MI23opc_control_conditionalIH4_2ex2ex5_3dec3dec26_23opc_control_conditional3opc_D0;
    // signal/wire (inner)
    wire [16:0] opc_div_codasip_return_MI13opc_comp_3regIH4_2ex2ex5_3dec3dec16_13opc_comp_3reg3opc_D0;
    // signal/wire (inner)
    wire [16:0] opc_mul_codasip_return_MI13opc_comp_3regIH4_2ex2ex5_3dec3dec16_13opc_comp_3reg3opc_D0;
    // signal/wire (inner)
    wire [9:0] opc_ori_codasip_return_MI17opc_comp_2reg_immIH4_2ex2ex5_3dec3dec20_17opc_comp_2reg_imm3opc_D0;
    // signal/wire (inner)
    wire [16:0] opc_rem_codasip_return_MI13opc_comp_3regIH4_2ex2ex5_3dec3dec16_13opc_comp_3reg3opc_D0;
    // signal/wire (inner)
    wire [16:0] opc_sll_codasip_return_MI13opc_comp_3regIH4_2ex2ex5_3dec3dec16_13opc_comp_3reg3opc_D0;
    // signal/wire (inner)
    wire [16:0] opc_slt_codasip_return_MI13opc_comp_3regIH4_2ex2ex5_3dec3dec16_13opc_comp_3reg3opc_D0;
    // signal/wire (inner)
    wire [16:0] opc_sra_codasip_return_MI13opc_comp_3regIH4_2ex2ex5_3dec3dec16_13opc_comp_3reg3opc_D0;
    // signal/wire (inner)
    wire [16:0] opc_srl_codasip_return_MI13opc_comp_3regIH4_2ex2ex5_3dec3dec16_13opc_comp_3reg3opc_D0;
    // signal/wire (inner)
    wire [16:0] opc_sub_codasip_return_MI13opc_comp_3regIH4_2ex2ex5_3dec3dec16_13opc_comp_3reg3opc_D0;
    // signal/wire (inner)
    wire [16:0] opc_xor_codasip_return_MI13opc_comp_3regIH4_2ex2ex5_3dec3dec16_13opc_comp_3reg3opc_D0;
    // signal/wire (inner)
    wire [3:0] i_hw_jal_s_ex_sel_imm_D0;
    // signal/wire (inner)
    wire i_hw_jal_s_ex_reg_write_D0;
    // signal/wire (inner)
    wire [1:0] i_hw_jal_s_ex_aluop1_mux_D0;
    // signal/wire (inner)
    wire i_hw_jal_s_ex_aluop2_mux_D0;
    // signal/wire (inner)
    wire [2:0] i_hw_jal_s_ex_cmp_function_D0;
    // signal/wire (inner)
    wire [2:0] i_hw_jal_s_ex_mem_type_D0;
    // signal/wire (inner)
    wire i_hw_jal_s_ex_jal_D0;
    // signal/wire (inner)
    wire [3:0] i_hw_lui_s_ex_sel_imm_D0;
    // signal/wire (inner)
    wire i_hw_lui_s_ex_reg_write_D0;
    // signal/wire (inner)
    wire i_hw_lui_s_ex_aluop2_mux_D0;
    // signal/wire (inner)
    wire [2:0] i_hw_lui_s_ex_cmp_function_D0;
    // signal/wire (inner)
    wire [2:0] i_hw_lui_s_ex_mem_type_D0;
    // signal/wire (inner)
    wire [3:0] i_hw_wfi_s_ex_alu_function_D0;
    // signal/wire (inner)
    wire [2:0] i_hw_wfi_s_ex_cmp_function_D0;
    // signal/wire (inner)
    wire [2:0] i_hw_wfi_s_ex_mem_type_D0;
    // signal/wire (inner)
    wire [9:0] opc_addi_codasip_return_MI17opc_comp_2reg_immIH4_2ex2ex5_3dec3dec20_17opc_comp_2reg_imm3opc_D0;
    // signal/wire (inner)
    wire [9:0] opc_andi_codasip_return_MI17opc_comp_2reg_immIH4_2ex2ex5_3dec3dec20_17opc_comp_2reg_imm3opc_D0;
    // signal/wire (inner)
    wire [9:0] opc_bgeu_codasip_return_MI23opc_control_conditionalIH4_2ex2ex5_3dec3dec26_23opc_control_conditional3opc_D0;
    // signal/wire (inner)
    wire [9:0] opc_bltu_codasip_return_MI23opc_control_conditionalIH4_2ex2ex5_3dec3dec26_23opc_control_conditional3opc_D0;
    // signal/wire (inner)
    wire [16:0] opc_divu_codasip_return_MI13opc_comp_3regIH4_2ex2ex5_3dec3dec16_13opc_comp_3reg3opc_D0;
    // signal/wire (inner)
    wire [16:0] opc_mulh_codasip_return_MI13opc_comp_3regIH4_2ex2ex5_3dec3dec16_13opc_comp_3reg3opc_D0;
    // signal/wire (inner)
    wire [16:0] opc_remu_codasip_return_MI13opc_comp_3regIH4_2ex2ex5_3dec3dec16_13opc_comp_3reg3opc_D0;
    // signal/wire (inner)
    wire [16:0] opc_slli_codasip_return_MI23opc_comp_2reg_imm_shiftIH4_2ex2ex5_3dec3dec26_23opc_comp_2reg_imm_shift3opc_D0;
    // signal/wire (inner)
    wire [9:0] opc_slti_codasip_return_MI17opc_comp_2reg_immIH4_2ex2ex5_3dec3dec20_17opc_comp_2reg_imm3opc_D0;
    // signal/wire (inner)
    wire [16:0] opc_sltu_codasip_return_MI13opc_comp_3regIH4_2ex2ex5_3dec3dec16_13opc_comp_3reg3opc_D0;
    // signal/wire (inner)
    wire [16:0] opc_srai_codasip_return_MI23opc_comp_2reg_imm_shiftIH4_2ex2ex5_3dec3dec26_23opc_comp_2reg_imm_shift3opc_D0;
    // signal/wire (inner)
    wire [16:0] opc_srli_codasip_return_MI23opc_comp_2reg_imm_shiftIH4_2ex2ex5_3dec3dec26_23opc_comp_2reg_imm_shift3opc_D0;
    // signal/wire (inner)
    wire [9:0] opc_xori_codasip_return_MI17opc_comp_2reg_immIH4_2ex2ex5_3dec3dec20_17opc_comp_2reg_imm3opc_D0;
    // signal/wire (inner)
    wire [3:0] i_hw_jalr_s_ex_sel_imm_D0;
    // signal/wire (inner)
    wire i_hw_jalr_s_ex_reg_write_D0;
    // signal/wire (inner)
    wire [1:0] i_hw_jalr_s_ex_aluop1_mux_D0;
    // signal/wire (inner)
    wire i_hw_jalr_s_ex_aluop2_mux_D0;
    // signal/wire (inner)
    wire [2:0] i_hw_jalr_s_ex_cmp_function_D0;
    // signal/wire (inner)
    wire [2:0] i_hw_jalr_s_ex_mem_type_D0;
    // signal/wire (inner)
    wire i_hw_jalr_s_ex_jalr_D0;
    // signal/wire (inner)
    wire [9:0] codasip_tmp_var_0_i_hw_load_dec_dec_ex_ex;
    // signal/wire (inner)
    wire [2:0] i_hw_load_s_ex_mem_type_D0;
    // signal/wire (inner)
    wire [2:0] i_hw_load_s_ex_mem_type_D0_ACT;
    // signal/wire (inner)
    wire [3:0] i_hw_load_s_ex_sel_imm_D0;
    // signal/wire (inner)
    wire i_hw_load_s_ex_reg_write_D0;
    // signal/wire (inner)
    wire [1:0] i_hw_load_s_ex_aluop1_mux_D0;
    // signal/wire (inner)
    wire i_hw_load_s_ex_aluop2_mux_D0;
    // signal/wire (inner)
    wire [2:0] i_hw_load_s_ex_cmp_function_D0;
    // signal/wire (inner)
    wire i_hw_load_s_ex_memop_D0;
    // signal/wire (inner)
    wire [2:0] i_hw_load_s_ex_mem_cmd_D0;
    // signal/wire (inner)
    wire [2:0] i_hw_xret_s_ex_cmp_function_D0;
    // signal/wire (inner)
    wire [2:0] i_hw_xret_s_ex_mem_type_D0;
    // signal/wire (inner)
    wire [2:0] i_hw_xret_s_ex_csr_funct_D0;
    // signal/wire (inner)
    wire [9:0] opc_csrrc_codasip_return_MI21opc_control_registersIH4_2ex2ex5_3dec3dec24_21opc_control_registers3opc_D0;
    // signal/wire (inner)
    wire [9:0] opc_csrrs_codasip_return_MI21opc_control_registersIH4_2ex2ex5_3dec3dec24_21opc_control_registers3opc_D0;
    // signal/wire (inner)
    wire [9:0] opc_csrrw_codasip_return_MI21opc_control_registersIH4_2ex2ex5_3dec3dec24_21opc_control_registers3opc_D0;
    // signal/wire (inner)
    wire [9:0] opc_loadb_codasip_return_MI9opc_loadsIH4_2ex2ex5_3dec3dec11_9opc_loads3opc_D0;
    // signal/wire (inner)
    wire [9:0] opc_loadh_codasip_return_MI9opc_loadsIH4_2ex2ex5_3dec3dec11_9opc_loads3opc_D0;
    // signal/wire (inner)
    wire [9:0] opc_loadw_codasip_return_MI9opc_loadsIH4_2ex2ex5_3dec3dec11_9opc_loads3opc_D0;
    // signal/wire (inner)
    wire [16:0] opc_mulhu_codasip_return_MI13opc_comp_3regIH4_2ex2ex5_3dec3dec16_13opc_comp_3reg3opc_D0;
    // signal/wire (inner)
    wire [9:0] opc_sltiu_codasip_return_MI17opc_comp_2reg_immIH4_2ex2ex5_3dec3dec20_17opc_comp_2reg_imm3opc_D0;

    // data-path code:
    assign codasip_param_1 = invalid_instruction_wire;
    assign cs_0_wire = (((((((((((((((((((((((((codasip_param_0 == 32'd115) || (codasip_param_0 == 32'd1048691)) || ({{codasip_param_0[31:25],codasip_param_0[13:12]},codasip_param_0[6:0]} == 16'd147)) || ({codasip_param_0[31:26],codasip_param_0[6:0]} == 13'd51)) || ({{codasip_param_0[31:28],codasip_param_0[14:12]},codasip_param_0[6:0]} == 14'd15)) || (codasip_param_0 == 32'd273678451)) || (codasip_param_0 == 32'd807403635)) || ({{codasip_param_0[31:25],codasip_param_0[14:12]},codasip_param_0[6:0]} == 17'd32819)) || ({{codasip_param_0[31:25],codasip_param_0[14:12]},codasip_param_0[6:0]} == 17'd33427)) || ({{codasip_param_0[31:25],codasip_param_0[14:12]},codasip_param_0[6:0]} == 17'd33459)) || ({codasip_param_0[14:12],codasip_param_0[6:0]} == 10'd103)) || ({codasip_param_0[14:12],codasip_param_0[6:0]} == 10'd143)) || ({codasip_param_0[14:13],codasip_param_0[6:0]} == 9'd35)) || ({codasip_param_0[14:12],codasip_param_0[6:0]} == 10'd259)) || ({codasip_param_0[14:12],codasip_param_0[6:0]} == 10'd291)) || ({codasip_param_0[14:13],codasip_param_0[6:0]} == 9'd483)) || ({codasip_param_0[13],codasip_param_0[6:0]} == 8'd3)) || ({codasip_param_0[13],codasip_param_0[6:0]} == 8'd99)) || ({codasip_param_0[13:12],codasip_param_0[6:0]} == 9'd371)) || ({codasip_param_0[13:12],codasip_param_0[6:0]} == 9'd403)) || ({codasip_param_0[12],codasip_param_0[6:0]} == 8'd19)) || ({codasip_param_0[12],codasip_param_0[6:0]} == 8'd243)) || (codasip_param_0[6:0] == 7'd23)) || (codasip_param_0[6:0] == 7'd55)) || (codasip_param_0[6:0] == 7'd111)) ? 1'd1 : 1'd0;
    assign cs_10_wire = ({{codasip_param_0[31:25],codasip_param_0[14:12]},codasip_param_0[6:0]} == 17'd51) ? 1'd1 : 1'd0;
    assign cs_11_wire = ({{codasip_param_0[31:25],codasip_param_0[14:12]},codasip_param_0[6:0]} == 17'd307) ? 1'd1 : 1'd0;
    assign cs_12_wire = ({{codasip_param_0[31:25],codasip_param_0[14:12]},codasip_param_0[6:0]} == 17'd435) ? 1'd1 : 1'd0;
    assign cs_13_wire = ({{codasip_param_0[31:25],codasip_param_0[14:12]},codasip_param_0[6:0]} == 17'd947) ? 1'd1 : 1'd0;
    assign cs_14_wire = ({{codasip_param_0[31:25],codasip_param_0[14:12]},codasip_param_0[6:0]} == 17'd819) ? 1'd1 : 1'd0;
    assign cs_15_wire = ({{codasip_param_0[31:25],codasip_param_0[14:12]},codasip_param_0[6:0]} == 17'd563) ? 1'd1 : 1'd0;
    assign cs_16_wire = ({{codasip_param_0[31:25],codasip_param_0[14:12]},codasip_param_0[6:0]} == 17'd179) ? 1'd1 : 1'd0;
    assign cs_17_wire = ({{codasip_param_0[31:25],codasip_param_0[14:12]},codasip_param_0[6:0]} == 17'd691) ? 1'd1 : 1'd0;
    assign cs_18_wire = ({{codasip_param_0[31:25],codasip_param_0[14:12]},codasip_param_0[6:0]} == 17'd1075) ? 1'd1 : 1'd0;
    assign cs_19_wire = ({{codasip_param_0[31:25],codasip_param_0[14:12]},codasip_param_0[6:0]} == 17'd1203) ? 1'd1 : 1'd0;
    assign cs_1_wire = (codasip_param_0 == 32'd115) ? 1'd1 : 1'd0;
    assign cs_20_wire = ({{codasip_param_0[31:25],codasip_param_0[14:12]},codasip_param_0[6:0]} == 17'd1459) ? 1'd1 : 1'd0;
    assign cs_21_wire = ({{codasip_param_0[31:25],codasip_param_0[14:12]},codasip_param_0[6:0]} == 17'd1331) ? 1'd1 : 1'd0;
    assign cs_22_wire = ({{codasip_param_0[31:25],codasip_param_0[14:12]},codasip_param_0[6:0]} == 17'd1587) ? 1'd1 : 1'd0;
    assign cs_23_wire = ({{codasip_param_0[31:25],codasip_param_0[14:12]},codasip_param_0[6:0]} == 17'd1715) ? 1'd1 : 1'd0;
    assign cs_24_wire = ({{codasip_param_0[31:25],codasip_param_0[14:12]},codasip_param_0[6:0]} == 17'd1843) ? 1'd1 : 1'd0;
    assign cs_25_wire = ({{codasip_param_0[31:25],codasip_param_0[14:12]},codasip_param_0[6:0]} == 17'd1971) ? 1'd1 : 1'd0;
    assign cs_26_wire = ({{codasip_param_0[31:25],codasip_param_0[14:12]},codasip_param_0[6:0]} == 17'd32819) ? 1'd1 : 1'd0;
    assign cs_27_wire = ({{codasip_param_0[31:25],codasip_param_0[14:12]},codasip_param_0[6:0]} == 17'd33459) ? 1'd1 : 1'd0;
    assign cs_28_wire = ({{codasip_param_0[31:28],codasip_param_0[14:12]},codasip_param_0[6:0]} == 14'd15) ? 1'd1 : 1'd0;
    assign cs_29_wire = (codasip_param_0 == 32'd273678451) ? 1'd1 : 1'd0;
    assign cs_31_wire = (codasip_param_0 == 32'd807403635) ? 1'd1 : 1'd0;
    assign cs_32_wire = ({codasip_param_0[14:12],codasip_param_0[6:0]} == 10'd103) ? 1'd1 : 1'd0;
    assign cs_33_wire = ({codasip_param_0[14:12],codasip_param_0[6:0]} == 10'd143) ? 1'd1 : 1'd0;
    assign cs_34_wire = (({codasip_param_0[14:13],codasip_param_0[6:0]} == 9'd35) || ({codasip_param_0[14:12],codasip_param_0[6:0]} == 10'd291)) ? 1'd1 : 1'd0;
    assign cs_35_wire = ({codasip_param_0[14:12],codasip_param_0[6:0]} == 10'd163) ? 1'd1 : 1'd0;
    assign cs_36_wire = ({codasip_param_0[14:12],codasip_param_0[6:0]} == 10'd35) ? 1'd1 : 1'd0;
    assign cs_37_wire = ({codasip_param_0[14:12],codasip_param_0[6:0]} == 10'd291) ? 1'd1 : 1'd0;
    assign cs_38_wire = (({codasip_param_0[14:12],codasip_param_0[6:0]} == 10'd259) || ({codasip_param_0[13],codasip_param_0[6:0]} == 8'd3)) ? 1'd1 : 1'd0;
    assign cs_39_wire = ({codasip_param_0[14:12],codasip_param_0[6:0]} == 10'd259) ? 1'd1 : 1'd0;
    assign cs_3_wire = (codasip_param_0 == 32'd1048691) ? 1'd1 : 1'd0;
    assign cs_40_wire = ({codasip_param_0[14:12],codasip_param_0[6:0]} == 10'd131) ? 1'd1 : 1'd0;
    assign cs_41_wire = ({codasip_param_0[14:12],codasip_param_0[6:0]} == 10'd643) ? 1'd1 : 1'd0;
    assign cs_42_wire = ({codasip_param_0[14:12],codasip_param_0[6:0]} == 10'd3) ? 1'd1 : 1'd0;
    assign cs_43_wire = ({codasip_param_0[14:12],codasip_param_0[6:0]} == 10'd515) ? 1'd1 : 1'd0;
    assign cs_44_wire = (({codasip_param_0[14:13],codasip_param_0[6:0]} == 9'd483) || ({codasip_param_0[13],codasip_param_0[6:0]} == 8'd99)) ? 1'd1 : 1'd0;
    assign cs_45_wire = ({codasip_param_0[14:12],codasip_param_0[6:0]} == 10'd867) ? 1'd1 : 1'd0;
    assign cs_46_wire = ({codasip_param_0[14:12],codasip_param_0[6:0]} == 10'd995) ? 1'd1 : 1'd0;
    assign cs_47_wire = ({codasip_param_0[14:12],codasip_param_0[6:0]} == 10'd99) ? 1'd1 : 1'd0;
    assign cs_48_wire = ({codasip_param_0[14:12],codasip_param_0[6:0]} == 10'd227) ? 1'd1 : 1'd0;
    assign cs_49_wire = ({codasip_param_0[14:12],codasip_param_0[6:0]} == 10'd611) ? 1'd1 : 1'd0;
    assign cs_50_wire = ({codasip_param_0[14:12],codasip_param_0[6:0]} == 10'd739) ? 1'd1 : 1'd0;
    assign cs_51_wire = (({codasip_param_0[13:12],codasip_param_0[6:0]} == 9'd371) || ({codasip_param_0[12],codasip_param_0[6:0]} == 8'd243)) ? 1'd1 : 1'd0;
    assign cs_52_wire = ({codasip_param_0[14:12],codasip_param_0[6:0]} == 10'd371) ? 1'd1 : 1'd0;
    assign cs_53_wire = ({codasip_param_0[14:12],codasip_param_0[6:0]} == 10'd883) ? 1'd1 : 1'd0;
    assign cs_54_wire = ({codasip_param_0[14:12],codasip_param_0[6:0]} == 10'd499) ? 1'd1 : 1'd0;
    assign cs_55_wire = ({codasip_param_0[14:12],codasip_param_0[6:0]} == 10'd243) ? 1'd1 : 1'd0;
    assign cs_56_wire = ({codasip_param_0[14:12],codasip_param_0[6:0]} == 10'd755) ? 1'd1 : 1'd0;
    assign cs_57_wire = ({codasip_param_0[14:12],codasip_param_0[6:0]} == 10'd1011) ? 1'd1 : 1'd0;
    assign cs_58_wire = (({codasip_param_0[13:12],codasip_param_0[6:0]} == 9'd403) || ({codasip_param_0[12],codasip_param_0[6:0]} == 8'd19)) ? 1'd1 : 1'd0;
    assign cs_59_wire = ({codasip_param_0[14:12],codasip_param_0[6:0]} == 10'd915) ? 1'd1 : 1'd0;
    assign cs_5_wire = (({{codasip_param_0[31:25],codasip_param_0[13:12]},codasip_param_0[6:0]} == 16'd147) || ({{codasip_param_0[31:25],codasip_param_0[14:12]},codasip_param_0[6:0]} == 17'd33427)) ? 1'd1 : 1'd0;
    assign cs_60_wire = ({codasip_param_0[14:12],codasip_param_0[6:0]} == 10'd403) ? 1'd1 : 1'd0;
    assign cs_61_wire = ({codasip_param_0[14:12],codasip_param_0[6:0]} == 10'd19) ? 1'd1 : 1'd0;
    assign cs_62_wire = ({codasip_param_0[14:12],codasip_param_0[6:0]} == 10'd787) ? 1'd1 : 1'd0;
    assign cs_63_wire = ({codasip_param_0[14:12],codasip_param_0[6:0]} == 10'd275) ? 1'd1 : 1'd0;
    assign cs_64_wire = ({codasip_param_0[14:12],codasip_param_0[6:0]} == 10'd531) ? 1'd1 : 1'd0;
    assign cs_65_wire = (codasip_param_0[6:0] == 7'd23) ? 1'd1 : 1'd0;
    assign cs_66_wire = (codasip_param_0[6:0] == 7'd55) ? 1'd1 : 1'd0;
    assign cs_67_wire = (codasip_param_0[6:0] == 7'd111) ? 1'd1 : 1'd0;
    assign cs_6_wire = ({{codasip_param_0[31:25],codasip_param_0[14:12]},codasip_param_0[6:0]} == 17'd147) ? 1'd1 : 1'd0;
    assign cs_7_wire = ({{codasip_param_0[31:25],codasip_param_0[14:12]},codasip_param_0[6:0]} == 17'd659) ? 1'd1 : 1'd0;
    assign cs_8_wire = ({{codasip_param_0[31:25],codasip_param_0[14:12]},codasip_param_0[6:0]} == 17'd33427) ? 1'd1 : 1'd0;
    assign cs_9_wire = ((({codasip_param_0[31:26],codasip_param_0[6:0]} == 13'd51) || ({{codasip_param_0[31:25],codasip_param_0[14:12]},codasip_param_0[6:0]} == 17'd32819)) || ({{codasip_param_0[31:25],codasip_param_0[14:12]},codasip_param_0[6:0]} == 17'd33459)) ? 1'd1 : 1'd0;
    assign invalid_instruction_wire = ((ACT == 1'd1) && (vs_0_wire == 1'd0)) ? 1'd1 : 1'd0;
    assign vs_0_wire = ((codasip_param_0[6:0] == 7'd111) || ((codasip_param_0[6:0] == 7'd55) || ((codasip_param_0[6:0] == 7'd23) || ((({codasip_param_0[13:12],codasip_param_0[6:0]} == 9'd403) || ({codasip_param_0[12],codasip_param_0[6:0]} == 8'd19)) || ((({codasip_param_0[13:12],codasip_param_0[6:0]} == 9'd371) || ({codasip_param_0[12],codasip_param_0[6:0]} == 8'd243)) || ((({codasip_param_0[14:13],codasip_param_0[6:0]} == 9'd483) || ({codasip_param_0[13],codasip_param_0[6:0]} == 8'd99)) || ((({codasip_param_0[14:12],codasip_param_0[6:0]} == 10'd259) || ({codasip_param_0[13],codasip_param_0[6:0]} == 8'd3)) || ((({codasip_param_0[14:13],codasip_param_0[6:0]} == 9'd35) || ({codasip_param_0[14:12],codasip_param_0[6:0]} == 10'd291)) || (({codasip_param_0[14:12],codasip_param_0[6:0]} == 10'd143) || (({codasip_param_0[14:12],codasip_param_0[6:0]} == 10'd103) || ((codasip_param_0 == 32'd807403635) || ((codasip_param_0 == 32'd273678451) || (({{codasip_param_0[31:28],codasip_param_0[14:12]},codasip_param_0[6:0]} == 14'd15) || (((({codasip_param_0[31:26],codasip_param_0[6:0]} == 13'd51) || ({{codasip_param_0[31:25],codasip_param_0[14:12]},codasip_param_0[6:0]} == 17'd32819)) || ({{codasip_param_0[31:25],codasip_param_0[14:12]},codasip_param_0[6:0]} == 17'd33459)) || ((({{codasip_param_0[31:25],codasip_param_0[13:12]},codasip_param_0[6:0]} == 16'd147) || ({{codasip_param_0[31:25],codasip_param_0[14:12]},codasip_param_0[6:0]} == 17'd33427)) || ((codasip_param_0 == 32'd1048691) || (codasip_param_0 == 32'd115))))))))))))))))) ? 1'd1 : 1'd0;
    assign i_hw_auipc_ACT = (((invalid_instruction_wire == 1'd0) && (ACT == 1'd1)) && ((cs_0_wire == 1'd1) && (cs_65_wire == 1'd1))) ? 1'd1 : 1'd0;
    assign i_hw_ecall_ACT = (((invalid_instruction_wire == 1'd0) && (ACT == 1'd1)) && ((cs_0_wire == 1'd1) && (cs_1_wire == 1'd1))) ? 1'd1 : 1'd0;
    assign i_hw_fence_ACT = (((invalid_instruction_wire == 1'd0) && (ACT == 1'd1)) && ((cs_0_wire == 1'd1) && (cs_28_wire == 1'd1))) ? 1'd1 : 1'd0;
    assign i_hw_store_ACT = (((invalid_instruction_wire == 1'd0) && (ACT == 1'd1)) && ((cs_0_wire == 1'd1) && (cs_34_wire == 1'd1))) ? 1'd1 : 1'd0;
    assign opc_csrrci_ACT = (((invalid_instruction_wire == 1'd0) && (ACT == 1'd1)) && (((cs_0_wire == 1'd1) && (cs_51_wire == 1'd1)) && (cs_57_wire == 1'd1))) ? 1'd1 : 1'd0;
    assign opc_csrrsi_ACT = (((invalid_instruction_wire == 1'd0) && (ACT == 1'd1)) && (((cs_0_wire == 1'd1) && (cs_51_wire == 1'd1)) && (cs_53_wire == 1'd1))) ? 1'd1 : 1'd0;
    assign opc_csrrwi_ACT = (((invalid_instruction_wire == 1'd0) && (ACT == 1'd1)) && (((cs_0_wire == 1'd1) && (cs_51_wire == 1'd1)) && (cs_56_wire == 1'd1))) ? 1'd1 : 1'd0;
    assign opc_loadbu_ACT = (((invalid_instruction_wire == 1'd0) && (ACT == 1'd1)) && (((cs_0_wire == 1'd1) && (cs_38_wire == 1'd1)) && (cs_43_wire == 1'd1))) ? 1'd1 : 1'd0;
    assign opc_loadhu_ACT = (((invalid_instruction_wire == 1'd0) && (ACT == 1'd1)) && (((cs_0_wire == 1'd1) && (cs_38_wire == 1'd1)) && (cs_41_wire == 1'd1))) ? 1'd1 : 1'd0;
    assign opc_mulhsu_ACT = (((invalid_instruction_wire == 1'd0) && (ACT == 1'd1)) && (((cs_0_wire == 1'd1) && (cs_9_wire == 1'd1)) && (cs_21_wire == 1'd1))) ? 1'd1 : 1'd0;
    assign opc_storeb_ACT = (((invalid_instruction_wire == 1'd0) && (ACT == 1'd1)) && (((cs_0_wire == 1'd1) && (cs_34_wire == 1'd1)) && (cs_36_wire == 1'd1))) ? 1'd1 : 1'd0;
    assign opc_storeh_ACT = (((invalid_instruction_wire == 1'd0) && (ACT == 1'd1)) && (((cs_0_wire == 1'd1) && (cs_34_wire == 1'd1)) && (cs_35_wire == 1'd1))) ? 1'd1 : 1'd0;
    assign opc_storew_ACT = (((invalid_instruction_wire == 1'd0) && (ACT == 1'd1)) && (((cs_0_wire == 1'd1) && (cs_34_wire == 1'd1)) && (cs_37_wire == 1'd1))) ? 1'd1 : 1'd0;
    assign i_hw_ebreak_ACT = (((invalid_instruction_wire == 1'd0) && (ACT == 1'd1)) && ((cs_0_wire == 1'd1) && (cs_3_wire == 1'd1))) ? 1'd1 : 1'd0;
    assign i_hw_fencei_ACT = (((invalid_instruction_wire == 1'd0) && (ACT == 1'd1)) && ((cs_0_wire == 1'd1) && (cs_33_wire == 1'd1))) ? 1'd1 : 1'd0;
    assign i_hw_comp_3reg_ACT = (((invalid_instruction_wire == 1'd0) && (ACT == 1'd1)) && ((cs_0_wire == 1'd1) && (cs_9_wire == 1'd1))) ? 1'd1 : 1'd0;
    assign i_hw_comp_2reg_imm_ACT = (((invalid_instruction_wire == 1'd0) && (ACT == 1'd1)) && ((cs_0_wire == 1'd1) && (cs_58_wire == 1'd1))) ? 1'd1 : 1'd0;
    assign i_hw_control_registers_ACT = (((invalid_instruction_wire == 1'd0) && (ACT == 1'd1)) && ((cs_0_wire == 1'd1) && (cs_51_wire == 1'd1))) ? 1'd1 : 1'd0;
    assign i_hw_comp_2reg_imm_shift_ACT = (((invalid_instruction_wire == 1'd0) && (ACT == 1'd1)) && ((cs_0_wire == 1'd1) && (cs_5_wire == 1'd1))) ? 1'd1 : 1'd0;
    assign i_hw_control_conditional_ACT = (((invalid_instruction_wire == 1'd0) && (ACT == 1'd1)) && ((cs_0_wire == 1'd1) && (cs_44_wire == 1'd1))) ? 1'd1 : 1'd0;
    assign opc_or_ACT = (((invalid_instruction_wire == 1'd0) && (ACT == 1'd1)) && (((cs_0_wire == 1'd1) && (cs_9_wire == 1'd1)) && (cs_14_wire == 1'd1))) ? 1'd1 : 1'd0;
    assign opc_add_ACT = (((invalid_instruction_wire == 1'd0) && (ACT == 1'd1)) && (((cs_0_wire == 1'd1) && (cs_9_wire == 1'd1)) && (cs_10_wire == 1'd1))) ? 1'd1 : 1'd0;
    assign opc_and_ACT = (((invalid_instruction_wire == 1'd0) && (ACT == 1'd1)) && (((cs_0_wire == 1'd1) && (cs_9_wire == 1'd1)) && (cs_13_wire == 1'd1))) ? 1'd1 : 1'd0;
    assign opc_beq_ACT = (((invalid_instruction_wire == 1'd0) && (ACT == 1'd1)) && (((cs_0_wire == 1'd1) && (cs_44_wire == 1'd1)) && (cs_47_wire == 1'd1))) ? 1'd1 : 1'd0;
    assign opc_bge_ACT = (((invalid_instruction_wire == 1'd0) && (ACT == 1'd1)) && (((cs_0_wire == 1'd1) && (cs_44_wire == 1'd1)) && (cs_50_wire == 1'd1))) ? 1'd1 : 1'd0;
    assign opc_blt_ACT = (((invalid_instruction_wire == 1'd0) && (ACT == 1'd1)) && (((cs_0_wire == 1'd1) && (cs_44_wire == 1'd1)) && (cs_49_wire == 1'd1))) ? 1'd1 : 1'd0;
    assign opc_bne_ACT = (((invalid_instruction_wire == 1'd0) && (ACT == 1'd1)) && (((cs_0_wire == 1'd1) && (cs_44_wire == 1'd1)) && (cs_48_wire == 1'd1))) ? 1'd1 : 1'd0;
    assign opc_div_ACT = (((invalid_instruction_wire == 1'd0) && (ACT == 1'd1)) && (((cs_0_wire == 1'd1) && (cs_9_wire == 1'd1)) && (cs_22_wire == 1'd1))) ? 1'd1 : 1'd0;
    assign opc_mul_ACT = (((invalid_instruction_wire == 1'd0) && (ACT == 1'd1)) && (((cs_0_wire == 1'd1) && (cs_9_wire == 1'd1)) && (cs_18_wire == 1'd1))) ? 1'd1 : 1'd0;
    assign opc_ori_ACT = (((invalid_instruction_wire == 1'd0) && (ACT == 1'd1)) && (((cs_0_wire == 1'd1) && (cs_58_wire == 1'd1)) && (cs_62_wire == 1'd1))) ? 1'd1 : 1'd0;
    assign opc_rem_ACT = (((invalid_instruction_wire == 1'd0) && (ACT == 1'd1)) && (((cs_0_wire == 1'd1) && (cs_9_wire == 1'd1)) && (cs_24_wire == 1'd1))) ? 1'd1 : 1'd0;
    assign opc_sll_ACT = (((invalid_instruction_wire == 1'd0) && (ACT == 1'd1)) && (((cs_0_wire == 1'd1) && (cs_9_wire == 1'd1)) && (cs_16_wire == 1'd1))) ? 1'd1 : 1'd0;
    assign opc_slt_ACT = (((invalid_instruction_wire == 1'd0) && (ACT == 1'd1)) && (((cs_0_wire == 1'd1) && (cs_9_wire == 1'd1)) && (cs_11_wire == 1'd1))) ? 1'd1 : 1'd0;
    assign opc_sra_ACT = (((invalid_instruction_wire == 1'd0) && (ACT == 1'd1)) && (((cs_0_wire == 1'd1) && (cs_9_wire == 1'd1)) && (cs_27_wire == 1'd1))) ? 1'd1 : 1'd0;
    assign opc_srl_ACT = (((invalid_instruction_wire == 1'd0) && (ACT == 1'd1)) && (((cs_0_wire == 1'd1) && (cs_9_wire == 1'd1)) && (cs_17_wire == 1'd1))) ? 1'd1 : 1'd0;
    assign opc_sub_ACT = (((invalid_instruction_wire == 1'd0) && (ACT == 1'd1)) && (((cs_0_wire == 1'd1) && (cs_9_wire == 1'd1)) && (cs_26_wire == 1'd1))) ? 1'd1 : 1'd0;
    assign opc_xor_ACT = (((invalid_instruction_wire == 1'd0) && (ACT == 1'd1)) && (((cs_0_wire == 1'd1) && (cs_9_wire == 1'd1)) && (cs_15_wire == 1'd1))) ? 1'd1 : 1'd0;
    assign i_hw_jal_ACT = (((invalid_instruction_wire == 1'd0) && (ACT == 1'd1)) && ((cs_0_wire == 1'd1) && (cs_67_wire == 1'd1))) ? 1'd1 : 1'd0;
    assign i_hw_lui_ACT = (((invalid_instruction_wire == 1'd0) && (ACT == 1'd1)) && ((cs_0_wire == 1'd1) && (cs_66_wire == 1'd1))) ? 1'd1 : 1'd0;
    assign i_hw_wfi_ACT = (((invalid_instruction_wire == 1'd0) && (ACT == 1'd1)) && ((cs_0_wire == 1'd1) && (cs_29_wire == 1'd1))) ? 1'd1 : 1'd0;
    assign opc_addi_ACT = (((invalid_instruction_wire == 1'd0) && (ACT == 1'd1)) && (((cs_0_wire == 1'd1) && (cs_58_wire == 1'd1)) && (cs_61_wire == 1'd1))) ? 1'd1 : 1'd0;
    assign opc_andi_ACT = (((invalid_instruction_wire == 1'd0) && (ACT == 1'd1)) && (((cs_0_wire == 1'd1) && (cs_58_wire == 1'd1)) && (cs_59_wire == 1'd1))) ? 1'd1 : 1'd0;
    assign opc_bgeu_ACT = (((invalid_instruction_wire == 1'd0) && (ACT == 1'd1)) && (((cs_0_wire == 1'd1) && (cs_44_wire == 1'd1)) && (cs_46_wire == 1'd1))) ? 1'd1 : 1'd0;
    assign opc_bltu_ACT = (((invalid_instruction_wire == 1'd0) && (ACT == 1'd1)) && (((cs_0_wire == 1'd1) && (cs_44_wire == 1'd1)) && (cs_45_wire == 1'd1))) ? 1'd1 : 1'd0;
    assign opc_divu_ACT = (((invalid_instruction_wire == 1'd0) && (ACT == 1'd1)) && (((cs_0_wire == 1'd1) && (cs_9_wire == 1'd1)) && (cs_23_wire == 1'd1))) ? 1'd1 : 1'd0;
    assign opc_mulh_ACT = (((invalid_instruction_wire == 1'd0) && (ACT == 1'd1)) && (((cs_0_wire == 1'd1) && (cs_9_wire == 1'd1)) && (cs_19_wire == 1'd1))) ? 1'd1 : 1'd0;
    assign opc_remu_ACT = (((invalid_instruction_wire == 1'd0) && (ACT == 1'd1)) && (((cs_0_wire == 1'd1) && (cs_9_wire == 1'd1)) && (cs_25_wire == 1'd1))) ? 1'd1 : 1'd0;
    assign opc_slli_ACT = (((invalid_instruction_wire == 1'd0) && (ACT == 1'd1)) && (((cs_0_wire == 1'd1) && (cs_5_wire == 1'd1)) && (cs_6_wire == 1'd1))) ? 1'd1 : 1'd0;
    assign opc_slti_ACT = (((invalid_instruction_wire == 1'd0) && (ACT == 1'd1)) && (((cs_0_wire == 1'd1) && (cs_58_wire == 1'd1)) && (cs_63_wire == 1'd1))) ? 1'd1 : 1'd0;
    assign opc_sltu_ACT = (((invalid_instruction_wire == 1'd0) && (ACT == 1'd1)) && (((cs_0_wire == 1'd1) && (cs_9_wire == 1'd1)) && (cs_12_wire == 1'd1))) ? 1'd1 : 1'd0;
    assign opc_srai_ACT = (((invalid_instruction_wire == 1'd0) && (ACT == 1'd1)) && (((cs_0_wire == 1'd1) && (cs_5_wire == 1'd1)) && (cs_8_wire == 1'd1))) ? 1'd1 : 1'd0;
    assign opc_srli_ACT = (((invalid_instruction_wire == 1'd0) && (ACT == 1'd1)) && (((cs_0_wire == 1'd1) && (cs_5_wire == 1'd1)) && (cs_7_wire == 1'd1))) ? 1'd1 : 1'd0;
    assign opc_xori_ACT = (((invalid_instruction_wire == 1'd0) && (ACT == 1'd1)) && (((cs_0_wire == 1'd1) && (cs_58_wire == 1'd1)) && (cs_64_wire == 1'd1))) ? 1'd1 : 1'd0;
    assign i_hw_jalr_ACT = (((invalid_instruction_wire == 1'd0) && (ACT == 1'd1)) && ((cs_0_wire == 1'd1) && (cs_32_wire == 1'd1))) ? 1'd1 : 1'd0;
    assign i_hw_load_ACT = (((invalid_instruction_wire == 1'd0) && (ACT == 1'd1)) && ((cs_0_wire == 1'd1) && (cs_38_wire == 1'd1))) ? 1'd1 : 1'd0;
    assign i_hw_xret_ACT = (((invalid_instruction_wire == 1'd0) && (ACT == 1'd1)) && ((cs_0_wire == 1'd1) && (cs_31_wire == 1'd1))) ? 1'd1 : 1'd0;
    assign opc_csrrc_ACT = (((invalid_instruction_wire == 1'd0) && (ACT == 1'd1)) && (((cs_0_wire == 1'd1) && (cs_51_wire == 1'd1)) && (cs_54_wire == 1'd1))) ? 1'd1 : 1'd0;
    assign opc_csrrs_ACT = (((invalid_instruction_wire == 1'd0) && (ACT == 1'd1)) && (((cs_0_wire == 1'd1) && (cs_51_wire == 1'd1)) && (cs_52_wire == 1'd1))) ? 1'd1 : 1'd0;
    assign opc_csrrw_ACT = (((invalid_instruction_wire == 1'd0) && (ACT == 1'd1)) && (((cs_0_wire == 1'd1) && (cs_51_wire == 1'd1)) && (cs_55_wire == 1'd1))) ? 1'd1 : 1'd0;
    assign opc_loadb_ACT = (((invalid_instruction_wire == 1'd0) && (ACT == 1'd1)) && (((cs_0_wire == 1'd1) && (cs_38_wire == 1'd1)) && (cs_42_wire == 1'd1))) ? 1'd1 : 1'd0;
    assign opc_loadh_ACT = (((invalid_instruction_wire == 1'd0) && (ACT == 1'd1)) && (((cs_0_wire == 1'd1) && (cs_38_wire == 1'd1)) && (cs_40_wire == 1'd1))) ? 1'd1 : 1'd0;
    assign opc_loadw_ACT = (((invalid_instruction_wire == 1'd0) && (ACT == 1'd1)) && (((cs_0_wire == 1'd1) && (cs_38_wire == 1'd1)) && (cs_39_wire == 1'd1))) ? 1'd1 : 1'd0;
    assign opc_mulhu_ACT = (((invalid_instruction_wire == 1'd0) && (ACT == 1'd1)) && (((cs_0_wire == 1'd1) && (cs_9_wire == 1'd1)) && (cs_20_wire == 1'd1))) ? 1'd1 : 1'd0;
    assign opc_sltiu_ACT = (((invalid_instruction_wire == 1'd0) && (ACT == 1'd1)) && (((cs_0_wire == 1'd1) && (cs_58_wire == 1'd1)) && (cs_60_wire == 1'd1))) ? 1'd1 : 1'd0;
    assign i_hw_auipc_s_ex_sel_imm_D0 = i_hw_auipc_ACT ? 4'd2 : 4'd0;
    assign s_ex_sel_imm_D0 = ((((((((i_hw_auipc_s_ex_sel_imm_D0 | i_hw_fencei_s_ex_sel_imm_D0) | i_hw_comp_2reg_imm_s_ex_sel_imm_D0) | i_hw_comp_2reg_imm_shift_s_ex_sel_imm_D0) | i_hw_control_conditional_s_ex_sel_imm_D0) | i_hw_jal_s_ex_sel_imm_D0) | i_hw_lui_s_ex_sel_imm_D0) | i_hw_jalr_s_ex_sel_imm_D0) | i_hw_load_s_ex_sel_imm_D0);
    assign i_hw_auipc_s_ex_reg_write_D0 = i_hw_auipc_ACT ? 1'd1 : 1'd0;
    assign s_ex_reg_write_D0 = ((((((((i_hw_auipc_s_ex_reg_write_D0 | i_hw_comp_3reg_s_ex_reg_write_D0) | i_hw_comp_2reg_imm_s_ex_reg_write_D0) | i_hw_control_registers_s_ex_reg_write_D0) | i_hw_comp_2reg_imm_shift_s_ex_reg_write_D0) | i_hw_jal_s_ex_reg_write_D0) | i_hw_lui_s_ex_reg_write_D0) | i_hw_jalr_s_ex_reg_write_D0) | i_hw_load_s_ex_reg_write_D0);
    assign i_hw_auipc_s_ex_aluop1_mux_D0 = i_hw_auipc_ACT ? 2'd2 : 2'd0;
    assign s_ex_aluop1_mux_D0 = (((((((((i_hw_auipc_s_ex_aluop1_mux_D0 | i_hw_store_s_ex_aluop1_mux_D0) | i_hw_fencei_s_ex_aluop1_mux_D0) | i_hw_comp_3reg_s_ex_aluop1_mux_D0) | i_hw_comp_2reg_imm_s_ex_aluop1_mux_D0) | i_hw_comp_2reg_imm_shift_s_ex_aluop1_mux_D0) | i_hw_control_conditional_s_ex_aluop1_mux_D0) | i_hw_jal_s_ex_aluop1_mux_D0) | i_hw_jalr_s_ex_aluop1_mux_D0) | i_hw_load_s_ex_aluop1_mux_D0);
    assign i_hw_auipc_s_ex_aluop2_mux_D0 = i_hw_auipc_ACT ? 1'd1 : 1'd0;
    assign s_ex_aluop2_mux_D0 = (((((((((i_hw_auipc_s_ex_aluop2_mux_D0 | i_hw_store_s_ex_aluop2_mux_D0) | i_hw_fencei_s_ex_aluop2_mux_D0) | i_hw_comp_2reg_imm_s_ex_aluop2_mux_D0) | i_hw_comp_2reg_imm_shift_s_ex_aluop2_mux_D0) | i_hw_control_conditional_s_ex_aluop2_mux_D0) | i_hw_jal_s_ex_aluop2_mux_D0) | i_hw_lui_s_ex_aluop2_mux_D0) | i_hw_jalr_s_ex_aluop2_mux_D0) | i_hw_load_s_ex_aluop2_mux_D0);
    assign i_hw_auipc_s_ex_cmp_function_D0 = i_hw_auipc_ACT ? 3'd1 : 3'd0;
    assign s_ex_cmp_function_D0 = (((((((((((((((((((((i_hw_auipc_s_ex_cmp_function_D0 | i_hw_ecall_s_ex_cmp_function_D0) | i_hw_fence_s_ex_cmp_function_D0) | i_hw_store_s_ex_cmp_function_D0) | i_hw_ebreak_s_ex_cmp_function_D0) | i_hw_fencei_s_ex_cmp_function_D0) | i_hw_comp_3reg_s_ex_cmp_function_D0) | i_hw_comp_2reg_imm_s_ex_cmp_function_D0) | i_hw_control_registers_s_ex_cmp_function_D0) | i_hw_comp_2reg_imm_shift_s_ex_cmp_function_D0) | i_hw_control_conditional_s_ex_cmp_function_D0_ACT) | i_hw_control_conditional_s_ex_cmp_function_D0_ACT) | i_hw_control_conditional_s_ex_cmp_function_D0_ACT) | i_hw_control_conditional_s_ex_cmp_function_D0_ACT) | i_hw_control_conditional_s_ex_cmp_function_D0_ACT) | i_hw_control_conditional_s_ex_cmp_function_D0_ACT) | i_hw_jal_s_ex_cmp_function_D0) | i_hw_lui_s_ex_cmp_function_D0) | i_hw_wfi_s_ex_cmp_function_D0) | i_hw_jalr_s_ex_cmp_function_D0) | i_hw_load_s_ex_cmp_function_D0) | i_hw_xret_s_ex_cmp_function_D0);
    assign i_hw_auipc_s_ex_mem_type_D0 = i_hw_auipc_ACT ? 3'd1 : 3'd0;
    assign s_ex_mem_type_D0 = ((((((((((((((((((((((i_hw_auipc_s_ex_mem_type_D0 | i_hw_ecall_s_ex_mem_type_D0) | i_hw_fence_s_ex_mem_type_D0) | i_hw_store_s_ex_mem_type_D0_ACT) | i_hw_store_s_ex_mem_type_D0_ACT) | i_hw_store_s_ex_mem_type_D0_ACT) | i_hw_ebreak_s_ex_mem_type_D0) | i_hw_fencei_s_ex_mem_type_D0) | i_hw_comp_3reg_s_ex_mem_type_D0) | i_hw_comp_2reg_imm_s_ex_mem_type_D0) | i_hw_control_registers_s_ex_mem_type_D0) | i_hw_comp_2reg_imm_shift_s_ex_mem_type_D0) | i_hw_control_conditional_s_ex_mem_type_D0) | i_hw_jal_s_ex_mem_type_D0) | i_hw_lui_s_ex_mem_type_D0) | i_hw_wfi_s_ex_mem_type_D0) | i_hw_jalr_s_ex_mem_type_D0) | i_hw_load_s_ex_mem_type_D0_ACT) | i_hw_load_s_ex_mem_type_D0_ACT) | i_hw_load_s_ex_mem_type_D0_ACT) | i_hw_load_s_ex_mem_type_D0_ACT) | i_hw_load_s_ex_mem_type_D0_ACT) | i_hw_xret_s_ex_mem_type_D0);
    assign i_hw_ecall_s_ex_cmp_function_D0 = i_hw_ecall_ACT ? 3'd1 : 3'd0;
    assign i_hw_ecall_s_ex_mem_type_D0 = i_hw_ecall_ACT ? 3'd1 : 3'd0;
    assign i_hw_ecall_s_ex_csr_funct_D0 = i_hw_ecall_ACT ? 3'd6 : 3'd0;
    assign s_ex_csr_funct_D0 = (((((((i_hw_ecall_s_ex_csr_funct_D0 | i_hw_control_registers_s_ex_csr_funct_D0_ACT) | i_hw_control_registers_s_ex_csr_funct_D0_ACT) | i_hw_control_registers_s_ex_csr_funct_D0_ACT) | i_hw_control_registers_s_ex_csr_funct_D0_ACT) | i_hw_control_registers_s_ex_csr_funct_D0_ACT) | i_hw_control_registers_s_ex_csr_funct_D0_ACT) | i_hw_xret_s_ex_csr_funct_D0);
    assign i_hw_fence_s_ex_cmp_function_D0 = i_hw_fence_ACT ? 3'd1 : 3'd0;
    assign i_hw_fence_s_ex_mem_type_D0 = i_hw_fence_ACT ? 3'd1 : 3'd0;
    assign codasip_tmp_var_0_i_hw_store_dec_dec_ex_ex = codasip_return_MI10opc_storesIH4_2ex2ex5_3dec3dec13_10opc_stores3opc;
    assign i_hw_store_s_ex_mem_type_D0 = (codasip_tmp_var_0_i_hw_store_dec_dec_ex_ex == 10'd163) ? 3'd2 :
        (codasip_tmp_var_0_i_hw_store_dec_dec_ex_ex == 10'd291) ? 3'd4 : 3'd1;
    assign i_hw_store_s_ex_mem_type_D0_ACT = i_hw_store_ACT ? i_hw_store_s_ex_mem_type_D0 : 3'd0;
    assign i_hw_store_s_ex_aluop1_mux_D0 = i_hw_store_ACT ? 2'd1 : 2'd0;
    assign i_hw_store_s_ex_aluop2_mux_D0 = i_hw_store_ACT ? 1'd1 : 1'd0;
    assign i_hw_store_s_ex_cmp_function_D0 = i_hw_store_ACT ? 3'd1 : 3'd0;
    assign i_hw_store_s_ex_memop_D0 = i_hw_store_ACT ? 1'd1 : 1'd0;
    assign s_ex_memop_D0 = (i_hw_store_s_ex_memop_D0 | i_hw_load_s_ex_memop_D0);
    assign i_hw_store_s_ex_mem_cmd_D0 = i_hw_store_ACT ? 3'd2 : 3'd0;
    assign s_ex_mem_cmd_D0 = (i_hw_store_s_ex_mem_cmd_D0 | i_hw_load_s_ex_mem_cmd_D0);
    assign opc_csrrci_codasip_return_MI21opc_control_registersIH4_2ex2ex5_3dec3dec24_21opc_control_registers3opc_D0 = opc_csrrci_ACT ? 10'd1011 : 10'd0;
    assign codasip_return_MI21opc_control_registersIH4_2ex2ex5_3dec3dec24_21opc_control_registers3opc = (((((opc_csrrci_codasip_return_MI21opc_control_registersIH4_2ex2ex5_3dec3dec24_21opc_control_registers3opc_D0 | opc_csrrsi_codasip_return_MI21opc_control_registersIH4_2ex2ex5_3dec3dec24_21opc_control_registers3opc_D0) | opc_csrrwi_codasip_return_MI21opc_control_registersIH4_2ex2ex5_3dec3dec24_21opc_control_registers3opc_D0) | opc_csrrc_codasip_return_MI21opc_control_registersIH4_2ex2ex5_3dec3dec24_21opc_control_registers3opc_D0) | opc_csrrs_codasip_return_MI21opc_control_registersIH4_2ex2ex5_3dec3dec24_21opc_control_registers3opc_D0) | opc_csrrw_codasip_return_MI21opc_control_registersIH4_2ex2ex5_3dec3dec24_21opc_control_registers3opc_D0);
    assign opc_csrrsi_codasip_return_MI21opc_control_registersIH4_2ex2ex5_3dec3dec24_21opc_control_registers3opc_D0 = opc_csrrsi_ACT ? 10'd883 : 10'd0;
    assign opc_csrrwi_codasip_return_MI21opc_control_registersIH4_2ex2ex5_3dec3dec24_21opc_control_registers3opc_D0 = opc_csrrwi_ACT ? 10'd755 : 10'd0;
    assign opc_loadbu_codasip_return_MI9opc_loadsIH4_2ex2ex5_3dec3dec11_9opc_loads3opc_D0 = opc_loadbu_ACT ? 10'd515 : 10'd0;
    assign codasip_return_MI9opc_loadsIH4_2ex2ex5_3dec3dec11_9opc_loads3opc = ((((opc_loadbu_codasip_return_MI9opc_loadsIH4_2ex2ex5_3dec3dec11_9opc_loads3opc_D0 | opc_loadhu_codasip_return_MI9opc_loadsIH4_2ex2ex5_3dec3dec11_9opc_loads3opc_D0) | opc_loadb_codasip_return_MI9opc_loadsIH4_2ex2ex5_3dec3dec11_9opc_loads3opc_D0) | opc_loadh_codasip_return_MI9opc_loadsIH4_2ex2ex5_3dec3dec11_9opc_loads3opc_D0) | opc_loadw_codasip_return_MI9opc_loadsIH4_2ex2ex5_3dec3dec11_9opc_loads3opc_D0);
    assign opc_loadhu_codasip_return_MI9opc_loadsIH4_2ex2ex5_3dec3dec11_9opc_loads3opc_D0 = opc_loadhu_ACT ? 10'd643 : 10'd0;
    assign opc_mulhsu_codasip_return_MI13opc_comp_3regIH4_2ex2ex5_3dec3dec16_13opc_comp_3reg3opc_D0 = opc_mulhsu_ACT ? 17'd1331 : 17'd0;
    assign codasip_return_MI13opc_comp_3regIH4_2ex2ex5_3dec3dec16_13opc_comp_3reg3opc = (((((((((((((((((opc_mulhsu_codasip_return_MI13opc_comp_3regIH4_2ex2ex5_3dec3dec16_13opc_comp_3reg3opc_D0 | opc_or_codasip_return_MI13opc_comp_3regIH4_2ex2ex5_3dec3dec16_13opc_comp_3reg3opc_D0) | opc_add_codasip_return_MI13opc_comp_3regIH4_2ex2ex5_3dec3dec16_13opc_comp_3reg3opc_D0) | opc_and_codasip_return_MI13opc_comp_3regIH4_2ex2ex5_3dec3dec16_13opc_comp_3reg3opc_D0) | opc_div_codasip_return_MI13opc_comp_3regIH4_2ex2ex5_3dec3dec16_13opc_comp_3reg3opc_D0) | opc_mul_codasip_return_MI13opc_comp_3regIH4_2ex2ex5_3dec3dec16_13opc_comp_3reg3opc_D0) | opc_rem_codasip_return_MI13opc_comp_3regIH4_2ex2ex5_3dec3dec16_13opc_comp_3reg3opc_D0) | opc_sll_codasip_return_MI13opc_comp_3regIH4_2ex2ex5_3dec3dec16_13opc_comp_3reg3opc_D0) | opc_slt_codasip_return_MI13opc_comp_3regIH4_2ex2ex5_3dec3dec16_13opc_comp_3reg3opc_D0) | opc_sra_codasip_return_MI13opc_comp_3regIH4_2ex2ex5_3dec3dec16_13opc_comp_3reg3opc_D0) | opc_srl_codasip_return_MI13opc_comp_3regIH4_2ex2ex5_3dec3dec16_13opc_comp_3reg3opc_D0) | opc_sub_codasip_return_MI13opc_comp_3regIH4_2ex2ex5_3dec3dec16_13opc_comp_3reg3opc_D0) | opc_xor_codasip_return_MI13opc_comp_3regIH4_2ex2ex5_3dec3dec16_13opc_comp_3reg3opc_D0) | opc_divu_codasip_return_MI13opc_comp_3regIH4_2ex2ex5_3dec3dec16_13opc_comp_3reg3opc_D0) | opc_mulh_codasip_return_MI13opc_comp_3regIH4_2ex2ex5_3dec3dec16_13opc_comp_3reg3opc_D0) | opc_remu_codasip_return_MI13opc_comp_3regIH4_2ex2ex5_3dec3dec16_13opc_comp_3reg3opc_D0) | opc_sltu_codasip_return_MI13opc_comp_3regIH4_2ex2ex5_3dec3dec16_13opc_comp_3reg3opc_D0) | opc_mulhu_codasip_return_MI13opc_comp_3regIH4_2ex2ex5_3dec3dec16_13opc_comp_3reg3opc_D0);
    assign opc_storeb_codasip_return_MI10opc_storesIH4_2ex2ex5_3dec3dec13_10opc_stores3opc_D0 = opc_storeb_ACT ? 10'd35 : 10'd0;
    assign codasip_return_MI10opc_storesIH4_2ex2ex5_3dec3dec13_10opc_stores3opc = ((opc_storeb_codasip_return_MI10opc_storesIH4_2ex2ex5_3dec3dec13_10opc_stores3opc_D0 | opc_storeh_codasip_return_MI10opc_storesIH4_2ex2ex5_3dec3dec13_10opc_stores3opc_D0) | opc_storew_codasip_return_MI10opc_storesIH4_2ex2ex5_3dec3dec13_10opc_stores3opc_D0);
    assign opc_storeh_codasip_return_MI10opc_storesIH4_2ex2ex5_3dec3dec13_10opc_stores3opc_D0 = opc_storeh_ACT ? 10'd163 : 10'd0;
    assign opc_storew_codasip_return_MI10opc_storesIH4_2ex2ex5_3dec3dec13_10opc_stores3opc_D0 = opc_storew_ACT ? 10'd291 : 10'd0;
    assign i_hw_ebreak_s_ex_alu_function_D0 = i_hw_ebreak_ACT ? 4'd2 : 4'd0;
    assign s_ex_alu_function_D0 = ((((((((((((((((((((((((i_hw_ebreak_s_ex_alu_function_D0 | i_hw_comp_3reg_s_ex_alu_function_D0_ACT) | i_hw_comp_3reg_s_ex_alu_function_D0_ACT) | i_hw_comp_3reg_s_ex_alu_function_D0_ACT) | i_hw_comp_3reg_s_ex_alu_function_D0_ACT) | i_hw_comp_3reg_s_ex_alu_function_D0_ACT) | i_hw_comp_3reg_s_ex_alu_function_D0_ACT) | i_hw_comp_3reg_s_ex_alu_function_D0_ACT) | i_hw_comp_3reg_s_ex_alu_function_D0_ACT) | i_hw_comp_3reg_s_ex_alu_function_D0_ACT) | i_hw_comp_3reg_s_ex_alu_function_D0_ACT) | i_hw_comp_3reg_s_ex_alu_function_D0_ACT) | i_hw_comp_3reg_s_ex_alu_function_D0_ACT) | i_hw_comp_3reg_s_ex_alu_function_D0_ACT) | i_hw_comp_2reg_imm_s_ex_alu_function_D0_ACT) | i_hw_comp_2reg_imm_s_ex_alu_function_D0_ACT) | i_hw_comp_2reg_imm_s_ex_alu_function_D0_ACT) | i_hw_comp_2reg_imm_s_ex_alu_function_D0_ACT) | i_hw_comp_2reg_imm_s_ex_alu_function_D0_ACT) | i_hw_comp_2reg_imm_s_ex_alu_function_D0_ACT) | i_hw_comp_2reg_imm_shift_s_ex_alu_function_D0_ACT) | i_hw_comp_2reg_imm_shift_s_ex_alu_function_D0_ACT) | i_hw_comp_2reg_imm_shift_s_ex_alu_function_D0_ACT) | i_hw_comp_2reg_imm_shift_s_ex_alu_function_D0_ACT) | i_hw_wfi_s_ex_alu_function_D0);
    assign i_hw_ebreak_s_ex_cmp_function_D0 = i_hw_ebreak_ACT ? 3'd1 : 3'd0;
    assign i_hw_ebreak_s_ex_mem_type_D0 = i_hw_ebreak_ACT ? 3'd1 : 3'd0;
    assign i_hw_fencei_s_ex_sel_imm_D0 = i_hw_fencei_ACT ? 4'd5 : 4'd0;
    assign i_hw_fencei_s_ex_aluop1_mux_D0 = i_hw_fencei_ACT ? 2'd2 : 2'd0;
    assign i_hw_fencei_s_ex_aluop2_mux_D0 = i_hw_fencei_ACT ? 1'd1 : 1'd0;
    assign i_hw_fencei_s_ex_cmp_function_D0 = i_hw_fencei_ACT ? 3'd1 : 3'd0;
    assign i_hw_fencei_s_ex_mem_type_D0 = i_hw_fencei_ACT ? 3'd1 : 3'd0;
    assign i_hw_fencei_s_ex_inv_all_instr_D0 = i_hw_fencei_ACT ? 1'd1 : 1'd0;
    assign s_ex_inv_all_instr_D0 = i_hw_fencei_s_ex_inv_all_instr_D0;
    assign codasip_tmp_var_0_i_hw_comp_3reg_dec_dec_ex_ex = codasip_return_MI13opc_comp_3regIH4_2ex2ex5_3dec3dec16_13opc_comp_3reg3opc;
    assign i_hw_comp_3reg_s_ex_alu_function_D0 = (codasip_tmp_var_0_i_hw_comp_3reg_dec_dec_ex_ex == 17'd307) ? 4'd5 :
        (codasip_tmp_var_0_i_hw_comp_3reg_dec_dec_ex_ex == 17'd435) ? 4'd6 :
        (codasip_tmp_var_0_i_hw_comp_3reg_dec_dec_ex_ex == 17'd947) ? 4'd9 :
        (codasip_tmp_var_0_i_hw_comp_3reg_dec_dec_ex_ex == 17'd819) ? 4'd8 :
        (codasip_tmp_var_0_i_hw_comp_3reg_dec_dec_ex_ex == 17'd563) ? 4'd4 :
        (codasip_tmp_var_0_i_hw_comp_3reg_dec_dec_ex_ex == 17'd179) ? 4'd1 :
        (codasip_tmp_var_0_i_hw_comp_3reg_dec_dec_ex_ex == 17'd691) ? 4'd7 :
        (codasip_tmp_var_0_i_hw_comp_3reg_dec_dec_ex_ex == 17'd32819) ? 4'd10 :
        ((((codasip_tmp_var_0_i_hw_comp_3reg_dec_dec_ex_ex == 17'd1331) || (codasip_tmp_var_0_i_hw_comp_3reg_dec_dec_ex_ex == 17'd1459)) || (codasip_tmp_var_0_i_hw_comp_3reg_dec_dec_ex_ex == 17'd1203)) || (codasip_tmp_var_0_i_hw_comp_3reg_dec_dec_ex_ex == 17'd1075)) ? 4'd11 :
        ((codasip_tmp_var_0_i_hw_comp_3reg_dec_dec_ex_ex == 17'd1715) || (codasip_tmp_var_0_i_hw_comp_3reg_dec_dec_ex_ex == 17'd1587)) ? 4'd12 :
        ((codasip_tmp_var_0_i_hw_comp_3reg_dec_dec_ex_ex == 17'd1971) || (codasip_tmp_var_0_i_hw_comp_3reg_dec_dec_ex_ex == 17'd1843)) ? 4'd13 :
        (codasip_tmp_var_0_i_hw_comp_3reg_dec_dec_ex_ex == 17'd33459) ? 4'd14 : 4'd0;
    assign i_hw_comp_3reg_s_ex_alu_function_D0_ACT = i_hw_comp_3reg_ACT ? i_hw_comp_3reg_s_ex_alu_function_D0 : 4'd0;
    assign i_hw_comp_3reg_s_ex_aluop1_signed_D0 = i_hw_comp_3reg_ACT ? (((((codasip_return_MI13opc_comp_3regIH4_2ex2ex5_3dec3dec16_13opc_comp_3reg3opc == 17'd1075) || (codasip_return_MI13opc_comp_3regIH4_2ex2ex5_3dec3dec16_13opc_comp_3reg3opc == 17'd1203)) || (codasip_return_MI13opc_comp_3regIH4_2ex2ex5_3dec3dec16_13opc_comp_3reg3opc == 17'd1587)) || (codasip_return_MI13opc_comp_3regIH4_2ex2ex5_3dec3dec16_13opc_comp_3reg3opc == 17'd1843)) || (codasip_return_MI13opc_comp_3regIH4_2ex2ex5_3dec3dec16_13opc_comp_3reg3opc == 17'd1331)) : 1'd0;
    assign s_ex_aluop1_signed_D0 = i_hw_comp_3reg_s_ex_aluop1_signed_D0;
    assign i_hw_comp_3reg_s_ex_aluop2_signed_D0 = i_hw_comp_3reg_ACT ? ((((codasip_return_MI13opc_comp_3regIH4_2ex2ex5_3dec3dec16_13opc_comp_3reg3opc == 17'd1075) || (codasip_return_MI13opc_comp_3regIH4_2ex2ex5_3dec3dec16_13opc_comp_3reg3opc == 17'd1203)) || (codasip_return_MI13opc_comp_3regIH4_2ex2ex5_3dec3dec16_13opc_comp_3reg3opc == 17'd1587)) || (codasip_return_MI13opc_comp_3regIH4_2ex2ex5_3dec3dec16_13opc_comp_3reg3opc == 17'd1843)) : 1'd0;
    assign s_ex_aluop2_signed_D0 = i_hw_comp_3reg_s_ex_aluop2_signed_D0;
    assign i_hw_comp_3reg_s_ex_mulh_D0 = i_hw_comp_3reg_ACT ? (((codasip_return_MI13opc_comp_3regIH4_2ex2ex5_3dec3dec16_13opc_comp_3reg3opc == 17'd1203) || (codasip_return_MI13opc_comp_3regIH4_2ex2ex5_3dec3dec16_13opc_comp_3reg3opc == 17'd1459)) || (codasip_return_MI13opc_comp_3regIH4_2ex2ex5_3dec3dec16_13opc_comp_3reg3opc == 17'd1331)) : 1'd0;
    assign s_ex_mulh_D0 = i_hw_comp_3reg_s_ex_mulh_D0;
    assign i_hw_comp_3reg_s_ex_reg_write_D0 = i_hw_comp_3reg_ACT ? 1'd1 : 1'd0;
    assign i_hw_comp_3reg_s_ex_aluop1_mux_D0 = i_hw_comp_3reg_ACT ? 2'd1 : 2'd0;
    assign i_hw_comp_3reg_s_ex_cmp_function_D0 = i_hw_comp_3reg_ACT ? 3'd1 : 3'd0;
    assign i_hw_comp_3reg_s_ex_mem_type_D0 = i_hw_comp_3reg_ACT ? 3'd1 : 3'd0;
    assign codasip_tmp_var_0_i_hw_comp_2reg_imm_dec_dec_ex_ex = codasip_return_MI17opc_comp_2reg_immIH4_2ex2ex5_3dec3dec20_17opc_comp_2reg_imm3opc;
    assign i_hw_comp_2reg_imm_s_ex_alu_function_D0 = (codasip_tmp_var_0_i_hw_comp_2reg_imm_dec_dec_ex_ex == 10'd275) ? 4'd5 :
        (codasip_tmp_var_0_i_hw_comp_2reg_imm_dec_dec_ex_ex == 10'd403) ? 4'd6 :
        (codasip_tmp_var_0_i_hw_comp_2reg_imm_dec_dec_ex_ex == 10'd915) ? 4'd9 :
        (codasip_tmp_var_0_i_hw_comp_2reg_imm_dec_dec_ex_ex == 10'd787) ? 4'd8 :
        (codasip_tmp_var_0_i_hw_comp_2reg_imm_dec_dec_ex_ex == 10'd531) ? 4'd4 : 4'd0;
    assign i_hw_comp_2reg_imm_s_ex_alu_function_D0_ACT = i_hw_comp_2reg_imm_ACT ? i_hw_comp_2reg_imm_s_ex_alu_function_D0 : 4'd0;
    assign i_hw_comp_2reg_imm_s_ex_sel_imm_D0 = i_hw_comp_2reg_imm_ACT ? 4'd4 : 4'd0;
    assign i_hw_comp_2reg_imm_s_ex_reg_write_D0 = i_hw_comp_2reg_imm_ACT ? 1'd1 : 1'd0;
    assign i_hw_comp_2reg_imm_s_ex_aluop1_mux_D0 = i_hw_comp_2reg_imm_ACT ? 2'd1 : 2'd0;
    assign i_hw_comp_2reg_imm_s_ex_aluop2_mux_D0 = i_hw_comp_2reg_imm_ACT ? 1'd1 : 1'd0;
    assign i_hw_comp_2reg_imm_s_ex_cmp_function_D0 = i_hw_comp_2reg_imm_ACT ? 3'd1 : 3'd0;
    assign i_hw_comp_2reg_imm_s_ex_mem_type_D0 = i_hw_comp_2reg_imm_ACT ? 3'd1 : 3'd0;
    assign i_hw_control_registers_s_ex_reg_write_D0 = i_hw_control_registers_ACT ? 1'd1 : 1'd0;
    assign i_hw_control_registers_s_ex_cmp_function_D0 = i_hw_control_registers_ACT ? 3'd1 : 3'd0;
    assign i_hw_control_registers_s_ex_mem_type_D0 = i_hw_control_registers_ACT ? 3'd1 : 3'd0;
    assign codasip_tmp_var_0_i_hw_control_registers_dec_dec_ex_ex = codasip_return_MI21opc_control_registersIH4_2ex2ex5_3dec3dec24_21opc_control_registers3opc;
    assign i_hw_control_registers_s_ex_csr_funct_D0 = (codasip_tmp_var_0_i_hw_control_registers_dec_dec_ex_ex == 10'd243) ? 3'd0 :
        (codasip_tmp_var_0_i_hw_control_registers_dec_dec_ex_ex == 10'd371) ? 3'd1 :
        (codasip_tmp_var_0_i_hw_control_registers_dec_dec_ex_ex == 10'd499) ? 3'd2 :
        (codasip_tmp_var_0_i_hw_control_registers_dec_dec_ex_ex == 10'd755) ? 3'd3 :
        (codasip_tmp_var_0_i_hw_control_registers_dec_dec_ex_ex == 10'd1011) ? 3'd5 : 3'd4;
    assign i_hw_control_registers_s_ex_csr_funct_D0_ACT = i_hw_control_registers_ACT ? i_hw_control_registers_s_ex_csr_funct_D0 : 3'd0;
    assign i_hw_control_registers_s_ex_csr_read_D0 = i_hw_control_registers_ACT ? 1'd1 : 1'd0;
    assign s_ex_csr_read_D0 = i_hw_control_registers_s_ex_csr_read_D0;
    assign i_hw_control_registers_s_ex_csr_write_D0 = i_hw_control_registers_ACT ? 1'd1 : 1'd0;
    assign s_ex_csr_write_D0 = i_hw_control_registers_s_ex_csr_write_D0;
    assign codasip_tmp_var_0_i_hw_comp_2reg_imm_shift_dec_dec_ex_ex = codasip_return_MI23opc_comp_2reg_imm_shiftIH4_2ex2ex5_3dec3dec26_23opc_comp_2reg_imm_shift3opc;
    assign i_hw_comp_2reg_imm_shift_s_ex_alu_function_D0 = (codasip_tmp_var_0_i_hw_comp_2reg_imm_shift_dec_dec_ex_ex == 17'd147) ? 4'd1 :
        (codasip_tmp_var_0_i_hw_comp_2reg_imm_shift_dec_dec_ex_ex == 17'd659) ? 4'd7 :
        (codasip_tmp_var_0_i_hw_comp_2reg_imm_shift_dec_dec_ex_ex == 17'd33427) ? 4'd14 : 4'd0;
    assign i_hw_comp_2reg_imm_shift_s_ex_alu_function_D0_ACT = i_hw_comp_2reg_imm_shift_ACT ? i_hw_comp_2reg_imm_shift_s_ex_alu_function_D0 : 4'd0;
    assign i_hw_comp_2reg_imm_shift_s_ex_sel_imm_D0 = i_hw_comp_2reg_imm_shift_ACT ? 4'd4 : 4'd0;
    assign i_hw_comp_2reg_imm_shift_s_ex_reg_write_D0 = i_hw_comp_2reg_imm_shift_ACT ? 1'd1 : 1'd0;
    assign i_hw_comp_2reg_imm_shift_s_ex_aluop1_mux_D0 = i_hw_comp_2reg_imm_shift_ACT ? 2'd1 : 2'd0;
    assign i_hw_comp_2reg_imm_shift_s_ex_aluop2_mux_D0 = i_hw_comp_2reg_imm_shift_ACT ? 1'd1 : 1'd0;
    assign i_hw_comp_2reg_imm_shift_s_ex_cmp_function_D0 = i_hw_comp_2reg_imm_shift_ACT ? 3'd1 : 3'd0;
    assign i_hw_comp_2reg_imm_shift_s_ex_mem_type_D0 = i_hw_comp_2reg_imm_shift_ACT ? 3'd1 : 3'd0;
    assign codasip_tmp_var_0_i_hw_control_conditional_dec_dec_ex_ex = codasip_return_MI23opc_control_conditionalIH4_2ex2ex5_3dec3dec26_23opc_control_conditional3opc;
    assign i_hw_control_conditional_s_ex_cmp_function_D0 = (codasip_tmp_var_0_i_hw_control_conditional_dec_dec_ex_ex == 10'd99) ? 3'd0 :
        (codasip_tmp_var_0_i_hw_control_conditional_dec_dec_ex_ex == 10'd611) ? 3'd2 :
        (codasip_tmp_var_0_i_hw_control_conditional_dec_dec_ex_ex == 10'd867) ? 3'd4 :
        (codasip_tmp_var_0_i_hw_control_conditional_dec_dec_ex_ex == 10'd739) ? 3'd3 :
        (codasip_tmp_var_0_i_hw_control_conditional_dec_dec_ex_ex == 10'd995) ? 3'd5 : 3'd1;
    assign i_hw_control_conditional_s_ex_cmp_function_D0_ACT = i_hw_control_conditional_ACT ? i_hw_control_conditional_s_ex_cmp_function_D0 : 3'd0;
    assign i_hw_control_conditional_s_ex_sel_imm_D0 = i_hw_control_conditional_ACT ? 4'd1 : 4'd0;
    assign i_hw_control_conditional_s_ex_aluop1_mux_D0 = i_hw_control_conditional_ACT ? 2'd2 : 2'd0;
    assign i_hw_control_conditional_s_ex_aluop2_mux_D0 = i_hw_control_conditional_ACT ? 1'd1 : 1'd0;
    assign i_hw_control_conditional_s_ex_mem_type_D0 = i_hw_control_conditional_ACT ? 3'd1 : 3'd0;
    assign i_hw_control_conditional_s_ex_branch_D0 = i_hw_control_conditional_ACT ? 1'd1 : 1'd0;
    assign s_ex_branch_D0 = i_hw_control_conditional_s_ex_branch_D0;
    assign opc_or_codasip_return_MI13opc_comp_3regIH4_2ex2ex5_3dec3dec16_13opc_comp_3reg3opc_D0 = opc_or_ACT ? 17'd819 : 17'd0;
    assign opc_add_codasip_return_MI13opc_comp_3regIH4_2ex2ex5_3dec3dec16_13opc_comp_3reg3opc_D0 = opc_add_ACT ? 17'd51 : 17'd0;
    assign opc_and_codasip_return_MI13opc_comp_3regIH4_2ex2ex5_3dec3dec16_13opc_comp_3reg3opc_D0 = opc_and_ACT ? 17'd947 : 17'd0;
    assign opc_beq_codasip_return_MI23opc_control_conditionalIH4_2ex2ex5_3dec3dec26_23opc_control_conditional3opc_D0 = opc_beq_ACT ? 10'd99 : 10'd0;
    assign codasip_return_MI23opc_control_conditionalIH4_2ex2ex5_3dec3dec26_23opc_control_conditional3opc = (((((opc_beq_codasip_return_MI23opc_control_conditionalIH4_2ex2ex5_3dec3dec26_23opc_control_conditional3opc_D0 | opc_bge_codasip_return_MI23opc_control_conditionalIH4_2ex2ex5_3dec3dec26_23opc_control_conditional3opc_D0) | opc_blt_codasip_return_MI23opc_control_conditionalIH4_2ex2ex5_3dec3dec26_23opc_control_conditional3opc_D0) | opc_bne_codasip_return_MI23opc_control_conditionalIH4_2ex2ex5_3dec3dec26_23opc_control_conditional3opc_D0) | opc_bgeu_codasip_return_MI23opc_control_conditionalIH4_2ex2ex5_3dec3dec26_23opc_control_conditional3opc_D0) | opc_bltu_codasip_return_MI23opc_control_conditionalIH4_2ex2ex5_3dec3dec26_23opc_control_conditional3opc_D0);
    assign opc_bge_codasip_return_MI23opc_control_conditionalIH4_2ex2ex5_3dec3dec26_23opc_control_conditional3opc_D0 = opc_bge_ACT ? 10'd739 : 10'd0;
    assign opc_blt_codasip_return_MI23opc_control_conditionalIH4_2ex2ex5_3dec3dec26_23opc_control_conditional3opc_D0 = opc_blt_ACT ? 10'd611 : 10'd0;
    assign opc_bne_codasip_return_MI23opc_control_conditionalIH4_2ex2ex5_3dec3dec26_23opc_control_conditional3opc_D0 = opc_bne_ACT ? 10'd227 : 10'd0;
    assign opc_div_codasip_return_MI13opc_comp_3regIH4_2ex2ex5_3dec3dec16_13opc_comp_3reg3opc_D0 = opc_div_ACT ? 17'd1587 : 17'd0;
    assign opc_mul_codasip_return_MI13opc_comp_3regIH4_2ex2ex5_3dec3dec16_13opc_comp_3reg3opc_D0 = opc_mul_ACT ? 17'd1075 : 17'd0;
    assign opc_ori_codasip_return_MI17opc_comp_2reg_immIH4_2ex2ex5_3dec3dec20_17opc_comp_2reg_imm3opc_D0 = opc_ori_ACT ? 10'd787 : 10'd0;
    assign codasip_return_MI17opc_comp_2reg_immIH4_2ex2ex5_3dec3dec20_17opc_comp_2reg_imm3opc = (((((opc_ori_codasip_return_MI17opc_comp_2reg_immIH4_2ex2ex5_3dec3dec20_17opc_comp_2reg_imm3opc_D0 | opc_addi_codasip_return_MI17opc_comp_2reg_immIH4_2ex2ex5_3dec3dec20_17opc_comp_2reg_imm3opc_D0) | opc_andi_codasip_return_MI17opc_comp_2reg_immIH4_2ex2ex5_3dec3dec20_17opc_comp_2reg_imm3opc_D0) | opc_slti_codasip_return_MI17opc_comp_2reg_immIH4_2ex2ex5_3dec3dec20_17opc_comp_2reg_imm3opc_D0) | opc_xori_codasip_return_MI17opc_comp_2reg_immIH4_2ex2ex5_3dec3dec20_17opc_comp_2reg_imm3opc_D0) | opc_sltiu_codasip_return_MI17opc_comp_2reg_immIH4_2ex2ex5_3dec3dec20_17opc_comp_2reg_imm3opc_D0);
    assign opc_rem_codasip_return_MI13opc_comp_3regIH4_2ex2ex5_3dec3dec16_13opc_comp_3reg3opc_D0 = opc_rem_ACT ? 17'd1843 : 17'd0;
    assign opc_sll_codasip_return_MI13opc_comp_3regIH4_2ex2ex5_3dec3dec16_13opc_comp_3reg3opc_D0 = opc_sll_ACT ? 17'd179 : 17'd0;
    assign opc_slt_codasip_return_MI13opc_comp_3regIH4_2ex2ex5_3dec3dec16_13opc_comp_3reg3opc_D0 = opc_slt_ACT ? 17'd307 : 17'd0;
    assign opc_sra_codasip_return_MI13opc_comp_3regIH4_2ex2ex5_3dec3dec16_13opc_comp_3reg3opc_D0 = opc_sra_ACT ? 17'd33459 : 17'd0;
    assign opc_srl_codasip_return_MI13opc_comp_3regIH4_2ex2ex5_3dec3dec16_13opc_comp_3reg3opc_D0 = opc_srl_ACT ? 17'd691 : 17'd0;
    assign opc_sub_codasip_return_MI13opc_comp_3regIH4_2ex2ex5_3dec3dec16_13opc_comp_3reg3opc_D0 = opc_sub_ACT ? 17'd32819 : 17'd0;
    assign opc_xor_codasip_return_MI13opc_comp_3regIH4_2ex2ex5_3dec3dec16_13opc_comp_3reg3opc_D0 = opc_xor_ACT ? 17'd563 : 17'd0;
    assign i_hw_jal_s_ex_sel_imm_D0 = i_hw_jal_ACT ? 4'd3 : 4'd0;
    assign i_hw_jal_s_ex_reg_write_D0 = i_hw_jal_ACT ? 1'd1 : 1'd0;
    assign i_hw_jal_s_ex_aluop1_mux_D0 = i_hw_jal_ACT ? 2'd2 : 2'd0;
    assign i_hw_jal_s_ex_aluop2_mux_D0 = i_hw_jal_ACT ? 1'd1 : 1'd0;
    assign i_hw_jal_s_ex_cmp_function_D0 = i_hw_jal_ACT ? 3'd1 : 3'd0;
    assign i_hw_jal_s_ex_mem_type_D0 = i_hw_jal_ACT ? 3'd1 : 3'd0;
    assign i_hw_jal_s_ex_jal_D0 = i_hw_jal_ACT ? 1'd1 : 1'd0;
    assign s_ex_jal_D0 = i_hw_jal_s_ex_jal_D0;
    assign i_hw_lui_s_ex_sel_imm_D0 = i_hw_lui_ACT ? 4'd2 : 4'd0;
    assign i_hw_lui_s_ex_reg_write_D0 = i_hw_lui_ACT ? 1'd1 : 1'd0;
    assign i_hw_lui_s_ex_aluop2_mux_D0 = i_hw_lui_ACT ? 1'd1 : 1'd0;
    assign i_hw_lui_s_ex_cmp_function_D0 = i_hw_lui_ACT ? 3'd1 : 3'd0;
    assign i_hw_lui_s_ex_mem_type_D0 = i_hw_lui_ACT ? 3'd1 : 3'd0;
    assign i_hw_wfi_s_ex_alu_function_D0 = i_hw_wfi_ACT ? 4'd3 : 4'd0;
    assign i_hw_wfi_s_ex_cmp_function_D0 = i_hw_wfi_ACT ? 3'd1 : 3'd0;
    assign i_hw_wfi_s_ex_mem_type_D0 = i_hw_wfi_ACT ? 3'd1 : 3'd0;
    assign opc_addi_codasip_return_MI17opc_comp_2reg_immIH4_2ex2ex5_3dec3dec20_17opc_comp_2reg_imm3opc_D0 = opc_addi_ACT ? 10'd19 : 10'd0;
    assign opc_andi_codasip_return_MI17opc_comp_2reg_immIH4_2ex2ex5_3dec3dec20_17opc_comp_2reg_imm3opc_D0 = opc_andi_ACT ? 10'd915 : 10'd0;
    assign opc_bgeu_codasip_return_MI23opc_control_conditionalIH4_2ex2ex5_3dec3dec26_23opc_control_conditional3opc_D0 = opc_bgeu_ACT ? 10'd995 : 10'd0;
    assign opc_bltu_codasip_return_MI23opc_control_conditionalIH4_2ex2ex5_3dec3dec26_23opc_control_conditional3opc_D0 = opc_bltu_ACT ? 10'd867 : 10'd0;
    assign opc_divu_codasip_return_MI13opc_comp_3regIH4_2ex2ex5_3dec3dec16_13opc_comp_3reg3opc_D0 = opc_divu_ACT ? 17'd1715 : 17'd0;
    assign opc_mulh_codasip_return_MI13opc_comp_3regIH4_2ex2ex5_3dec3dec16_13opc_comp_3reg3opc_D0 = opc_mulh_ACT ? 17'd1203 : 17'd0;
    assign opc_remu_codasip_return_MI13opc_comp_3regIH4_2ex2ex5_3dec3dec16_13opc_comp_3reg3opc_D0 = opc_remu_ACT ? 17'd1971 : 17'd0;
    assign opc_slli_codasip_return_MI23opc_comp_2reg_imm_shiftIH4_2ex2ex5_3dec3dec26_23opc_comp_2reg_imm_shift3opc_D0 = opc_slli_ACT ? 17'd147 : 17'd0;
    assign codasip_return_MI23opc_comp_2reg_imm_shiftIH4_2ex2ex5_3dec3dec26_23opc_comp_2reg_imm_shift3opc = ((opc_slli_codasip_return_MI23opc_comp_2reg_imm_shiftIH4_2ex2ex5_3dec3dec26_23opc_comp_2reg_imm_shift3opc_D0 | opc_srai_codasip_return_MI23opc_comp_2reg_imm_shiftIH4_2ex2ex5_3dec3dec26_23opc_comp_2reg_imm_shift3opc_D0) | opc_srli_codasip_return_MI23opc_comp_2reg_imm_shiftIH4_2ex2ex5_3dec3dec26_23opc_comp_2reg_imm_shift3opc_D0);
    assign opc_slti_codasip_return_MI17opc_comp_2reg_immIH4_2ex2ex5_3dec3dec20_17opc_comp_2reg_imm3opc_D0 = opc_slti_ACT ? 10'd275 : 10'd0;
    assign opc_sltu_codasip_return_MI13opc_comp_3regIH4_2ex2ex5_3dec3dec16_13opc_comp_3reg3opc_D0 = opc_sltu_ACT ? 17'd435 : 17'd0;
    assign opc_srai_codasip_return_MI23opc_comp_2reg_imm_shiftIH4_2ex2ex5_3dec3dec26_23opc_comp_2reg_imm_shift3opc_D0 = opc_srai_ACT ? 17'd33427 : 17'd0;
    assign opc_srli_codasip_return_MI23opc_comp_2reg_imm_shiftIH4_2ex2ex5_3dec3dec26_23opc_comp_2reg_imm_shift3opc_D0 = opc_srli_ACT ? 17'd659 : 17'd0;
    assign opc_xori_codasip_return_MI17opc_comp_2reg_immIH4_2ex2ex5_3dec3dec20_17opc_comp_2reg_imm3opc_D0 = opc_xori_ACT ? 10'd531 : 10'd0;
    assign i_hw_jalr_s_ex_sel_imm_D0 = i_hw_jalr_ACT ? 4'd4 : 4'd0;
    assign i_hw_jalr_s_ex_reg_write_D0 = i_hw_jalr_ACT ? 1'd1 : 1'd0;
    assign i_hw_jalr_s_ex_aluop1_mux_D0 = i_hw_jalr_ACT ? 2'd1 : 2'd0;
    assign i_hw_jalr_s_ex_aluop2_mux_D0 = i_hw_jalr_ACT ? 1'd1 : 1'd0;
    assign i_hw_jalr_s_ex_cmp_function_D0 = i_hw_jalr_ACT ? 3'd1 : 3'd0;
    assign i_hw_jalr_s_ex_mem_type_D0 = i_hw_jalr_ACT ? 3'd1 : 3'd0;
    assign i_hw_jalr_s_ex_jalr_D0 = i_hw_jalr_ACT ? 1'd1 : 1'd0;
    assign s_ex_jalr_D0 = i_hw_jalr_s_ex_jalr_D0;
    assign codasip_tmp_var_0_i_hw_load_dec_dec_ex_ex = codasip_return_MI9opc_loadsIH4_2ex2ex5_3dec3dec11_9opc_loads3opc;
    assign i_hw_load_s_ex_mem_type_D0 = (codasip_tmp_var_0_i_hw_load_dec_dec_ex_ex == 10'd131) ? 3'd2 :
        (codasip_tmp_var_0_i_hw_load_dec_dec_ex_ex == 10'd259) ? 3'd4 :
        (codasip_tmp_var_0_i_hw_load_dec_dec_ex_ex == 10'd515) ? 3'd5 :
        (codasip_tmp_var_0_i_hw_load_dec_dec_ex_ex == 10'd643) ? 3'd6 : 3'd1;
    assign i_hw_load_s_ex_mem_type_D0_ACT = i_hw_load_ACT ? i_hw_load_s_ex_mem_type_D0 : 3'd0;
    assign i_hw_load_s_ex_sel_imm_D0 = i_hw_load_ACT ? 4'd4 : 4'd0;
    assign i_hw_load_s_ex_reg_write_D0 = i_hw_load_ACT ? 1'd1 : 1'd0;
    assign i_hw_load_s_ex_aluop1_mux_D0 = i_hw_load_ACT ? 2'd1 : 2'd0;
    assign i_hw_load_s_ex_aluop2_mux_D0 = i_hw_load_ACT ? 1'd1 : 1'd0;
    assign i_hw_load_s_ex_cmp_function_D0 = i_hw_load_ACT ? 3'd1 : 3'd0;
    assign i_hw_load_s_ex_memop_D0 = i_hw_load_ACT ? 1'd1 : 1'd0;
    assign i_hw_load_s_ex_mem_cmd_D0 = i_hw_load_ACT ? 3'd1 : 3'd0;
    assign i_hw_xret_s_ex_cmp_function_D0 = i_hw_xret_ACT ? 3'd1 : 3'd0;
    assign i_hw_xret_s_ex_mem_type_D0 = i_hw_xret_ACT ? 3'd1 : 3'd0;
    assign i_hw_xret_s_ex_csr_funct_D0 = i_hw_xret_ACT ? 3'd7 : 3'd0;
    assign opc_csrrc_codasip_return_MI21opc_control_registersIH4_2ex2ex5_3dec3dec24_21opc_control_registers3opc_D0 = opc_csrrc_ACT ? 10'd499 : 10'd0;
    assign opc_csrrs_codasip_return_MI21opc_control_registersIH4_2ex2ex5_3dec3dec24_21opc_control_registers3opc_D0 = opc_csrrs_ACT ? 10'd371 : 10'd0;
    assign opc_csrrw_codasip_return_MI21opc_control_registersIH4_2ex2ex5_3dec3dec24_21opc_control_registers3opc_D0 = opc_csrrw_ACT ? 10'd243 : 10'd0;
    assign opc_loadb_codasip_return_MI9opc_loadsIH4_2ex2ex5_3dec3dec11_9opc_loads3opc_D0 = opc_loadb_ACT ? 10'd3 : 10'd0;
    assign opc_loadh_codasip_return_MI9opc_loadsIH4_2ex2ex5_3dec3dec11_9opc_loads3opc_D0 = opc_loadh_ACT ? 10'd131 : 10'd0;
    assign opc_loadw_codasip_return_MI9opc_loadsIH4_2ex2ex5_3dec3dec11_9opc_loads3opc_D0 = opc_loadw_ACT ? 10'd259 : 10'd0;
    assign opc_mulhu_codasip_return_MI13opc_comp_3regIH4_2ex2ex5_3dec3dec16_13opc_comp_3reg3opc_D0 = opc_mulhu_ACT ? 17'd1459 : 17'd0;
    assign opc_sltiu_codasip_return_MI17opc_comp_2reg_immIH4_2ex2ex5_3dec3dec20_17opc_comp_2reg_imm3opc_D0 = opc_sltiu_ACT ? 10'd403 : 10'd0;
endmodule
