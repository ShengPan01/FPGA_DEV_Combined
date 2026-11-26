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
 *  \brief   Contains module definition of the 'codix_berkelium_ca_core_main_t' functional unit.
 */

module codix_berkelium_ca_core_main_t(
    input  wire ACT,
    input  wire p_meip_Q0,
    input  wire p_msip_Q0,
    input  wire p_mtip_Q0,
    input  wire [8:0] r_csr_mie_Q0,
    input  wire [2:0] r_debug_state_Q0,
    input  wire [31:0] r_ex_instr_Q0,
    input  wire r_ex_valid_Q0,
    input  wire r_sleep_Q0,
    input  wire r_wb_wfi_Q0,
    input  wire s_debug_mode_req_Q0,
    input  wire s_hw_break_req_Q0,
    input  wire s_port_break_en_Q0,
    input  wire s_port_break_hw_Q0,
    input  wire s_sw_break_req_Q0,
    output wire csr_file_ACT,
    output wire ex_ACT,
    output wire fe_ACT,
    output wire jtag_fsm_ACT,
    output wire npc_ACT,
    output wire pipeline_control_ACT,
    output wire ports_ACT,
    output wire s_debug_mode_req_D0,
    output wire s_hw_break_req_D0,
    output wire s_irq_D0,
    output wire s_sleep_D0,
    output wire s_sw_break_req_D0,
    output wire s_user_mode_req_D0,
    output wire wb_ACT,
    output wire wb_output_ACT
);
    // type, wire and constant declarations:
    // signal/wire (inner)
    wire codasip_tmp_var_2;
    // signal/wire (inner)
    wire codasip_tmp_var_3;

    // data-path code:
    assign codasip_tmp_var_2 = (!r_sleep_Q0);
    assign codasip_tmp_var_3 = (!r_sleep_Q0);
    assign csr_file_ACT = ((ACT == 1'd1) && codasip_tmp_var_2) ? 1'd1 : 1'd0;
    assign ex_ACT = ((ACT == 1'd1) && codasip_tmp_var_3) ? 1'd1 : 1'd0;
    assign fe_ACT = ((ACT == 1'd1) && codasip_tmp_var_3) ? 1'd1 : 1'd0;
    assign jtag_fsm_ACT = (ACT == 1'd1) ? 1'd1 : 1'd0;
    assign npc_ACT = ((ACT == 1'd1) && codasip_tmp_var_3) ? 1'd1 : 1'd0;
    assign pipeline_control_ACT = (ACT == 1'd1) ? 1'd1 : 1'd0;
    assign ports_ACT = (ACT == 1'd1) ? 1'd1 : 1'd0;
    assign s_debug_mode_req_D0 = (ACT == 1'd1) ? (((s_sw_break_req_Q0 || s_hw_break_req_Q0) && r_ex_valid_Q0) && s_port_break_en_Q0) : 1'd0;
    assign s_hw_break_req_D0 = (ACT == 1'd1) ? ((r_debug_state_Q0 == 3'd0) && s_port_break_hw_Q0) : 1'd0;
    assign s_irq_D0 = (ACT == 1'd1) ? (((p_meip_Q0 && r_csr_mie_Q0[8]) || (p_mtip_Q0 && r_csr_mie_Q0[4])) || (p_msip_Q0 && r_csr_mie_Q0[0])) : 1'd0;
    assign s_sleep_D0 = (ACT == 1'd1) ? (r_wb_wfi_Q0 || s_debug_mode_req_Q0) : 1'd0;
    assign s_sw_break_req_D0 = (ACT == 1'd1) ? (r_ex_instr_Q0 == 32'd2414923891) : 1'd0;
    assign s_user_mode_req_D0 = (ACT == 1'd1) ? ((r_debug_state_Q0 == 3'd3) && (!s_port_break_hw_Q0)) : 1'd0;
    assign wb_ACT = ((ACT == 1'd1) && codasip_tmp_var_2) ? 1'd1 : 1'd0;
    assign wb_output_ACT = ((ACT == 1'd1) && codasip_tmp_var_2) ? 1'd1 : 1'd0;
endmodule
