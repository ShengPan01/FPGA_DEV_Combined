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
 *  \brief   Contains module definition of the 'codix_berkelium_ca_core_decompressor_16b32b_t' instruction decoder.
 */

module codix_berkelium_ca_core_decompressor_16b32b_t(
    input  wire ACT,
    input  wire [15:0] codasip_param_0,
    input  wire [10:0] s_fe_16b_instr_Q0,
    output wire codasip_param_1,
    output wire s_fe_16b_instr_inval_imm_D0,
    output wire s_fe_16b_instr_inval_reg_D0,
    output wire [2:0] s_fe_func3_imm_D0,
    output wire [6:0] s_fe_func7_imm_D0,
    output wire [6:0] s_fe_opcode_D0,
    output wire [4:0] s_fe_rd_imm_D0,
    output wire [4:0] s_fe_rs1_imm_D0,
    output wire [4:0] s_fe_rs2_imm_D0
);
    // type, wire and constant declarations:
    // signal/wire (inner)
    wire [4:0] codasip_return_MI12opc_lsw_compIH4_2fe2fe22_19decompressor_16b32b19decompressor_16b32b15_12opc_lsw_comp3opc;
    // signal/wire (inner)
    wire [4:0] codasip_return_MI12opc_jmp_compIH4_2fe2fe22_19decompressor_16b32b19decompressor_16b32b15_12opc_jmp_comp3opc;
    // signal/wire (inner)
    wire [5:0] codasip_return_MI13opc_jmpr_compIH4_2fe2fe22_19decompressor_16b32b19decompressor_16b32b16_13opc_jmpr_comp3opc;
    // signal/wire (inner)
    wire [4:0] codasip_return_MI11opc_br_compIH4_2fe2fe22_19decompressor_16b32b19decompressor_16b32b14_11opc_br_comp3opc;
    // signal/wire (inner)
    wire [6:0] codasip_return_MI12opc_sri_compIH4_2fe2fe22_19decompressor_16b32b19decompressor_16b32b15_12opc_sri_comp3opc;
    // signal/wire (inner)
    wire [9:0] codasip_return_MI16opc_compreg_compIH4_2fe2fe22_19decompressor_16b32b19decompressor_16b32b19_16opc_compreg_comp3opc;
    // signal/wire (inner)
    wire invalid_instruction_wire;
    // signal/wire (inner)
    wire cs_0_wire;
    // signal/wire (inner)
    wire cs_1_wire;
    // signal/wire (inner)
    wire cs_2_wire;
    // signal/wire (inner)
    wire cs_3_wire;
    // signal/wire (inner)
    wire cs_4_wire;
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
    wire cs_30_wire;
    // signal/wire (inner)
    wire vs_0_wire;
    // signal/wire (inner)
    wire opc_j_comp_ACT;
    // signal/wire (inner)
    wire opc_jr_comp_ACT;
    // signal/wire (inner)
    wire opc_or_comp_ACT;
    // signal/wire (inner)
    wire i_hw_br_comp_ACT;
    // signal/wire (inner)
    wire i_hw_li_comp_ACT;
    // signal/wire (inner)
    wire i_hw_loadwsp_ACT;
    // signal/wire (inner)
    wire opc_and_comp_ACT;
    // signal/wire (inner)
    wire opc_jal_comp_ACT;
    // signal/wire (inner)
    wire opc_loadwreg_ACT;
    // signal/wire (inner)
    wire opc_sub_comp_ACT;
    // signal/wire (inner)
    wire opc_xor_comp_ACT;
    // signal/wire (inner)
    wire i_hw_jal_comp_ACT;
    // signal/wire (inner)
    wire i_hw_lsw_comp_ACT;
    // signal/wire (inner)
    wire i_hw_sri_comp_ACT;
    // signal/wire (inner)
    wire i_hw_storewsp_ACT;
    // signal/wire (inner)
    wire opc_beqz_comp_ACT;
    // signal/wire (inner)
    wire opc_bnez_comp_ACT;
    // signal/wire (inner)
    wire opc_jalr_comp_ACT;
    // signal/wire (inner)
    wire opc_srai_comp_ACT;
    // signal/wire (inner)
    wire opc_srli_comp_ACT;
    // signal/wire (inner)
    wire opc_storewreg_ACT;
    // signal/wire (inner)
    wire i_hw_addi_comp_ACT;
    // signal/wire (inner)
    wire i_hw_andi_comp_ACT;
    // signal/wire (inner)
    wire i_hw_slli_comp_ACT;
    // signal/wire (inner)
    wire i_hw_addispn_comp_ACT;
    // signal/wire (inner)
    wire i_hw_compreg_comp_ACT;
    // signal/wire (inner)
    wire i_hw_lui_addisp_comp_ACT;
    // signal/wire (inner)
    wire i_hw_jalr_mvadd_ebreak_comp_ACT;
    // signal/wire (inner)
    wire [4:0] opc_j_comp_codasip_return_MI12opc_jmp_compIH4_2fe2fe22_19decompressor_16b32b19decompressor_16b32b15_12opc_jmp_comp3opc_D0;
    // signal/wire (inner)
    wire [5:0] opc_jr_comp_codasip_return_MI13opc_jmpr_compIH4_2fe2fe22_19decompressor_16b32b19decompressor_16b32b16_13opc_jmpr_comp3opc_D0;
    // signal/wire (inner)
    wire [9:0] opc_or_comp_codasip_return_MI16opc_compreg_compIH4_2fe2fe22_19decompressor_16b32b19decompressor_16b32b19_16opc_compreg_comp3opc_D0;
    // signal/wire (inner)
    wire [4:0] codasip_tmp_var_0_i_hw_br_comp_decompressor_16b32b_decompressor_16b32b_fe_fe;
    // signal/wire (inner)
    wire [6:0] i_hw_br_comp_s_fe_opcode_D0;
    // signal/wire (inner)
    wire [6:0] i_hw_br_comp_s_fe_opcode_D0_ACT;
    // signal/wire (inner)
    wire [2:0] i_hw_br_comp_s_fe_func3_imm_D0;
    // signal/wire (inner)
    wire [2:0] i_hw_br_comp_s_fe_func3_imm_D0_ACT;
    // signal/wire (inner)
    wire [4:0] i_hw_br_comp_s_fe_rd_imm_D0;
    // signal/wire (inner)
    wire [4:0] i_hw_br_comp_s_fe_rs1_imm_D0;
    // signal/wire (inner)
    wire [4:0] i_hw_br_comp_s_fe_rs2_imm_D0;
    // signal/wire (inner)
    wire [6:0] i_hw_br_comp_s_fe_func7_imm_D0;
    // signal/wire (inner)
    wire [6:0] i_hw_li_comp_s_fe_opcode_D0;
    // signal/wire (inner)
    wire [4:0] i_hw_li_comp_s_fe_rd_imm_D0;
    // signal/wire (inner)
    wire [2:0] i_hw_li_comp_s_fe_func3_imm_D0;
    // signal/wire (inner)
    wire [4:0] i_hw_li_comp_s_fe_rs1_imm_D0;
    // signal/wire (inner)
    wire [4:0] i_hw_li_comp_s_fe_rs2_imm_D0;
    // signal/wire (inner)
    wire [6:0] i_hw_li_comp_s_fe_func7_imm_D0;
    // signal/wire (inner)
    wire i_hw_li_comp_s_fe_16b_instr_inval_reg_D0;
    // signal/wire (inner)
    wire [6:0] i_hw_loadwsp_s_fe_opcode_D0;
    // signal/wire (inner)
    wire [4:0] i_hw_loadwsp_s_fe_rd_imm_D0;
    // signal/wire (inner)
    wire [2:0] i_hw_loadwsp_s_fe_func3_imm_D0;
    // signal/wire (inner)
    wire [4:0] i_hw_loadwsp_s_fe_rs1_imm_D0;
    // signal/wire (inner)
    wire [4:0] i_hw_loadwsp_s_fe_rs2_imm_D0;
    // signal/wire (inner)
    wire [6:0] i_hw_loadwsp_s_fe_func7_imm_D0;
    // signal/wire (inner)
    wire i_hw_loadwsp_s_fe_16b_instr_inval_reg_D0;
    // signal/wire (inner)
    wire [9:0] opc_and_comp_codasip_return_MI16opc_compreg_compIH4_2fe2fe22_19decompressor_16b32b19decompressor_16b32b19_16opc_compreg_comp3opc_D0;
    // signal/wire (inner)
    wire [4:0] opc_jal_comp_codasip_return_MI12opc_jmp_compIH4_2fe2fe22_19decompressor_16b32b19decompressor_16b32b15_12opc_jmp_comp3opc_D0;
    // signal/wire (inner)
    wire [4:0] opc_loadwreg_codasip_return_MI12opc_lsw_compIH4_2fe2fe22_19decompressor_16b32b19decompressor_16b32b15_12opc_lsw_comp3opc_D0;
    // signal/wire (inner)
    wire [9:0] opc_sub_comp_codasip_return_MI16opc_compreg_compIH4_2fe2fe22_19decompressor_16b32b19decompressor_16b32b19_16opc_compreg_comp3opc_D0;
    // signal/wire (inner)
    wire [9:0] opc_xor_comp_codasip_return_MI16opc_compreg_compIH4_2fe2fe22_19decompressor_16b32b19decompressor_16b32b19_16opc_compreg_comp3opc_D0;
    // signal/wire (inner)
    wire [4:0] codasip_tmp_var_0_i_hw_jal_comp_decompressor_16b32b_decompressor_16b32b_fe_fe;
    // signal/wire (inner)
    wire [6:0] i_hw_jal_comp_s_fe_opcode_D0;
    // signal/wire (inner)
    wire [4:0] i_hw_jal_comp_s_fe_rd_imm_D0;
    // signal/wire (inner)
    wire [4:0] i_hw_jal_comp_s_fe_rd_imm_D0_ACT;
    // signal/wire (inner)
    wire [2:0] i_hw_jal_comp_s_fe_func3_imm_D0;
    // signal/wire (inner)
    wire [4:0] i_hw_jal_comp_s_fe_rs1_imm_D0;
    // signal/wire (inner)
    wire [4:0] i_hw_jal_comp_s_fe_rs2_imm_D0;
    // signal/wire (inner)
    wire [6:0] i_hw_jal_comp_s_fe_func7_imm_D0;
    // signal/wire (inner)
    wire [4:0] codasip_tmp_var_0_i_hw_lsw_comp_decompressor_16b32b_decompressor_16b32b_fe_fe;
    // signal/wire (inner)
    wire [6:0] i_hw_lsw_comp_s_fe_opcode_D0;
    // signal/wire (inner)
    wire [6:0] i_hw_lsw_comp_s_fe_opcode_D0_ACT;
    // signal/wire (inner)
    wire [4:0] i_hw_lsw_comp_s_fe_rd_imm_D0;
    // signal/wire (inner)
    wire [4:0] i_hw_lsw_comp_s_fe_rd_imm_D0_ACT;
    // signal/wire (inner)
    wire [2:0] i_hw_lsw_comp_s_fe_func3_imm_D0;
    // signal/wire (inner)
    wire [2:0] i_hw_lsw_comp_s_fe_func3_imm_D0_ACT;
    // signal/wire (inner)
    wire [4:0] i_hw_lsw_comp_s_fe_rs2_imm_D0;
    // signal/wire (inner)
    wire [4:0] i_hw_lsw_comp_s_fe_rs2_imm_D0_ACT;
    // signal/wire (inner)
    wire [4:0] i_hw_lsw_comp_s_fe_rs1_imm_D0;
    // signal/wire (inner)
    wire [6:0] i_hw_lsw_comp_s_fe_func7_imm_D0;
    // signal/wire (inner)
    wire [6:0] codasip_tmp_var_0_i_hw_sri_comp_decompressor_16b32b_decompressor_16b32b_fe_fe;
    // signal/wire (inner)
    wire [6:0] i_hw_sri_comp_s_fe_opcode_D0;
    // signal/wire (inner)
    wire [6:0] i_hw_sri_comp_s_fe_opcode_D0_ACT;
    // signal/wire (inner)
    wire [2:0] i_hw_sri_comp_s_fe_func3_imm_D0;
    // signal/wire (inner)
    wire [2:0] i_hw_sri_comp_s_fe_func3_imm_D0_ACT;
    // signal/wire (inner)
    wire [6:0] i_hw_sri_comp_s_fe_func7_imm_D0;
    // signal/wire (inner)
    wire [6:0] i_hw_sri_comp_s_fe_func7_imm_D0_ACT;
    // signal/wire (inner)
    wire [4:0] i_hw_sri_comp_s_fe_rd_imm_D0;
    // signal/wire (inner)
    wire [4:0] i_hw_sri_comp_s_fe_rs1_imm_D0;
    // signal/wire (inner)
    wire [4:0] i_hw_sri_comp_s_fe_rs2_imm_D0;
    // signal/wire (inner)
    wire i_hw_sri_comp_s_fe_16b_instr_inval_imm_D0;
    // signal/wire (inner)
    wire [6:0] i_hw_storewsp_s_fe_opcode_D0;
    // signal/wire (inner)
    wire [4:0] i_hw_storewsp_s_fe_rd_imm_D0;
    // signal/wire (inner)
    wire [2:0] i_hw_storewsp_s_fe_func3_imm_D0;
    // signal/wire (inner)
    wire [4:0] i_hw_storewsp_s_fe_rs1_imm_D0;
    // signal/wire (inner)
    wire [4:0] i_hw_storewsp_s_fe_rs2_imm_D0;
    // signal/wire (inner)
    wire [6:0] i_hw_storewsp_s_fe_func7_imm_D0;
    // signal/wire (inner)
    wire [4:0] opc_beqz_comp_codasip_return_MI11opc_br_compIH4_2fe2fe22_19decompressor_16b32b19decompressor_16b32b14_11opc_br_comp3opc_D0;
    // signal/wire (inner)
    wire [4:0] opc_bnez_comp_codasip_return_MI11opc_br_compIH4_2fe2fe22_19decompressor_16b32b19decompressor_16b32b14_11opc_br_comp3opc_D0;
    // signal/wire (inner)
    wire [5:0] opc_jalr_comp_codasip_return_MI13opc_jmpr_compIH4_2fe2fe22_19decompressor_16b32b19decompressor_16b32b16_13opc_jmpr_comp3opc_D0;
    // signal/wire (inner)
    wire [6:0] opc_srai_comp_codasip_return_MI12opc_sri_compIH4_2fe2fe22_19decompressor_16b32b19decompressor_16b32b15_12opc_sri_comp3opc_D0;
    // signal/wire (inner)
    wire [6:0] opc_srli_comp_codasip_return_MI12opc_sri_compIH4_2fe2fe22_19decompressor_16b32b19decompressor_16b32b15_12opc_sri_comp3opc_D0;
    // signal/wire (inner)
    wire [4:0] opc_storewreg_codasip_return_MI12opc_lsw_compIH4_2fe2fe22_19decompressor_16b32b19decompressor_16b32b15_12opc_lsw_comp3opc_D0;
    // signal/wire (inner)
    wire [6:0] i_hw_addi_comp_s_fe_opcode_D0;
    // signal/wire (inner)
    wire [4:0] i_hw_addi_comp_s_fe_rd_imm_D0;
    // signal/wire (inner)
    wire [2:0] i_hw_addi_comp_s_fe_func3_imm_D0;
    // signal/wire (inner)
    wire [4:0] i_hw_addi_comp_s_fe_rs1_imm_D0;
    // signal/wire (inner)
    wire [4:0] i_hw_addi_comp_s_fe_rs2_imm_D0;
    // signal/wire (inner)
    wire [6:0] i_hw_addi_comp_s_fe_func7_imm_D0;
    // signal/wire (inner)
    wire i_hw_addi_comp_s_fe_16b_instr_inval_imm_D0;
    // signal/wire (inner)
    wire i_hw_addi_comp_s_fe_16b_instr_inval_reg_D0;
    // signal/wire (inner)
    wire [6:0] i_hw_andi_comp_s_fe_opcode_D0;
    // signal/wire (inner)
    wire [4:0] i_hw_andi_comp_s_fe_rd_imm_D0;
    // signal/wire (inner)
    wire [2:0] i_hw_andi_comp_s_fe_func3_imm_D0;
    // signal/wire (inner)
    wire [4:0] i_hw_andi_comp_s_fe_rs1_imm_D0;
    // signal/wire (inner)
    wire [4:0] i_hw_andi_comp_s_fe_rs2_imm_D0;
    // signal/wire (inner)
    wire [6:0] i_hw_andi_comp_s_fe_func7_imm_D0;
    // signal/wire (inner)
    wire [6:0] i_hw_slli_comp_s_fe_opcode_D0;
    // signal/wire (inner)
    wire [4:0] i_hw_slli_comp_s_fe_rd_imm_D0;
    // signal/wire (inner)
    wire [2:0] i_hw_slli_comp_s_fe_func3_imm_D0;
    // signal/wire (inner)
    wire [4:0] i_hw_slli_comp_s_fe_rs1_imm_D0;
    // signal/wire (inner)
    wire [4:0] i_hw_slli_comp_s_fe_rs2_imm_D0;
    // signal/wire (inner)
    wire [6:0] i_hw_slli_comp_s_fe_func7_imm_D0;
    // signal/wire (inner)
    wire i_hw_slli_comp_s_fe_16b_instr_inval_imm_D0;
    // signal/wire (inner)
    wire i_hw_slli_comp_s_fe_16b_instr_inval_reg_D0;
    // signal/wire (inner)
    wire [6:0] i_hw_addispn_comp_s_fe_opcode_D0;
    // signal/wire (inner)
    wire [4:0] i_hw_addispn_comp_s_fe_rd_imm_D0;
    // signal/wire (inner)
    wire [2:0] i_hw_addispn_comp_s_fe_func3_imm_D0;
    // signal/wire (inner)
    wire [4:0] i_hw_addispn_comp_s_fe_rs1_imm_D0;
    // signal/wire (inner)
    wire [4:0] i_hw_addispn_comp_s_fe_rs2_imm_D0;
    // signal/wire (inner)
    wire [6:0] i_hw_addispn_comp_s_fe_func7_imm_D0;
    // signal/wire (inner)
    wire i_hw_addispn_comp_s_fe_16b_instr_inval_imm_D0;
    // signal/wire (inner)
    wire [9:0] codasip_tmp_var_0_i_hw_compreg_comp_decompressor_16b32b_decompressor_16b32b_fe_fe;
    // signal/wire (inner)
    wire [6:0] i_hw_compreg_comp_s_fe_opcode_D0;
    // signal/wire (inner)
    wire [6:0] i_hw_compreg_comp_s_fe_opcode_D0_ACT;
    // signal/wire (inner)
    wire [2:0] i_hw_compreg_comp_s_fe_func3_imm_D0;
    // signal/wire (inner)
    wire [2:0] i_hw_compreg_comp_s_fe_func3_imm_D0_ACT;
    // signal/wire (inner)
    wire [6:0] i_hw_compreg_comp_s_fe_func7_imm_D0;
    // signal/wire (inner)
    wire [6:0] i_hw_compreg_comp_s_fe_func7_imm_D0_ACT;
    // signal/wire (inner)
    wire [4:0] i_hw_compreg_comp_s_fe_rd_imm_D0;
    // signal/wire (inner)
    wire [4:0] i_hw_compreg_comp_s_fe_rs1_imm_D0;
    // signal/wire (inner)
    wire [4:0] i_hw_compreg_comp_s_fe_rs2_imm_D0;
    // signal/wire (inner)
    wire codasip_tmp_var_0_i_hw_lui_addisp_comp_decompressor_16b32b_decompressor_16b32b_fe_fe;
    // signal/wire (inner)
    wire [6:0] i_hw_lui_addisp_comp_s_fe_opcode_D0;
    // signal/wire (inner)
    wire [6:0] i_hw_lui_addisp_comp_s_fe_opcode_D0_ACT;
    // signal/wire (inner)
    wire [2:0] i_hw_lui_addisp_comp_s_fe_func3_imm_D0;
    // signal/wire (inner)
    wire [2:0] i_hw_lui_addisp_comp_s_fe_func3_imm_D0_ACT;
    // signal/wire (inner)
    wire [4:0] i_hw_lui_addisp_comp_s_fe_rs1_imm_D0;
    // signal/wire (inner)
    wire [4:0] i_hw_lui_addisp_comp_s_fe_rs1_imm_D0_ACT;
    // signal/wire (inner)
    wire [4:0] i_hw_lui_addisp_comp_s_fe_rs2_imm_D0;
    // signal/wire (inner)
    wire [4:0] i_hw_lui_addisp_comp_s_fe_rs2_imm_D0_ACT;
    // signal/wire (inner)
    wire [6:0] i_hw_lui_addisp_comp_s_fe_func7_imm_D0;
    // signal/wire (inner)
    wire [6:0] i_hw_lui_addisp_comp_s_fe_func7_imm_D0_ACT;
    // signal/wire (inner)
    wire i_hw_lui_addisp_comp_s_fe_16b_instr_inval_imm_D0;
    // signal/wire (inner)
    wire i_hw_lui_addisp_comp_s_fe_16b_instr_inval_imm_D0_ACT;
    // signal/wire (inner)
    wire [4:0] i_hw_lui_addisp_comp_s_fe_rd_imm_D0;
    // signal/wire (inner)
    wire codasip_tmp_var_0_i_hw_jalr_mvadd_ebreak_comp_decompressor_16b32b_decompressor_16b32b_fe_fe;
    // signal/wire (inner)
    wire codasip_tmp_var_1_i_hw_jalr_mvadd_ebreak_comp_decompressor_16b32b_decompressor_16b32b_fe_fe;
    // signal/wire (inner)
    wire [5:0] codasip_tmp_var_2_i_hw_jalr_mvadd_ebreak_comp_decompressor_16b32b_decompressor_16b32b_fe_fe;
    // signal/wire (inner)
    wire [5:0] codasip_tmp_var_3_i_hw_jalr_mvadd_ebreak_comp_decompressor_16b32b_decompressor_16b32b_fe_fe;
    // signal/wire (inner)
    wire [6:0] i_hw_jalr_mvadd_ebreak_comp_s_fe_opcode_D0;
    // signal/wire (inner)
    wire [6:0] i_hw_jalr_mvadd_ebreak_comp_s_fe_opcode_D0_ACT;
    // signal/wire (inner)
    wire [4:0] i_hw_jalr_mvadd_ebreak_comp_s_fe_rd_imm_D0;
    // signal/wire (inner)
    wire [4:0] i_hw_jalr_mvadd_ebreak_comp_s_fe_rd_imm_D0_ACT;
    // signal/wire (inner)
    wire [2:0] i_hw_jalr_mvadd_ebreak_comp_s_fe_func3_imm_D0;
    // signal/wire (inner)
    wire [2:0] i_hw_jalr_mvadd_ebreak_comp_s_fe_func3_imm_D0_ACT;
    // signal/wire (inner)
    wire [4:0] i_hw_jalr_mvadd_ebreak_comp_s_fe_rs1_imm_D0;
    // signal/wire (inner)
    wire [4:0] i_hw_jalr_mvadd_ebreak_comp_s_fe_rs1_imm_D0_ACT;
    // signal/wire (inner)
    wire [4:0] i_hw_jalr_mvadd_ebreak_comp_s_fe_rs2_imm_D0;
    // signal/wire (inner)
    wire [4:0] i_hw_jalr_mvadd_ebreak_comp_s_fe_rs2_imm_D0_ACT;
    // signal/wire (inner)
    wire [6:0] i_hw_jalr_mvadd_ebreak_comp_s_fe_func7_imm_D0;
    // signal/wire (inner)
    wire [6:0] i_hw_jalr_mvadd_ebreak_comp_s_fe_func7_imm_D0_ACT;
    // signal/wire (inner)
    wire i_hw_jalr_mvadd_ebreak_comp_codasip_tmp_var_1_i_hw_jalr_mvadd_ebreak_comp_decompressor_16b32b_decompressor_16b32b_fe_fe_D0;
    // signal/wire (inner)
    wire [5:0] i_hw_jalr_mvadd_ebreak_comp_codasip_tmp_var_2_i_hw_jalr_mvadd_ebreak_comp_decompressor_16b32b_decompressor_16b32b_fe_fe_D0;
    // signal/wire (inner)
    wire [5:0] i_hw_jalr_mvadd_ebreak_comp_codasip_tmp_var_3_i_hw_jalr_mvadd_ebreak_comp_decompressor_16b32b_decompressor_16b32b_fe_fe_D0;

    // additional declarations:
    wire signed [6:0] tmp_codasip_conv_STATIC_CAST_9954_1;
    wire signed [4:0] tmp_codasip_conv_STATIC_CAST_11281_2;
    wire signed [6:0] tmp_codasip_conv_STATIC_CAST_11209_3;

    // conversions for data-path:
    assign tmp_codasip_conv_STATIC_CAST_9954_1 = $signed({{s_fe_16b_instr_Q0[10],s_fe_16b_instr_Q0[4:3]},s_fe_16b_instr_Q0[0]});
    assign tmp_codasip_conv_STATIC_CAST_11281_2 = $signed({s_fe_16b_instr_Q0[10],s_fe_16b_instr_Q0[4:3]});
    assign tmp_codasip_conv_STATIC_CAST_11209_3 = $signed({{{s_fe_16b_instr_Q0[10],s_fe_16b_instr_Q0[2:1]},s_fe_16b_instr_Q0[3]},s_fe_16b_instr_Q0[0]});
    // data-path code:
    assign codasip_param_1 = invalid_instruction_wire;
    assign cs_0_wire = ((((((((({{codasip_param_0[15],codasip_param_0[13]},codasip_param_0[1]} == 3'd0) || ({codasip_param_0[15:11],codasip_param_0[1:0]} == 7'd65)) || ({codasip_param_0[15:10],codasip_param_0[1:0]} == 8'd141)) || ({codasip_param_0[15:12],codasip_param_0[1:0]} == 6'd38)) || ({{codasip_param_0[15:13],codasip_param_0[11:10]},codasip_param_0[1:0]} == 7'd73)) || ({codasip_param_0[15:13],codasip_param_0[1]} == 4'd12)) || ({codasip_param_0[14:12],codasip_param_0[1:0]} == 5'd2)) || ({codasip_param_0[14:13],codasip_param_0[1:0]} == 4'd10)) || ({codasip_param_0[13],codasip_param_0[1:0]} == 3'd5)) ? 1'd1 : 1'd0;
    assign cs_10_wire = ({{codasip_param_0[15:13],codasip_param_0[11:10]},codasip_param_0[1:0]} == 7'd69) ? 1'd1 : 1'd0;
    assign cs_11_wire = ({codasip_param_0[15:10],codasip_param_0[1:0]} == 8'd141) ? 1'd1 : 1'd0;
    assign cs_12_wire = ({{codasip_param_0[15:10],codasip_param_0[6:5]},codasip_param_0[1:0]} == 10'd573) ? 1'd1 : 1'd0;
    assign cs_13_wire = ({{codasip_param_0[15:10],codasip_param_0[6:5]},codasip_param_0[1:0]} == 10'd569) ? 1'd1 : 1'd0;
    assign cs_14_wire = ({{codasip_param_0[15:10],codasip_param_0[6:5]},codasip_param_0[1:0]} == 10'd565) ? 1'd1 : 1'd0;
    assign cs_15_wire = ({{codasip_param_0[15:10],codasip_param_0[6:5]},codasip_param_0[1:0]} == 10'd561) ? 1'd1 : 1'd0;
    assign cs_16_wire = ({codasip_param_0[15:13],codasip_param_0[1:0]} == 5'd18) ? 1'd1 : 1'd0;
    assign cs_17_wire = ({codasip_param_0[15:12],codasip_param_0[1:0]} == 6'd34) ? 1'd1 : 1'd0;
    assign cs_18_wire = ({codasip_param_0[15:12],codasip_param_0[1:0]} == 6'd38) ? 1'd1 : 1'd0;
    assign cs_19_wire = ({{codasip_param_0[15:13],codasip_param_0[11:10]},codasip_param_0[1:0]} == 7'd73) ? 1'd1 : 1'd0;
    assign cs_1_wire = ({codasip_param_0[14:13],codasip_param_0[1:0]} == 4'd8) ? 1'd1 : 1'd0;
    assign cs_20_wire = ({codasip_param_0[15:14],codasip_param_0[1:0]} == 4'd13) ? 1'd1 : 1'd0;
    assign cs_21_wire = ({codasip_param_0[15:13],codasip_param_0[1:0]} == 5'd25) ? 1'd1 : 1'd0;
    assign cs_22_wire = ({codasip_param_0[15:13],codasip_param_0[1:0]} == 5'd29) ? 1'd1 : 1'd0;
    assign cs_23_wire = ({codasip_param_0[15:12],codasip_param_0[1:0]} == 6'd2) ? 1'd1 : 1'd0;
    assign cs_25_wire = ({codasip_param_0[15:13],codasip_param_0[1:0]} == 5'd10) ? 1'd1 : 1'd0;
    assign cs_26_wire = ({codasip_param_0[15:13],codasip_param_0[1:0]} == 5'd26) ? 1'd1 : 1'd0;
    assign cs_27_wire = ({codasip_param_0[14:13],codasip_param_0[1:0]} == 4'd5) ? 1'd1 : 1'd0;
    assign cs_28_wire = ({codasip_param_0[15:13],codasip_param_0[1:0]} == 5'd21) ? 1'd1 : 1'd0;
    assign cs_29_wire = ({codasip_param_0[15:13],codasip_param_0[1:0]} == 5'd5) ? 1'd1 : 1'd0;
    assign cs_2_wire = ({codasip_param_0[15:13],codasip_param_0[1:0]} == 5'd8) ? 1'd1 : 1'd0;
    assign cs_30_wire = ({codasip_param_0[15:13],codasip_param_0[1:0]} == 5'd13) ? 1'd1 : 1'd0;
    assign cs_3_wire = ({codasip_param_0[15:13],codasip_param_0[1:0]} == 5'd24) ? 1'd1 : 1'd0;
    assign cs_4_wire = ({codasip_param_0[15:13],codasip_param_0[1:0]} == 5'd9) ? 1'd1 : 1'd0;
    assign cs_5_wire = ({codasip_param_0[15:13],codasip_param_0[1:0]} == 5'd1) ? 1'd1 : 1'd0;
    assign cs_6_wire = ({codasip_param_0[15:13],codasip_param_0[1:0]} == 5'd0) ? 1'd1 : 1'd0;
    assign cs_7_wire = ({codasip_param_0[15:11],codasip_param_0[1:0]} == 7'd65) ? 1'd1 : 1'd0;
    assign cs_8_wire = ({{codasip_param_0[15:13],codasip_param_0[11]},codasip_param_0[1:0]} == 6'd33) ? 1'd1 : 1'd0;
    assign cs_9_wire = ({{codasip_param_0[15:13],codasip_param_0[11:10]},codasip_param_0[1:0]} == 7'd65) ? 1'd1 : 1'd0;
    assign invalid_instruction_wire = ((ACT == 1'd1) && (vs_0_wire == 1'd0)) ? 1'd1 : 1'd0;
    assign vs_0_wire = (({codasip_param_0[15:13],codasip_param_0[1:0]} == 5'd13) || (({codasip_param_0[14:13],codasip_param_0[1:0]} == 4'd5) || (({codasip_param_0[15:13],codasip_param_0[1:0]} == 5'd26) || (({codasip_param_0[15:13],codasip_param_0[1:0]} == 5'd10) || (({codasip_param_0[15:12],codasip_param_0[1:0]} == 6'd2) || (({codasip_param_0[15:14],codasip_param_0[1:0]} == 4'd13) || (({{codasip_param_0[15:13],codasip_param_0[11:10]},codasip_param_0[1:0]} == 7'd73) || (({codasip_param_0[15:13],codasip_param_0[1:0]} == 5'd18) || (({codasip_param_0[15:10],codasip_param_0[1:0]} == 8'd141) || (({codasip_param_0[15:11],codasip_param_0[1:0]} == 7'd65) || (({codasip_param_0[15:13],codasip_param_0[1:0]} == 5'd0) || (({codasip_param_0[15:13],codasip_param_0[1:0]} == 5'd1) || (({codasip_param_0[15:13],codasip_param_0[1:0]} == 5'd9) || ({codasip_param_0[14:13],codasip_param_0[1:0]} == 4'd8)))))))))))))) ? 1'd1 : 1'd0;
    assign opc_j_comp_ACT = (((invalid_instruction_wire == 1'd0) && (ACT == 1'd1)) && (((cs_0_wire == 1'd1) && (cs_27_wire == 1'd1)) && (cs_28_wire == 1'd1))) ? 1'd1 : 1'd0;
    assign opc_jr_comp_ACT = (((invalid_instruction_wire == 1'd0) && (ACT == 1'd1)) && (((cs_0_wire == 1'd1) && (cs_16_wire == 1'd1)) && (cs_17_wire == 1'd1))) ? 1'd1 : 1'd0;
    assign opc_or_comp_ACT = (((invalid_instruction_wire == 1'd0) && (ACT == 1'd1)) && (((cs_0_wire == 1'd1) && (cs_11_wire == 1'd1)) && (cs_13_wire == 1'd1))) ? 1'd1 : 1'd0;
    assign i_hw_br_comp_ACT = (((invalid_instruction_wire == 1'd0) && (ACT == 1'd1)) && ((cs_0_wire == 1'd1) && (cs_20_wire == 1'd1))) ? 1'd1 : 1'd0;
    assign i_hw_li_comp_ACT = (((invalid_instruction_wire == 1'd0) && (ACT == 1'd1)) && ((cs_0_wire == 1'd1) && (cs_4_wire == 1'd1))) ? 1'd1 : 1'd0;
    assign i_hw_loadwsp_ACT = (((invalid_instruction_wire == 1'd0) && (ACT == 1'd1)) && ((cs_0_wire == 1'd1) && (cs_25_wire == 1'd1))) ? 1'd1 : 1'd0;
    assign opc_and_comp_ACT = (((invalid_instruction_wire == 1'd0) && (ACT == 1'd1)) && (((cs_0_wire == 1'd1) && (cs_11_wire == 1'd1)) && (cs_12_wire == 1'd1))) ? 1'd1 : 1'd0;
    assign opc_jal_comp_ACT = (((invalid_instruction_wire == 1'd0) && (ACT == 1'd1)) && (((cs_0_wire == 1'd1) && (cs_27_wire == 1'd1)) && (cs_29_wire == 1'd1))) ? 1'd1 : 1'd0;
    assign opc_loadwreg_ACT = (((invalid_instruction_wire == 1'd0) && (ACT == 1'd1)) && (((cs_0_wire == 1'd1) && (cs_1_wire == 1'd1)) && (cs_2_wire == 1'd1))) ? 1'd1 : 1'd0;
    assign opc_sub_comp_ACT = (((invalid_instruction_wire == 1'd0) && (ACT == 1'd1)) && (((cs_0_wire == 1'd1) && (cs_11_wire == 1'd1)) && (cs_15_wire == 1'd1))) ? 1'd1 : 1'd0;
    assign opc_xor_comp_ACT = (((invalid_instruction_wire == 1'd0) && (ACT == 1'd1)) && (((cs_0_wire == 1'd1) && (cs_11_wire == 1'd1)) && (cs_14_wire == 1'd1))) ? 1'd1 : 1'd0;
    assign i_hw_jal_comp_ACT = (((invalid_instruction_wire == 1'd0) && (ACT == 1'd1)) && ((cs_0_wire == 1'd1) && (cs_27_wire == 1'd1))) ? 1'd1 : 1'd0;
    assign i_hw_lsw_comp_ACT = (((invalid_instruction_wire == 1'd0) && (ACT == 1'd1)) && ((cs_0_wire == 1'd1) && (cs_1_wire == 1'd1))) ? 1'd1 : 1'd0;
    assign i_hw_sri_comp_ACT = (((invalid_instruction_wire == 1'd0) && (ACT == 1'd1)) && ((cs_0_wire == 1'd1) && (cs_7_wire == 1'd1))) ? 1'd1 : 1'd0;
    assign i_hw_storewsp_ACT = (((invalid_instruction_wire == 1'd0) && (ACT == 1'd1)) && ((cs_0_wire == 1'd1) && (cs_26_wire == 1'd1))) ? 1'd1 : 1'd0;
    assign opc_beqz_comp_ACT = (((invalid_instruction_wire == 1'd0) && (ACT == 1'd1)) && (((cs_0_wire == 1'd1) && (cs_20_wire == 1'd1)) && (cs_21_wire == 1'd1))) ? 1'd1 : 1'd0;
    assign opc_bnez_comp_ACT = (((invalid_instruction_wire == 1'd0) && (ACT == 1'd1)) && (((cs_0_wire == 1'd1) && (cs_20_wire == 1'd1)) && (cs_22_wire == 1'd1))) ? 1'd1 : 1'd0;
    assign opc_jalr_comp_ACT = (((invalid_instruction_wire == 1'd0) && (ACT == 1'd1)) && (((cs_0_wire == 1'd1) && (cs_16_wire == 1'd1)) && (cs_18_wire == 1'd1))) ? 1'd1 : 1'd0;
    assign opc_srai_comp_ACT = (((invalid_instruction_wire == 1'd0) && (ACT == 1'd1)) && ((((cs_0_wire == 1'd1) && (cs_7_wire == 1'd1)) && (cs_8_wire == 1'd1)) && (cs_10_wire == 1'd1))) ? 1'd1 : 1'd0;
    assign opc_srli_comp_ACT = (((invalid_instruction_wire == 1'd0) && (ACT == 1'd1)) && ((((cs_0_wire == 1'd1) && (cs_7_wire == 1'd1)) && (cs_8_wire == 1'd1)) && (cs_9_wire == 1'd1))) ? 1'd1 : 1'd0;
    assign opc_storewreg_ACT = (((invalid_instruction_wire == 1'd0) && (ACT == 1'd1)) && (((cs_0_wire == 1'd1) && (cs_1_wire == 1'd1)) && (cs_3_wire == 1'd1))) ? 1'd1 : 1'd0;
    assign i_hw_addi_comp_ACT = (((invalid_instruction_wire == 1'd0) && (ACT == 1'd1)) && ((cs_0_wire == 1'd1) && (cs_5_wire == 1'd1))) ? 1'd1 : 1'd0;
    assign i_hw_andi_comp_ACT = (((invalid_instruction_wire == 1'd0) && (ACT == 1'd1)) && ((cs_0_wire == 1'd1) && (cs_19_wire == 1'd1))) ? 1'd1 : 1'd0;
    assign i_hw_slli_comp_ACT = (((invalid_instruction_wire == 1'd0) && (ACT == 1'd1)) && ((cs_0_wire == 1'd1) && (cs_23_wire == 1'd1))) ? 1'd1 : 1'd0;
    assign i_hw_addispn_comp_ACT = (((invalid_instruction_wire == 1'd0) && (ACT == 1'd1)) && ((cs_0_wire == 1'd1) && (cs_6_wire == 1'd1))) ? 1'd1 : 1'd0;
    assign i_hw_compreg_comp_ACT = (((invalid_instruction_wire == 1'd0) && (ACT == 1'd1)) && ((cs_0_wire == 1'd1) && (cs_11_wire == 1'd1))) ? 1'd1 : 1'd0;
    assign i_hw_lui_addisp_comp_ACT = (((invalid_instruction_wire == 1'd0) && (ACT == 1'd1)) && ((cs_0_wire == 1'd1) && (cs_30_wire == 1'd1))) ? 1'd1 : 1'd0;
    assign i_hw_jalr_mvadd_ebreak_comp_ACT = (((invalid_instruction_wire == 1'd0) && (ACT == 1'd1)) && ((cs_0_wire == 1'd1) && (cs_16_wire == 1'd1))) ? 1'd1 : 1'd0;
    assign opc_j_comp_codasip_return_MI12opc_jmp_compIH4_2fe2fe22_19decompressor_16b32b19decompressor_16b32b15_12opc_jmp_comp3opc_D0 = opc_j_comp_ACT ? 5'd21 : 5'd0;
    assign codasip_return_MI12opc_jmp_compIH4_2fe2fe22_19decompressor_16b32b19decompressor_16b32b15_12opc_jmp_comp3opc = (opc_j_comp_codasip_return_MI12opc_jmp_compIH4_2fe2fe22_19decompressor_16b32b19decompressor_16b32b15_12opc_jmp_comp3opc_D0 | opc_jal_comp_codasip_return_MI12opc_jmp_compIH4_2fe2fe22_19decompressor_16b32b19decompressor_16b32b15_12opc_jmp_comp3opc_D0);
    assign opc_jr_comp_codasip_return_MI13opc_jmpr_compIH4_2fe2fe22_19decompressor_16b32b19decompressor_16b32b16_13opc_jmpr_comp3opc_D0 = opc_jr_comp_ACT ? 6'd34 : 6'd0;
    assign codasip_return_MI13opc_jmpr_compIH4_2fe2fe22_19decompressor_16b32b19decompressor_16b32b16_13opc_jmpr_comp3opc = (opc_jr_comp_codasip_return_MI13opc_jmpr_compIH4_2fe2fe22_19decompressor_16b32b19decompressor_16b32b16_13opc_jmpr_comp3opc_D0 | opc_jalr_comp_codasip_return_MI13opc_jmpr_compIH4_2fe2fe22_19decompressor_16b32b19decompressor_16b32b16_13opc_jmpr_comp3opc_D0);
    assign opc_or_comp_codasip_return_MI16opc_compreg_compIH4_2fe2fe22_19decompressor_16b32b19decompressor_16b32b19_16opc_compreg_comp3opc_D0 = opc_or_comp_ACT ? 10'd569 : 10'd0;
    assign codasip_return_MI16opc_compreg_compIH4_2fe2fe22_19decompressor_16b32b19decompressor_16b32b19_16opc_compreg_comp3opc = (((opc_or_comp_codasip_return_MI16opc_compreg_compIH4_2fe2fe22_19decompressor_16b32b19decompressor_16b32b19_16opc_compreg_comp3opc_D0 | opc_and_comp_codasip_return_MI16opc_compreg_compIH4_2fe2fe22_19decompressor_16b32b19decompressor_16b32b19_16opc_compreg_comp3opc_D0) | opc_sub_comp_codasip_return_MI16opc_compreg_compIH4_2fe2fe22_19decompressor_16b32b19decompressor_16b32b19_16opc_compreg_comp3opc_D0) | opc_xor_comp_codasip_return_MI16opc_compreg_compIH4_2fe2fe22_19decompressor_16b32b19decompressor_16b32b19_16opc_compreg_comp3opc_D0);
    assign codasip_tmp_var_0_i_hw_br_comp_decompressor_16b32b_decompressor_16b32b_fe_fe = codasip_return_MI11opc_br_compIH4_2fe2fe22_19decompressor_16b32b19decompressor_16b32b14_11opc_br_comp3opc;
    assign i_hw_br_comp_s_fe_opcode_D0 = ((codasip_tmp_var_0_i_hw_br_comp_decompressor_16b32b_decompressor_16b32b_fe_fe == 5'd25) || (codasip_tmp_var_0_i_hw_br_comp_decompressor_16b32b_decompressor_16b32b_fe_fe == 5'd29)) ? 7'd99 : 7'd0;
    assign i_hw_br_comp_s_fe_opcode_D0_ACT = i_hw_br_comp_ACT ? i_hw_br_comp_s_fe_opcode_D0 : 7'd0;
    assign s_fe_opcode_D0 = (((((((((((((((((i_hw_br_comp_s_fe_opcode_D0_ACT | i_hw_li_comp_s_fe_opcode_D0) | i_hw_loadwsp_s_fe_opcode_D0) | i_hw_jal_comp_s_fe_opcode_D0) | i_hw_lsw_comp_s_fe_opcode_D0_ACT) | i_hw_lsw_comp_s_fe_opcode_D0_ACT) | i_hw_sri_comp_s_fe_opcode_D0_ACT) | i_hw_storewsp_s_fe_opcode_D0) | i_hw_addi_comp_s_fe_opcode_D0) | i_hw_andi_comp_s_fe_opcode_D0) | i_hw_slli_comp_s_fe_opcode_D0) | i_hw_addispn_comp_s_fe_opcode_D0) | i_hw_compreg_comp_s_fe_opcode_D0_ACT) | i_hw_lui_addisp_comp_s_fe_opcode_D0_ACT) | i_hw_lui_addisp_comp_s_fe_opcode_D0_ACT) | i_hw_jalr_mvadd_ebreak_comp_s_fe_opcode_D0_ACT) | i_hw_jalr_mvadd_ebreak_comp_s_fe_opcode_D0_ACT) | i_hw_jalr_mvadd_ebreak_comp_s_fe_opcode_D0_ACT);
    assign i_hw_br_comp_s_fe_func3_imm_D0 = (codasip_tmp_var_0_i_hw_br_comp_decompressor_16b32b_decompressor_16b32b_fe_fe == 5'd25) ? 3'd0 :
        (codasip_tmp_var_0_i_hw_br_comp_decompressor_16b32b_decompressor_16b32b_fe_fe == 5'd29) ? 3'd1 : 3'd0;
    assign i_hw_br_comp_s_fe_func3_imm_D0_ACT = i_hw_br_comp_ACT ? i_hw_br_comp_s_fe_func3_imm_D0 : 3'd0;
    assign s_fe_func3_imm_D0 = (((((((((((((((((((i_hw_br_comp_s_fe_func3_imm_D0_ACT | i_hw_br_comp_s_fe_func3_imm_D0_ACT) | i_hw_li_comp_s_fe_func3_imm_D0) | i_hw_loadwsp_s_fe_func3_imm_D0) | i_hw_jal_comp_s_fe_func3_imm_D0) | i_hw_lsw_comp_s_fe_func3_imm_D0_ACT) | i_hw_sri_comp_s_fe_func3_imm_D0_ACT) | i_hw_storewsp_s_fe_func3_imm_D0) | i_hw_addi_comp_s_fe_func3_imm_D0) | i_hw_andi_comp_s_fe_func3_imm_D0) | i_hw_slli_comp_s_fe_func3_imm_D0) | i_hw_addispn_comp_s_fe_func3_imm_D0) | i_hw_compreg_comp_s_fe_func3_imm_D0_ACT) | i_hw_compreg_comp_s_fe_func3_imm_D0_ACT) | i_hw_compreg_comp_s_fe_func3_imm_D0_ACT) | i_hw_compreg_comp_s_fe_func3_imm_D0_ACT) | i_hw_lui_addisp_comp_s_fe_func3_imm_D0_ACT) | i_hw_lui_addisp_comp_s_fe_func3_imm_D0_ACT) | i_hw_jalr_mvadd_ebreak_comp_s_fe_func3_imm_D0_ACT) | i_hw_jalr_mvadd_ebreak_comp_s_fe_func3_imm_D0_ACT);
    assign i_hw_br_comp_s_fe_rd_imm_D0 = i_hw_br_comp_ACT ? {{s_fe_16b_instr_Q0[9:8],s_fe_16b_instr_Q0[2:1]},s_fe_16b_instr_Q0[10]} : 5'd0;
    assign s_fe_rd_imm_D0 = ((((((((((((((((((i_hw_br_comp_s_fe_rd_imm_D0 | i_hw_li_comp_s_fe_rd_imm_D0) | i_hw_loadwsp_s_fe_rd_imm_D0) | i_hw_jal_comp_s_fe_rd_imm_D0_ACT) | i_hw_jal_comp_s_fe_rd_imm_D0_ACT) | i_hw_lsw_comp_s_fe_rd_imm_D0_ACT) | i_hw_lsw_comp_s_fe_rd_imm_D0_ACT) | i_hw_sri_comp_s_fe_rd_imm_D0) | i_hw_storewsp_s_fe_rd_imm_D0) | i_hw_addi_comp_s_fe_rd_imm_D0) | i_hw_andi_comp_s_fe_rd_imm_D0) | i_hw_slli_comp_s_fe_rd_imm_D0) | i_hw_addispn_comp_s_fe_rd_imm_D0) | i_hw_compreg_comp_s_fe_rd_imm_D0) | i_hw_lui_addisp_comp_s_fe_rd_imm_D0) | i_hw_jalr_mvadd_ebreak_comp_s_fe_rd_imm_D0_ACT) | i_hw_jalr_mvadd_ebreak_comp_s_fe_rd_imm_D0_ACT) | i_hw_jalr_mvadd_ebreak_comp_s_fe_rd_imm_D0_ACT) | i_hw_jalr_mvadd_ebreak_comp_s_fe_rd_imm_D0_ACT);
    assign i_hw_br_comp_s_fe_rs1_imm_D0 = i_hw_br_comp_ACT ? {2'd1,s_fe_16b_instr_Q0[7:5]} : 5'd0;
    assign s_fe_rs1_imm_D0 = ((((((((((((((((i_hw_br_comp_s_fe_rs1_imm_D0 | i_hw_li_comp_s_fe_rs1_imm_D0) | i_hw_loadwsp_s_fe_rs1_imm_D0) | i_hw_jal_comp_s_fe_rs1_imm_D0) | i_hw_lsw_comp_s_fe_rs1_imm_D0) | i_hw_sri_comp_s_fe_rs1_imm_D0) | i_hw_storewsp_s_fe_rs1_imm_D0) | i_hw_addi_comp_s_fe_rs1_imm_D0) | i_hw_andi_comp_s_fe_rs1_imm_D0) | i_hw_slli_comp_s_fe_rs1_imm_D0) | i_hw_addispn_comp_s_fe_rs1_imm_D0) | i_hw_compreg_comp_s_fe_rs1_imm_D0) | i_hw_lui_addisp_comp_s_fe_rs1_imm_D0_ACT) | i_hw_lui_addisp_comp_s_fe_rs1_imm_D0_ACT) | i_hw_jalr_mvadd_ebreak_comp_s_fe_rs1_imm_D0_ACT) | i_hw_jalr_mvadd_ebreak_comp_s_fe_rs1_imm_D0_ACT) | i_hw_jalr_mvadd_ebreak_comp_s_fe_rs1_imm_D0_ACT);
    assign i_hw_br_comp_s_fe_rs2_imm_D0 = i_hw_br_comp_ACT ? 5'd0 : 5'd0;
    assign s_fe_rs2_imm_D0 = (((((((((((((((((i_hw_br_comp_s_fe_rs2_imm_D0 | i_hw_li_comp_s_fe_rs2_imm_D0) | i_hw_loadwsp_s_fe_rs2_imm_D0) | i_hw_jal_comp_s_fe_rs2_imm_D0) | i_hw_lsw_comp_s_fe_rs2_imm_D0_ACT) | i_hw_lsw_comp_s_fe_rs2_imm_D0_ACT) | i_hw_sri_comp_s_fe_rs2_imm_D0) | i_hw_storewsp_s_fe_rs2_imm_D0) | i_hw_addi_comp_s_fe_rs2_imm_D0) | i_hw_andi_comp_s_fe_rs2_imm_D0) | i_hw_slli_comp_s_fe_rs2_imm_D0) | i_hw_addispn_comp_s_fe_rs2_imm_D0) | i_hw_compreg_comp_s_fe_rs2_imm_D0) | i_hw_lui_addisp_comp_s_fe_rs2_imm_D0_ACT) | i_hw_lui_addisp_comp_s_fe_rs2_imm_D0_ACT) | i_hw_jalr_mvadd_ebreak_comp_s_fe_rs2_imm_D0_ACT) | i_hw_jalr_mvadd_ebreak_comp_s_fe_rs2_imm_D0_ACT) | i_hw_jalr_mvadd_ebreak_comp_s_fe_rs2_imm_D0_ACT);
    assign i_hw_br_comp_s_fe_func7_imm_D0 = i_hw_br_comp_ACT ? $unsigned(tmp_codasip_conv_STATIC_CAST_9954_1) : 7'd0;
    assign s_fe_func7_imm_D0 = (((((((((((((((((i_hw_br_comp_s_fe_func7_imm_D0 | i_hw_li_comp_s_fe_func7_imm_D0) | i_hw_loadwsp_s_fe_func7_imm_D0) | i_hw_jal_comp_s_fe_func7_imm_D0) | i_hw_lsw_comp_s_fe_func7_imm_D0) | i_hw_sri_comp_s_fe_func7_imm_D0_ACT) | i_hw_sri_comp_s_fe_func7_imm_D0_ACT) | i_hw_storewsp_s_fe_func7_imm_D0) | i_hw_addi_comp_s_fe_func7_imm_D0) | i_hw_andi_comp_s_fe_func7_imm_D0) | i_hw_slli_comp_s_fe_func7_imm_D0) | i_hw_addispn_comp_s_fe_func7_imm_D0) | i_hw_compreg_comp_s_fe_func7_imm_D0_ACT) | i_hw_compreg_comp_s_fe_func7_imm_D0_ACT) | i_hw_lui_addisp_comp_s_fe_func7_imm_D0_ACT) | i_hw_lui_addisp_comp_s_fe_func7_imm_D0_ACT) | i_hw_jalr_mvadd_ebreak_comp_s_fe_func7_imm_D0_ACT) | i_hw_jalr_mvadd_ebreak_comp_s_fe_func7_imm_D0_ACT);
    assign i_hw_li_comp_s_fe_opcode_D0 = i_hw_li_comp_ACT ? 7'd19 : 7'd0;
    assign i_hw_li_comp_s_fe_rd_imm_D0 = i_hw_li_comp_ACT ? s_fe_16b_instr_Q0[9:5] : 5'd0;
    assign i_hw_li_comp_s_fe_func3_imm_D0 = i_hw_li_comp_ACT ? 3'd0 : 3'd0;
    assign i_hw_li_comp_s_fe_rs1_imm_D0 = i_hw_li_comp_ACT ? 5'd0 : 5'd0;
    assign i_hw_li_comp_s_fe_rs2_imm_D0 = i_hw_li_comp_ACT ? s_fe_16b_instr_Q0[4:0] : 5'd0;
    assign i_hw_li_comp_s_fe_func7_imm_D0 = i_hw_li_comp_ACT ? $unsigned(((s_fe_16b_instr_Q0[10]) ? -7'sd1 : 7'sd0)) : 7'd0;
    assign i_hw_li_comp_s_fe_16b_instr_inval_reg_D0 = i_hw_li_comp_ACT ? (s_fe_16b_instr_Q0[9:5] == 5'd0) : 1'd0;
    assign s_fe_16b_instr_inval_reg_D0 = (((i_hw_li_comp_s_fe_16b_instr_inval_reg_D0 | i_hw_loadwsp_s_fe_16b_instr_inval_reg_D0) | i_hw_addi_comp_s_fe_16b_instr_inval_reg_D0) | i_hw_slli_comp_s_fe_16b_instr_inval_reg_D0);
    assign i_hw_loadwsp_s_fe_opcode_D0 = i_hw_loadwsp_ACT ? 7'd3 : 7'd0;
    assign i_hw_loadwsp_s_fe_rd_imm_D0 = i_hw_loadwsp_ACT ? s_fe_16b_instr_Q0[9:5] : 5'd0;
    assign i_hw_loadwsp_s_fe_func3_imm_D0 = i_hw_loadwsp_ACT ? 3'd2 : 3'd0;
    assign i_hw_loadwsp_s_fe_rs1_imm_D0 = i_hw_loadwsp_ACT ? 5'd2 : 5'd0;
    assign i_hw_loadwsp_s_fe_rs2_imm_D0 = i_hw_loadwsp_ACT ? {s_fe_16b_instr_Q0[4:2],2'd0} : 5'd0;
    assign i_hw_loadwsp_s_fe_func7_imm_D0 = i_hw_loadwsp_ACT ? {{4{1'b0}}, {s_fe_16b_instr_Q0[1:0],s_fe_16b_instr_Q0[10]}} : 7'd0;
    assign i_hw_loadwsp_s_fe_16b_instr_inval_reg_D0 = i_hw_loadwsp_ACT ? (s_fe_16b_instr_Q0[9:5] == 5'd0) : 1'd0;
    assign opc_and_comp_codasip_return_MI16opc_compreg_compIH4_2fe2fe22_19decompressor_16b32b19decompressor_16b32b19_16opc_compreg_comp3opc_D0 = opc_and_comp_ACT ? 10'd573 : 10'd0;
    assign opc_jal_comp_codasip_return_MI12opc_jmp_compIH4_2fe2fe22_19decompressor_16b32b19decompressor_16b32b15_12opc_jmp_comp3opc_D0 = opc_jal_comp_ACT ? 5'd5 : 5'd0;
    assign opc_loadwreg_codasip_return_MI12opc_lsw_compIH4_2fe2fe22_19decompressor_16b32b19decompressor_16b32b15_12opc_lsw_comp3opc_D0 = opc_loadwreg_ACT ? 5'd8 : 5'd0;
    assign codasip_return_MI12opc_lsw_compIH4_2fe2fe22_19decompressor_16b32b19decompressor_16b32b15_12opc_lsw_comp3opc = (opc_loadwreg_codasip_return_MI12opc_lsw_compIH4_2fe2fe22_19decompressor_16b32b19decompressor_16b32b15_12opc_lsw_comp3opc_D0 | opc_storewreg_codasip_return_MI12opc_lsw_compIH4_2fe2fe22_19decompressor_16b32b19decompressor_16b32b15_12opc_lsw_comp3opc_D0);
    assign opc_sub_comp_codasip_return_MI16opc_compreg_compIH4_2fe2fe22_19decompressor_16b32b19decompressor_16b32b19_16opc_compreg_comp3opc_D0 = opc_sub_comp_ACT ? 10'd561 : 10'd0;
    assign opc_xor_comp_codasip_return_MI16opc_compreg_compIH4_2fe2fe22_19decompressor_16b32b19decompressor_16b32b19_16opc_compreg_comp3opc_D0 = opc_xor_comp_ACT ? 10'd565 : 10'd0;
    assign i_hw_jal_comp_s_fe_opcode_D0 = i_hw_jal_comp_ACT ? 7'd111 : 7'd0;
    assign codasip_tmp_var_0_i_hw_jal_comp_decompressor_16b32b_decompressor_16b32b_fe_fe = codasip_return_MI12opc_jmp_compIH4_2fe2fe22_19decompressor_16b32b19decompressor_16b32b15_12opc_jmp_comp3opc;
    assign i_hw_jal_comp_s_fe_rd_imm_D0 = (codasip_tmp_var_0_i_hw_jal_comp_decompressor_16b32b_decompressor_16b32b_fe_fe == 5'd21) ? 5'd0 :
        (codasip_tmp_var_0_i_hw_jal_comp_decompressor_16b32b_decompressor_16b32b_fe_fe == 5'd5) ? 5'd1 : 5'd0;
    assign i_hw_jal_comp_s_fe_rd_imm_D0_ACT = i_hw_jal_comp_ACT ? i_hw_jal_comp_s_fe_rd_imm_D0 : 5'd0;
    assign i_hw_jal_comp_s_fe_func3_imm_D0 = i_hw_jal_comp_ACT ? $unsigned(((s_fe_16b_instr_Q0[10]) ? -3'sd1 : 3'sd0)) : 3'd0;
    assign i_hw_jal_comp_s_fe_rs1_imm_D0 = i_hw_jal_comp_ACT ? $unsigned(((s_fe_16b_instr_Q0[10]) ? -5'sd1 : 5'sd0)) : 5'd0;
    assign i_hw_jal_comp_s_fe_rs2_imm_D0 = i_hw_jal_comp_ACT ? {{s_fe_16b_instr_Q0[9],s_fe_16b_instr_Q0[3:1]},s_fe_16b_instr_Q0[10]} : 5'd0;
    assign i_hw_jal_comp_s_fe_func7_imm_D0 = i_hw_jal_comp_ACT ? $unsigned($signed({{{{{s_fe_16b_instr_Q0[10],s_fe_16b_instr_Q0[6]},s_fe_16b_instr_Q0[8:7]},s_fe_16b_instr_Q0[4]},s_fe_16b_instr_Q0[5]},s_fe_16b_instr_Q0[0]})) : 7'd0;
    assign codasip_tmp_var_0_i_hw_lsw_comp_decompressor_16b32b_decompressor_16b32b_fe_fe = codasip_return_MI12opc_lsw_compIH4_2fe2fe22_19decompressor_16b32b19decompressor_16b32b15_12opc_lsw_comp3opc;
    assign i_hw_lsw_comp_s_fe_opcode_D0 = (codasip_tmp_var_0_i_hw_lsw_comp_decompressor_16b32b_decompressor_16b32b_fe_fe == 5'd8) ? 7'd3 :
        (codasip_tmp_var_0_i_hw_lsw_comp_decompressor_16b32b_decompressor_16b32b_fe_fe == 5'd24) ? 7'd35 : 7'd0;
    assign i_hw_lsw_comp_s_fe_opcode_D0_ACT = i_hw_lsw_comp_ACT ? i_hw_lsw_comp_s_fe_opcode_D0 : 7'd0;
    assign i_hw_lsw_comp_s_fe_rd_imm_D0 = (codasip_tmp_var_0_i_hw_lsw_comp_decompressor_16b32b_decompressor_16b32b_fe_fe == 5'd8) ? {2'd1,s_fe_16b_instr_Q0[2:0]} :
        (codasip_tmp_var_0_i_hw_lsw_comp_decompressor_16b32b_decompressor_16b32b_fe_fe == 5'd24) ? {{s_fe_16b_instr_Q0[9:8],s_fe_16b_instr_Q0[4]},2'd0} : 5'd0;
    assign i_hw_lsw_comp_s_fe_rd_imm_D0_ACT = i_hw_lsw_comp_ACT ? i_hw_lsw_comp_s_fe_rd_imm_D0 : 5'd0;
    assign i_hw_lsw_comp_s_fe_func3_imm_D0 = ((codasip_tmp_var_0_i_hw_lsw_comp_decompressor_16b32b_decompressor_16b32b_fe_fe == 5'd8) || (codasip_tmp_var_0_i_hw_lsw_comp_decompressor_16b32b_decompressor_16b32b_fe_fe == 5'd24)) ? 3'd2 : 3'd0;
    assign i_hw_lsw_comp_s_fe_func3_imm_D0_ACT = i_hw_lsw_comp_ACT ? i_hw_lsw_comp_s_fe_func3_imm_D0 : 3'd0;
    assign i_hw_lsw_comp_s_fe_rs2_imm_D0 = (codasip_tmp_var_0_i_hw_lsw_comp_decompressor_16b32b_decompressor_16b32b_fe_fe == 5'd8) ? {{s_fe_16b_instr_Q0[9:8],s_fe_16b_instr_Q0[4]},2'd0} :
        (codasip_tmp_var_0_i_hw_lsw_comp_decompressor_16b32b_decompressor_16b32b_fe_fe == 5'd24) ? {2'd1,s_fe_16b_instr_Q0[2:0]} : 5'd0;
    assign i_hw_lsw_comp_s_fe_rs2_imm_D0_ACT = i_hw_lsw_comp_ACT ? i_hw_lsw_comp_s_fe_rs2_imm_D0 : 5'd0;
    assign i_hw_lsw_comp_s_fe_rs1_imm_D0 = i_hw_lsw_comp_ACT ? {2'd1,s_fe_16b_instr_Q0[7:5]} : 5'd0;
    assign i_hw_lsw_comp_s_fe_func7_imm_D0 = i_hw_lsw_comp_ACT ? {{5{1'b0}}, {s_fe_16b_instr_Q0[3],s_fe_16b_instr_Q0[10]}} : 7'd0;
    assign codasip_tmp_var_0_i_hw_sri_comp_decompressor_16b32b_decompressor_16b32b_fe_fe = codasip_return_MI12opc_sri_compIH4_2fe2fe22_19decompressor_16b32b19decompressor_16b32b15_12opc_sri_comp3opc;
    assign i_hw_sri_comp_s_fe_opcode_D0 = ((codasip_tmp_var_0_i_hw_sri_comp_decompressor_16b32b_decompressor_16b32b_fe_fe == 7'd65) || (codasip_tmp_var_0_i_hw_sri_comp_decompressor_16b32b_decompressor_16b32b_fe_fe == 7'd69)) ? 7'd19 : 7'd0;
    assign i_hw_sri_comp_s_fe_opcode_D0_ACT = i_hw_sri_comp_ACT ? i_hw_sri_comp_s_fe_opcode_D0 : 7'd0;
    assign i_hw_sri_comp_s_fe_func3_imm_D0 = ((codasip_tmp_var_0_i_hw_sri_comp_decompressor_16b32b_decompressor_16b32b_fe_fe == 7'd65) || (codasip_tmp_var_0_i_hw_sri_comp_decompressor_16b32b_decompressor_16b32b_fe_fe == 7'd69)) ? 3'd5 : 3'd0;
    assign i_hw_sri_comp_s_fe_func3_imm_D0_ACT = i_hw_sri_comp_ACT ? i_hw_sri_comp_s_fe_func3_imm_D0 : 3'd0;
    assign i_hw_sri_comp_s_fe_func7_imm_D0 = (codasip_tmp_var_0_i_hw_sri_comp_decompressor_16b32b_decompressor_16b32b_fe_fe == 7'd65) ? 7'd0 :
        (codasip_tmp_var_0_i_hw_sri_comp_decompressor_16b32b_decompressor_16b32b_fe_fe == 7'd69) ? 7'd32 : 7'd0;
    assign i_hw_sri_comp_s_fe_func7_imm_D0_ACT = i_hw_sri_comp_ACT ? i_hw_sri_comp_s_fe_func7_imm_D0 : 7'd0;
    assign i_hw_sri_comp_s_fe_rd_imm_D0 = i_hw_sri_comp_ACT ? {2'd1,s_fe_16b_instr_Q0[7:5]} : 5'd0;
    assign i_hw_sri_comp_s_fe_rs1_imm_D0 = i_hw_sri_comp_ACT ? {2'd1,s_fe_16b_instr_Q0[7:5]} : 5'd0;
    assign i_hw_sri_comp_s_fe_rs2_imm_D0 = i_hw_sri_comp_ACT ? s_fe_16b_instr_Q0[4:0] : 5'd0;
    assign i_hw_sri_comp_s_fe_16b_instr_inval_imm_D0 = i_hw_sri_comp_ACT ? (s_fe_16b_instr_Q0[4:0] == 5'd0) : 1'd0;
    assign s_fe_16b_instr_inval_imm_D0 = (((((i_hw_sri_comp_s_fe_16b_instr_inval_imm_D0 | i_hw_addi_comp_s_fe_16b_instr_inval_imm_D0) | i_hw_slli_comp_s_fe_16b_instr_inval_imm_D0) | i_hw_addispn_comp_s_fe_16b_instr_inval_imm_D0) | i_hw_lui_addisp_comp_s_fe_16b_instr_inval_imm_D0_ACT) | i_hw_lui_addisp_comp_s_fe_16b_instr_inval_imm_D0_ACT);
    assign i_hw_storewsp_s_fe_opcode_D0 = i_hw_storewsp_ACT ? 7'd35 : 7'd0;
    assign i_hw_storewsp_s_fe_rd_imm_D0 = i_hw_storewsp_ACT ? {s_fe_16b_instr_Q0[9:7],2'd0} : 5'd0;
    assign i_hw_storewsp_s_fe_func3_imm_D0 = i_hw_storewsp_ACT ? 3'd2 : 3'd0;
    assign i_hw_storewsp_s_fe_rs1_imm_D0 = i_hw_storewsp_ACT ? 5'd2 : 5'd0;
    assign i_hw_storewsp_s_fe_rs2_imm_D0 = i_hw_storewsp_ACT ? s_fe_16b_instr_Q0[4:0] : 5'd0;
    assign i_hw_storewsp_s_fe_func7_imm_D0 = i_hw_storewsp_ACT ? {{4{1'b0}}, {s_fe_16b_instr_Q0[6:5],s_fe_16b_instr_Q0[10]}} : 7'd0;
    assign opc_beqz_comp_codasip_return_MI11opc_br_compIH4_2fe2fe22_19decompressor_16b32b19decompressor_16b32b14_11opc_br_comp3opc_D0 = opc_beqz_comp_ACT ? 5'd25 : 5'd0;
    assign codasip_return_MI11opc_br_compIH4_2fe2fe22_19decompressor_16b32b19decompressor_16b32b14_11opc_br_comp3opc = (opc_beqz_comp_codasip_return_MI11opc_br_compIH4_2fe2fe22_19decompressor_16b32b19decompressor_16b32b14_11opc_br_comp3opc_D0 | opc_bnez_comp_codasip_return_MI11opc_br_compIH4_2fe2fe22_19decompressor_16b32b19decompressor_16b32b14_11opc_br_comp3opc_D0);
    assign opc_bnez_comp_codasip_return_MI11opc_br_compIH4_2fe2fe22_19decompressor_16b32b19decompressor_16b32b14_11opc_br_comp3opc_D0 = opc_bnez_comp_ACT ? 5'd29 : 5'd0;
    assign opc_jalr_comp_codasip_return_MI13opc_jmpr_compIH4_2fe2fe22_19decompressor_16b32b19decompressor_16b32b16_13opc_jmpr_comp3opc_D0 = opc_jalr_comp_ACT ? 6'd38 : 6'd0;
    assign opc_srai_comp_codasip_return_MI12opc_sri_compIH4_2fe2fe22_19decompressor_16b32b19decompressor_16b32b15_12opc_sri_comp3opc_D0 = opc_srai_comp_ACT ? 7'd69 : 7'd0;
    assign codasip_return_MI12opc_sri_compIH4_2fe2fe22_19decompressor_16b32b19decompressor_16b32b15_12opc_sri_comp3opc = (opc_srai_comp_codasip_return_MI12opc_sri_compIH4_2fe2fe22_19decompressor_16b32b19decompressor_16b32b15_12opc_sri_comp3opc_D0 | opc_srli_comp_codasip_return_MI12opc_sri_compIH4_2fe2fe22_19decompressor_16b32b19decompressor_16b32b15_12opc_sri_comp3opc_D0);
    assign opc_srli_comp_codasip_return_MI12opc_sri_compIH4_2fe2fe22_19decompressor_16b32b19decompressor_16b32b15_12opc_sri_comp3opc_D0 = opc_srli_comp_ACT ? 7'd65 : 7'd0;
    assign opc_storewreg_codasip_return_MI12opc_lsw_compIH4_2fe2fe22_19decompressor_16b32b19decompressor_16b32b15_12opc_lsw_comp3opc_D0 = opc_storewreg_ACT ? 5'd24 : 5'd0;
    assign i_hw_addi_comp_s_fe_opcode_D0 = i_hw_addi_comp_ACT ? 7'd19 : 7'd0;
    assign i_hw_addi_comp_s_fe_rd_imm_D0 = i_hw_addi_comp_ACT ? s_fe_16b_instr_Q0[9:5] : 5'd0;
    assign i_hw_addi_comp_s_fe_func3_imm_D0 = i_hw_addi_comp_ACT ? 3'd0 : 3'd0;
    assign i_hw_addi_comp_s_fe_rs1_imm_D0 = i_hw_addi_comp_ACT ? s_fe_16b_instr_Q0[9:5] : 5'd0;
    assign i_hw_addi_comp_s_fe_rs2_imm_D0 = i_hw_addi_comp_ACT ? s_fe_16b_instr_Q0[4:0] : 5'd0;
    assign i_hw_addi_comp_s_fe_func7_imm_D0 = i_hw_addi_comp_ACT ? $unsigned(((s_fe_16b_instr_Q0[10]) ? -7'sd1 : 7'sd0)) : 7'd0;
    assign i_hw_addi_comp_s_fe_16b_instr_inval_imm_D0 = i_hw_addi_comp_ACT ? (({s_fe_16b_instr_Q0[10],s_fe_16b_instr_Q0[4:0]} == 6'd0) && (s_fe_16b_instr_Q0[9:5] != 5'd0)) : 1'd0;
    assign i_hw_addi_comp_s_fe_16b_instr_inval_reg_D0 = i_hw_addi_comp_ACT ? ((s_fe_16b_instr_Q0[9:5] == 5'd0) && ({s_fe_16b_instr_Q0[10],s_fe_16b_instr_Q0[4:0]} != 6'd0)) : 1'd0;
    assign i_hw_andi_comp_s_fe_opcode_D0 = i_hw_andi_comp_ACT ? 7'd19 : 7'd0;
    assign i_hw_andi_comp_s_fe_rd_imm_D0 = i_hw_andi_comp_ACT ? {2'd1,s_fe_16b_instr_Q0[7:5]} : 5'd0;
    assign i_hw_andi_comp_s_fe_func3_imm_D0 = i_hw_andi_comp_ACT ? 3'd7 : 3'd0;
    assign i_hw_andi_comp_s_fe_rs1_imm_D0 = i_hw_andi_comp_ACT ? {2'd1,s_fe_16b_instr_Q0[7:5]} : 5'd0;
    assign i_hw_andi_comp_s_fe_rs2_imm_D0 = i_hw_andi_comp_ACT ? s_fe_16b_instr_Q0[4:0] : 5'd0;
    assign i_hw_andi_comp_s_fe_func7_imm_D0 = i_hw_andi_comp_ACT ? $unsigned(((s_fe_16b_instr_Q0[10]) ? -7'sd1 : 7'sd0)) : 7'd0;
    assign i_hw_slli_comp_s_fe_opcode_D0 = i_hw_slli_comp_ACT ? 7'd19 : 7'd0;
    assign i_hw_slli_comp_s_fe_rd_imm_D0 = i_hw_slli_comp_ACT ? s_fe_16b_instr_Q0[9:5] : 5'd0;
    assign i_hw_slli_comp_s_fe_func3_imm_D0 = i_hw_slli_comp_ACT ? 3'd1 : 3'd0;
    assign i_hw_slli_comp_s_fe_rs1_imm_D0 = i_hw_slli_comp_ACT ? s_fe_16b_instr_Q0[9:5] : 5'd0;
    assign i_hw_slli_comp_s_fe_rs2_imm_D0 = i_hw_slli_comp_ACT ? s_fe_16b_instr_Q0[4:0] : 5'd0;
    assign i_hw_slli_comp_s_fe_func7_imm_D0 = i_hw_slli_comp_ACT ? 7'd0 : 7'd0;
    assign i_hw_slli_comp_s_fe_16b_instr_inval_imm_D0 = i_hw_slli_comp_ACT ? (s_fe_16b_instr_Q0[4:0] == 5'd0) : 1'd0;
    assign i_hw_slli_comp_s_fe_16b_instr_inval_reg_D0 = i_hw_slli_comp_ACT ? (s_fe_16b_instr_Q0[9:5] == 5'd0) : 1'd0;
    assign i_hw_addispn_comp_s_fe_opcode_D0 = i_hw_addispn_comp_ACT ? 7'd19 : 7'd0;
    assign i_hw_addispn_comp_s_fe_rd_imm_D0 = i_hw_addispn_comp_ACT ? {2'd1,s_fe_16b_instr_Q0[2:0]} : 5'd0;
    assign i_hw_addispn_comp_s_fe_func3_imm_D0 = i_hw_addispn_comp_ACT ? 3'd0 : 3'd0;
    assign i_hw_addispn_comp_s_fe_rs1_imm_D0 = i_hw_addispn_comp_ACT ? 5'd2 : 5'd0;
    assign i_hw_addispn_comp_s_fe_rs2_imm_D0 = i_hw_addispn_comp_ACT ? {{{s_fe_16b_instr_Q0[9],s_fe_16b_instr_Q0[3]},s_fe_16b_instr_Q0[4]},2'd0} : 5'd0;
    assign i_hw_addispn_comp_s_fe_func7_imm_D0 = i_hw_addispn_comp_ACT ? {{2{1'b0}}, {s_fe_16b_instr_Q0[8:5],s_fe_16b_instr_Q0[10]}} : 7'd0;
    assign i_hw_addispn_comp_s_fe_16b_instr_inval_imm_D0 = i_hw_addispn_comp_ACT ? ({{{s_fe_16b_instr_Q0[8:5],s_fe_16b_instr_Q0[10:9]},s_fe_16b_instr_Q0[3]},s_fe_16b_instr_Q0[4]} == 8'd0) : 1'd0;
    assign codasip_tmp_var_0_i_hw_compreg_comp_decompressor_16b32b_decompressor_16b32b_fe_fe = codasip_return_MI16opc_compreg_compIH4_2fe2fe22_19decompressor_16b32b19decompressor_16b32b19_16opc_compreg_comp3opc;
    assign i_hw_compreg_comp_s_fe_opcode_D0 = ((((codasip_tmp_var_0_i_hw_compreg_comp_decompressor_16b32b_decompressor_16b32b_fe_fe == 10'd573) || (codasip_tmp_var_0_i_hw_compreg_comp_decompressor_16b32b_decompressor_16b32b_fe_fe == 10'd569)) || (codasip_tmp_var_0_i_hw_compreg_comp_decompressor_16b32b_decompressor_16b32b_fe_fe == 10'd565)) || (codasip_tmp_var_0_i_hw_compreg_comp_decompressor_16b32b_decompressor_16b32b_fe_fe == 10'd561)) ? 7'd51 : 7'd0;
    assign i_hw_compreg_comp_s_fe_opcode_D0_ACT = i_hw_compreg_comp_ACT ? i_hw_compreg_comp_s_fe_opcode_D0 : 7'd0;
    assign i_hw_compreg_comp_s_fe_func3_imm_D0 = (codasip_tmp_var_0_i_hw_compreg_comp_decompressor_16b32b_decompressor_16b32b_fe_fe == 10'd573) ? 3'd7 :
        (codasip_tmp_var_0_i_hw_compreg_comp_decompressor_16b32b_decompressor_16b32b_fe_fe == 10'd569) ? 3'd6 :
        (codasip_tmp_var_0_i_hw_compreg_comp_decompressor_16b32b_decompressor_16b32b_fe_fe == 10'd565) ? 3'd4 :
        (codasip_tmp_var_0_i_hw_compreg_comp_decompressor_16b32b_decompressor_16b32b_fe_fe == 10'd561) ? 3'd0 : 3'd0;
    assign i_hw_compreg_comp_s_fe_func3_imm_D0_ACT = i_hw_compreg_comp_ACT ? i_hw_compreg_comp_s_fe_func3_imm_D0 : 3'd0;
    assign i_hw_compreg_comp_s_fe_func7_imm_D0 = (((codasip_tmp_var_0_i_hw_compreg_comp_decompressor_16b32b_decompressor_16b32b_fe_fe == 10'd573) || (codasip_tmp_var_0_i_hw_compreg_comp_decompressor_16b32b_decompressor_16b32b_fe_fe == 10'd569)) || (codasip_tmp_var_0_i_hw_compreg_comp_decompressor_16b32b_decompressor_16b32b_fe_fe == 10'd565)) ? 7'd0 :
        (codasip_tmp_var_0_i_hw_compreg_comp_decompressor_16b32b_decompressor_16b32b_fe_fe == 10'd561) ? 7'd32 : 7'd0;
    assign i_hw_compreg_comp_s_fe_func7_imm_D0_ACT = i_hw_compreg_comp_ACT ? i_hw_compreg_comp_s_fe_func7_imm_D0 : 7'd0;
    assign i_hw_compreg_comp_s_fe_rd_imm_D0 = i_hw_compreg_comp_ACT ? {2'd1,s_fe_16b_instr_Q0[7:5]} : 5'd0;
    assign i_hw_compreg_comp_s_fe_rs1_imm_D0 = i_hw_compreg_comp_ACT ? {2'd1,s_fe_16b_instr_Q0[7:5]} : 5'd0;
    assign i_hw_compreg_comp_s_fe_rs2_imm_D0 = i_hw_compreg_comp_ACT ? {2'd1,s_fe_16b_instr_Q0[2:0]} : 5'd0;
    assign codasip_tmp_var_0_i_hw_lui_addisp_comp_decompressor_16b32b_decompressor_16b32b_fe_fe = (s_fe_16b_instr_Q0[9:5] == 5'd2);
    assign i_hw_lui_addisp_comp_s_fe_opcode_D0 = codasip_tmp_var_0_i_hw_lui_addisp_comp_decompressor_16b32b_decompressor_16b32b_fe_fe ? 7'd19 : 7'd55;
    assign i_hw_lui_addisp_comp_s_fe_opcode_D0_ACT = i_hw_lui_addisp_comp_ACT ? i_hw_lui_addisp_comp_s_fe_opcode_D0 : 7'd0;
    assign i_hw_lui_addisp_comp_s_fe_func3_imm_D0 = codasip_tmp_var_0_i_hw_lui_addisp_comp_decompressor_16b32b_decompressor_16b32b_fe_fe ? 3'd0 : s_fe_16b_instr_Q0[2:0];
    assign i_hw_lui_addisp_comp_s_fe_func3_imm_D0_ACT = i_hw_lui_addisp_comp_ACT ? i_hw_lui_addisp_comp_s_fe_func3_imm_D0 : 3'd0;
    assign i_hw_lui_addisp_comp_s_fe_rs1_imm_D0 = codasip_tmp_var_0_i_hw_lui_addisp_comp_decompressor_16b32b_decompressor_16b32b_fe_fe ? 5'd2 : $unsigned(tmp_codasip_conv_STATIC_CAST_11281_2);
    assign i_hw_lui_addisp_comp_s_fe_rs1_imm_D0_ACT = i_hw_lui_addisp_comp_ACT ? i_hw_lui_addisp_comp_s_fe_rs1_imm_D0 : 5'd0;
    assign i_hw_lui_addisp_comp_s_fe_rs2_imm_D0 = codasip_tmp_var_0_i_hw_lui_addisp_comp_decompressor_16b32b_decompressor_16b32b_fe_fe ? {s_fe_16b_instr_Q0[4],4'd0} : $unsigned(((s_fe_16b_instr_Q0[10]) ? -5'sd1 : 5'sd0));
    assign i_hw_lui_addisp_comp_s_fe_rs2_imm_D0_ACT = i_hw_lui_addisp_comp_ACT ? i_hw_lui_addisp_comp_s_fe_rs2_imm_D0 : 5'd0;
    assign i_hw_lui_addisp_comp_s_fe_func7_imm_D0 = codasip_tmp_var_0_i_hw_lui_addisp_comp_decompressor_16b32b_decompressor_16b32b_fe_fe ? $unsigned(tmp_codasip_conv_STATIC_CAST_11209_3) : $unsigned(((s_fe_16b_instr_Q0[10]) ? -7'sd1 : 7'sd0));
    assign i_hw_lui_addisp_comp_s_fe_func7_imm_D0_ACT = i_hw_lui_addisp_comp_ACT ? i_hw_lui_addisp_comp_s_fe_func7_imm_D0 : 7'd0;
    assign i_hw_lui_addisp_comp_s_fe_16b_instr_inval_imm_D0 = codasip_tmp_var_0_i_hw_lui_addisp_comp_decompressor_16b32b_decompressor_16b32b_fe_fe ? ({{{{s_fe_16b_instr_Q0[10],s_fe_16b_instr_Q0[2:1]},s_fe_16b_instr_Q0[3]},s_fe_16b_instr_Q0[0]},s_fe_16b_instr_Q0[4]} == 6'd0) : ({s_fe_16b_instr_Q0[10],s_fe_16b_instr_Q0[4:0]} == 6'd0);
    assign i_hw_lui_addisp_comp_s_fe_16b_instr_inval_imm_D0_ACT = i_hw_lui_addisp_comp_ACT ? i_hw_lui_addisp_comp_s_fe_16b_instr_inval_imm_D0 : 1'd0;
    assign i_hw_lui_addisp_comp_s_fe_rd_imm_D0 = i_hw_lui_addisp_comp_ACT ? s_fe_16b_instr_Q0[9:5] : 5'd0;
    assign codasip_tmp_var_0_i_hw_jalr_mvadd_ebreak_comp_decompressor_16b32b_decompressor_16b32b_fe_fe = (s_fe_16b_instr_Q0[9:0] == 10'd0);
    assign i_hw_jalr_mvadd_ebreak_comp_s_fe_opcode_D0 = codasip_tmp_var_0_i_hw_jalr_mvadd_ebreak_comp_decompressor_16b32b_decompressor_16b32b_fe_fe ? 7'd115 :
        codasip_tmp_var_1_i_hw_jalr_mvadd_ebreak_comp_decompressor_16b32b_decompressor_16b32b_fe_fe ? 7'd103 :
        ((codasip_tmp_var_3_i_hw_jalr_mvadd_ebreak_comp_decompressor_16b32b_decompressor_16b32b_fe_fe == 6'd34) || (codasip_tmp_var_3_i_hw_jalr_mvadd_ebreak_comp_decompressor_16b32b_decompressor_16b32b_fe_fe == 6'd38)) ? 7'd51 : 7'd0;
    assign i_hw_jalr_mvadd_ebreak_comp_s_fe_opcode_D0_ACT = i_hw_jalr_mvadd_ebreak_comp_ACT ? i_hw_jalr_mvadd_ebreak_comp_s_fe_opcode_D0 : 7'd0;
    assign i_hw_jalr_mvadd_ebreak_comp_s_fe_rd_imm_D0 = codasip_tmp_var_0_i_hw_jalr_mvadd_ebreak_comp_decompressor_16b32b_decompressor_16b32b_fe_fe ? s_fe_16b_instr_Q0[9:5] :
        (codasip_tmp_var_2_i_hw_jalr_mvadd_ebreak_comp_decompressor_16b32b_decompressor_16b32b_fe_fe == 6'd34) ? 5'd0 :
        (codasip_tmp_var_2_i_hw_jalr_mvadd_ebreak_comp_decompressor_16b32b_decompressor_16b32b_fe_fe == 6'd38) ? 5'd1 :
        ((!codasip_tmp_var_1_i_hw_jalr_mvadd_ebreak_comp_decompressor_16b32b_decompressor_16b32b_fe_fe) && (!codasip_tmp_var_0_i_hw_jalr_mvadd_ebreak_comp_decompressor_16b32b_decompressor_16b32b_fe_fe)) ? s_fe_16b_instr_Q0[9:5] : 5'd0;
    assign i_hw_jalr_mvadd_ebreak_comp_s_fe_rd_imm_D0_ACT = i_hw_jalr_mvadd_ebreak_comp_ACT ? i_hw_jalr_mvadd_ebreak_comp_s_fe_rd_imm_D0 : 5'd0;
    assign i_hw_jalr_mvadd_ebreak_comp_s_fe_func3_imm_D0 = codasip_tmp_var_0_i_hw_jalr_mvadd_ebreak_comp_decompressor_16b32b_decompressor_16b32b_fe_fe ? 3'd0 :
        (((codasip_tmp_var_3_i_hw_jalr_mvadd_ebreak_comp_decompressor_16b32b_decompressor_16b32b_fe_fe == 6'd34) || (codasip_tmp_var_3_i_hw_jalr_mvadd_ebreak_comp_decompressor_16b32b_decompressor_16b32b_fe_fe == 6'd38)) || codasip_tmp_var_1_i_hw_jalr_mvadd_ebreak_comp_decompressor_16b32b_decompressor_16b32b_fe_fe) ? 3'd0 : 3'd0;
    assign i_hw_jalr_mvadd_ebreak_comp_s_fe_func3_imm_D0_ACT = i_hw_jalr_mvadd_ebreak_comp_ACT ? i_hw_jalr_mvadd_ebreak_comp_s_fe_func3_imm_D0 : 3'd0;
    assign i_hw_jalr_mvadd_ebreak_comp_s_fe_rs1_imm_D0 = codasip_tmp_var_0_i_hw_jalr_mvadd_ebreak_comp_decompressor_16b32b_decompressor_16b32b_fe_fe ? s_fe_16b_instr_Q0[9:5] :
        (codasip_tmp_var_3_i_hw_jalr_mvadd_ebreak_comp_decompressor_16b32b_decompressor_16b32b_fe_fe == 6'd34) ? 5'd0 :
        ((codasip_tmp_var_3_i_hw_jalr_mvadd_ebreak_comp_decompressor_16b32b_decompressor_16b32b_fe_fe == 6'd38) || codasip_tmp_var_1_i_hw_jalr_mvadd_ebreak_comp_decompressor_16b32b_decompressor_16b32b_fe_fe) ? s_fe_16b_instr_Q0[9:5] : 5'd0;
    assign i_hw_jalr_mvadd_ebreak_comp_s_fe_rs1_imm_D0_ACT = i_hw_jalr_mvadd_ebreak_comp_ACT ? i_hw_jalr_mvadd_ebreak_comp_s_fe_rs1_imm_D0 : 5'd0;
    assign i_hw_jalr_mvadd_ebreak_comp_s_fe_rs2_imm_D0 = codasip_tmp_var_0_i_hw_jalr_mvadd_ebreak_comp_decompressor_16b32b_decompressor_16b32b_fe_fe ? 5'd1 :
        codasip_tmp_var_1_i_hw_jalr_mvadd_ebreak_comp_decompressor_16b32b_decompressor_16b32b_fe_fe ? 5'd0 : s_fe_16b_instr_Q0[4:0];
    assign i_hw_jalr_mvadd_ebreak_comp_s_fe_rs2_imm_D0_ACT = i_hw_jalr_mvadd_ebreak_comp_ACT ? i_hw_jalr_mvadd_ebreak_comp_s_fe_rs2_imm_D0 : 5'd0;
    assign i_hw_jalr_mvadd_ebreak_comp_s_fe_func7_imm_D0 = codasip_tmp_var_0_i_hw_jalr_mvadd_ebreak_comp_decompressor_16b32b_decompressor_16b32b_fe_fe ? 7'd0 : 7'd0;
    assign i_hw_jalr_mvadd_ebreak_comp_s_fe_func7_imm_D0_ACT = i_hw_jalr_mvadd_ebreak_comp_ACT ? i_hw_jalr_mvadd_ebreak_comp_s_fe_func7_imm_D0 : 7'd0;
    assign i_hw_jalr_mvadd_ebreak_comp_codasip_tmp_var_1_i_hw_jalr_mvadd_ebreak_comp_decompressor_16b32b_decompressor_16b32b_fe_fe_D0 = (!codasip_tmp_var_0_i_hw_jalr_mvadd_ebreak_comp_decompressor_16b32b_decompressor_16b32b_fe_fe) ? (s_fe_16b_instr_Q0[4:0] == 5'd0) : 1'd0;
    assign codasip_tmp_var_1_i_hw_jalr_mvadd_ebreak_comp_decompressor_16b32b_decompressor_16b32b_fe_fe = i_hw_jalr_mvadd_ebreak_comp_codasip_tmp_var_1_i_hw_jalr_mvadd_ebreak_comp_decompressor_16b32b_decompressor_16b32b_fe_fe_D0;
    assign i_hw_jalr_mvadd_ebreak_comp_codasip_tmp_var_2_i_hw_jalr_mvadd_ebreak_comp_decompressor_16b32b_decompressor_16b32b_fe_fe_D0 = codasip_tmp_var_1_i_hw_jalr_mvadd_ebreak_comp_decompressor_16b32b_decompressor_16b32b_fe_fe ? codasip_return_MI13opc_jmpr_compIH4_2fe2fe22_19decompressor_16b32b19decompressor_16b32b16_13opc_jmpr_comp3opc : 6'd0;
    assign codasip_tmp_var_2_i_hw_jalr_mvadd_ebreak_comp_decompressor_16b32b_decompressor_16b32b_fe_fe = i_hw_jalr_mvadd_ebreak_comp_codasip_tmp_var_2_i_hw_jalr_mvadd_ebreak_comp_decompressor_16b32b_decompressor_16b32b_fe_fe_D0;
    assign i_hw_jalr_mvadd_ebreak_comp_codasip_tmp_var_3_i_hw_jalr_mvadd_ebreak_comp_decompressor_16b32b_decompressor_16b32b_fe_fe_D0 = ((!codasip_tmp_var_1_i_hw_jalr_mvadd_ebreak_comp_decompressor_16b32b_decompressor_16b32b_fe_fe) && (!codasip_tmp_var_0_i_hw_jalr_mvadd_ebreak_comp_decompressor_16b32b_decompressor_16b32b_fe_fe)) ? codasip_return_MI13opc_jmpr_compIH4_2fe2fe22_19decompressor_16b32b19decompressor_16b32b16_13opc_jmpr_comp3opc : 6'd0;
    assign codasip_tmp_var_3_i_hw_jalr_mvadd_ebreak_comp_decompressor_16b32b_decompressor_16b32b_fe_fe = i_hw_jalr_mvadd_ebreak_comp_codasip_tmp_var_3_i_hw_jalr_mvadd_ebreak_comp_decompressor_16b32b_decompressor_16b32b_fe_fe_D0;
endmodule
