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
 *  \brief   Contains module definition of the 'codix_berkelium_ca_core_pipeline_control_t' functional unit.
 */

module codix_berkelium_ca_core_pipeline_control_t(
    input  wire ACT,
    input  wire [2:0] r_debug_state_Q0,
    input  wire s_ex_clear_Q0,
    input  wire s_ex_stall_Q0,
    input  wire s_irq_Q0,
    input  wire s_sleep_Q0,
    input  wire s_user_mode_req_Q0,
    input  wire s_wb_clear_Q0,
    input  wire s_wb_stall_Q0,
    output wire pipe_EX_clear_D0,
    output wire pipe_EX_stall_D0,
    output wire pipe_WB_clear_D0,
    output wire pipe_WB_stall_D0,
    output wire r_sleep_D0,
    output wire r_sleep_WE0
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

    // data-path code:
    assign codasip_tmp_var_0 = s_ex_clear_Q0;
    assign codasip_tmp_var_1 = (!codasip_tmp_var_0) ? s_ex_stall_Q0 : 1'd0;
    assign codasip_tmp_var_2 = s_wb_stall_Q0;
    assign codasip_tmp_var_3 = (!codasip_tmp_var_2) ? s_wb_clear_Q0 : 1'd0;
    assign codasip_tmp_var_4 = (s_sleep_Q0 && (!s_wb_stall_Q0));
    assign codasip_tmp_var_5 = (!codasip_tmp_var_4) ? (s_user_mode_req_Q0 || ((r_debug_state_Q0 == 3'd0) && s_irq_Q0)) : 1'd0;
    assign pipe_EX_clear_D0 = ((ACT == 1'd1) && codasip_tmp_var_0) ? 1'd1 : 1'd0;
    assign pipe_EX_stall_D0 = ((ACT == 1'd1) && codasip_tmp_var_1) ? 1'd1 : 1'd0;
    assign pipe_WB_clear_D0 = ((ACT == 1'd1) && codasip_tmp_var_3) ? 1'd1 : 1'd0;
    assign pipe_WB_stall_D0 = ((ACT == 1'd1) && codasip_tmp_var_2) ? 1'd1 : 1'd0;
    assign r_sleep_D0 = codasip_tmp_var_4 ? 1'd1 :
        codasip_tmp_var_5 ? 1'd0 : 1'd0;
    assign r_sleep_WE0 = ((ACT == 1'd1) && codasip_tmp_var_4) ? 1'd1 :
        ((ACT == 1'd1) && codasip_tmp_var_5) ? 1'd1 : 1'd0;
endmodule
