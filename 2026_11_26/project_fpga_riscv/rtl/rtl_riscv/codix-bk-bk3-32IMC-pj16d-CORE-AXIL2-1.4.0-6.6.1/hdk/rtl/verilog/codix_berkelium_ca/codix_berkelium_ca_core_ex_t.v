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
 *  \brief   Contains module definition of the 'codix_berkelium_ca_core_ex_t' functional unit.
 */

module codix_berkelium_ca_core_ex_t(
    input  wire ACT,
    input  wire dec_codasip_param_1,
    input  wire [31:0] r_ex_instr_Q0,
    input  wire [4:0] r_wb_addrW_Q0,
    input  wire r_wb_csr_read_Q0,
    input  wire r_wb_csr_write_Q0,
    input  wire [2:0] r_wb_mem_cmd_Q0,
    input  wire r_wb_memop_Q0,
    input  wire [31:0] r_wb_result_Q0,
    input  wire r_wb_save_return_addr_Q0,
    input  wire [31:0] rf_gpr_Q0,
    input  wire [31:0] rf_gpr_Q1,
    input  wire s_sleep_Q0,
    input  wire s_wb_reg_write_bypass_Q0,
    output wire dec_ACT,
    output wire [31:0] dec_codasip_param_0,
    output wire ex_alu_ACT,
    output wire ex_cmp_ACT,
    output wire ex_memory_ACT,
    output wire ex_mul_div_ACT,
    output wire ex_output_ACT,
    output wire [4:0] rf_gpr_RA0,
    output wire [4:0] rf_gpr_RA1,
    output wire rf_gpr_RE0,
    output wire rf_gpr_RE1,
    output wire s_ex_activation_ack_D0,
    output wire s_ex_ilegal_instr_D0,
    output wire s_ex_raw_hazard_D0,
    output wire [31:0] s_ex_rs1_data_bypassed_D0,
    output wire [31:0] s_ex_rs2_data_bypassed_D0
);
    // type, wire and constant declarations:
    // signal/wire (inner)
    wire codasip_tmp_var_0;
    // signal/wire (inner)
    wire [4:0] rs1_addr_B0;
    // signal/wire (inner)
    wire [4:0] rs2_addr_B0;

    // data-path code:
    assign rs1_addr_B0 = r_ex_instr_Q0[19:15];
    assign rs2_addr_B0 = r_ex_instr_Q0[24:20];
    assign codasip_tmp_var_0 = (!s_sleep_Q0);
    assign dec_ACT = (ACT == 1'd1) ? 1'd1 : 1'd0;
    assign dec_codasip_param_0 = (ACT == 1'd1) ? r_ex_instr_Q0 : 32'd0;
    assign ex_alu_ACT = (ACT == 1'd1) ? 1'd1 : 1'd0;
    assign ex_cmp_ACT = (ACT == 1'd1) ? 1'd1 : 1'd0;
    assign ex_memory_ACT = ((ACT == 1'd1) && codasip_tmp_var_0) ? 1'd1 : 1'd0;
    assign ex_mul_div_ACT = (ACT == 1'd1) ? 1'd1 : 1'd0;
    assign ex_output_ACT = (ACT == 1'd1) ? 1'd1 : 1'd0;
    assign rf_gpr_RA0 = rs1_addr_B0;
    assign rf_gpr_RA1 = rs2_addr_B0;
    assign rf_gpr_RE0 = (ACT == 1'd1) ? 1'd1 : 1'd0;
    assign rf_gpr_RE1 = (ACT == 1'd1) ? 1'd1 : 1'd0;
    assign s_ex_activation_ack_D0 = (ACT == 1'd1) ? 1'd1 : 1'd0;
    assign s_ex_ilegal_instr_D0 = (ACT == 1'd1) ? dec_codasip_param_1 : 1'd0;
    assign s_ex_raw_hazard_D0 = (ACT == 1'd1) ? (((((rs1_addr_B0 == r_wb_addrW_Q0) || (rs2_addr_B0 == r_wb_addrW_Q0)) && ((((r_wb_memop_Q0 == 1'd1) && (r_wb_mem_cmd_Q0 == 3'd1)) || r_wb_csr_read_Q0) || r_wb_save_return_addr_Q0)) && (r_wb_addrW_Q0 != 5'd0)) || r_wb_csr_write_Q0) : 1'd0;
    assign s_ex_rs1_data_bypassed_D0 = (ACT == 1'd1) ? ((((r_wb_addrW_Q0 == rs1_addr_B0) && s_wb_reg_write_bypass_Q0)) ? r_wb_result_Q0 : rf_gpr_Q0) : 32'd0;
    assign s_ex_rs2_data_bypassed_D0 = (ACT == 1'd1) ? ((((r_wb_addrW_Q0 == rs2_addr_B0) && s_wb_reg_write_bypass_Q0)) ? r_wb_result_Q0 : rf_gpr_Q1) : 32'd0;
endmodule
