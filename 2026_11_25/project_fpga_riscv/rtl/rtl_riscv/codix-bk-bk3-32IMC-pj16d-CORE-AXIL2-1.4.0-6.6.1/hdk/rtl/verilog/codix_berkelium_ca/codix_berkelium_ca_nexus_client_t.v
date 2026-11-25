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
 *  \brief   Contains module definition of the 'codix_berkelium_ca_nexus_client_t' Nexus ASIP client.
 */

module codix_berkelium_ca_nexus_client_t(
    input  wire CLK,
    input  wire RST,
    input  wire NEXUS_BAR,
    input  wire [6:0] NEXUS_RRS,
    input  wire [31:0] codix_berkelium_core_r_ex_pc_Q0,
    input  wire codix_berkelium_core_r_ex_valid_Q0,
    input  wire NEXUS_CLIENT_CAPTURE,
    input  wire [31:0] NEXUS_CLIENT_D0,
    input  wire NEXUS_CLIENT_UPDATE,
    input  wire [31:0] r_PC_BSC_Q0,
    input  wire [31:0] rf_gpr_BSC_Q0,
    input  wire s_port_break_sw_Q0,
    output wire DEBUG_MODE,
    output wire [31:0] NEXUS_CLIENT_Q0,
    output wire NEXUS_CLIENT_RST_REQUEST,
    output wire [31:0] r_PC_BSC_D0,
    output wire r_PC_BSC_UPDATE0,
    output wire [31:0] rf_gpr_BSC_D0,
    output wire [1:0] rf_gpr_BSC_UPDATE0,
    output wire s_port_break_en_D0,
    output wire s_port_break_hw_D0
);
    // type, wire and constant declarations:
    // FSM state constants
    localparam [1:0] STATE_USER_MODE = 2'b0;
    localparam [1:0] STATE_USER_WAIT = 2'b01;
    localparam [1:0] STATE_DEBUG_WAIT = 2'b10;
    localparam [1:0] STATE_DEBUG_MODE = 2'b11;
    // FSM state register (current state)
    reg [1:0] state_reg_Q0;
    // FSM state register (next state)
    reg [1:0] state_reg_D0;
    // signal/wire (inner)
    wire nrrs_dc_reg_WE0_wire;
    // signal/wire (inner)
    wire hw_breakpoint_status_set_wire;
    // signal/wire (inner)
    wire DEBUG_MODE_wire;
    // signal/wire (inner)
    wire nrrs_dc_select_wire;
    // signal/wire (inner)
    wire [31:0] dev_status_wire;
    // signal/wire (inner)
    wire dev_status_select_wire;
    // signal/wire (inner)
    wire codasip_break_en_wire;
    // signal/wire (inner)
    wire debug_mode_req_wire;
    // signal/wire (inner)
    wire debug_mode_hw_req_wire;
    // signal/wire (inner)
    wire user_mode_wire;
    // signal/wire (inner)
    wire user_mode_req_wire;
    // signal/wire (inner)
    wire user_wait_wire;
    // signal/wire (inner)
    wire dev_status_hwb_flag_wire;
    // signal/wire (inner)
    wire nexus_client_bsc_64_select_wire;
    // signal/wire (inner)
    wire nexus_client_bsc_65_select_wire;
    // signal/wire (inner)
    wire nexus_client_bsc_66_select_wire;

    // additional declarations:
    wire rst_flag_reg_WE0;
    wire rst_flag_reg_D0;
    wire rst_flag_reg_Q0;
    wire rst_break_flag_reg_WE0;
    wire rst_break_flag_reg_D0;
    wire rst_break_flag_reg_Q0;
    wire NEXUS_BAR_reg_D0;
    wire NEXUS_BAR_reg_Q0;
    wire nrrs_dc_reg_WE0;
    wire [31:0] nrrs_dc_reg_D0;
    wire [31:0] nrrs_dc_reg_Q0;
    wire hw_breakpoint_status_reg_WE0;
    wire [3:0] hw_breakpoint_status_reg_D0;
    wire [3:0] hw_breakpoint_status_reg_Q0;
    wire sw_breakpoint_status_reg_WE0;
    wire sw_breakpoint_status_reg_D0;
    wire sw_breakpoint_status_reg_Q0;
    wire single_step_status_reg_WE0;
    wire single_step_status_reg_D0;
    wire single_step_status_reg_Q0;
    wire [6:0] bw0_NEXUS_RRS;
    wire bw0_NEXUS_UPDATE;
    wire [31:0] bw0_NEXUS_BREAK_INSTR_A0;
    wire bw0_NEXUS_BREAK_INSTR_VALID;
    wire [31:0] bw0_NEXUS_CLIENT_D0;
    wire bw0_NEXUS_SEL;
    wire bw0_NEXUS_BREAK;
    wire [31:0] bw0_NEXUS_CLIENT_Q0;
    wire [6:0] bw1_NEXUS_RRS;
    wire bw1_NEXUS_UPDATE;
    wire [31:0] bw1_NEXUS_BREAK_INSTR_A0;
    wire bw1_NEXUS_BREAK_INSTR_VALID;
    wire [31:0] bw1_NEXUS_CLIENT_D0;
    wire bw1_NEXUS_SEL;
    wire bw1_NEXUS_BREAK;
    wire [31:0] bw1_NEXUS_CLIENT_Q0;
    wire [6:0] bw2_NEXUS_RRS;
    wire bw2_NEXUS_UPDATE;
    wire [31:0] bw2_NEXUS_BREAK_INSTR_A0;
    wire bw2_NEXUS_BREAK_INSTR_VALID;
    wire [31:0] bw2_NEXUS_CLIENT_D0;
    wire bw2_NEXUS_SEL;
    wire bw2_NEXUS_BREAK;
    wire [31:0] bw2_NEXUS_CLIENT_Q0;
    wire [6:0] bw3_NEXUS_RRS;
    wire bw3_NEXUS_UPDATE;
    wire [31:0] bw3_NEXUS_BREAK_INSTR_A0;
    wire bw3_NEXUS_BREAK_INSTR_VALID;
    wire [31:0] bw3_NEXUS_CLIENT_D0;
    wire bw3_NEXUS_SEL;
    wire bw3_NEXUS_BREAK;
    wire [31:0] bw3_NEXUS_CLIENT_Q0;

    // FSM state register
    always @( posedge CLK or negedge RST ) begin
        if ( RST == 1'b0 ) begin
            state_reg_Q0 <= STATE_USER_MODE;
        end else begin
            state_reg_Q0 <= state_reg_D0;
        end
    end
    // FSM transitions (next state logic)
    always @(*) begin
        case ( state_reg_Q0 )
            STATE_USER_MODE: begin
                if ( (debug_mode_req_wire == 1'd1) ) begin
                    state_reg_D0 = STATE_DEBUG_WAIT;
                end else begin
                    state_reg_D0 = STATE_USER_MODE;
                end
            end
            STATE_USER_WAIT: begin
                if ( (s_port_break_sw_Q0 == 1'd0) ) begin
                    state_reg_D0 = STATE_USER_MODE;
                end else begin
                    state_reg_D0 = STATE_USER_WAIT;
                end
            end
            STATE_DEBUG_WAIT: begin
                if ( (s_port_break_sw_Q0 == 1'd1) ) begin
                    state_reg_D0 = STATE_DEBUG_MODE;
                end else if ( (codasip_break_en_wire == 1'd0) ) begin
                    state_reg_D0 = STATE_USER_MODE;
                end else begin
                    state_reg_D0 = STATE_DEBUG_WAIT;
                end
            end
            STATE_DEBUG_MODE: begin
                if ( (user_mode_req_wire == 1'd1) ) begin
                    state_reg_D0 = STATE_USER_WAIT;
                end else begin
                    state_reg_D0 = STATE_DEBUG_MODE;
                end
            end
            // fault recovery
            default: begin
                state_reg_D0 = STATE_USER_MODE;
            end
        endcase
    end

    // child instances inside 'nexus_client' Nexus ASIP client:
    // instance of 'rst_flag_reg' register:
    d_ff_plain_rst_we_t #(
        .bit_width(32'd1),
        .default_value(1'b1),
        .reset_level(1'b0),
        .reset_sync(1'b0)
    ) rst_flag_reg (
        .CLK(CLK),
        .RST(RST),
        .WE0(rst_flag_reg_WE0),
        .D0(rst_flag_reg_D0),
        .Q0(rst_flag_reg_Q0)
    );

    // instance of 'rst_break_flag_reg' register:
    d_ff_plain_rst_we_t #(
        .bit_width(32'd1),
        .default_value(1'b1),
        .reset_level(1'b0),
        .reset_sync(1'b0)
    ) rst_break_flag_reg (
        .CLK(CLK),
        .RST(RST),
        .WE0(rst_break_flag_reg_WE0),
        .D0(rst_break_flag_reg_D0),
        .Q0(rst_break_flag_reg_Q0)
    );

    // instance of 'NEXUS_BAR_reg' register:
    d_ff_plain_rst_t #(
        .bit_width(32'd1),
        .default_value(1'b1),
        .reset_level(1'b0),
        .reset_sync(1'b0)
    ) NEXUS_BAR_reg (
        .CLK(CLK),
        .RST(RST),
        .D0(NEXUS_BAR_reg_D0),
        .Q0(NEXUS_BAR_reg_Q0)
    );

    // instance of 'nrrs_dc_reg' register:
    d_ff_plain_rst_we_t #(
        .bit_width(32'd32),
        .default_value(32'b0),
        .reset_level(1'b0),
        .reset_sync(1'b0)
    ) nrrs_dc_reg (
        .CLK(CLK),
        .RST(RST),
        .WE0(nrrs_dc_reg_WE0),
        .D0(nrrs_dc_reg_D0),
        .Q0(nrrs_dc_reg_Q0)
    );

    // instance of 'hw_breakpoint_status_reg' register:
    d_ff_plain_rst_we_t #(
        .bit_width(32'd4),
        .default_value(4'b0),
        .reset_level(1'b0),
        .reset_sync(1'b0)
    ) hw_breakpoint_status_reg (
        .CLK(CLK),
        .RST(RST),
        .WE0(hw_breakpoint_status_reg_WE0),
        .D0(hw_breakpoint_status_reg_D0),
        .Q0(hw_breakpoint_status_reg_Q0)
    );

    // instance of 'sw_breakpoint_status_reg' register:
    d_ff_plain_rst_we_t #(
        .bit_width(32'd1),
        .default_value(1'b0),
        .reset_level(1'b0),
        .reset_sync(1'b0)
    ) sw_breakpoint_status_reg (
        .CLK(CLK),
        .RST(RST),
        .WE0(sw_breakpoint_status_reg_WE0),
        .D0(sw_breakpoint_status_reg_D0),
        .Q0(sw_breakpoint_status_reg_Q0)
    );

    // instance of 'single_step_status_reg' register:
    d_ff_plain_rst_we_t #(
        .bit_width(32'd1),
        .default_value(1'b0),
        .reset_level(1'b0),
        .reset_sync(1'b0)
    ) single_step_status_reg (
        .CLK(CLK),
        .RST(RST),
        .WE0(single_step_status_reg_WE0),
        .D0(single_step_status_reg_D0),
        .Q0(single_step_status_reg_Q0)
    );

    // instance of 'bw0' Nexus breakpoint/watchpoint:
    codix_berkelium_ca_nexus_client_bw_module_t #(
        .BW_INDEX(7'd0)
    ) bw0 (
        .CLK(CLK),
        .RST(RST),
        .NEXUS_RRS(bw0_NEXUS_RRS),
        .NEXUS_UPDATE(bw0_NEXUS_UPDATE),
        .NEXUS_BREAK_INSTR_A0(bw0_NEXUS_BREAK_INSTR_A0),
        .NEXUS_BREAK_INSTR_VALID(bw0_NEXUS_BREAK_INSTR_VALID),
        .NEXUS_CLIENT_D0(bw0_NEXUS_CLIENT_D0),
        .NEXUS_SEL(bw0_NEXUS_SEL),
        .NEXUS_BREAK(bw0_NEXUS_BREAK),
        .NEXUS_CLIENT_Q0(bw0_NEXUS_CLIENT_Q0)
    );

    // instance of 'bw1' Nexus breakpoint/watchpoint:
    codix_berkelium_ca_nexus_client_bw_module_t #(
        .BW_INDEX(7'd1)
    ) bw1 (
        .CLK(CLK),
        .RST(RST),
        .NEXUS_RRS(bw1_NEXUS_RRS),
        .NEXUS_UPDATE(bw1_NEXUS_UPDATE),
        .NEXUS_BREAK_INSTR_A0(bw1_NEXUS_BREAK_INSTR_A0),
        .NEXUS_BREAK_INSTR_VALID(bw1_NEXUS_BREAK_INSTR_VALID),
        .NEXUS_CLIENT_D0(bw1_NEXUS_CLIENT_D0),
        .NEXUS_SEL(bw1_NEXUS_SEL),
        .NEXUS_BREAK(bw1_NEXUS_BREAK),
        .NEXUS_CLIENT_Q0(bw1_NEXUS_CLIENT_Q0)
    );

    // instance of 'bw2' Nexus breakpoint/watchpoint:
    codix_berkelium_ca_nexus_client_bw_module_t #(
        .BW_INDEX(7'd2)
    ) bw2 (
        .CLK(CLK),
        .RST(RST),
        .NEXUS_RRS(bw2_NEXUS_RRS),
        .NEXUS_UPDATE(bw2_NEXUS_UPDATE),
        .NEXUS_BREAK_INSTR_A0(bw2_NEXUS_BREAK_INSTR_A0),
        .NEXUS_BREAK_INSTR_VALID(bw2_NEXUS_BREAK_INSTR_VALID),
        .NEXUS_CLIENT_D0(bw2_NEXUS_CLIENT_D0),
        .NEXUS_SEL(bw2_NEXUS_SEL),
        .NEXUS_BREAK(bw2_NEXUS_BREAK),
        .NEXUS_CLIENT_Q0(bw2_NEXUS_CLIENT_Q0)
    );

    // instance of 'bw3' Nexus breakpoint/watchpoint:
    codix_berkelium_ca_nexus_client_bw_module_t #(
        .BW_INDEX(7'd3)
    ) bw3 (
        .CLK(CLK),
        .RST(RST),
        .NEXUS_RRS(bw3_NEXUS_RRS),
        .NEXUS_UPDATE(bw3_NEXUS_UPDATE),
        .NEXUS_BREAK_INSTR_A0(bw3_NEXUS_BREAK_INSTR_A0),
        .NEXUS_BREAK_INSTR_VALID(bw3_NEXUS_BREAK_INSTR_VALID),
        .NEXUS_CLIENT_D0(bw3_NEXUS_CLIENT_D0),
        .NEXUS_SEL(bw3_NEXUS_SEL),
        .NEXUS_BREAK(bw3_NEXUS_BREAK),
        .NEXUS_CLIENT_Q0(bw3_NEXUS_CLIENT_Q0)
    );

    // data-path code:
    assign user_mode_wire = (state_reg_Q0 == STATE_USER_MODE);
    assign user_wait_wire = (state_reg_Q0 == STATE_USER_WAIT);
    assign DEBUG_MODE_wire = (state_reg_Q0 == STATE_DEBUG_MODE);
    assign DEBUG_MODE = DEBUG_MODE_wire;
    assign dev_status_wire = {16'd0,{{4'd0,hw_breakpoint_status_reg_Q0},{1'd0,{rst_flag_reg_Q0,{DEBUG_MODE_wire,{2'd0,{dev_status_hwb_flag_wire,{sw_breakpoint_status_reg_Q0,single_step_status_reg_Q0}}}}}}}};
    assign nrrs_dc_select_wire = (NEXUS_RRS == 7'd2);
    assign dev_status_select_wire = (NEXUS_RRS == 7'd4);
    assign codasip_break_en_wire = (nrrs_dc_reg_Q0[13] | rst_break_flag_reg_Q0);
    assign debug_mode_hw_req_wire = (nrrs_dc_reg_Q0[13] & (nrrs_dc_reg_Q0[12] | (nrrs_dc_reg_Q0[8] | hw_breakpoint_status_set_wire)));
    assign debug_mode_req_wire = (debug_mode_hw_req_wire | ((nrrs_dc_reg_Q0[13] & s_port_break_sw_Q0) | rst_break_flag_reg_Q0));
    assign user_mode_req_wire = (((NEXUS_CLIENT_UPDATE & nrrs_dc_select_wire) & (~NEXUS_CLIENT_D0[12])) | (~codasip_break_en_wire));
    assign hw_breakpoint_status_set_wire = (user_mode_wire & (bw3_NEXUS_BREAK | (bw2_NEXUS_BREAK | (bw1_NEXUS_BREAK | bw0_NEXUS_BREAK))));
    assign hw_breakpoint_status_reg_D0 = {(bw3_NEXUS_BREAK & hw_breakpoint_status_set_wire),{(bw2_NEXUS_BREAK & hw_breakpoint_status_set_wire),{(bw1_NEXUS_BREAK & hw_breakpoint_status_set_wire),(bw0_NEXUS_BREAK & hw_breakpoint_status_set_wire)}}};
    assign hw_breakpoint_status_reg_WE0 = ((hw_breakpoint_status_set_wire & nrrs_dc_reg_Q0[13]) | user_wait_wire);
    assign dev_status_hwb_flag_wire = (hw_breakpoint_status_reg_Q0[3] | (hw_breakpoint_status_reg_Q0[2] | (hw_breakpoint_status_reg_Q0[1] | hw_breakpoint_status_reg_Q0[0])));
    assign sw_breakpoint_status_reg_D0 = (user_mode_wire & s_port_break_sw_Q0);
    assign sw_breakpoint_status_reg_WE0 = (((user_mode_wire & s_port_break_sw_Q0) & nrrs_dc_reg_Q0[13]) | user_wait_wire);
    assign single_step_status_reg_D0 = (DEBUG_MODE_wire & nrrs_dc_reg_Q0[8]);
    assign single_step_status_reg_WE0 = (((DEBUG_MODE_wire & nrrs_dc_reg_Q0[8]) & nrrs_dc_reg_Q0[13]) | user_wait_wire);
    assign bw0_NEXUS_UPDATE = NEXUS_CLIENT_UPDATE;
    assign bw0_NEXUS_RRS = NEXUS_RRS;
    assign bw0_NEXUS_CLIENT_D0 = NEXUS_CLIENT_D0;
    assign bw0_NEXUS_BREAK_INSTR_A0 = codix_berkelium_core_r_ex_pc_Q0;
    assign bw0_NEXUS_BREAK_INSTR_VALID = codix_berkelium_core_r_ex_valid_Q0;
    assign bw1_NEXUS_UPDATE = NEXUS_CLIENT_UPDATE;
    assign bw1_NEXUS_RRS = NEXUS_RRS;
    assign bw1_NEXUS_CLIENT_D0 = NEXUS_CLIENT_D0;
    assign bw1_NEXUS_BREAK_INSTR_A0 = codix_berkelium_core_r_ex_pc_Q0;
    assign bw1_NEXUS_BREAK_INSTR_VALID = codix_berkelium_core_r_ex_valid_Q0;
    assign bw2_NEXUS_UPDATE = NEXUS_CLIENT_UPDATE;
    assign bw2_NEXUS_RRS = NEXUS_RRS;
    assign bw2_NEXUS_CLIENT_D0 = NEXUS_CLIENT_D0;
    assign bw2_NEXUS_BREAK_INSTR_A0 = codix_berkelium_core_r_ex_pc_Q0;
    assign bw2_NEXUS_BREAK_INSTR_VALID = codix_berkelium_core_r_ex_valid_Q0;
    assign bw3_NEXUS_UPDATE = NEXUS_CLIENT_UPDATE;
    assign bw3_NEXUS_RRS = NEXUS_RRS;
    assign bw3_NEXUS_CLIENT_D0 = NEXUS_CLIENT_D0;
    assign bw3_NEXUS_BREAK_INSTR_A0 = codix_berkelium_core_r_ex_pc_Q0;
    assign bw3_NEXUS_BREAK_INSTR_VALID = codix_berkelium_core_r_ex_valid_Q0;
    assign nrrs_dc_reg_WE0_wire = (NEXUS_CLIENT_UPDATE & nrrs_dc_select_wire);
    assign rst_flag_reg_D0 = 1'd0;
    assign rst_flag_reg_WE0 = (dev_status_select_wire & NEXUS_CLIENT_CAPTURE);
    assign rst_break_flag_reg_D0 = 1'd0;
    assign rst_break_flag_reg_WE0 = ((NEXUS_BAR ^ NEXUS_BAR_reg_Q0) | nrrs_dc_reg_WE0_wire);
    assign NEXUS_BAR_reg_D0 = NEXUS_BAR;
    assign nrrs_dc_reg_D0 = NEXUS_CLIENT_D0;
    assign nrrs_dc_reg_WE0 = nrrs_dc_reg_WE0_wire;
    assign nexus_client_bsc_64_select_wire = (NEXUS_RRS == 7'd64);
    assign nexus_client_bsc_65_select_wire = (NEXUS_RRS == 7'd65);
    assign nexus_client_bsc_66_select_wire = (NEXUS_RRS == 7'd66);
    assign r_PC_BSC_UPDATE0 = (nexus_client_bsc_64_select_wire & NEXUS_CLIENT_UPDATE);
    assign r_PC_BSC_D0 = NEXUS_CLIENT_D0;
    assign rf_gpr_BSC_UPDATE0 = {(nexus_client_bsc_66_select_wire & NEXUS_CLIENT_UPDATE),(nexus_client_bsc_65_select_wire & NEXUS_CLIENT_UPDATE)};
    assign rf_gpr_BSC_D0 = NEXUS_CLIENT_D0;
    assign NEXUS_CLIENT_Q0 = (nrrs_dc_select_wire == 1'd1) ? nrrs_dc_reg_Q0 :
        (dev_status_select_wire == 1'd1) ? dev_status_wire :
        (bw0_NEXUS_SEL == 1'd1) ? bw0_NEXUS_CLIENT_Q0 :
        (bw1_NEXUS_SEL == 1'd1) ? bw1_NEXUS_CLIENT_Q0 :
        (bw2_NEXUS_SEL == 1'd1) ? bw2_NEXUS_CLIENT_Q0 :
        (bw3_NEXUS_SEL == 1'd1) ? bw3_NEXUS_CLIENT_Q0 :
        (nexus_client_bsc_64_select_wire == 1'd1) ? r_PC_BSC_Q0 :
        (nexus_client_bsc_66_select_wire == 1'd1) ? rf_gpr_BSC_Q0 : 32'd0;
    assign NEXUS_CLIENT_RST_REQUEST = nrrs_dc_reg_Q0[24];
    assign s_port_break_en_D0 = codasip_break_en_wire;
    assign s_port_break_hw_D0 = (((user_mode_wire == 1'd1) && (debug_mode_hw_req_wire == 1'd1)) || ((state_reg_Q0 == STATE_DEBUG_WAIT) || (DEBUG_MODE_wire == 1'd1)));
endmodule
