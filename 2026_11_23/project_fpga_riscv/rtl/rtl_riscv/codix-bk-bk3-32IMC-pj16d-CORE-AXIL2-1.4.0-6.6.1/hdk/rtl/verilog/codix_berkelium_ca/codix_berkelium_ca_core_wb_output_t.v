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
 *  \brief   Contains module definition of the 'codix_berkelium_ca_core_wb_output_t' functional unit.
 */

module codix_berkelium_ca_core_wb_output_t(
    input  wire ACT,
    input  wire [4:0] r_wb_addrW_Q0,
    input  wire r_wb_csr_read_Q0,
    input  wire r_wb_halt_Q0,
    input  wire r_wb_instr_fin_Q0,
    input  wire r_wb_memop_Q0,
    input  wire r_wb_reg_write_Q0,
    input  wire [31:0] r_wb_result_Q0,
    input  wire r_wb_save_return_addr_Q0,
    input  wire [31:0] s_wb_csr_data_Q0,
    input  wire s_wb_exc_Q0,
    input  wire s_wb_irq_taken_Q0,
    input  wire [31:0] s_wb_mem_Q0,
    input  wire [31:0] s_wb_next_pc_Q0,
    input  wire s_wb_stall_wb_Q0,
    output wire halt_ACT,
    output wire [31:0] rf_gpr_D0,
    output wire [4:0] rf_gpr_WA0,
    output wire rf_gpr_WE0,
    output wire s_wb_activation_ack_D0,
    output wire s_wb_reg_write_bypass_D0
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
    // signal/wire (CodAL)
    wire s_wb_reg_write;
    // signal/wire (inner)
    wire s_wb_reg_write_bypass_D0_ACT_wire;
    // signal/wire (CodAL)
    wire [31:0] s_wb_writeback;

    // data-path code:
    assign codasip_tmp_var_0 = r_wb_save_return_addr_Q0;
    assign codasip_tmp_var_1 = (!codasip_tmp_var_0) ? r_wb_memop_Q0 : 1'd0;
    assign codasip_tmp_var_2 = ((!codasip_tmp_var_1) && (!codasip_tmp_var_0)) ? r_wb_csr_read_Q0 : 1'd0;
    assign s_wb_writeback = codasip_tmp_var_0 ? s_wb_next_pc_Q0 :
        codasip_tmp_var_1 ? s_wb_mem_Q0 :
        codasip_tmp_var_2 ? s_wb_csr_data_Q0 : r_wb_result_Q0;
    assign s_wb_reg_write_bypass_D0_ACT_wire = codasip_tmp_var_0 ? 1'd0 :
        codasip_tmp_var_1 ? 1'd0 :
        codasip_tmp_var_2 ? 1'd0 : ((r_wb_addrW_Q0 != 5'd0) && r_wb_reg_write_Q0);
    assign s_wb_reg_write = (((r_wb_reg_write_Q0 & (!s_wb_stall_wb_Q0)) & ((!s_wb_exc_Q0) | s_wb_irq_taken_Q0)) & (r_wb_addrW_Q0 != 5'd0));
    assign codasip_tmp_var_3 = (s_wb_reg_write && r_wb_instr_fin_Q0);
    assign codasip_tmp_var_4 = r_wb_halt_Q0;
    assign halt_ACT = ((ACT == 1'd1) && codasip_tmp_var_4) ? 1'd1 : 1'd0;
    assign rf_gpr_D0 = ((ACT == 1'd1) && codasip_tmp_var_3) ? s_wb_writeback : 32'd0;
    assign rf_gpr_WA0 = ((ACT == 1'd1) && codasip_tmp_var_3) ? r_wb_addrW_Q0 : 5'd0;
    assign rf_gpr_WE0 = ((ACT == 1'd1) && codasip_tmp_var_3) ? 1'd1 : 1'd0;
    assign s_wb_activation_ack_D0 = (ACT == 1'd1) ? 1'd1 : 1'd0;
    assign s_wb_reg_write_bypass_D0 = (ACT == 1'd1) ? s_wb_reg_write_bypass_D0_ACT_wire : 1'd0;
endmodule
