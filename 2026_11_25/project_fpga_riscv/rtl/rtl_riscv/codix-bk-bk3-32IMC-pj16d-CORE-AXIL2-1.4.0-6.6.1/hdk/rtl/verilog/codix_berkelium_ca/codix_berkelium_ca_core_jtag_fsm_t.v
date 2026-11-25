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
 *  \brief   Contains module definition of the 'codix_berkelium_ca_core_jtag_fsm_t' functional unit.
 */

module codix_berkelium_ca_core_jtag_fsm_t(
    input  wire ACT,
    input  wire [2:0] r_debug_state_Q0,
    input  wire s_debug_mode_ready_Q0,
    input  wire s_debug_mode_req_Q0,
    input  wire s_ex_activation_ack_Q0,
    input  wire s_port_break_hw_Q0,
    input  wire s_user_mode_ready_Q0,
    input  wire s_user_mode_req_Q0,
    input  wire s_wb_activation_ack_Q0,
    input  wire s_wb_stall_Q0,
    output wire [2:0] r_debug_state_D0,
    output wire r_debug_state_WE0,
    output wire s_debug_mode_ready_D0,
    output wire s_port_break_sw_D0,
    output wire s_user_mode_ready_D0
);
    // type, wire and constant declarations:
    // signal/wire (inner)
    wire [2:0] codasip_tmp_var_0;
    // signal/wire (inner)
    wire [2:0] debug_mode_value_B0;
    // signal/wire (inner)
    wire [2:0] debug_req_value_B0;
    // signal/wire (inner)
    wire [2:0] debug_state_next_B0;
    // signal/wire (inner)
    wire [2:0] debug_wait_value_B0;
    // signal/wire (inner)
    wire [2:0] user_mode_value_B0;
    // signal/wire (inner)
    wire [2:0] user_req_value_B0;

    // additional declarations:
    // temporal variable for multiplexer, should not be synthesized as register
    reg [2:0] tmp_codasip_conv_cs_debug_state_next_B0_D0_mux_1;

    // data-path code:
    assign user_mode_value_B0 = (((s_debug_mode_req_Q0 && (!s_wb_stall_Q0))) ? 3'd1 : r_debug_state_Q0);
    assign debug_req_value_B0 = ((s_debug_mode_ready_Q0) ? ((s_port_break_hw_Q0) ? 3'd3 : 3'd2) : r_debug_state_Q0);
    assign debug_wait_value_B0 = ((s_port_break_hw_Q0) ? 3'd3 : r_debug_state_Q0);
    assign debug_mode_value_B0 = ((s_user_mode_req_Q0) ? 3'd4 : r_debug_state_Q0);
    assign user_req_value_B0 = ((s_user_mode_ready_Q0) ? 3'd0 : r_debug_state_Q0);
    assign codasip_tmp_var_0 = r_debug_state_Q0;
    always @(*) begin
        case ( codasip_tmp_var_0 )
            3'd0: tmp_codasip_conv_cs_debug_state_next_B0_D0_mux_1 = user_mode_value_B0;
            3'd1: tmp_codasip_conv_cs_debug_state_next_B0_D0_mux_1 = debug_req_value_B0;
            3'd2: tmp_codasip_conv_cs_debug_state_next_B0_D0_mux_1 = debug_wait_value_B0;
            3'd3: tmp_codasip_conv_cs_debug_state_next_B0_D0_mux_1 = debug_mode_value_B0;
            3'd4: tmp_codasip_conv_cs_debug_state_next_B0_D0_mux_1 = user_req_value_B0;
            default: tmp_codasip_conv_cs_debug_state_next_B0_D0_mux_1 = 3'bxxx;
        endcase
    end
    assign debug_state_next_B0 = tmp_codasip_conv_cs_debug_state_next_B0_D0_mux_1;
    assign r_debug_state_D0 = debug_state_next_B0;
    assign r_debug_state_WE0 = (ACT == 1'd1) ? 1'd1 : 1'd0;
    assign s_debug_mode_ready_D0 = (ACT == 1'd1) ? (s_wb_activation_ack_Q0 == 1'd0) : 1'd0;
    assign s_port_break_sw_D0 = (ACT == 1'd1) ? ((r_debug_state_Q0 == 3'd3) || (r_debug_state_Q0 == 3'd2)) : 1'd0;
    assign s_user_mode_ready_D0 = (ACT == 1'd1) ? (s_ex_activation_ack_Q0 == 1'd1) : 1'd0;
endmodule
