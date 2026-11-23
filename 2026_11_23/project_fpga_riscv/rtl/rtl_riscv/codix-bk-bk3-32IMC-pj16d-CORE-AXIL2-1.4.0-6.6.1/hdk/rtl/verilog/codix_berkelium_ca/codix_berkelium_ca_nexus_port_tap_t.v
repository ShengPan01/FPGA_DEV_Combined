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
 *  \brief   Contains module definition of the 'codix_berkelium_ca_nexus_port_tap_t' JTAG Test Access Port specified specified by IEEE Std 1149.1-2001.
 */

module codix_berkelium_ca_nexus_port_tap_t(
    input  wire TCK,
    input  wire TRST,
    input  wire TMS,
    input  wire TDI,
    input  wire NEXUS_TDO,
    input  wire DEBUG_MODE,
    output wire TDO,
    output wire NEXUS_BAR,
    output wire NEXUS_CAPTURE,
    output wire NEXUS_SEL,
    output wire NEXUS_SHIFT,
    output wire NEXUS_UPDATE,
    output wire NEXUS_TDI
);
    // type, wire and constant declarations:
    // signal/wire (inner)
    wire capture_ir_wire;
    // signal/wire (inner)
    wire capture_dr_wire;
    // signal/wire (inner)
    wire shift_ir_wire;
    // signal/wire (inner)
    wire shift_dr_wire;
    // signal/wire (inner)
    wire update_ir_wire;
    // signal/wire (inner)
    wire update_dr_wire;
    // signal/wire (inner)
    wire idcode_reg_enable_wire;
    // signal/wire (inner)
    wire nexus_access_enable_wire;
    // signal/wire (inner)
    wire nexus_control_shift_reg_enable_wire;
    // signal/wire (inner)
    wire bypass_reg_enable_wire;
    // signal/wire (inner)
    wire NEXUS_RST_assert_cnd_wire;
    // FSM state constants
    localparam [3:0] STATE_TEST_LOGIC_RESET = 4'b0;
    localparam [3:0] STATE_RUN_TEST_IDLE = 4'b0001;
    localparam [3:0] STATE_SELECT_DR = 4'b0010;
    localparam [3:0] STATE_SELECT_IR = 4'b0011;
    localparam [3:0] STATE_CAPTURE_DR = 4'b0100;
    localparam [3:0] STATE_SHIFT_DR = 4'b0101;
    localparam [3:0] STATE_EXIT1_DR = 4'b0110;
    localparam [3:0] STATE_PAUSE_DR = 4'b0111;
    localparam [3:0] STATE_EXIT2_DR = 4'b1000;
    localparam [3:0] STATE_UPDATE_DR = 4'b1001;
    localparam [3:0] STATE_CAPTURE_IR = 4'b1010;
    localparam [3:0] STATE_SHIFT_IR = 4'b1011;
    localparam [3:0] STATE_EXIT1_IR = 4'b1100;
    localparam [3:0] STATE_PAUSE_IR = 4'b1101;
    localparam [3:0] STATE_EXIT2_IR = 4'b1110;
    localparam [3:0] STATE_UPDATE_IR = 4'b1111;
    // FSM state register (current state)
    reg [3:0] state_reg_Q0;
    // FSM state register (next state)
    reg [3:0] state_reg_D0;

    // additional declarations:
    wire instr_reg_WE0;
    wire [3:0] instr_reg_D0;
    wire [3:0] instr_reg_Q0;
    wire instr_shift_reg_BSC_CAPTURE0;
    wire instr_shift_reg_BSC_SHIFT0;
    wire instr_shift_reg_SI;
    wire [3:0] instr_shift_reg_D0;
    wire [3:0] instr_shift_reg_Q0;
    wire bypass_reg_BSC_CAPTURE0;
    wire bypass_reg_BSC_SHIFT0;
    wire bypass_reg_SI;
    wire bypass_reg_D0;
    wire bypass_reg_Q0;
    wire idcode_reg_BSC_CAPTURE0;
    wire idcode_reg_BSC_SHIFT0;
    wire idcode_reg_SI;
    wire [31:0] idcode_reg_D0;
    wire [31:0] idcode_reg_Q0;
    wire nexus_control_shift_reg_BSC_CAPTURE0;
    wire nexus_control_shift_reg_BSC_SHIFT0;
    wire nexus_control_shift_reg_SI;
    wire [1:0] nexus_control_shift_reg_D0;
    wire [1:0] nexus_control_shift_reg_Q0;
    wire nexus_control_reg_WE0;
    wire nexus_control_reg_D0;
    wire nexus_control_reg_Q0;
    wire TDO_reg_CLK;
    wire TDO_reg_D0;
    wire TDO_reg_Q0;

    // FSM state register
    always @( posedge TCK or negedge TRST ) begin
        if ( TRST == 1'b0 ) begin
            state_reg_Q0 <= STATE_TEST_LOGIC_RESET;
        end else begin
            state_reg_Q0 <= state_reg_D0;
        end
    end
    // FSM transitions (next state logic)
    always @(*) begin
        case ( state_reg_Q0 )
            STATE_TEST_LOGIC_RESET: begin
                if ( (TMS == 1'd1) ) begin
                    state_reg_D0 = STATE_TEST_LOGIC_RESET;
                end else begin
                    state_reg_D0 = STATE_RUN_TEST_IDLE;
                end
            end
            STATE_RUN_TEST_IDLE: begin
                if ( (TMS == 1'd1) ) begin
                    state_reg_D0 = STATE_SELECT_DR;
                end else begin
                    state_reg_D0 = STATE_RUN_TEST_IDLE;
                end
            end
            STATE_SELECT_DR: begin
                if ( (TMS == 1'd1) ) begin
                    state_reg_D0 = STATE_SELECT_IR;
                end else begin
                    state_reg_D0 = STATE_CAPTURE_DR;
                end
            end
            STATE_SELECT_IR: begin
                if ( (TMS == 1'd1) ) begin
                    state_reg_D0 = STATE_TEST_LOGIC_RESET;
                end else begin
                    state_reg_D0 = STATE_CAPTURE_IR;
                end
            end
            STATE_CAPTURE_DR: begin
                if ( (TMS == 1'd1) ) begin
                    state_reg_D0 = STATE_EXIT1_DR;
                end else begin
                    state_reg_D0 = STATE_SHIFT_DR;
                end
            end
            STATE_SHIFT_DR: begin
                if ( (TMS == 1'd1) ) begin
                    state_reg_D0 = STATE_EXIT1_DR;
                end else begin
                    state_reg_D0 = STATE_SHIFT_DR;
                end
            end
            STATE_EXIT1_DR: begin
                if ( (TMS == 1'd1) ) begin
                    state_reg_D0 = STATE_UPDATE_DR;
                end else begin
                    state_reg_D0 = STATE_PAUSE_DR;
                end
            end
            STATE_PAUSE_DR: begin
                if ( (TMS == 1'd1) ) begin
                    state_reg_D0 = STATE_EXIT2_DR;
                end else begin
                    state_reg_D0 = STATE_PAUSE_DR;
                end
            end
            STATE_EXIT2_DR: begin
                if ( (TMS == 1'd1) ) begin
                    state_reg_D0 = STATE_UPDATE_DR;
                end else begin
                    state_reg_D0 = STATE_SHIFT_DR;
                end
            end
            STATE_UPDATE_DR: begin
                if ( (TMS == 1'd1) ) begin
                    state_reg_D0 = STATE_SELECT_DR;
                end else begin
                    state_reg_D0 = STATE_RUN_TEST_IDLE;
                end
            end
            STATE_CAPTURE_IR: begin
                if ( (TMS == 1'd1) ) begin
                    state_reg_D0 = STATE_EXIT1_IR;
                end else begin
                    state_reg_D0 = STATE_SHIFT_IR;
                end
            end
            STATE_SHIFT_IR: begin
                if ( (TMS == 1'd1) ) begin
                    state_reg_D0 = STATE_EXIT1_IR;
                end else begin
                    state_reg_D0 = STATE_SHIFT_IR;
                end
            end
            STATE_EXIT1_IR: begin
                if ( (TMS == 1'd1) ) begin
                    state_reg_D0 = STATE_UPDATE_IR;
                end else begin
                    state_reg_D0 = STATE_PAUSE_IR;
                end
            end
            STATE_PAUSE_IR: begin
                if ( (TMS == 1'd1) ) begin
                    state_reg_D0 = STATE_EXIT2_IR;
                end else begin
                    state_reg_D0 = STATE_PAUSE_IR;
                end
            end
            STATE_EXIT2_IR: begin
                if ( (TMS == 1'd1) ) begin
                    state_reg_D0 = STATE_UPDATE_IR;
                end else begin
                    state_reg_D0 = STATE_SHIFT_IR;
                end
            end
            STATE_UPDATE_IR: begin
                if ( (TMS == 1'd1) ) begin
                    state_reg_D0 = STATE_SELECT_DR;
                end else begin
                    state_reg_D0 = STATE_RUN_TEST_IDLE;
                end
            end
            // fault recovery
            default: begin
                state_reg_D0 = STATE_TEST_LOGIC_RESET;
            end
        endcase
    end

    // child instances inside 'tap' JTAG Test Access Port:
    // instance of 'instr_reg' register:
    d_ff_plain_rst_we_t #(
        .bit_width(32'd4),
        .default_value(4'b0010),
        .reset_level(1'b0),
        .reset_sync(1'b0)
    ) instr_reg (
        .CLK(TCK),
        .RST(TRST),
        .WE0(instr_reg_WE0),
        .D0(instr_reg_D0),
        .Q0(instr_reg_Q0)
    );

    // instance of 'instr_shift_reg' register:
    bsc_shift_reg_t #(
        .bit_width(32'd4),
        .default_value(4'b0),
        .reset_level(1'b0),
        .reset_sync(1'b0)
    ) instr_shift_reg (
        .CLK(TCK),
        .RST(TRST),
        .BSC_CAPTURE0(instr_shift_reg_BSC_CAPTURE0),
        .BSC_SHIFT0(instr_shift_reg_BSC_SHIFT0),
        .SI(instr_shift_reg_SI),
        .D0(instr_shift_reg_D0),
        .Q0(instr_shift_reg_Q0)
    );

    // instance of 'bypass_reg' register:
    bsc_shift_reg_t #(
        .bit_width(32'd1),
        .default_value(1'b0),
        .reset_level(1'b0),
        .reset_sync(1'b0)
    ) bypass_reg (
        .CLK(TCK),
        .RST(TRST),
        .BSC_CAPTURE0(bypass_reg_BSC_CAPTURE0),
        .BSC_SHIFT0(bypass_reg_BSC_SHIFT0),
        .SI(bypass_reg_SI),
        .D0(bypass_reg_D0),
        .Q0(bypass_reg_Q0)
    );

    // instance of 'idcode_reg' register:
    bsc_shift_reg_t #(
        .bit_width(32'd32),
        .default_value(32'b0),
        .reset_level(1'b0),
        .reset_sync(1'b0)
    ) idcode_reg (
        .CLK(TCK),
        .RST(TRST),
        .BSC_CAPTURE0(idcode_reg_BSC_CAPTURE0),
        .BSC_SHIFT0(idcode_reg_BSC_SHIFT0),
        .SI(idcode_reg_SI),
        .D0(idcode_reg_D0),
        .Q0(idcode_reg_Q0)
    );

    // instance of 'nexus_control_shift_reg' register:
    bsc_shift_reg_t #(
        .bit_width(32'd2),
        .default_value(2'b0),
        .reset_level(1'b0),
        .reset_sync(1'b0)
    ) nexus_control_shift_reg (
        .CLK(TCK),
        .RST(TRST),
        .BSC_CAPTURE0(nexus_control_shift_reg_BSC_CAPTURE0),
        .BSC_SHIFT0(nexus_control_shift_reg_BSC_SHIFT0),
        .SI(nexus_control_shift_reg_SI),
        .D0(nexus_control_shift_reg_D0),
        .Q0(nexus_control_shift_reg_Q0)
    );

    // instance of 'nexus_control_reg' register:
    d_ff_plain_rst_we_t #(
        .bit_width(32'd1),
        .default_value(1'b0),
        .reset_level(1'b0),
        .reset_sync(1'b0)
    ) nexus_control_reg (
        .CLK(TCK),
        .RST(TRST),
        .WE0(nexus_control_reg_WE0),
        .D0(nexus_control_reg_D0),
        .Q0(nexus_control_reg_Q0)
    );

    // instance of 'TDO_reg' register:
    d_ff_plain_rst_t #(
        .bit_width(32'd1),
        .default_value(1'b0),
        .reset_level(1'b0),
        .reset_sync(1'b0)
    ) TDO_reg (
        .CLK(TDO_reg_CLK),
        .RST(TRST),
        .D0(TDO_reg_D0),
        .Q0(TDO_reg_Q0)
    );

    // data-path code:
    assign capture_ir_wire = (state_reg_Q0 == STATE_CAPTURE_IR);
    assign capture_dr_wire = (state_reg_Q0 == STATE_CAPTURE_DR);
    assign shift_ir_wire = (state_reg_Q0 == STATE_SHIFT_IR);
    assign shift_dr_wire = (state_reg_Q0 == STATE_SHIFT_DR);
    assign update_ir_wire = (state_reg_Q0 == STATE_UPDATE_IR);
    assign update_dr_wire = (state_reg_Q0 == STATE_UPDATE_DR);
    assign idcode_reg_enable_wire = (instr_reg_Q0 == 4'd2);
    assign nexus_access_enable_wire = (instr_reg_Q0 == 4'd3);
    assign nexus_control_shift_reg_enable_wire = (instr_reg_Q0 == 4'd4);
    assign bypass_reg_enable_wire = ((~idcode_reg_enable_wire) & ((~nexus_access_enable_wire) & (~nexus_control_shift_reg_enable_wire)));
    assign NEXUS_RST_assert_cnd_wire = ((state_reg_Q0 == STATE_TEST_LOGIC_RESET) || ((state_reg_Q0 == STATE_SELECT_IR) && (TMS == 1'd1)));
    assign instr_reg_D0 = NEXUS_RST_assert_cnd_wire ? 4'd2 : instr_shift_reg_Q0;
    assign instr_reg_WE0 = (NEXUS_RST_assert_cnd_wire || update_ir_wire);
    assign instr_shift_reg_D0 = 4'd1;
    assign instr_shift_reg_BSC_CAPTURE0 = capture_ir_wire;
    assign instr_shift_reg_BSC_SHIFT0 = shift_ir_wire;
    assign instr_shift_reg_SI = TDI;
    assign bypass_reg_D0 = 1'd0;
    assign bypass_reg_BSC_CAPTURE0 = (bypass_reg_enable_wire & capture_dr_wire);
    assign bypass_reg_BSC_SHIFT0 = (bypass_reg_enable_wire & shift_dr_wire);
    assign bypass_reg_SI = TDI;
    assign idcode_reg_D0 = 32'd268439555;
    assign idcode_reg_BSC_CAPTURE0 = (idcode_reg_enable_wire & capture_dr_wire);
    assign idcode_reg_BSC_SHIFT0 = (idcode_reg_enable_wire & shift_dr_wire);
    assign idcode_reg_SI = TDI;
    assign nexus_control_shift_reg_D0 = {DEBUG_MODE,nexus_control_reg_Q0};
    assign nexus_control_shift_reg_BSC_CAPTURE0 = (nexus_control_shift_reg_enable_wire & capture_dr_wire);
    assign nexus_control_shift_reg_BSC_SHIFT0 = (nexus_control_shift_reg_enable_wire & shift_dr_wire);
    assign nexus_control_shift_reg_SI = TDI;
    assign nexus_control_reg_D0 = (!NEXUS_RST_assert_cnd_wire) ? nexus_control_shift_reg_Q0[0] : 1'd0;
    assign nexus_control_reg_WE0 = (NEXUS_RST_assert_cnd_wire | (update_dr_wire & nexus_control_shift_reg_enable_wire));
    assign TDO_reg_CLK = (~TCK);
    assign TDO_reg_D0 = (shift_ir_wire == 1'd1) ? instr_shift_reg_Q0[0] :
        ((shift_dr_wire == 1'd1) && (idcode_reg_enable_wire == 1'd1)) ? idcode_reg_Q0[0] :
        ((shift_dr_wire == 1'd1) && (nexus_control_shift_reg_enable_wire == 1'd1)) ? nexus_control_shift_reg_Q0[0] :
        ((shift_dr_wire == 1'd1) && (nexus_access_enable_wire == 1'd1)) ? NEXUS_TDO :
        (shift_dr_wire == 1'd1) ? bypass_reg_Q0 : 1'd0;
    assign TDO = TDO_reg_Q0;
    assign NEXUS_BAR = nexus_control_reg_Q0;
    assign NEXUS_CAPTURE = (capture_dr_wire & nexus_access_enable_wire);
    assign NEXUS_SEL = nexus_access_enable_wire;
    assign NEXUS_SHIFT = (shift_dr_wire & nexus_access_enable_wire);
    assign NEXUS_TDI = (TDI & nexus_access_enable_wire);
    assign NEXUS_UPDATE = (update_dr_wire & nexus_access_enable_wire);
endmodule
