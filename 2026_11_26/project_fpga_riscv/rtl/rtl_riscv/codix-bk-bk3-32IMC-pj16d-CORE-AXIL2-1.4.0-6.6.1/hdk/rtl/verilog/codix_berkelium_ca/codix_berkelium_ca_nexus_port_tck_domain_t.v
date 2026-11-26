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
 *  \brief   Contains module definition of the 'codix_berkelium_ca_nexus_port_tck_domain_t' Internal logic of Nexus Port running on JTAG clock domain (TCK).
 */

module codix_berkelium_ca_nexus_port_tck_domain_t(
    input  wire TCK,
    input  wire TRST,
    input  wire NEXUS_CAPTURE,
    input  wire NEXUS_SEL,
    input  wire NEXUS_SHIFT,
    input  wire NEXUS_UPDATE,
    input  wire NEXUS_TDI,
    input  wire sync_data_from_clk_DONE_TCK,
    input  wire [31:0] sync_data_from_clk_TCK,
    output wire NEXUS_TDO,
    output wire sync_addr_from_tck_READY_TCK,
    output wire [7:0] sync_addr_from_tck_TCK,
    output wire sync_data_from_tck_READY_TCK,
    output wire [31:0] sync_data_from_tck_TCK
);
    // type, wire and constant declarations:
    // FSM state constants
    localparam [2:0] STATE_IDLE = 3'b0;
    localparam [2:0] STATE_ADDR_CAPTURE = 3'b001;
    localparam [2:0] STATE_ADDR_SHIFT = 3'b010;
    localparam [2:0] STATE_DATA_CAPTURE = 3'b011;
    localparam [2:0] STATE_DATA_SHIFT = 3'b100;
    localparam [2:0] STATE_DATA_UPDATE = 3'b101;
    // FSM state register (current state)
    reg [2:0] state_reg_Q0;
    // FSM state register (next state)
    reg [2:0] state_reg_D0;
    // signal/wire (inner)
    wire sync_status_wire;

    // additional declarations:
    wire addr_shift_reg_BSC_CAPTURE0;
    wire addr_shift_reg_BSC_SHIFT0;
    wire addr_shift_reg_SI;
    wire [7:0] addr_shift_reg_D0;
    wire [7:0] addr_shift_reg_Q0;
    wire data_shift_reg_BSC_CAPTURE0;
    wire data_shift_reg_BSC_SHIFT0;
    wire data_shift_reg_SI;
    wire [31:0] data_shift_reg_D0;
    wire [31:0] data_shift_reg_Q0;
    wire addr_ready_reg_D0;
    wire addr_ready_reg_Q0;
    wire data_ready_reg_D0;
    wire data_ready_reg_Q0;
    wire sync_status_reg_WE0;
    wire sync_status_reg_D0;
    wire sync_status_reg_Q0;

    // FSM state register
    always @( posedge TCK or negedge TRST ) begin
        if ( TRST == 1'b0 ) begin
            state_reg_Q0 <= STATE_IDLE;
        end else begin
            state_reg_Q0 <= state_reg_D0;
        end
    end
    // FSM transitions (next state logic)
    always @(*) begin
        case ( state_reg_Q0 )
            STATE_IDLE: begin
                if ( (NEXUS_SEL == 1'd0) ) begin
                    state_reg_D0 = STATE_IDLE;
                end else begin
                    state_reg_D0 = STATE_ADDR_CAPTURE;
                end
            end
            STATE_ADDR_CAPTURE: begin
                if ( (NEXUS_SEL == 1'd0) ) begin
                    state_reg_D0 = STATE_IDLE;
                end else if ( (NEXUS_CAPTURE == 1'd1) ) begin
                    state_reg_D0 = STATE_ADDR_SHIFT;
                end else begin
                    state_reg_D0 = STATE_ADDR_CAPTURE;
                end
            end
            STATE_ADDR_SHIFT: begin
                if ( (NEXUS_UPDATE == 1'd1) ) begin
                    state_reg_D0 = STATE_DATA_CAPTURE;
                end else begin
                    state_reg_D0 = STATE_ADDR_SHIFT;
                end
            end
            STATE_DATA_CAPTURE: begin
                if ( (NEXUS_SEL == 1'd0) ) begin
                    state_reg_D0 = STATE_IDLE;
                end else if ( (NEXUS_CAPTURE == 1'd1) ) begin
                    state_reg_D0 = STATE_DATA_SHIFT;
                end else begin
                    state_reg_D0 = STATE_DATA_CAPTURE;
                end
            end
            STATE_DATA_SHIFT: begin
                if ( (NEXUS_UPDATE == 1'd1) ) begin
                    state_reg_D0 = STATE_DATA_UPDATE;
                end else begin
                    state_reg_D0 = STATE_DATA_SHIFT;
                end
            end
            STATE_DATA_UPDATE: begin
                if ( (NEXUS_SEL == 1'd0) ) begin
                    state_reg_D0 = STATE_IDLE;
                end else if ( (NEXUS_CAPTURE == 1'd1) ) begin
                    state_reg_D0 = STATE_ADDR_SHIFT;
                end else begin
                    state_reg_D0 = STATE_DATA_UPDATE;
                end
            end
            // fault recovery
            default: begin
                state_reg_D0 = STATE_IDLE;
            end
        endcase
    end

    // child instances inside 'tck_domain' Internal logic of Nexus Port running on JTAG clock domain (TCK):
    // instance of 'addr_shift_reg' register:
    bsc_shift_reg_t #(
        .bit_width(32'd8),
        .default_value(8'b0),
        .reset_level(1'b0),
        .reset_sync(1'b0)
    ) addr_shift_reg (
        .CLK(TCK),
        .RST(TRST),
        .BSC_CAPTURE0(addr_shift_reg_BSC_CAPTURE0),
        .BSC_SHIFT0(addr_shift_reg_BSC_SHIFT0),
        .SI(addr_shift_reg_SI),
        .D0(addr_shift_reg_D0),
        .Q0(addr_shift_reg_Q0)
    );

    // instance of 'data_shift_reg' register:
    bsc_shift_reg_t #(
        .bit_width(32'd32),
        .default_value(32'b0),
        .reset_level(1'b0),
        .reset_sync(1'b0)
    ) data_shift_reg (
        .CLK(TCK),
        .RST(TRST),
        .BSC_CAPTURE0(data_shift_reg_BSC_CAPTURE0),
        .BSC_SHIFT0(data_shift_reg_BSC_SHIFT0),
        .SI(data_shift_reg_SI),
        .D0(data_shift_reg_D0),
        .Q0(data_shift_reg_Q0)
    );

    // instance of 'addr_ready_reg' register:
    d_ff_plain_rst_t #(
        .bit_width(32'd1),
        .default_value(1'b0),
        .reset_level(1'b0),
        .reset_sync(1'b0)
    ) addr_ready_reg (
        .CLK(TCK),
        .RST(TRST),
        .D0(addr_ready_reg_D0),
        .Q0(addr_ready_reg_Q0)
    );

    // instance of 'data_ready_reg' register:
    d_ff_plain_rst_t #(
        .bit_width(32'd1),
        .default_value(1'b0),
        .reset_level(1'b0),
        .reset_sync(1'b0)
    ) data_ready_reg (
        .CLK(TCK),
        .RST(TRST),
        .D0(data_ready_reg_D0),
        .Q0(data_ready_reg_Q0)
    );

    // instance of 'sync_status_reg' register:
    d_ff_plain_rst_we_t #(
        .bit_width(32'd1),
        .default_value(1'b0),
        .reset_level(1'b0),
        .reset_sync(1'b0)
    ) sync_status_reg (
        .CLK(TCK),
        .RST(TRST),
        .WE0(sync_status_reg_WE0),
        .D0(sync_status_reg_D0),
        .Q0(sync_status_reg_Q0)
    );

    // data-path code:
    assign addr_shift_reg_BSC_CAPTURE0 = ((NEXUS_CAPTURE == 1'd1) && ((state_reg_Q0 == STATE_ADDR_CAPTURE) || (state_reg_Q0 == STATE_DATA_UPDATE)));
    assign addr_shift_reg_BSC_SHIFT0 = ((NEXUS_SHIFT == 1'd1) && (state_reg_Q0 == STATE_ADDR_SHIFT));
    assign addr_shift_reg_D0 = {7'd0,sync_status_reg_Q0};
    assign addr_shift_reg_SI = NEXUS_TDI;
    assign data_shift_reg_BSC_CAPTURE0 = ((NEXUS_CAPTURE == 1'd1) && (state_reg_Q0 == STATE_DATA_CAPTURE));
    assign data_shift_reg_BSC_SHIFT0 = ((NEXUS_SHIFT == 1'd1) && (state_reg_Q0 == STATE_DATA_SHIFT));
    assign data_shift_reg_D0 = sync_data_from_clk_TCK;
    assign data_shift_reg_SI = NEXUS_TDI;
    assign addr_ready_reg_D0 = ((state_reg_Q0 == STATE_DATA_CAPTURE) || ((state_reg_Q0 == STATE_ADDR_SHIFT) && (NEXUS_UPDATE == 1'd1)));
    assign data_ready_reg_D0 = ((state_reg_Q0 == STATE_DATA_UPDATE) || ((state_reg_Q0 == STATE_DATA_SHIFT) && (NEXUS_UPDATE == 1'd1)));
    assign sync_status_wire = ((state_reg_Q0 == STATE_ADDR_SHIFT) && ((NEXUS_UPDATE == 1'd1) && (addr_shift_reg_Q0[0] == 1'd0)));
    assign sync_status_reg_D0 = sync_status_wire;
    assign sync_status_reg_WE0 = ((sync_status_wire == 1'd1) || (((state_reg_Q0 == STATE_DATA_CAPTURE) && (sync_data_from_clk_DONE_TCK == 1'd1)) || ((!(state_reg_Q0 == STATE_IDLE)) && (NEXUS_SEL == 1'd0))));
    assign NEXUS_TDO = (state_reg_Q0 == STATE_ADDR_SHIFT) ? addr_shift_reg_Q0[0] :
        (state_reg_Q0 == STATE_DATA_SHIFT) ? data_shift_reg_Q0[0] : 1'd0;
    assign sync_addr_from_tck_TCK = addr_shift_reg_Q0;
    assign sync_addr_from_tck_READY_TCK = addr_ready_reg_Q0;
    assign sync_data_from_tck_TCK = data_shift_reg_Q0;
    assign sync_data_from_tck_READY_TCK = data_ready_reg_Q0;
endmodule
