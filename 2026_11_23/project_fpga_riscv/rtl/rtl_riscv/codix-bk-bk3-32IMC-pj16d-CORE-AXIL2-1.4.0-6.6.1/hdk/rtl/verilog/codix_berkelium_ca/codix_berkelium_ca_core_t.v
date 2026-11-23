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
 *  \brief   Contains module definition of the 'codix_berkelium_ca_core_t' ASIP core.
 */

module codix_berkelium_ca_core_t(
    input  wire CLK,
    input  wire RST,
    input  wire [31:0] if_fetch_Q0,
    input  wire [2:0] if_fetch_RESPONSE0,
    input  wire [1:0] if_fetch_STATUS0,
    input  wire [31:0] if_ldst_Q0,
    input  wire [2:0] if_ldst_RESPONSE0,
    input  wire [1:0] if_ldst_STATUS0,
    input  wire [31:0] nexus_client_r_PC_BSC_D0,
    input  wire nexus_client_r_PC_BSC_UPDATE0,
    input  wire nexus_client_r_PC_DEBUG_MODE,
    input  wire [31:0] nexus_client_rf_gpr_BSC_D0,
    input  wire [1:0] nexus_client_rf_gpr_BSC_UPDATE0,
    input  wire nexus_client_rf_gpr_DEBUG_MODE,
    input  wire p_meip_Q0,
    input  wire p_msip_Q0,
    input  wire p_mtip_Q0,
    input  wire [53:0] predictor_mem_if_read_Q0,
    input  wire s_port_break_en_Q0,
    input  wire s_port_break_hw_Q0,
    output wire codasip_halt_wire_D0_halt_1041,
    output wire [31:0] core_r_ex_pc_Q0_4827,
    output wire core_r_ex_valid_Q0_4830,
    output wire [31:0] if_fetch_A0_npc_925,
    output wire [2:0] if_fetch_BC0_npc_931,
    output wire [1:0] if_fetch_BI0_npc_928,
    output wire [2:0] if_fetch_REQUEST0_npc_922,
    output wire [31:0] if_ldst_A0_ex_memory_1763,
    output wire [2:0] if_ldst_BC0_ex_memory_1769,
    output wire [1:0] if_ldst_BI0_ex_memory_1766,
    output wire [31:0] if_ldst_D0_wb_732,
    output wire [2:0] if_ldst_REQUEST0_ex_memory_1760,
    output wire [31:0] nexus_client_r_PC_BSC_Q0_r_PC_465,
    output wire [31:0] nexus_client_rf_gpr_BSC_Q0_rf_gpr_470,
    output wire p_wfi_D0_ports_1046,
    output wire [7:0] predictor_mem_if_read_A0_npc_949,
    output wire predictor_mem_if_read_BC0_npc_955,
    output wire predictor_mem_if_read_BI0_npc_953,
    output wire [1:0] predictor_mem_if_read_REQUEST0_npc_947,
    output wire [7:0] predictor_mem_if_write_A0_ex_output_1919,
    output wire predictor_mem_if_write_BC0_ex_output_1925,
    output wire predictor_mem_if_write_BI0_ex_output_1922,
    output wire [53:0] predictor_mem_if_write_D0_ex_output_1929,
    output wire [1:0] predictor_mem_if_write_REQUEST0_ex_output_1916,
    output wire s_port_break_sw_D0_jtag_fsm_1651
);
    // type, wire and constant declarations:
    // signal/wire (CodAL)
    wire s_irq;
    // signal/wire (CodAL)
    wire s_sleep;
    // signal/wire (CodAL)
    wire [31:0] s_fe_response_rc;
    // signal/wire (CodAL)
    wire s_fe_rc_fin_ack_ok;
    // signal/wire (CodAL)
    wire s_fe_instr_load;
    // signal/wire (CodAL)
    wire s_fe_inc_pc;
    // signal/wire (CodAL)
    wire [31:0] s_fe_mem_instr;
    // signal/wire (CodAL)
    wire [31:0] s_fe_32b_instr;
    // signal/wire (CodAL)
    wire [59:0] s_fe_pred_data;
    // signal/wire (CodAL)
    wire [30:0] s_fe_pred_taddr;
    // signal/wire (CodAL)
    wire s_fe_pred_taken;
    // signal/wire (CodAL)
    wire s_fe_pred_taken_align;
    // signal/wire (CodAL)
    wire s_fe_inc_pc_align;
    // signal/wire (CodAL)
    wire [15:0] s_fe_16b_instr;
    // signal/wire (CodAL)
    wire s_fe_16b_instr_inval;
    // signal/wire (CodAL)
    wire s_fe_16b_instr_inval_imm;
    // signal/wire (CodAL)
    wire s_fe_16b_instr_inval_reg;
    // signal/wire (CodAL)
    wire s_fe_16b_instr_en;
    // signal/wire (CodAL)
    wire [6:0] s_fe_opcode;
    // signal/wire (CodAL)
    wire [4:0] s_fe_rd_imm;
    // signal/wire (CodAL)
    wire [2:0] s_fe_func3_imm;
    // signal/wire (CodAL)
    wire [4:0] s_fe_rs1_imm;
    // signal/wire (CodAL)
    wire [4:0] s_fe_rs2_imm;
    // signal/wire (CodAL)
    wire [6:0] s_fe_func7_imm;
    // signal/wire (CodAL)
    wire s_ex_ilegal_instr;
    // signal/wire (CodAL)
    wire [31:0] s_ex_jump_addr;
    // signal/wire (CodAL)
    wire s_ex_pc_we;
    // signal/wire (CodAL)
    wire [31:0] s_ex_rs1_data_bypassed;
    // signal/wire (CodAL)
    wire [31:0] s_ex_rs2_data_bypassed;
    // signal/wire (CodAL)
    wire s_ex_raw_hazard;
    // signal/wire (CodAL)
    wire [3:0] s_ex_alu_function;
    // signal/wire (CodAL)
    wire [2:0] s_ex_cmp_function;
    // signal/wire (CodAL)
    wire [3:0] s_ex_sel_imm;
    // signal/wire (CodAL)
    wire s_ex_reg_write;
    // signal/wire (CodAL)
    wire [1:0] s_ex_aluop1_mux;
    // signal/wire (CodAL)
    wire s_ex_aluop2_mux;
    // signal/wire (CodAL)
    wire s_ex_memop;
    // signal/wire (CodAL)
    wire [2:0] s_ex_mem_type;
    // signal/wire (CodAL)
    wire s_ex_branch;
    // signal/wire (CodAL)
    wire s_ex_jal;
    // signal/wire (CodAL)
    wire s_ex_jalr;
    // signal/wire (CodAL)
    wire [2:0] s_ex_mem_cmd;
    // signal/wire (CodAL)
    wire s_ex_inv_all_instr;
    // signal/wire (CodAL)
    wire [2:0] s_ex_csr_funct;
    // signal/wire (CodAL)
    wire s_ex_csr_read;
    // signal/wire (CodAL)
    wire s_ex_csr_write;
    // signal/wire (CodAL)
    wire s_ex_aluop1_signed;
    // signal/wire (CodAL)
    wire s_ex_aluop2_signed;
    // signal/wire (CodAL)
    wire s_ex_mulh;
    // signal/wire (CodAL)
    wire [31:0] s_ex_mul_div_result;
    // signal/wire (CodAL)
    wire s_ex_mul_div_stall;
    // signal/wire (CodAL)
    wire [59:0] s_ex_pred_data;
    // signal/wire (CodAL)
    wire [31:0] s_ex_add_result;
    // signal/wire (CodAL)
    wire [31:0] s_ex_result;
    // signal/wire (CodAL)
    wire s_ex_cmp_true;
    // signal/wire (CodAL)
    wire s_ex_request_stall;
    // signal/wire (CodAL)
    wire s_ex_stall_ex;
    // signal/wire (CodAL)
    wire s_ex_stall;
    // signal/wire (CodAL)
    wire s_ex_clear;
    // signal/wire (CodAL)
    wire s_ex_mem_error;
    // signal/wire (CodAL)
    wire [31:0] s_wb_next_pc;
    // signal/wire (CodAL)
    wire s_wb_reg_write_bypass;
    // signal/wire (CodAL)
    wire [31:0] s_wb_csr_data;
    // signal/wire (CodAL)
    wire s_wb_finish_stall;
    // signal/wire (CodAL)
    wire s_wb_stall_wb;
    // signal/wire (CodAL)
    wire s_wb_stall;
    // signal/wire (CodAL)
    wire s_wb_clear;
    // signal/wire (CodAL)
    wire [31:0] s_wb_mem;
    // signal/wire (CodAL)
    wire s_wb_mem_error;
    // signal/wire (CodAL)
    wire s_wb_mem_unaligned;
    // signal/wire (CodAL)
    wire s_wb_exc;
    // signal/wire (CodAL)
    wire s_wb_mret;
    // signal/wire (CodAL)
    wire s_wb_irq_taken;
    // signal/wire (CodAL)
    wire s_wb_irq;
    // signal/wire (CodAL)
    wire s_ex_activation_ack;
    // signal/wire (CodAL)
    wire s_wb_activation_ack;
    // signal/wire (CodAL)
    wire s_sw_break_req;
    // signal/wire (CodAL)
    wire s_hw_break_req;
    // signal/wire (CodAL)
    wire s_debug_mode_req;
    // signal/wire (CodAL)
    wire s_user_mode_req;
    // signal/wire (CodAL)
    wire s_debug_mode_ready;
    // signal/wire (CodAL)
    wire s_user_mode_ready;
    // signal/wire (inner)
    wire [31:0] codasip_return2_barrel_shifter_32_inline_1_inline_1;

    // additional declarations:
    wire pipeline_control_r_sleep_WE0_0;
    wire pipeline_control_r_sleep_D0_1;
    wire r_sleep_Q0_2;
    wire npc_r_fe_inv_all_pending_WE0_3;
    wire npc_r_fe_inv_all_pending_D0_4;
    wire r_fe_inv_all_pending_Q0_5;
    wire npc_r_fe_request_ready_WE0_6;
    wire npc_r_fe_request_ready_D0_7;
    wire r_fe_request_ready_Q0_8;
    wire fe_r_fe_instr_buf0_full_WE0_9;
    wire fe_r_fe_instr_buf0_full_D0_10;
    wire r_fe_instr_buf0_full_Q0_11;
    wire ex_output_r_pred_valid_bits_WE0_12;
    wire [15:0] ex_output_r_pred_valid_bits_D0_13;
    wire [15:0] r_pred_valid_bits_Q0_14;
    wire fe_r_fe_instr_buf1_WE0_15;
    wire [31:0] fe_r_fe_instr_buf1_D0_16;
    wire [31:0] r_fe_instr_buf1_Q0_17;
    wire fe_r_fe_instr_buf1_full_WE0_18;
    wire fe_r_fe_instr_buf1_full_D0_19;
    wire r_fe_instr_buf1_full_Q0_20;
    wire npc_r_fe_exc_WE0_21;
    wire npc_r_fe_exc_D0_22;
    wire r_fe_exc_Q0_23;
    wire npc_r_fe_exc_code_WE0_24;
    wire [3:0] npc_r_fe_exc_code_D0_25;
    wire [3:0] r_fe_exc_code_Q0_26;
    wire npc_r_fe_exc_instr_addr_WE0_27;
    wire [31:0] npc_r_fe_exc_instr_addr_D0_28;
    wire [31:0] r_fe_exc_instr_addr_Q0_29;
    wire pipe_EX_clear_Q0_30;
    wire pipe_EX_stall_Q0_31;
    wire fe_output_r_ex_instr_WE0_32;
    wire [31:0] fe_output_r_ex_instr_D0_33;
    wire [31:0] r_ex_instr_Q0_34;
    wire fe_output_r_ex_instr_val_WE0_35;
    wire fe_output_r_ex_instr_val_D0_36;
    wire r_ex_instr_val_Q0_37;
    wire fe_output_r_ex_16b_instr_WE0_38;
    wire fe_output_r_ex_16b_instr_D0_39;
    wire r_ex_16b_instr_Q0_40;
    wire fe_output_r_ex_pc_WE0_41;
    wire [31:0] fe_output_r_ex_pc_D0_42;
    wire [31:0] r_ex_pc_Q0_43;
    wire fe_r_ex_pred_bits_WE0_44;
    wire [1:0] fe_r_ex_pred_bits_D0_45;
    wire [1:0] r_ex_pred_bits_Q0_46;
    wire fe_r_ex_pred_taddr_WE0_47;
    wire [30:0] fe_r_ex_pred_taddr_D0_48;
    wire [30:0] r_ex_pred_taddr_Q0_49;
    wire fe_output_r_ex_exc_WE0_50;
    wire fe_output_r_ex_exc_D0_51;
    wire r_ex_exc_Q0_52;
    wire fe_output_r_ex_exc_code_WE0_53;
    wire [3:0] fe_output_r_ex_exc_code_D0_54;
    wire [3:0] r_ex_exc_code_Q0_55;
    wire fe_output_r_ex_exc_instr_addr_WE0_56;
    wire [31:0] fe_output_r_ex_exc_instr_addr_D0_57;
    wire [31:0] r_ex_exc_instr_addr_Q0_58;
    wire pipe_WB_clear_Q0_59;
    wire pipe_WB_stall_Q0_60;
    wire ex_output_r_wb_instr_val_WE0_61;
    wire ex_output_r_wb_instr_val_D0_62;
    wire r_wb_instr_val_Q0_63;
    wire ex_output_r_wb_16b_instr_WE0_64;
    wire ex_output_r_wb_16b_instr_D0_65;
    wire r_wb_16b_instr_Q0_66;
    wire ex_output_r_wb_instr_fin_WE0_67;
    wire ex_output_r_wb_instr_fin_D0_68;
    wire r_wb_instr_fin_Q0_69;
    wire ex_output_r_wb_pc_WE0_70;
    wire [31:0] ex_output_r_wb_pc_D0_71;
    wire [31:0] r_wb_pc_Q0_72;
    wire ex_output_r_wb_result_WE0_73;
    wire [31:0] ex_output_r_wb_result_D0_74;
    wire [31:0] r_wb_result_Q0_75;
    wire ex_output_r_wb_addrW_WE0_76;
    wire [4:0] ex_output_r_wb_addrW_D0_77;
    wire [4:0] r_wb_addrW_Q0_78;
    wire ex_output_r_wb_reg_write_WE0_79;
    wire ex_output_r_wb_reg_write_D0_80;
    wire r_wb_reg_write_Q0_81;
    wire ex_output_r_wb_memop_WE0_82;
    wire ex_output_r_wb_memop_D0_83;
    wire r_wb_memop_Q0_84;
    wire ex_output_r_wb_mem_type_WE0_85;
    wire [2:0] ex_output_r_wb_mem_type_D0_86;
    wire [2:0] r_wb_mem_type_Q0_87;
    wire ex_output_r_wb_mem_cmd_WE0_88;
    wire [2:0] ex_output_r_wb_mem_cmd_D0_89;
    wire [2:0] r_wb_mem_cmd_Q0_90;
    wire ex_output_r_wb_writedata_WE0_91;
    wire [31:0] ex_output_r_wb_writedata_D0_92;
    wire [31:0] r_wb_writedata_Q0_93;
    wire ex_output_r_wb_zimm_WE0_94;
    wire [4:0] ex_output_r_wb_zimm_D0_95;
    wire [4:0] r_wb_zimm_Q0_96;
    wire ex_output_r_wb_csr_funct_WE0_97;
    wire [2:0] ex_output_r_wb_csr_funct_D0_98;
    wire [2:0] r_wb_csr_funct_Q0_99;
    wire ex_output_r_wb_csr_addr_WE0_100;
    wire [11:0] ex_output_r_wb_csr_addr_D0_101;
    wire [11:0] r_wb_csr_addr_Q0_102;
    wire ex_output_r_wb_csr_data_WE0_103;
    wire [31:0] ex_output_r_wb_csr_data_D0_104;
    wire [31:0] r_wb_csr_data_Q0_105;
    wire ex_output_r_wb_csr_read_WE0_106;
    wire ex_output_r_wb_csr_read_D0_107;
    wire r_wb_csr_read_Q0_108;
    wire ex_output_r_wb_csr_write_WE0_109;
    wire ex_output_r_wb_csr_write_D0_110;
    wire r_wb_csr_write_Q0_111;
    wire ex_output_r_wb_save_return_addr_WE0_112;
    wire ex_output_r_wb_save_return_addr_D0_113;
    wire r_wb_save_return_addr_Q0_114;
    wire ex_output_r_wb_branch_ex_WE0_115;
    wire ex_output_r_wb_branch_ex_D0_116;
    wire r_wb_branch_ex_Q0_117;
    wire ex_output_r_wb_wfi_WE0_118;
    wire ex_output_r_wb_wfi_D0_119;
    wire r_wb_wfi_Q0_120;
    wire ex_output_r_wb_exc_WE0_121;
    wire ex_output_r_wb_exc_D0_122;
    wire r_wb_exc_Q0_123;
    wire ex_output_r_wb_exc_code_WE0_124;
    wire [3:0] ex_output_r_wb_exc_code_D0_125;
    wire [3:0] r_wb_exc_code_Q0_126;
    wire ex_output_r_wb_exc_instr_addr_WE0_127;
    wire [31:0] ex_output_r_wb_exc_instr_addr_D0_128;
    wire [31:0] r_wb_exc_instr_addr_Q0_129;
    wire ex_output_r_wb_halt_WE0_130;
    wire ex_output_r_wb_halt_D0_131;
    wire r_wb_halt_Q0_132;
    wire fe_output_r_fe_reload_WE0_133;
    wire fe_output_r_fe_reload_D0_134;
    wire r_fe_reload_Q0_135;
    wire fe_output_r_ex_valid_WE0_136;
    wire fe_output_r_ex_valid_D0_137;
    wire r_ex_valid_Q0_138;
    wire jtag_fsm_r_debug_state_WE0_139;
    wire [2:0] jtag_fsm_r_debug_state_D0_140;
    wire [2:0] r_debug_state_Q0_141;
    wire csr_file_r_csr_mtvec_WE0_142;
    wire [31:0] csr_file_r_csr_mtvec_D0_143;
    wire [31:0] r_csr_mtvec_Q0_144;
    wire csr_file_r_csr_mscratch_WE0_145;
    wire [31:0] csr_file_r_csr_mscratch_D0_146;
    wire [31:0] r_csr_mscratch_Q0_147;
    wire [31:0] npc_r_PC_D0_148;
    wire npc_r_PC_WE0_149;
    wire [31:0] r_PC_Q0_150;
    wire [31:0] rf_gpr_D0_151;
    wire [31:0] reset_rf_gpr_D0_152;
    wire [31:0] wb_output_rf_gpr_D0_153;
    wire [4:0] ex_rf_gpr_RA0_154;
    wire [4:0] ex_rf_gpr_RA1_155;
    wire ex_rf_gpr_RE0_156;
    wire ex_rf_gpr_RE1_157;
    wire [4:0] rf_gpr_WA0_158;
    wire [4:0] reset_rf_gpr_WA0_159;
    wire [4:0] wb_output_rf_gpr_WA0_160;
    wire rf_gpr_WE0_161;
    wire reset_rf_gpr_WE0_162;
    wire wb_output_rf_gpr_WE0_163;
    wire [31:0] rf_gpr_Q0_164;
    wire [31:0] rf_gpr_Q1_165;
    wire csr_file_r_csr_mbadaddr_WE0_166;
    wire [31:0] csr_file_r_csr_mbadaddr_D0_167;
    wire [31:0] r_csr_mbadaddr_Q0_168;
    wire csr_file_r_csr_mstatus_WE0_169;
    wire [31:0] csr_file_r_csr_mstatus_D0_170;
    wire [31:0] r_csr_mstatus_Q0_171;
    wire csr_file_r_csr_mepc_WE0_172;
    wire [31:0] csr_file_r_csr_mepc_D0_173;
    wire [31:0] r_csr_mepc_Q0_174;
    wire csr_file_r_csr_mie_WE0_175;
    wire [31:0] csr_file_r_csr_mie_D0_176;
    wire [31:0] r_csr_mie_Q0_177;
    wire csr_file_r_csr_mcause_WE0_178;
    wire [31:0] csr_file_r_csr_mcause_D0_179;
    wire [31:0] r_csr_mcause_Q0_180;
    wire ex_ex_mul_div_ACT_181;
    wire main_pipeline_control_ACT_182;
    wire pipeline_control_pipe_EX_clear_D0_183;
    wire pipeline_control_pipe_EX_stall_D0_184;
    wire pipeline_control_pipe_WB_clear_D0_185;
    wire pipeline_control_pipe_WB_stall_D0_186;
    wire main_wb_ACT_187;
    wire ex_alu_barrel_shifter_32_inline_1_inline_1_ACT_188;
    wire [3:0] ex_alu_barrel_shifter_32_inline_1_inline_1_codasip_param_0_189;
    wire [31:0] ex_alu_barrel_shifter_32_inline_1_inline_1_codasip_param_1_190;
    wire [4:0] ex_alu_barrel_shifter_32_inline_1_inline_1_codasip_param_2_191;
    wire main_npc_ACT_192;
    wire wb_output_halt_ACT_193;
    wire main_ports_ACT_194;
    wire codasip_startup_ctrl_reset_ACT_195;
    wire reset_FIN_196;
    wire ex_ex_alu_ACT_197;
    wire ex_ex_cmp_ACT_198;
    wire main_csr_file_ACT_199;
    wire main_jtag_fsm_ACT_200;
    wire ex_ex_memory_ACT_201;
    wire ex_ex_output_ACT_202;
    wire fe_fe_output_ACT_203;
    wire main_wb_output_ACT_204;
    wire main_ex_ACT_205;
    wire dec_codasip_param_1_206;
    wire ex_dec_ACT_207;
    wire [31:0] ex_dec_codasip_param_0_208;
    wire main_fe_ACT_209;
    wire decompressor_16b32b_codasip_param_1_210;
    wire fe_decompressor_16b32b_ACT_211;
    wire [15:0] fe_decompressor_16b32b_codasip_param_0_212;
    wire codasip_startup_ctrl_main_ACT_213;

    // child instances inside 'core' ASIP core:
    // instance of 'r_sleep' register:
    d_ff_plain_rst_we_t #(
        .bit_width(32'd1),
        .default_value(1'b0),
        .reset_level(1'b0),
        .reset_sync(1'b0)
    ) r_sleep (
        .CLK(CLK),
        .RST(RST),
        .WE0(pipeline_control_r_sleep_WE0_0),
        .D0(pipeline_control_r_sleep_D0_1),
        .Q0(r_sleep_Q0_2)
    );

    // instance of 'r_fe_inv_all_pending' register:
    d_ff_plain_rst_we_t #(
        .bit_width(32'd1),
        .default_value(1'b0),
        .reset_level(1'b0),
        .reset_sync(1'b0)
    ) r_fe_inv_all_pending (
        .CLK(CLK),
        .RST(RST),
        .WE0(npc_r_fe_inv_all_pending_WE0_3),
        .D0(npc_r_fe_inv_all_pending_D0_4),
        .Q0(r_fe_inv_all_pending_Q0_5)
    );

    // instance of 'r_fe_request_ready' register:
    d_ff_plain_rst_we_t #(
        .bit_width(32'd1),
        .default_value(1'b0),
        .reset_level(1'b0),
        .reset_sync(1'b0)
    ) r_fe_request_ready (
        .CLK(CLK),
        .RST(RST),
        .WE0(npc_r_fe_request_ready_WE0_6),
        .D0(npc_r_fe_request_ready_D0_7),
        .Q0(r_fe_request_ready_Q0_8)
    );

    // instance of 'r_fe_instr_buf0_full' register:
    d_ff_plain_rst_we_t #(
        .bit_width(32'd1),
        .default_value(1'b0),
        .reset_level(1'b0),
        .reset_sync(1'b0)
    ) r_fe_instr_buf0_full (
        .CLK(CLK),
        .RST(RST),
        .WE0(fe_r_fe_instr_buf0_full_WE0_9),
        .D0(fe_r_fe_instr_buf0_full_D0_10),
        .Q0(r_fe_instr_buf0_full_Q0_11)
    );

    // instance of 'r_pred_valid_bits' register:
    d_ff_plain_rst_we_t #(
        .bit_width(32'd16),
        .default_value(16'b0),
        .reset_level(1'b0),
        .reset_sync(1'b0)
    ) r_pred_valid_bits (
        .CLK(CLK),
        .RST(RST),
        .WE0(ex_output_r_pred_valid_bits_WE0_12),
        .D0(ex_output_r_pred_valid_bits_D0_13),
        .Q0(r_pred_valid_bits_Q0_14)
    );

    // instance of 'r_fe_instr_buf1' register:
    d_ff_plain_rst_we_t #(
        .bit_width(32'd32),
        .default_value(32'b0),
        .reset_level(1'b0),
        .reset_sync(1'b0)
    ) r_fe_instr_buf1 (
        .CLK(CLK),
        .RST(RST),
        .WE0(fe_r_fe_instr_buf1_WE0_15),
        .D0(fe_r_fe_instr_buf1_D0_16),
        .Q0(r_fe_instr_buf1_Q0_17)
    );

    // instance of 'r_fe_instr_buf1_full' register:
    d_ff_plain_rst_we_t #(
        .bit_width(32'd1),
        .default_value(1'b0),
        .reset_level(1'b0),
        .reset_sync(1'b0)
    ) r_fe_instr_buf1_full (
        .CLK(CLK),
        .RST(RST),
        .WE0(fe_r_fe_instr_buf1_full_WE0_18),
        .D0(fe_r_fe_instr_buf1_full_D0_19),
        .Q0(r_fe_instr_buf1_full_Q0_20)
    );

    // instance of 'r_fe_exc' register:
    d_ff_plain_rst_we_t #(
        .bit_width(32'd1),
        .default_value(1'b0),
        .reset_level(1'b0),
        .reset_sync(1'b0)
    ) r_fe_exc (
        .CLK(CLK),
        .RST(RST),
        .WE0(npc_r_fe_exc_WE0_21),
        .D0(npc_r_fe_exc_D0_22),
        .Q0(r_fe_exc_Q0_23)
    );

    // instance of 'r_fe_exc_code' register:
    d_ff_plain_rst_we_t #(
        .bit_width(32'd4),
        .default_value(4'b0),
        .reset_level(1'b0),
        .reset_sync(1'b0)
    ) r_fe_exc_code (
        .CLK(CLK),
        .RST(RST),
        .WE0(npc_r_fe_exc_code_WE0_24),
        .D0(npc_r_fe_exc_code_D0_25),
        .Q0(r_fe_exc_code_Q0_26)
    );

    // instance of 'r_fe_exc_instr_addr' register:
    d_ff_plain_rst_we_t #(
        .bit_width(32'd32),
        .default_value(32'b0),
        .reset_level(1'b0),
        .reset_sync(1'b0)
    ) r_fe_exc_instr_addr (
        .CLK(CLK),
        .RST(RST),
        .WE0(npc_r_fe_exc_instr_addr_WE0_27),
        .D0(npc_r_fe_exc_instr_addr_D0_28),
        .Q0(r_fe_exc_instr_addr_Q0_29)
    );

    // instance of 'r_ex_instr' register:
    d_ff_pipeline_rst_we_t #(
        .bit_width(32'd32),
        .default_value(32'b00000000000000000000000000010011),
        .reset_level(1'b0),
        .reset_sync(1'b0)
    ) r_ex_instr (
        .CLK(CLK),
        .RST(RST),
        .CLEAR(pipe_EX_clear_Q0_30),
        .STALL(pipe_EX_stall_Q0_31),
        .WE0(fe_output_r_ex_instr_WE0_32),
        .D0(fe_output_r_ex_instr_D0_33),
        .Q0(r_ex_instr_Q0_34)
    );

    // instance of 'r_ex_instr_val' register:
    d_ff_pipeline_rst_we_t #(
        .bit_width(32'd1),
        .default_value(1'b0),
        .reset_level(1'b0),
        .reset_sync(1'b0)
    ) r_ex_instr_val (
        .CLK(CLK),
        .RST(RST),
        .CLEAR(pipe_EX_clear_Q0_30),
        .STALL(pipe_EX_stall_Q0_31),
        .WE0(fe_output_r_ex_instr_val_WE0_35),
        .D0(fe_output_r_ex_instr_val_D0_36),
        .Q0(r_ex_instr_val_Q0_37)
    );

    // instance of 'r_ex_16b_instr' register:
    d_ff_pipeline_rst_we_t #(
        .bit_width(32'd1),
        .default_value(1'b0),
        .reset_level(1'b0),
        .reset_sync(1'b0)
    ) r_ex_16b_instr (
        .CLK(CLK),
        .RST(RST),
        .CLEAR(pipe_EX_clear_Q0_30),
        .STALL(pipe_EX_stall_Q0_31),
        .WE0(fe_output_r_ex_16b_instr_WE0_38),
        .D0(fe_output_r_ex_16b_instr_D0_39),
        .Q0(r_ex_16b_instr_Q0_40)
    );

    // instance of 'r_ex_pc' register:
    d_ff_pipeline_rst_we_t #(
        .bit_width(32'd32),
        .default_value(32'b0),
        .reset_level(1'b0),
        .reset_sync(1'b0)
    ) r_ex_pc (
        .CLK(CLK),
        .RST(RST),
        .CLEAR(pipe_EX_clear_Q0_30),
        .STALL(pipe_EX_stall_Q0_31),
        .WE0(fe_output_r_ex_pc_WE0_41),
        .D0(fe_output_r_ex_pc_D0_42),
        .Q0(r_ex_pc_Q0_43)
    );
    assign core_r_ex_pc_Q0_4827 = r_ex_pc_Q0_43;

    // instance of 'r_ex_pred_bits' register:
    d_ff_pipeline_rst_we_t #(
        .bit_width(32'd2),
        .default_value(2'b0),
        .reset_level(1'b0),
        .reset_sync(1'b0)
    ) r_ex_pred_bits (
        .CLK(CLK),
        .RST(RST),
        .CLEAR(pipe_EX_clear_Q0_30),
        .STALL(pipe_EX_stall_Q0_31),
        .WE0(fe_r_ex_pred_bits_WE0_44),
        .D0(fe_r_ex_pred_bits_D0_45),
        .Q0(r_ex_pred_bits_Q0_46)
    );

    // instance of 'r_ex_pred_taddr' register:
    d_ff_pipeline_rst_we_t #(
        .bit_width(32'd31),
        .default_value(31'b0),
        .reset_level(1'b0),
        .reset_sync(1'b0)
    ) r_ex_pred_taddr (
        .CLK(CLK),
        .RST(RST),
        .CLEAR(pipe_EX_clear_Q0_30),
        .STALL(pipe_EX_stall_Q0_31),
        .WE0(fe_r_ex_pred_taddr_WE0_47),
        .D0(fe_r_ex_pred_taddr_D0_48),
        .Q0(r_ex_pred_taddr_Q0_49)
    );

    // instance of 'r_ex_exc' register:
    d_ff_pipeline_rst_we_t #(
        .bit_width(32'd1),
        .default_value(1'b0),
        .reset_level(1'b0),
        .reset_sync(1'b0)
    ) r_ex_exc (
        .CLK(CLK),
        .RST(RST),
        .CLEAR(pipe_EX_clear_Q0_30),
        .STALL(pipe_EX_stall_Q0_31),
        .WE0(fe_output_r_ex_exc_WE0_50),
        .D0(fe_output_r_ex_exc_D0_51),
        .Q0(r_ex_exc_Q0_52)
    );

    // instance of 'r_ex_exc_code' register:
    d_ff_pipeline_rst_we_t #(
        .bit_width(32'd4),
        .default_value(4'b0),
        .reset_level(1'b0),
        .reset_sync(1'b0)
    ) r_ex_exc_code (
        .CLK(CLK),
        .RST(RST),
        .CLEAR(pipe_EX_clear_Q0_30),
        .STALL(pipe_EX_stall_Q0_31),
        .WE0(fe_output_r_ex_exc_code_WE0_53),
        .D0(fe_output_r_ex_exc_code_D0_54),
        .Q0(r_ex_exc_code_Q0_55)
    );

    // instance of 'r_ex_exc_instr_addr' register:
    d_ff_pipeline_rst_we_t #(
        .bit_width(32'd32),
        .default_value(32'b0),
        .reset_level(1'b0),
        .reset_sync(1'b0)
    ) r_ex_exc_instr_addr (
        .CLK(CLK),
        .RST(RST),
        .CLEAR(pipe_EX_clear_Q0_30),
        .STALL(pipe_EX_stall_Q0_31),
        .WE0(fe_output_r_ex_exc_instr_addr_WE0_56),
        .D0(fe_output_r_ex_exc_instr_addr_D0_57),
        .Q0(r_ex_exc_instr_addr_Q0_58)
    );

    // instance of 'r_wb_instr_val' register:
    d_ff_pipeline_rst_we_t #(
        .bit_width(32'd1),
        .default_value(1'b0),
        .reset_level(1'b0),
        .reset_sync(1'b0)
    ) r_wb_instr_val (
        .CLK(CLK),
        .RST(RST),
        .CLEAR(pipe_WB_clear_Q0_59),
        .STALL(pipe_WB_stall_Q0_60),
        .WE0(ex_output_r_wb_instr_val_WE0_61),
        .D0(ex_output_r_wb_instr_val_D0_62),
        .Q0(r_wb_instr_val_Q0_63)
    );

    // instance of 'r_wb_16b_instr' register:
    d_ff_pipeline_rst_we_t #(
        .bit_width(32'd1),
        .default_value(1'b0),
        .reset_level(1'b0),
        .reset_sync(1'b0)
    ) r_wb_16b_instr (
        .CLK(CLK),
        .RST(RST),
        .CLEAR(pipe_WB_clear_Q0_59),
        .STALL(pipe_WB_stall_Q0_60),
        .WE0(ex_output_r_wb_16b_instr_WE0_64),
        .D0(ex_output_r_wb_16b_instr_D0_65),
        .Q0(r_wb_16b_instr_Q0_66)
    );

    // instance of 'r_wb_instr_fin' register:
    d_ff_pipeline_rst_we_t #(
        .bit_width(32'd1),
        .default_value(1'b0),
        .reset_level(1'b0),
        .reset_sync(1'b0)
    ) r_wb_instr_fin (
        .CLK(CLK),
        .RST(RST),
        .CLEAR(pipe_WB_clear_Q0_59),
        .STALL(pipe_WB_stall_Q0_60),
        .WE0(ex_output_r_wb_instr_fin_WE0_67),
        .D0(ex_output_r_wb_instr_fin_D0_68),
        .Q0(r_wb_instr_fin_Q0_69)
    );

    // instance of 'r_wb_pc' register:
    d_ff_pipeline_rst_we_t #(
        .bit_width(32'd32),
        .default_value(32'b0),
        .reset_level(1'b0),
        .reset_sync(1'b0)
    ) r_wb_pc (
        .CLK(CLK),
        .RST(RST),
        .CLEAR(pipe_WB_clear_Q0_59),
        .STALL(pipe_WB_stall_Q0_60),
        .WE0(ex_output_r_wb_pc_WE0_70),
        .D0(ex_output_r_wb_pc_D0_71),
        .Q0(r_wb_pc_Q0_72)
    );

    // instance of 'r_wb_result' register:
    d_ff_pipeline_rst_we_t #(
        .bit_width(32'd32),
        .default_value(32'b0),
        .reset_level(1'b0),
        .reset_sync(1'b0)
    ) r_wb_result (
        .CLK(CLK),
        .RST(RST),
        .CLEAR(pipe_WB_clear_Q0_59),
        .STALL(pipe_WB_stall_Q0_60),
        .WE0(ex_output_r_wb_result_WE0_73),
        .D0(ex_output_r_wb_result_D0_74),
        .Q0(r_wb_result_Q0_75)
    );

    // instance of 'r_wb_addrW' register:
    d_ff_pipeline_rst_we_t #(
        .bit_width(32'd5),
        .default_value(5'b0),
        .reset_level(1'b0),
        .reset_sync(1'b0)
    ) r_wb_addrW (
        .CLK(CLK),
        .RST(RST),
        .CLEAR(pipe_WB_clear_Q0_59),
        .STALL(pipe_WB_stall_Q0_60),
        .WE0(ex_output_r_wb_addrW_WE0_76),
        .D0(ex_output_r_wb_addrW_D0_77),
        .Q0(r_wb_addrW_Q0_78)
    );

    // instance of 'r_wb_reg_write' register:
    d_ff_pipeline_rst_we_t #(
        .bit_width(32'd1),
        .default_value(1'b0),
        .reset_level(1'b0),
        .reset_sync(1'b0)
    ) r_wb_reg_write (
        .CLK(CLK),
        .RST(RST),
        .CLEAR(pipe_WB_clear_Q0_59),
        .STALL(pipe_WB_stall_Q0_60),
        .WE0(ex_output_r_wb_reg_write_WE0_79),
        .D0(ex_output_r_wb_reg_write_D0_80),
        .Q0(r_wb_reg_write_Q0_81)
    );

    // instance of 'r_wb_memop' register:
    d_ff_pipeline_rst_we_t #(
        .bit_width(32'd1),
        .default_value(1'b0),
        .reset_level(1'b0),
        .reset_sync(1'b0)
    ) r_wb_memop (
        .CLK(CLK),
        .RST(RST),
        .CLEAR(pipe_WB_clear_Q0_59),
        .STALL(pipe_WB_stall_Q0_60),
        .WE0(ex_output_r_wb_memop_WE0_82),
        .D0(ex_output_r_wb_memop_D0_83),
        .Q0(r_wb_memop_Q0_84)
    );

    // instance of 'r_wb_mem_type' register:
    d_ff_pipeline_rst_we_t #(
        .bit_width(32'd3),
        .default_value(3'b0),
        .reset_level(1'b0),
        .reset_sync(1'b0)
    ) r_wb_mem_type (
        .CLK(CLK),
        .RST(RST),
        .CLEAR(pipe_WB_clear_Q0_59),
        .STALL(pipe_WB_stall_Q0_60),
        .WE0(ex_output_r_wb_mem_type_WE0_85),
        .D0(ex_output_r_wb_mem_type_D0_86),
        .Q0(r_wb_mem_type_Q0_87)
    );

    // instance of 'r_wb_mem_cmd' register:
    d_ff_pipeline_rst_we_t #(
        .bit_width(32'd3),
        .default_value(3'b0),
        .reset_level(1'b0),
        .reset_sync(1'b0)
    ) r_wb_mem_cmd (
        .CLK(CLK),
        .RST(RST),
        .CLEAR(pipe_WB_clear_Q0_59),
        .STALL(pipe_WB_stall_Q0_60),
        .WE0(ex_output_r_wb_mem_cmd_WE0_88),
        .D0(ex_output_r_wb_mem_cmd_D0_89),
        .Q0(r_wb_mem_cmd_Q0_90)
    );

    // instance of 'r_wb_writedata' register:
    d_ff_pipeline_rst_we_t #(
        .bit_width(32'd32),
        .default_value(32'b0),
        .reset_level(1'b0),
        .reset_sync(1'b0)
    ) r_wb_writedata (
        .CLK(CLK),
        .RST(RST),
        .CLEAR(pipe_WB_clear_Q0_59),
        .STALL(pipe_WB_stall_Q0_60),
        .WE0(ex_output_r_wb_writedata_WE0_91),
        .D0(ex_output_r_wb_writedata_D0_92),
        .Q0(r_wb_writedata_Q0_93)
    );

    // instance of 'r_wb_zimm' register:
    d_ff_plain_rst_we_t #(
        .bit_width(32'd5),
        .default_value(5'b0),
        .reset_level(1'b0),
        .reset_sync(1'b0)
    ) r_wb_zimm (
        .CLK(CLK),
        .RST(RST),
        .WE0(ex_output_r_wb_zimm_WE0_94),
        .D0(ex_output_r_wb_zimm_D0_95),
        .Q0(r_wb_zimm_Q0_96)
    );

    // instance of 'r_wb_csr_funct' register:
    d_ff_pipeline_rst_we_t #(
        .bit_width(32'd3),
        .default_value(3'b0),
        .reset_level(1'b0),
        .reset_sync(1'b0)
    ) r_wb_csr_funct (
        .CLK(CLK),
        .RST(RST),
        .CLEAR(pipe_WB_clear_Q0_59),
        .STALL(pipe_WB_stall_Q0_60),
        .WE0(ex_output_r_wb_csr_funct_WE0_97),
        .D0(ex_output_r_wb_csr_funct_D0_98),
        .Q0(r_wb_csr_funct_Q0_99)
    );

    // instance of 'r_wb_csr_addr' register:
    d_ff_plain_rst_we_t #(
        .bit_width(32'd12),
        .default_value(12'b0),
        .reset_level(1'b0),
        .reset_sync(1'b0)
    ) r_wb_csr_addr (
        .CLK(CLK),
        .RST(RST),
        .WE0(ex_output_r_wb_csr_addr_WE0_100),
        .D0(ex_output_r_wb_csr_addr_D0_101),
        .Q0(r_wb_csr_addr_Q0_102)
    );

    // instance of 'r_wb_csr_data' register:
    d_ff_plain_rst_we_t #(
        .bit_width(32'd32),
        .default_value(32'b0),
        .reset_level(1'b0),
        .reset_sync(1'b0)
    ) r_wb_csr_data (
        .CLK(CLK),
        .RST(RST),
        .WE0(ex_output_r_wb_csr_data_WE0_103),
        .D0(ex_output_r_wb_csr_data_D0_104),
        .Q0(r_wb_csr_data_Q0_105)
    );

    // instance of 'r_wb_csr_read' register:
    d_ff_pipeline_rst_we_t #(
        .bit_width(32'd1),
        .default_value(1'b0),
        .reset_level(1'b0),
        .reset_sync(1'b0)
    ) r_wb_csr_read (
        .CLK(CLK),
        .RST(RST),
        .CLEAR(pipe_WB_clear_Q0_59),
        .STALL(pipe_WB_stall_Q0_60),
        .WE0(ex_output_r_wb_csr_read_WE0_106),
        .D0(ex_output_r_wb_csr_read_D0_107),
        .Q0(r_wb_csr_read_Q0_108)
    );

    // instance of 'r_wb_csr_write' register:
    d_ff_pipeline_rst_we_t #(
        .bit_width(32'd1),
        .default_value(1'b0),
        .reset_level(1'b0),
        .reset_sync(1'b0)
    ) r_wb_csr_write (
        .CLK(CLK),
        .RST(RST),
        .CLEAR(pipe_WB_clear_Q0_59),
        .STALL(pipe_WB_stall_Q0_60),
        .WE0(ex_output_r_wb_csr_write_WE0_109),
        .D0(ex_output_r_wb_csr_write_D0_110),
        .Q0(r_wb_csr_write_Q0_111)
    );

    // instance of 'r_wb_save_return_addr' register:
    d_ff_pipeline_rst_we_t #(
        .bit_width(32'd1),
        .default_value(1'b0),
        .reset_level(1'b0),
        .reset_sync(1'b0)
    ) r_wb_save_return_addr (
        .CLK(CLK),
        .RST(RST),
        .CLEAR(pipe_WB_clear_Q0_59),
        .STALL(pipe_WB_stall_Q0_60),
        .WE0(ex_output_r_wb_save_return_addr_WE0_112),
        .D0(ex_output_r_wb_save_return_addr_D0_113),
        .Q0(r_wb_save_return_addr_Q0_114)
    );

    // instance of 'r_wb_branch_ex' register:
    d_ff_pipeline_rst_we_t #(
        .bit_width(32'd1),
        .default_value(1'b0),
        .reset_level(1'b0),
        .reset_sync(1'b0)
    ) r_wb_branch_ex (
        .CLK(CLK),
        .RST(RST),
        .CLEAR(pipe_WB_clear_Q0_59),
        .STALL(pipe_WB_stall_Q0_60),
        .WE0(ex_output_r_wb_branch_ex_WE0_115),
        .D0(ex_output_r_wb_branch_ex_D0_116),
        .Q0(r_wb_branch_ex_Q0_117)
    );

    // instance of 'r_wb_wfi' register:
    d_ff_pipeline_rst_we_t #(
        .bit_width(32'd1),
        .default_value(1'b0),
        .reset_level(1'b0),
        .reset_sync(1'b0)
    ) r_wb_wfi (
        .CLK(CLK),
        .RST(RST),
        .CLEAR(pipe_WB_clear_Q0_59),
        .STALL(pipe_WB_stall_Q0_60),
        .WE0(ex_output_r_wb_wfi_WE0_118),
        .D0(ex_output_r_wb_wfi_D0_119),
        .Q0(r_wb_wfi_Q0_120)
    );

    // instance of 'r_wb_exc' register:
    d_ff_pipeline_rst_we_t #(
        .bit_width(32'd1),
        .default_value(1'b0),
        .reset_level(1'b0),
        .reset_sync(1'b0)
    ) r_wb_exc (
        .CLK(CLK),
        .RST(RST),
        .CLEAR(pipe_WB_clear_Q0_59),
        .STALL(pipe_WB_stall_Q0_60),
        .WE0(ex_output_r_wb_exc_WE0_121),
        .D0(ex_output_r_wb_exc_D0_122),
        .Q0(r_wb_exc_Q0_123)
    );

    // instance of 'r_wb_exc_code' register:
    d_ff_pipeline_rst_we_t #(
        .bit_width(32'd4),
        .default_value(4'b0),
        .reset_level(1'b0),
        .reset_sync(1'b0)
    ) r_wb_exc_code (
        .CLK(CLK),
        .RST(RST),
        .CLEAR(pipe_WB_clear_Q0_59),
        .STALL(pipe_WB_stall_Q0_60),
        .WE0(ex_output_r_wb_exc_code_WE0_124),
        .D0(ex_output_r_wb_exc_code_D0_125),
        .Q0(r_wb_exc_code_Q0_126)
    );

    // instance of 'r_wb_exc_instr_addr' register:
    d_ff_pipeline_rst_we_t #(
        .bit_width(32'd32),
        .default_value(32'b0),
        .reset_level(1'b0),
        .reset_sync(1'b0)
    ) r_wb_exc_instr_addr (
        .CLK(CLK),
        .RST(RST),
        .CLEAR(pipe_EX_clear_Q0_30),
        .STALL(pipe_EX_stall_Q0_31),
        .WE0(ex_output_r_wb_exc_instr_addr_WE0_127),
        .D0(ex_output_r_wb_exc_instr_addr_D0_128),
        .Q0(r_wb_exc_instr_addr_Q0_129)
    );

    // instance of 'r_wb_halt' register:
    d_ff_plain_rst_we_t #(
        .bit_width(32'd1),
        .default_value(1'b0),
        .reset_level(1'b0),
        .reset_sync(1'b0)
    ) r_wb_halt (
        .CLK(CLK),
        .RST(RST),
        .WE0(ex_output_r_wb_halt_WE0_130),
        .D0(ex_output_r_wb_halt_D0_131),
        .Q0(r_wb_halt_Q0_132)
    );

    // instance of 'r_fe_reload' register:
    d_ff_plain_rst_we_t #(
        .bit_width(32'd1),
        .default_value(1'b0),
        .reset_level(1'b0),
        .reset_sync(1'b0)
    ) r_fe_reload (
        .CLK(CLK),
        .RST(RST),
        .WE0(fe_output_r_fe_reload_WE0_133),
        .D0(fe_output_r_fe_reload_D0_134),
        .Q0(r_fe_reload_Q0_135)
    );

    // instance of 'r_ex_valid' register:
    d_ff_pipeline_rst_we_t #(
        .bit_width(32'd1),
        .default_value(1'b0),
        .reset_level(1'b0),
        .reset_sync(1'b0)
    ) r_ex_valid (
        .CLK(CLK),
        .RST(RST),
        .CLEAR(pipe_EX_clear_Q0_30),
        .STALL(pipe_EX_stall_Q0_31),
        .WE0(fe_output_r_ex_valid_WE0_136),
        .D0(fe_output_r_ex_valid_D0_137),
        .Q0(r_ex_valid_Q0_138)
    );
    assign core_r_ex_valid_Q0_4830 = r_ex_valid_Q0_138;

    // instance of 'r_debug_state' register:
    d_ff_plain_rst_we_t #(
        .bit_width(32'd3),
        .default_value(3'b0),
        .reset_level(1'b0),
        .reset_sync(1'b0)
    ) r_debug_state (
        .CLK(CLK),
        .RST(RST),
        .WE0(jtag_fsm_r_debug_state_WE0_139),
        .D0(jtag_fsm_r_debug_state_D0_140),
        .Q0(r_debug_state_Q0_141)
    );

    // instance of 'r_csr_mtvec' register:
    d_ff_plain_rst_we_t #(
        .bit_width(32'd32),
        .default_value(32'b00000000000000000001000000000000),
        .reset_level(1'b0),
        .reset_sync(1'b0)
    ) r_csr_mtvec (
        .CLK(CLK),
        .RST(RST),
        .WE0(csr_file_r_csr_mtvec_WE0_142),
        .D0(csr_file_r_csr_mtvec_D0_143),
        .Q0(r_csr_mtvec_Q0_144)
    );

    // instance of 'r_csr_mscratch' register:
    d_ff_plain_rst_we_t #(
        .bit_width(32'd32),
        .default_value(32'b0),
        .reset_level(1'b0),
        .reset_sync(1'b0)
    ) r_csr_mscratch (
        .CLK(CLK),
        .RST(RST),
        .WE0(csr_file_r_csr_mscratch_WE0_145),
        .D0(csr_file_r_csr_mscratch_D0_146),
        .Q0(r_csr_mscratch_Q0_147)
    );

    // instance of 'r_PC' register:
    bsc_d_ff_plain_rst_we_t #(
        .bit_width(32'd32),
        .default_value(32'b00000000000000000001000000000000),
        .reset_level(1'b0),
        .reset_sync(1'b0)
    ) r_PC (
        .CLK(CLK),
        .RST(RST),
        .BSC_D0(nexus_client_r_PC_BSC_D0),
        .BSC_UPDATE0(nexus_client_r_PC_BSC_UPDATE0),
        .D0(npc_r_PC_D0_148),
        .DEBUG_MODE(nexus_client_r_PC_DEBUG_MODE),
        .WE0(npc_r_PC_WE0_149),
        .BSC_Q0(nexus_client_r_PC_BSC_Q0_r_PC_465),
        .Q0(r_PC_Q0_150)
    );

    // instance of 'rf_gpr' CodAL register file with boundary scan-chain support:
    codix_berkelium_ca_core_rf_gpr_t rf_gpr (
        .CLK(CLK),
        .RST(RST),
        .BSC_D0(nexus_client_rf_gpr_BSC_D0),
        .BSC_UPDATE0(nexus_client_rf_gpr_BSC_UPDATE0),
        .D0(rf_gpr_D0_151),
        .DEBUG_MODE(nexus_client_rf_gpr_DEBUG_MODE),
        .RA0(ex_rf_gpr_RA0_154),
        .RA1(ex_rf_gpr_RA1_155),
        .RE0(ex_rf_gpr_RE0_156),
        .RE1(ex_rf_gpr_RE1_157),
        .WA0(rf_gpr_WA0_158),
        .WE0(rf_gpr_WE0_161),
        .BSC_Q0(nexus_client_rf_gpr_BSC_Q0_rf_gpr_470),
        .Q0(rf_gpr_Q0_164),
        .Q1(rf_gpr_Q1_165)
    );
    assign rf_gpr_D0_151 = reset_rf_gpr_D0_152 |
        wb_output_rf_gpr_D0_153;
    assign rf_gpr_WA0_158 = reset_rf_gpr_WA0_159 |
        wb_output_rf_gpr_WA0_160;
    assign rf_gpr_WE0_161 = reset_rf_gpr_WE0_162 |
        wb_output_rf_gpr_WE0_163;

    // instance of 'r_csr_mbadaddr' register:
    d_ff_plain_rst_we_t #(
        .bit_width(32'd32),
        .default_value(32'b0),
        .reset_level(1'b0),
        .reset_sync(1'b0)
    ) r_csr_mbadaddr (
        .CLK(CLK),
        .RST(RST),
        .WE0(csr_file_r_csr_mbadaddr_WE0_166),
        .D0(csr_file_r_csr_mbadaddr_D0_167),
        .Q0(r_csr_mbadaddr_Q0_168)
    );

    // instance of 'r_csr_mstatus' register:
    d_ff_plain_rst_we_t #(
        .bit_width(32'd32),
        .default_value(32'b0),
        .reset_level(1'b0),
        .reset_sync(1'b0)
    ) r_csr_mstatus (
        .CLK(CLK),
        .RST(RST),
        .WE0(csr_file_r_csr_mstatus_WE0_169),
        .D0(csr_file_r_csr_mstatus_D0_170),
        .Q0(r_csr_mstatus_Q0_171)
    );

    // instance of 'r_csr_mepc' register:
    d_ff_plain_rst_we_t #(
        .bit_width(32'd32),
        .default_value(32'b0),
        .reset_level(1'b0),
        .reset_sync(1'b0)
    ) r_csr_mepc (
        .CLK(CLK),
        .RST(RST),
        .WE0(csr_file_r_csr_mepc_WE0_172),
        .D0(csr_file_r_csr_mepc_D0_173),
        .Q0(r_csr_mepc_Q0_174)
    );

    // instance of 'r_csr_mie' register:
    d_ff_plain_rst_we_t #(
        .bit_width(32'd32),
        .default_value(32'b0),
        .reset_level(1'b0),
        .reset_sync(1'b0)
    ) r_csr_mie (
        .CLK(CLK),
        .RST(RST),
        .WE0(csr_file_r_csr_mie_WE0_175),
        .D0(csr_file_r_csr_mie_D0_176),
        .Q0(r_csr_mie_Q0_177)
    );

    // instance of 'r_csr_mcause' register:
    d_ff_plain_rst_we_t #(
        .bit_width(32'd32),
        .default_value(32'b0),
        .reset_level(1'b0),
        .reset_sync(1'b0)
    ) r_csr_mcause (
        .CLK(CLK),
        .RST(RST),
        .WE0(csr_file_r_csr_mcause_WE0_178),
        .D0(csr_file_r_csr_mcause_D0_179),
        .Q0(r_csr_mcause_Q0_180)
    );

    // instance of 'ex_mul_div' functional unit:
    codix_berkelium_ca_core_ex_mul_div_t ex_mul_div (
        .CLK(CLK),
        .RST(RST),
        .ACT(ex_ex_mul_div_ACT_181),
        .s_ex_alu_function_Q0(s_ex_alu_function),
        .s_ex_aluop1_signed_Q0(s_ex_aluop1_signed),
        .s_ex_aluop2_signed_Q0(s_ex_aluop2_signed),
        .s_ex_mulh_Q0(s_ex_mulh),
        .s_ex_raw_hazard_Q0(s_ex_raw_hazard),
        .s_ex_rs1_data_bypassed_Q0(s_ex_rs1_data_bypassed),
        .s_ex_rs2_data_bypassed_Q0(s_ex_rs2_data_bypassed),
        .s_sleep_Q0(s_sleep),
        .s_wb_exc_Q0(s_wb_exc),
        .s_wb_irq_Q0(s_wb_irq),
        .s_wb_mret_Q0(s_wb_mret),
        .s_wb_stall_wb_Q0(s_wb_stall_wb),
        .s_ex_mul_div_result_D0(s_ex_mul_div_result),
        .s_ex_mul_div_stall_D0(s_ex_mul_div_stall)
    );

    // instance of 'pipeline_control' functional unit:
    codix_berkelium_ca_core_pipeline_control_t pipeline_control (
        .ACT(main_pipeline_control_ACT_182),
        .r_debug_state_Q0(r_debug_state_Q0_141),
        .s_ex_clear_Q0(s_ex_clear),
        .s_ex_stall_Q0(s_ex_stall),
        .s_irq_Q0(s_irq),
        .s_sleep_Q0(s_sleep),
        .s_user_mode_req_Q0(s_user_mode_req),
        .s_wb_clear_Q0(s_wb_clear),
        .s_wb_stall_Q0(s_wb_stall),
        .pipe_EX_clear_D0(pipeline_control_pipe_EX_clear_D0_183),
        .pipe_EX_stall_D0(pipeline_control_pipe_EX_stall_D0_184),
        .pipe_WB_clear_D0(pipeline_control_pipe_WB_clear_D0_185),
        .pipe_WB_stall_D0(pipeline_control_pipe_WB_stall_D0_186),
        .r_sleep_D0(pipeline_control_r_sleep_D0_1),
        .r_sleep_WE0(pipeline_control_r_sleep_WE0_0)
    );

    // instance of 'wb' functional unit:
    codix_berkelium_ca_core_wb_t wb (
        .ACT(main_wb_ACT_187),
        .if_ldst_Q0(if_ldst_Q0),
        .if_ldst_RESPONSE0(if_ldst_RESPONSE0),
        .r_wb_mem_type_Q0(r_wb_mem_type_Q0_87),
        .r_wb_memop_Q0(r_wb_memop_Q0_84),
        .r_wb_writedata_Q0(r_wb_writedata_Q0_93),
        .s_wb_finish_stall_Q0(s_wb_finish_stall),
        .if_ldst_D0(if_ldst_D0_wb_732),
        .s_wb_finish_stall_D0(s_wb_finish_stall),
        .s_wb_mem_D0(s_wb_mem),
        .s_wb_mem_error_D0(s_wb_mem_error),
        .s_wb_mem_unaligned_D0(s_wb_mem_unaligned),
        .s_wb_stall_wb_D0(s_wb_stall_wb)
    );

    // instance of 'barrel_shifter_32_inline_1_inline_1' functional unit:
    codix_berkelium_ca_core_barrel_shifter_32_inline_1_inline_1_t barrel_shifter_32_inline_1_inline_1 (
        .ACT(ex_alu_barrel_shifter_32_inline_1_inline_1_ACT_188),
        .codasip_param_0(ex_alu_barrel_shifter_32_inline_1_inline_1_codasip_param_0_189),
        .codasip_param_1(ex_alu_barrel_shifter_32_inline_1_inline_1_codasip_param_1_190),
        .codasip_param_2(ex_alu_barrel_shifter_32_inline_1_inline_1_codasip_param_2_191),
        .RET(codasip_return2_barrel_shifter_32_inline_1_inline_1)
    );

    // instance of 'npc' functional unit:
    codix_berkelium_ca_core_npc_t npc (
        .CLK(CLK),
        .RST(RST),
        .ACT(main_npc_ACT_192),
        .if_fetch_STATUS0(if_fetch_STATUS0),
        .r_csr_mepc_Q0(r_csr_mepc_Q0_174),
        .r_csr_mtvec_Q0(r_csr_mtvec_Q0_144),
        .r_ex_pc_Q0(r_ex_pc_Q0_43),
        .r_fe_inv_all_pending_Q0(r_fe_inv_all_pending_Q0_5),
        .r_PC_Q0(r_PC_Q0_150),
        .s_ex_inv_all_instr_Q0(s_ex_inv_all_instr),
        .s_ex_jump_addr_Q0(s_ex_jump_addr),
        .s_ex_pc_we_Q0(s_ex_pc_we),
        .s_ex_stall_ex_Q0(s_ex_stall_ex),
        .s_fe_16b_instr_en_Q0(s_fe_16b_instr_en),
        .s_fe_inc_pc_align_Q0(s_fe_inc_pc_align),
        .s_fe_inc_pc_Q0(s_fe_inc_pc),
        .s_fe_pred_taddr_Q0(s_fe_pred_taddr),
        .s_fe_pred_taken_align_Q0(s_fe_pred_taken_align),
        .s_fe_pred_taken_Q0(s_fe_pred_taken),
        .s_fe_rc_fin_ack_ok_Q0(s_fe_rc_fin_ack_ok),
        .s_sleep_Q0(s_sleep),
        .s_wb_exc_Q0(s_wb_exc),
        .s_wb_mret_Q0(s_wb_mret),
        .s_wb_stall_wb_Q0(s_wb_stall_wb),
        .if_fetch_A0(if_fetch_A0_npc_925),
        .if_fetch_BC0(if_fetch_BC0_npc_931),
        .if_fetch_BI0(if_fetch_BI0_npc_928),
        .if_fetch_REQUEST0(if_fetch_REQUEST0_npc_922),
        .predictor_mem_if_read_A0(predictor_mem_if_read_A0_npc_949),
        .predictor_mem_if_read_BC0(predictor_mem_if_read_BC0_npc_955),
        .predictor_mem_if_read_BI0(predictor_mem_if_read_BI0_npc_953),
        .predictor_mem_if_read_REQUEST0(predictor_mem_if_read_REQUEST0_npc_947),
        .r_fe_exc_code_D0(npc_r_fe_exc_code_D0_25),
        .r_fe_exc_code_WE0(npc_r_fe_exc_code_WE0_24),
        .r_fe_exc_D0(npc_r_fe_exc_D0_22),
        .r_fe_exc_instr_addr_D0(npc_r_fe_exc_instr_addr_D0_28),
        .r_fe_exc_instr_addr_WE0(npc_r_fe_exc_instr_addr_WE0_27),
        .r_fe_exc_WE0(npc_r_fe_exc_WE0_21),
        .r_fe_inv_all_pending_D0(npc_r_fe_inv_all_pending_D0_4),
        .r_fe_inv_all_pending_WE0(npc_r_fe_inv_all_pending_WE0_3),
        .r_fe_request_ready_D0(npc_r_fe_request_ready_D0_7),
        .r_fe_request_ready_WE0(npc_r_fe_request_ready_WE0_6),
        .r_PC_D0(npc_r_PC_D0_148),
        .r_PC_WE0(npc_r_PC_WE0_149),
        .s_ex_clear_D0(s_ex_clear),
        .s_ex_stall_D0(s_ex_stall),
        .s_wb_clear_D0(s_wb_clear),
        .s_wb_stall_D0(s_wb_stall)
    );

    // instance of 'halt' functional unit:
    codix_berkelium_ca_core_halt_t halt (
        .ACT(wb_output_halt_ACT_193),
        .codasip_halt_wire_D0(codasip_halt_wire_D0_halt_1041)
    );

    // instance of 'ports' functional unit:
    codix_berkelium_ca_core_ports_t ports (
        .ACT(main_ports_ACT_194),
        .r_debug_state_Q0(r_debug_state_Q0_141),
        .r_sleep_Q0(r_sleep_Q0_2),
        .p_wfi_D0(p_wfi_D0_ports_1046)
    );

    // instance of 'reset' functional unit:
    codix_berkelium_ca_core_reset_t reset (
        .CLK(CLK),
        .RST(RST),
        .ACT(codasip_startup_ctrl_reset_ACT_195),
        .FIN(reset_FIN_196),
        .rf_gpr_D0(reset_rf_gpr_D0_152),
        .rf_gpr_WA0(reset_rf_gpr_WA0_159),
        .rf_gpr_WE0(reset_rf_gpr_WE0_162)
    );

    // instance of 'ex_alu' functional unit:
    codix_berkelium_ca_core_ex_alu_t ex_alu (
        .ACT(ex_ex_alu_ACT_197),
        .codasip_return2_barrel_shifter_32_inline_1_inline_1_Q0(codasip_return2_barrel_shifter_32_inline_1_inline_1),
        .r_ex_instr_Q0(r_ex_instr_Q0_34[31:7]),
        .r_ex_pc_Q0(r_ex_pc_Q0_43),
        .s_ex_alu_function_Q0(s_ex_alu_function),
        .s_ex_aluop1_mux_Q0(s_ex_aluop1_mux),
        .s_ex_aluop2_mux_Q0(s_ex_aluop2_mux),
        .s_ex_mul_div_result_Q0(s_ex_mul_div_result),
        .s_ex_rs1_data_bypassed_Q0(s_ex_rs1_data_bypassed),
        .s_ex_rs2_data_bypassed_Q0(s_ex_rs2_data_bypassed),
        .s_ex_sel_imm_Q0(s_ex_sel_imm),
        .barrel_shifter_32_inline_1_inline_1_ACT(ex_alu_barrel_shifter_32_inline_1_inline_1_ACT_188),
        .barrel_shifter_32_inline_1_inline_1_codasip_param_0(ex_alu_barrel_shifter_32_inline_1_inline_1_codasip_param_0_189),
        .barrel_shifter_32_inline_1_inline_1_codasip_param_1(ex_alu_barrel_shifter_32_inline_1_inline_1_codasip_param_1_190),
        .barrel_shifter_32_inline_1_inline_1_codasip_param_2(ex_alu_barrel_shifter_32_inline_1_inline_1_codasip_param_2_191),
        .s_ex_add_result_D0(s_ex_add_result),
        .s_ex_result_D0(s_ex_result)
    );

    // instance of 'ex_cmp' functional unit:
    codix_berkelium_ca_core_ex_cmp_t ex_cmp (
        .ACT(ex_ex_cmp_ACT_198),
        .s_ex_cmp_function_Q0(s_ex_cmp_function),
        .s_ex_rs1_data_bypassed_Q0(s_ex_rs1_data_bypassed),
        .s_ex_rs2_data_bypassed_Q0(s_ex_rs2_data_bypassed),
        .s_ex_cmp_true_D0(s_ex_cmp_true)
    );

    // instance of 'csr_file' functional unit:
    codix_berkelium_ca_core_csr_file_t csr_file (
        .CLK(CLK),
        .RST(RST),
        .ACT(main_csr_file_ACT_199),
        .p_meip_Q0(p_meip_Q0),
        .p_msip_Q0(p_msip_Q0),
        .p_mtip_Q0(p_mtip_Q0),
        .r_csr_mbadaddr_Q0(r_csr_mbadaddr_Q0_168),
        .r_csr_mcause_Q0(r_csr_mcause_Q0_180),
        .r_csr_mepc_Q0(r_csr_mepc_Q0_174),
        .r_csr_mie_Q0(r_csr_mie_Q0_177),
        .r_csr_mscratch_Q0(r_csr_mscratch_Q0_147),
        .r_csr_mstatus_Q0(r_csr_mstatus_Q0_171),
        .r_csr_mtvec_Q0(r_csr_mtvec_Q0_144),
        .r_wb_16b_instr_Q0(r_wb_16b_instr_Q0_66),
        .r_wb_addrW_Q0(r_wb_addrW_Q0_78),
        .r_wb_branch_ex_Q0(r_wb_branch_ex_Q0_117),
        .r_wb_csr_addr_Q0(r_wb_csr_addr_Q0_102),
        .r_wb_csr_data_Q0(r_wb_csr_data_Q0_105),
        .r_wb_csr_funct_Q0(r_wb_csr_funct_Q0_99),
        .r_wb_csr_read_Q0(r_wb_csr_read_Q0_108),
        .r_wb_csr_write_Q0(r_wb_csr_write_Q0_111),
        .r_wb_exc_code_Q0(r_wb_exc_code_Q0_126),
        .r_wb_exc_instr_addr_Q0(r_wb_exc_instr_addr_Q0_129),
        .r_wb_exc_Q0(r_wb_exc_Q0_123),
        .r_wb_instr_fin_Q0(r_wb_instr_fin_Q0_69),
        .r_wb_instr_val_Q0(r_wb_instr_val_Q0_63),
        .r_wb_mem_cmd_Q0(r_wb_mem_cmd_Q0_90),
        .r_wb_pc_Q0(r_wb_pc_Q0_72),
        .r_wb_result_Q0(r_wb_result_Q0_75),
        .r_wb_zimm_Q0(r_wb_zimm_Q0_96),
        .s_irq_Q0(s_irq),
        .s_wb_csr_data_Q0(s_wb_csr_data),
        .s_wb_irq_Q0(s_wb_irq),
        .s_wb_irq_taken_Q0(s_wb_irq_taken),
        .s_wb_mem_error_Q0(s_wb_mem_error),
        .s_wb_mem_unaligned_Q0(s_wb_mem_unaligned),
        .s_wb_next_pc_Q0(s_wb_next_pc),
        .s_wb_stall_wb_Q0(s_wb_stall_wb),
        .r_csr_mbadaddr_D0(csr_file_r_csr_mbadaddr_D0_167),
        .r_csr_mbadaddr_WE0(csr_file_r_csr_mbadaddr_WE0_166),
        .r_csr_mcause_D0(csr_file_r_csr_mcause_D0_179),
        .r_csr_mcause_WE0(csr_file_r_csr_mcause_WE0_178),
        .r_csr_mepc_D0(csr_file_r_csr_mepc_D0_173),
        .r_csr_mepc_WE0(csr_file_r_csr_mepc_WE0_172),
        .r_csr_mie_D0(csr_file_r_csr_mie_D0_176),
        .r_csr_mie_WE0(csr_file_r_csr_mie_WE0_175),
        .r_csr_mscratch_D0(csr_file_r_csr_mscratch_D0_146),
        .r_csr_mscratch_WE0(csr_file_r_csr_mscratch_WE0_145),
        .r_csr_mstatus_D0(csr_file_r_csr_mstatus_D0_170),
        .r_csr_mstatus_WE0(csr_file_r_csr_mstatus_WE0_169),
        .r_csr_mtvec_D0(csr_file_r_csr_mtvec_D0_143),
        .r_csr_mtvec_WE0(csr_file_r_csr_mtvec_WE0_142),
        .s_wb_csr_data_D0(s_wb_csr_data),
        .s_wb_exc_D0(s_wb_exc),
        .s_wb_irq_D0(s_wb_irq),
        .s_wb_irq_taken_D0(s_wb_irq_taken),
        .s_wb_mret_D0(s_wb_mret),
        .s_wb_next_pc_D0(s_wb_next_pc)
    );

    // instance of 'jtag_fsm' functional unit:
    codix_berkelium_ca_core_jtag_fsm_t jtag_fsm (
        .ACT(main_jtag_fsm_ACT_200),
        .r_debug_state_Q0(r_debug_state_Q0_141),
        .s_debug_mode_ready_Q0(s_debug_mode_ready),
        .s_debug_mode_req_Q0(s_debug_mode_req),
        .s_ex_activation_ack_Q0(s_ex_activation_ack),
        .s_port_break_hw_Q0(s_port_break_hw_Q0),
        .s_user_mode_ready_Q0(s_user_mode_ready),
        .s_user_mode_req_Q0(s_user_mode_req),
        .s_wb_activation_ack_Q0(s_wb_activation_ack),
        .s_wb_stall_Q0(s_wb_stall),
        .r_debug_state_D0(jtag_fsm_r_debug_state_D0_140),
        .r_debug_state_WE0(jtag_fsm_r_debug_state_WE0_139),
        .s_debug_mode_ready_D0(s_debug_mode_ready),
        .s_port_break_sw_D0(s_port_break_sw_D0_jtag_fsm_1651),
        .s_user_mode_ready_D0(s_user_mode_ready)
    );

    // instance of 'ex_memory' functional unit:
    codix_berkelium_ca_core_ex_memory_t ex_memory (
        .ACT(ex_ex_memory_ACT_201),
        .if_ldst_STATUS0(if_ldst_STATUS0),
        .s_ex_add_result_Q0(s_ex_add_result),
        .s_ex_mem_cmd_Q0(s_ex_mem_cmd),
        .s_ex_mem_type_Q0(s_ex_mem_type),
        .s_ex_memop_Q0(s_ex_memop),
        .s_ex_mul_div_stall_Q0(s_ex_mul_div_stall),
        .s_ex_raw_hazard_Q0(s_ex_raw_hazard),
        .s_ex_request_stall_Q0(s_ex_request_stall),
        .s_wb_exc_Q0(s_wb_exc),
        .s_wb_irq_Q0(s_wb_irq),
        .s_wb_mret_Q0(s_wb_mret),
        .if_ldst_A0(if_ldst_A0_ex_memory_1763),
        .if_ldst_BC0(if_ldst_BC0_ex_memory_1769),
        .if_ldst_BI0(if_ldst_BI0_ex_memory_1766),
        .if_ldst_REQUEST0(if_ldst_REQUEST0_ex_memory_1760),
        .s_ex_mem_error_D0(s_ex_mem_error),
        .s_ex_request_stall_D0(s_ex_request_stall),
        .s_ex_stall_ex_D0(s_ex_stall_ex)
    );

    // instance of 'ex_output' functional unit:
    codix_berkelium_ca_core_ex_output_t ex_output (
        .ACT(ex_ex_output_ACT_202),
        .r_ex_16b_instr_Q0(r_ex_16b_instr_Q0_40),
        .r_ex_exc_code_Q0(r_ex_exc_code_Q0_55),
        .r_ex_exc_instr_addr_Q0(r_ex_exc_instr_addr_Q0_58),
        .r_ex_exc_Q0(r_ex_exc_Q0_52),
        .r_ex_instr_Q0(r_ex_instr_Q0_34[31:7]),
        .r_ex_instr_val_Q0(r_ex_instr_val_Q0_37),
        .r_ex_pc_Q0(r_ex_pc_Q0_43),
        .r_ex_pred_bits_Q0(r_ex_pred_bits_Q0_46),
        .r_ex_pred_taddr_Q0(r_ex_pred_taddr_Q0_49),
        .r_pred_valid_bits_Q0(r_pred_valid_bits_Q0_14),
        .s_ex_add_result_Q0(s_ex_add_result),
        .s_ex_alu_function_Q0(s_ex_alu_function),
        .s_ex_branch_Q0(s_ex_branch),
        .s_ex_cmp_true_Q0(s_ex_cmp_true),
        .s_ex_csr_funct_Q0(s_ex_csr_funct),
        .s_ex_csr_read_Q0(s_ex_csr_read),
        .s_ex_csr_write_Q0(s_ex_csr_write),
        .s_ex_ilegal_instr_Q0(s_ex_ilegal_instr),
        .s_ex_inv_all_instr_Q0(s_ex_inv_all_instr),
        .s_ex_jal_Q0(s_ex_jal),
        .s_ex_jalr_Q0(s_ex_jalr),
        .s_ex_mem_cmd_Q0(s_ex_mem_cmd),
        .s_ex_mem_error_Q0(s_ex_mem_error),
        .s_ex_mem_type_Q0(s_ex_mem_type),
        .s_ex_memop_Q0(s_ex_memop),
        .s_ex_mul_div_stall_Q0(s_ex_mul_div_stall),
        .s_ex_pred_data_Q0(s_ex_pred_data[53:0]),
        .s_ex_raw_hazard_Q0(s_ex_raw_hazard),
        .s_ex_reg_write_Q0(s_ex_reg_write),
        .s_ex_request_stall_Q0(s_ex_request_stall),
        .s_ex_result_Q0(s_ex_result),
        .s_ex_rs1_data_bypassed_Q0(s_ex_rs1_data_bypassed),
        .s_ex_rs2_data_bypassed_Q0(s_ex_rs2_data_bypassed),
        .s_sleep_Q0(s_sleep),
        .s_wb_exc_Q0(s_wb_exc),
        .s_wb_mret_Q0(s_wb_mret),
        .s_wb_stall_wb_Q0(s_wb_stall_wb),
        .predictor_mem_if_write_A0(predictor_mem_if_write_A0_ex_output_1919),
        .predictor_mem_if_write_BC0(predictor_mem_if_write_BC0_ex_output_1925),
        .predictor_mem_if_write_BI0(predictor_mem_if_write_BI0_ex_output_1922),
        .predictor_mem_if_write_D0(predictor_mem_if_write_D0_ex_output_1929),
        .predictor_mem_if_write_REQUEST0(predictor_mem_if_write_REQUEST0_ex_output_1916),
        .r_pred_valid_bits_D0(ex_output_r_pred_valid_bits_D0_13),
        .r_pred_valid_bits_WE0(ex_output_r_pred_valid_bits_WE0_12),
        .r_wb_16b_instr_D0(ex_output_r_wb_16b_instr_D0_65),
        .r_wb_16b_instr_WE0(ex_output_r_wb_16b_instr_WE0_64),
        .r_wb_addrW_D0(ex_output_r_wb_addrW_D0_77),
        .r_wb_addrW_WE0(ex_output_r_wb_addrW_WE0_76),
        .r_wb_branch_ex_D0(ex_output_r_wb_branch_ex_D0_116),
        .r_wb_branch_ex_WE0(ex_output_r_wb_branch_ex_WE0_115),
        .r_wb_csr_addr_D0(ex_output_r_wb_csr_addr_D0_101),
        .r_wb_csr_addr_WE0(ex_output_r_wb_csr_addr_WE0_100),
        .r_wb_csr_data_D0(ex_output_r_wb_csr_data_D0_104),
        .r_wb_csr_data_WE0(ex_output_r_wb_csr_data_WE0_103),
        .r_wb_csr_funct_D0(ex_output_r_wb_csr_funct_D0_98),
        .r_wb_csr_funct_WE0(ex_output_r_wb_csr_funct_WE0_97),
        .r_wb_csr_read_D0(ex_output_r_wb_csr_read_D0_107),
        .r_wb_csr_read_WE0(ex_output_r_wb_csr_read_WE0_106),
        .r_wb_csr_write_D0(ex_output_r_wb_csr_write_D0_110),
        .r_wb_csr_write_WE0(ex_output_r_wb_csr_write_WE0_109),
        .r_wb_exc_code_D0(ex_output_r_wb_exc_code_D0_125),
        .r_wb_exc_code_WE0(ex_output_r_wb_exc_code_WE0_124),
        .r_wb_exc_D0(ex_output_r_wb_exc_D0_122),
        .r_wb_exc_instr_addr_D0(ex_output_r_wb_exc_instr_addr_D0_128),
        .r_wb_exc_instr_addr_WE0(ex_output_r_wb_exc_instr_addr_WE0_127),
        .r_wb_exc_WE0(ex_output_r_wb_exc_WE0_121),
        .r_wb_halt_D0(ex_output_r_wb_halt_D0_131),
        .r_wb_halt_WE0(ex_output_r_wb_halt_WE0_130),
        .r_wb_instr_fin_D0(ex_output_r_wb_instr_fin_D0_68),
        .r_wb_instr_fin_WE0(ex_output_r_wb_instr_fin_WE0_67),
        .r_wb_instr_val_D0(ex_output_r_wb_instr_val_D0_62),
        .r_wb_instr_val_WE0(ex_output_r_wb_instr_val_WE0_61),
        .r_wb_mem_cmd_D0(ex_output_r_wb_mem_cmd_D0_89),
        .r_wb_mem_cmd_WE0(ex_output_r_wb_mem_cmd_WE0_88),
        .r_wb_mem_type_D0(ex_output_r_wb_mem_type_D0_86),
        .r_wb_mem_type_WE0(ex_output_r_wb_mem_type_WE0_85),
        .r_wb_memop_D0(ex_output_r_wb_memop_D0_83),
        .r_wb_memop_WE0(ex_output_r_wb_memop_WE0_82),
        .r_wb_pc_D0(ex_output_r_wb_pc_D0_71),
        .r_wb_pc_WE0(ex_output_r_wb_pc_WE0_70),
        .r_wb_reg_write_D0(ex_output_r_wb_reg_write_D0_80),
        .r_wb_reg_write_WE0(ex_output_r_wb_reg_write_WE0_79),
        .r_wb_result_D0(ex_output_r_wb_result_D0_74),
        .r_wb_result_WE0(ex_output_r_wb_result_WE0_73),
        .r_wb_save_return_addr_D0(ex_output_r_wb_save_return_addr_D0_113),
        .r_wb_save_return_addr_WE0(ex_output_r_wb_save_return_addr_WE0_112),
        .r_wb_wfi_D0(ex_output_r_wb_wfi_D0_119),
        .r_wb_wfi_WE0(ex_output_r_wb_wfi_WE0_118),
        .r_wb_writedata_D0(ex_output_r_wb_writedata_D0_92),
        .r_wb_writedata_WE0(ex_output_r_wb_writedata_WE0_91),
        .r_wb_zimm_D0(ex_output_r_wb_zimm_D0_95),
        .r_wb_zimm_WE0(ex_output_r_wb_zimm_WE0_94),
        .s_ex_jump_addr_D0(s_ex_jump_addr),
        .s_ex_pc_we_D0(s_ex_pc_we),
        .s_ex_pred_data_D0(s_ex_pred_data)
    );

    // instance of 'fe_output' functional unit:
    codix_berkelium_ca_core_fe_output_t fe_output (
        .ACT(fe_fe_output_ACT_203),
        .r_fe_exc_code_Q0(r_fe_exc_code_Q0_26),
        .r_fe_exc_instr_addr_Q0(r_fe_exc_instr_addr_Q0_29),
        .r_fe_exc_Q0(r_fe_exc_Q0_23),
        .r_fe_instr_buf1_full_Q0(r_fe_instr_buf1_full_Q0_20),
        .r_fe_reload_Q0(r_fe_reload_Q0_135),
        .r_fe_request_ready_Q0(r_fe_request_ready_Q0_8),
        .r_PC_Q0(r_PC_Q0_150),
        .s_debug_mode_req_Q0(s_debug_mode_req),
        .s_ex_pc_we_Q0(s_ex_pc_we),
        .s_fe_16b_instr_en_Q0(s_fe_16b_instr_en),
        .s_fe_16b_instr_inval_imm_Q0(s_fe_16b_instr_inval_imm),
        .s_fe_16b_instr_inval_Q0(s_fe_16b_instr_inval),
        .s_fe_16b_instr_inval_reg_Q0(s_fe_16b_instr_inval_reg),
        .s_fe_32b_instr_Q0(s_fe_32b_instr),
        .s_fe_func3_imm_Q0(s_fe_func3_imm),
        .s_fe_func7_imm_Q0(s_fe_func7_imm),
        .s_fe_instr_load_Q0(s_fe_instr_load),
        .s_fe_opcode_Q0(s_fe_opcode),
        .s_fe_rd_imm_Q0(s_fe_rd_imm),
        .s_fe_response_rc_Q0(s_fe_response_rc),
        .s_fe_rs1_imm_Q0(s_fe_rs1_imm),
        .s_fe_rs2_imm_Q0(s_fe_rs2_imm),
        .r_ex_16b_instr_D0(fe_output_r_ex_16b_instr_D0_39),
        .r_ex_16b_instr_WE0(fe_output_r_ex_16b_instr_WE0_38),
        .r_ex_exc_code_D0(fe_output_r_ex_exc_code_D0_54),
        .r_ex_exc_code_WE0(fe_output_r_ex_exc_code_WE0_53),
        .r_ex_exc_D0(fe_output_r_ex_exc_D0_51),
        .r_ex_exc_instr_addr_D0(fe_output_r_ex_exc_instr_addr_D0_57),
        .r_ex_exc_instr_addr_WE0(fe_output_r_ex_exc_instr_addr_WE0_56),
        .r_ex_exc_WE0(fe_output_r_ex_exc_WE0_50),
        .r_ex_instr_D0(fe_output_r_ex_instr_D0_33),
        .r_ex_instr_val_D0(fe_output_r_ex_instr_val_D0_36),
        .r_ex_instr_val_WE0(fe_output_r_ex_instr_val_WE0_35),
        .r_ex_instr_WE0(fe_output_r_ex_instr_WE0_32),
        .r_ex_pc_D0(fe_output_r_ex_pc_D0_42),
        .r_ex_pc_WE0(fe_output_r_ex_pc_WE0_41),
        .r_ex_valid_D0(fe_output_r_ex_valid_D0_137),
        .r_ex_valid_WE0(fe_output_r_ex_valid_WE0_136),
        .r_fe_reload_D0(fe_output_r_fe_reload_D0_134),
        .r_fe_reload_WE0(fe_output_r_fe_reload_WE0_133)
    );

    // instance of 'wb_output' functional unit:
    codix_berkelium_ca_core_wb_output_t wb_output (
        .ACT(main_wb_output_ACT_204),
        .r_wb_addrW_Q0(r_wb_addrW_Q0_78),
        .r_wb_csr_read_Q0(r_wb_csr_read_Q0_108),
        .r_wb_halt_Q0(r_wb_halt_Q0_132),
        .r_wb_instr_fin_Q0(r_wb_instr_fin_Q0_69),
        .r_wb_memop_Q0(r_wb_memop_Q0_84),
        .r_wb_reg_write_Q0(r_wb_reg_write_Q0_81),
        .r_wb_result_Q0(r_wb_result_Q0_75),
        .r_wb_save_return_addr_Q0(r_wb_save_return_addr_Q0_114),
        .s_wb_csr_data_Q0(s_wb_csr_data),
        .s_wb_exc_Q0(s_wb_exc),
        .s_wb_irq_taken_Q0(s_wb_irq_taken),
        .s_wb_mem_Q0(s_wb_mem),
        .s_wb_next_pc_Q0(s_wb_next_pc),
        .s_wb_stall_wb_Q0(s_wb_stall_wb),
        .halt_ACT(wb_output_halt_ACT_193),
        .rf_gpr_D0(wb_output_rf_gpr_D0_153),
        .rf_gpr_WA0(wb_output_rf_gpr_WA0_160),
        .rf_gpr_WE0(wb_output_rf_gpr_WE0_163),
        .s_wb_activation_ack_D0(s_wb_activation_ack),
        .s_wb_reg_write_bypass_D0(s_wb_reg_write_bypass)
    );

    // instance of 'ex' functional unit:
    codix_berkelium_ca_core_ex_t ex (
        .ACT(main_ex_ACT_205),
        .dec_codasip_param_1(dec_codasip_param_1_206),
        .r_ex_instr_Q0(r_ex_instr_Q0_34),
        .r_wb_addrW_Q0(r_wb_addrW_Q0_78),
        .r_wb_csr_read_Q0(r_wb_csr_read_Q0_108),
        .r_wb_csr_write_Q0(r_wb_csr_write_Q0_111),
        .r_wb_mem_cmd_Q0(r_wb_mem_cmd_Q0_90),
        .r_wb_memop_Q0(r_wb_memop_Q0_84),
        .r_wb_result_Q0(r_wb_result_Q0_75),
        .r_wb_save_return_addr_Q0(r_wb_save_return_addr_Q0_114),
        .rf_gpr_Q0(rf_gpr_Q0_164),
        .rf_gpr_Q1(rf_gpr_Q1_165),
        .s_sleep_Q0(s_sleep),
        .s_wb_reg_write_bypass_Q0(s_wb_reg_write_bypass),
        .dec_ACT(ex_dec_ACT_207),
        .dec_codasip_param_0(ex_dec_codasip_param_0_208),
        .ex_alu_ACT(ex_ex_alu_ACT_197),
        .ex_cmp_ACT(ex_ex_cmp_ACT_198),
        .ex_memory_ACT(ex_ex_memory_ACT_201),
        .ex_mul_div_ACT(ex_ex_mul_div_ACT_181),
        .ex_output_ACT(ex_ex_output_ACT_202),
        .rf_gpr_RA0(ex_rf_gpr_RA0_154),
        .rf_gpr_RA1(ex_rf_gpr_RA1_155),
        .rf_gpr_RE0(ex_rf_gpr_RE0_156),
        .rf_gpr_RE1(ex_rf_gpr_RE1_157),
        .s_ex_activation_ack_D0(s_ex_activation_ack),
        .s_ex_ilegal_instr_D0(s_ex_ilegal_instr),
        .s_ex_raw_hazard_D0(s_ex_raw_hazard),
        .s_ex_rs1_data_bypassed_D0(s_ex_rs1_data_bypassed),
        .s_ex_rs2_data_bypassed_D0(s_ex_rs2_data_bypassed)
    );

    // instance of 'fe' functional unit:
    codix_berkelium_ca_core_fe_t fe (
        .CLK(CLK),
        .RST(RST),
        .ACT(main_fe_ACT_209),
        .decompressor_16b32b_codasip_param_1(decompressor_16b32b_codasip_param_1_210),
        .if_fetch_Q0(if_fetch_Q0),
        .if_fetch_RESPONSE0(if_fetch_RESPONSE0),
        .predictor_mem_if_read_Q0(predictor_mem_if_read_Q0),
        .r_fe_instr_buf0_full_Q0(r_fe_instr_buf0_full_Q0_11),
        .r_fe_instr_buf1_full_Q0(r_fe_instr_buf1_full_Q0_20),
        .r_fe_instr_buf1_Q0(r_fe_instr_buf1_Q0_17),
        .r_fe_request_ready_Q0(r_fe_request_ready_Q0_8),
        .r_PC_Q0(r_PC_Q0_150[31:1]),
        .r_pred_valid_bits_Q0(r_pred_valid_bits_Q0_14),
        .s_ex_pc_we_Q0(s_ex_pc_we),
        .s_ex_stall_ex_Q0(s_ex_stall_ex),
        .s_fe_16b_instr_en_Q0(s_fe_16b_instr_en),
        .s_fe_16b_instr_Q0(s_fe_16b_instr),
        .s_fe_32b_instr_Q0(s_fe_32b_instr[15:0]),
        .s_fe_instr_load_Q0(s_fe_instr_load),
        .s_fe_mem_instr_Q0(s_fe_mem_instr),
        .s_fe_pred_data_Q0(s_fe_pred_data),
        .s_fe_pred_taddr_Q0(s_fe_pred_taddr),
        .s_fe_pred_taken_Q0(s_fe_pred_taken),
        .s_fe_rc_fin_ack_ok_Q0(s_fe_rc_fin_ack_ok),
        .s_fe_response_rc_Q0(s_fe_response_rc),
        .s_sleep_Q0(s_sleep),
        .s_wb_stall_wb_Q0(s_wb_stall_wb),
        .decompressor_16b32b_ACT(fe_decompressor_16b32b_ACT_211),
        .decompressor_16b32b_codasip_param_0(fe_decompressor_16b32b_codasip_param_0_212),
        .fe_output_ACT(fe_fe_output_ACT_203),
        .r_ex_pred_bits_D0(fe_r_ex_pred_bits_D0_45),
        .r_ex_pred_bits_WE0(fe_r_ex_pred_bits_WE0_44),
        .r_ex_pred_taddr_D0(fe_r_ex_pred_taddr_D0_48),
        .r_ex_pred_taddr_WE0(fe_r_ex_pred_taddr_WE0_47),
        .r_fe_instr_buf0_full_D0(fe_r_fe_instr_buf0_full_D0_10),
        .r_fe_instr_buf0_full_WE0(fe_r_fe_instr_buf0_full_WE0_9),
        .r_fe_instr_buf1_D0(fe_r_fe_instr_buf1_D0_16),
        .r_fe_instr_buf1_full_D0(fe_r_fe_instr_buf1_full_D0_19),
        .r_fe_instr_buf1_full_WE0(fe_r_fe_instr_buf1_full_WE0_18),
        .r_fe_instr_buf1_WE0(fe_r_fe_instr_buf1_WE0_15),
        .s_fe_16b_instr_D0(s_fe_16b_instr),
        .s_fe_16b_instr_en_D0(s_fe_16b_instr_en),
        .s_fe_16b_instr_inval_D0(s_fe_16b_instr_inval),
        .s_fe_32b_instr_D0(s_fe_32b_instr),
        .s_fe_inc_pc_align_D0(s_fe_inc_pc_align),
        .s_fe_inc_pc_D0(s_fe_inc_pc),
        .s_fe_instr_load_D0(s_fe_instr_load),
        .s_fe_mem_instr_D0(s_fe_mem_instr),
        .s_fe_pred_data_D0(s_fe_pred_data),
        .s_fe_pred_taddr_D0(s_fe_pred_taddr),
        .s_fe_pred_taken_align_D0(s_fe_pred_taken_align),
        .s_fe_pred_taken_D0(s_fe_pred_taken),
        .s_fe_rc_fin_ack_ok_D0(s_fe_rc_fin_ack_ok),
        .s_fe_response_rc_D0(s_fe_response_rc)
    );

    // instance of 'main' functional unit:
    codix_berkelium_ca_core_main_t main (
        .ACT(codasip_startup_ctrl_main_ACT_213),
        .p_meip_Q0(p_meip_Q0),
        .p_msip_Q0(p_msip_Q0),
        .p_mtip_Q0(p_mtip_Q0),
        .r_csr_mie_Q0(r_csr_mie_Q0_177[11:3]),
        .r_debug_state_Q0(r_debug_state_Q0_141),
        .r_ex_instr_Q0(r_ex_instr_Q0_34),
        .r_ex_valid_Q0(r_ex_valid_Q0_138),
        .r_sleep_Q0(r_sleep_Q0_2),
        .r_wb_wfi_Q0(r_wb_wfi_Q0_120),
        .s_debug_mode_req_Q0(s_debug_mode_req),
        .s_hw_break_req_Q0(s_hw_break_req),
        .s_port_break_en_Q0(s_port_break_en_Q0),
        .s_port_break_hw_Q0(s_port_break_hw_Q0),
        .s_sw_break_req_Q0(s_sw_break_req),
        .csr_file_ACT(main_csr_file_ACT_199),
        .ex_ACT(main_ex_ACT_205),
        .fe_ACT(main_fe_ACT_209),
        .jtag_fsm_ACT(main_jtag_fsm_ACT_200),
        .npc_ACT(main_npc_ACT_192),
        .pipeline_control_ACT(main_pipeline_control_ACT_182),
        .ports_ACT(main_ports_ACT_194),
        .s_debug_mode_req_D0(s_debug_mode_req),
        .s_hw_break_req_D0(s_hw_break_req),
        .s_irq_D0(s_irq),
        .s_sleep_D0(s_sleep),
        .s_sw_break_req_D0(s_sw_break_req),
        .s_user_mode_req_D0(s_user_mode_req),
        .wb_ACT(main_wb_ACT_187),
        .wb_output_ACT(main_wb_output_ACT_204)
    );

    // instance of 'decompressor_16b32b' instruction decoder:
    codix_berkelium_ca_core_decompressor_16b32b_t decompressor_16b32b (
        .ACT(fe_decompressor_16b32b_ACT_211),
        .codasip_param_0(fe_decompressor_16b32b_codasip_param_0_212),
        .s_fe_16b_instr_Q0(s_fe_16b_instr[12:2]),
        .codasip_param_1(decompressor_16b32b_codasip_param_1_210),
        .s_fe_16b_instr_inval_imm_D0(s_fe_16b_instr_inval_imm),
        .s_fe_16b_instr_inval_reg_D0(s_fe_16b_instr_inval_reg),
        .s_fe_func3_imm_D0(s_fe_func3_imm),
        .s_fe_func7_imm_D0(s_fe_func7_imm),
        .s_fe_opcode_D0(s_fe_opcode),
        .s_fe_rd_imm_D0(s_fe_rd_imm),
        .s_fe_rs1_imm_D0(s_fe_rs1_imm),
        .s_fe_rs2_imm_D0(s_fe_rs2_imm)
    );

    // instance of 'dec' instruction decoder:
    codix_berkelium_ca_core_dec_t dec (
        .ACT(ex_dec_ACT_207),
        .codasip_param_0(ex_dec_codasip_param_0_208),
        .codasip_param_1(dec_codasip_param_1_206),
        .s_ex_alu_function_D0(s_ex_alu_function),
        .s_ex_aluop1_mux_D0(s_ex_aluop1_mux),
        .s_ex_aluop1_signed_D0(s_ex_aluop1_signed),
        .s_ex_aluop2_mux_D0(s_ex_aluop2_mux),
        .s_ex_aluop2_signed_D0(s_ex_aluop2_signed),
        .s_ex_branch_D0(s_ex_branch),
        .s_ex_cmp_function_D0(s_ex_cmp_function),
        .s_ex_csr_funct_D0(s_ex_csr_funct),
        .s_ex_csr_read_D0(s_ex_csr_read),
        .s_ex_csr_write_D0(s_ex_csr_write),
        .s_ex_inv_all_instr_D0(s_ex_inv_all_instr),
        .s_ex_jal_D0(s_ex_jal),
        .s_ex_jalr_D0(s_ex_jalr),
        .s_ex_mem_cmd_D0(s_ex_mem_cmd),
        .s_ex_mem_type_D0(s_ex_mem_type),
        .s_ex_memop_D0(s_ex_memop),
        .s_ex_mulh_D0(s_ex_mulh),
        .s_ex_reg_write_D0(s_ex_reg_write),
        .s_ex_sel_imm_D0(s_ex_sel_imm)
    );

    // instance of 'pipe' pipeline controller:
    codix_berkelium_ca_core_pipe_t pipe (
        .EX_clear_D0(pipeline_control_pipe_EX_clear_D0_183),
        .EX_stall_D0(pipeline_control_pipe_EX_stall_D0_184),
        .WB_clear_D0(pipeline_control_pipe_WB_clear_D0_185),
        .WB_stall_D0(pipeline_control_pipe_WB_stall_D0_186),
        .EX_clear_Q0(pipe_EX_clear_Q0_30),
        .EX_stall_Q0(pipe_EX_stall_Q0_31),
        .WB_clear_Q0(pipe_WB_clear_Q0_59),
        .WB_stall_Q0(pipe_WB_stall_Q0_60)
    );

    // instance of 'codasip_startup_ctrl' startup controller:
    codix_berkelium_ca_core_codasip_startup_ctrl_t codasip_startup_ctrl (
        .CLK(CLK),
        .RST(RST),
        .reset_FIN(reset_FIN_196),
        .main_ACT(codasip_startup_ctrl_main_ACT_213),
        .reset_ACT(codasip_startup_ctrl_reset_ACT_195)
    );

endmodule
