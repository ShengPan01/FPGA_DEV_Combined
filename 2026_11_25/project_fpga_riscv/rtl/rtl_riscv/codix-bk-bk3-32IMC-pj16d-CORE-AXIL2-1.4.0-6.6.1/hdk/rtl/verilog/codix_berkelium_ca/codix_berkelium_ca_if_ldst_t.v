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
 *  \brief   Contains module definition of the 'codix_berkelium_ca_if_ldst_t' CodAL interface with Nexus support.
 */

module codix_berkelium_ca_if_ldst_t(
    input  wire CLK,
    input  wire RST,
    input  wire [6:0] NEXUS_RRS,
    input  wire [31:0] A0,
    input  wire [2:0] BC0,
    input  wire [1:0] BI0,
    input  wire [31:0] D0,
    input  wire [31:0] if_ldst_Q0,
    input  wire [2:0] if_ldst_RESPONSE0,
    input  wire [1:0] if_ldst_STATUS0,
    input  wire NEXUS_CLIENT_CAPTURE,
    input  wire [31:0] NEXUS_CLIENT_D0,
    input  wire NEXUS_CLIENT_UPDATE,
    input  wire [2:0] REQUEST0,
    output wire [31:0] if_ldst_A0,
    output wire [2:0] if_ldst_BC0,
    output wire [1:0] if_ldst_BI0,
    output wire [31:0] if_ldst_D0,
    output wire [2:0] if_ldst_REQUEST0,
    output wire [31:0] NEXUS_CLIENT_Q0,
    output wire [31:0] Q0,
    output wire [2:0] RESPONSE0,
    output wire [1:0] STATUS0
);
    // type, wire and constant declarations:
    // request command constants (CLB)
    localparam [2:0] CP_CMD_NONE = 3'b0;
    localparam [2:0] CP_CMD_READ = 3'b001;
    localparam [2:0] CP_CMD_WRITE = 3'b010;
    localparam [2:0] CP_CMD_INVALIDATE = 3'b100;
    localparam [2:0] CP_CMD_INVALIDATE_ALL = 3'b101;
    localparam [2:0] CP_CMD_FLUSH = 3'b110;
    localparam [2:0] CP_CMD_FLUSH_ALL = 3'b111;
    // request command constants (Memory)
    localparam [1:0] CP_CMD_NONE_MEM = 2'b0;
    localparam [1:0] CP_CMD_READ_MEM = 2'b01;
    localparam [1:0] CP_CMD_WRITE_MEM = 2'b10;
    // slave status constants
    localparam [1:0] CP_ST_BUSY = 2'b0;
    localparam [1:0] CP_ST_READY = 2'b01;
    localparam [1:0] CP_ST_ERROR = 2'b11;
    // command response constants
    localparam [2:0] CP_RS_IDLE = 3'b0;
    localparam [2:0] CP_RS_ACK = 3'b001;
    localparam [2:0] CP_RS_WAIT = 3'b010;
    localparam [2:0] CP_RS_ERROR = 3'b011;
    localparam [2:0] CP_RS_UNALIGNED = 3'b100;
    localparam [2:0] CP_RS_OOR = 3'b101;

    // FSM state constants
    localparam [3:0] STATE_IDLE = 4'b0;
    localparam [3:0] STATE_ERROR = 4'b0001;
    localparam [3:0] STATE_READ_REQ = 4'b0010;
    localparam [3:0] STATE_READ_DONE = 4'b0011;
    localparam [3:0] STATE_READ_FINISH = 4'b0100;
    localparam [3:0] STATE_WRITE_REQ = 4'b0101;
    localparam [3:0] STATE_WRITE_DONE = 4'b0110;
    localparam [3:0] STATE_WRITE_FINISH = 4'b0111;
    localparam [3:0] STATE_FLUSH = 4'b1000;
    localparam [3:0] STATE_INVALIDATE = 4'b1001;
    // FSM state register (current state)
    reg [3:0] state_reg_Q0;
    // FSM state register (next state)
    reg [3:0] state_reg_D0;
    // signal/wire (inner)
    wire request_status_ready_flag_wire;
    // signal/wire (inner)
    wire request_error_flag_wire;
    // signal/wire (inner)
    wire finish_ack_flag_wire;
    // signal/wire (inner)
    wire finish_error_flag_wire;
    // signal/wire (inner)
    wire [2:0] REQUEST_wire;
    // signal/wire (inner)
    wire update_access_wire;
    // signal/wire (inner)
    wire update_dv_wire;
    // signal/wire (inner)
    wire rwd_update_wire;
    // signal/wire (inner)
    wire rwcs_new_ac_wire;
    // signal/wire (inner)
    wire rwcs_cif_new_wire;
    // signal/wire (inner)
    wire rwcs_error_wire;
    // signal/wire (inner)
    wire rwcs_dv_wire;
    // signal/wire (inner)
    wire [13:0] rwcs_access_cntr_wire;
    // signal/wire (inner)
    wire rwcs_select_wire;
    // signal/wire (inner)
    wire rwa_select_wire;
    // signal/wire (inner)
    wire rwd_select_wire;

    // additional declarations:
    wire rwcs_reg_WE0;
    wire [31:0] rwcs_reg_D0;
    wire [31:0] rwcs_reg_Q0;
    wire update_delay_rwcs_reg_D0;
    wire update_delay_rwcs_reg_Q0;
    wire rwa_reg_WE0;
    wire [31:0] rwa_reg_D0;
    wire [31:0] rwa_reg_Q0;
    wire rwd_reg_WE0;
    wire [31:0] rwd_reg_D0;
    wire [31:0] rwd_reg_Q0;
    wire read_data_reg_WE0;
    wire [31:0] read_data_reg_D0;
    wire [31:0] read_data_reg_Q0;
    wire update_delay_read_data_reg_D0;
    wire update_delay_read_data_reg_Q0;
    wire update_delay_write_data_reg_D0;
    wire update_delay_write_data_reg_Q0;

    // FSM state register
    always @( posedge CLK or negedge RST ) begin
        if ( RST == 1'b0 ) begin
            state_reg_Q0 <= STATE_IDLE;
        end else begin
            state_reg_Q0 <= state_reg_D0;
        end
    end
    // FSM transitions (next state logic)
    always @(*) begin
        case ( state_reg_Q0 )
            STATE_IDLE: begin
                if ( ((rwcs_reg_Q0[31] == 1'd1) && (rwcs_reg_Q0[15:2] == 14'd0)) ) begin
                    state_reg_D0 = STATE_WRITE_DONE;
                end else if ( (((rwcs_reg_Q0[31] == 1'd1) && (rwcs_reg_Q0[30] == 1'd0)) && ((rwcs_reg_Q0[16] == 1'd1) && (update_delay_rwcs_reg_Q0 == 1'd1))) ) begin
                    state_reg_D0 = STATE_INVALIDATE;
                end else if ( ((rwcs_reg_Q0[31] == 1'd1) && ((rwcs_reg_Q0[30] == 1'd0) && ((update_delay_rwcs_reg_Q0 == 1'd1) || (update_delay_read_data_reg_Q0 == 1'd1)))) ) begin
                    state_reg_D0 = STATE_READ_REQ;
                end else if ( ((rwcs_reg_Q0[31] == 1'd1) && ((rwcs_reg_Q0[30] == 1'd1) && ((update_delay_rwcs_reg_Q0 == 1'd1) || (update_delay_write_data_reg_Q0 == 1'd1)))) ) begin
                    state_reg_D0 = STATE_WRITE_REQ;
                end else begin
                    state_reg_D0 = STATE_IDLE;
                end
            end
            STATE_ERROR: begin
                state_reg_D0 = STATE_IDLE;
            end
            STATE_READ_REQ: begin
                if ( (request_status_ready_flag_wire == 1'd1) ) begin
                    state_reg_D0 = STATE_READ_FINISH;
                end else if ( (request_error_flag_wire == 1'd1) ) begin
                    state_reg_D0 = STATE_ERROR;
                end else begin
                    state_reg_D0 = STATE_READ_REQ;
                end
            end
            STATE_READ_DONE: begin
                state_reg_D0 = STATE_IDLE;
            end
            STATE_READ_FINISH: begin
                if ( (finish_ack_flag_wire == 1'd1) ) begin
                    state_reg_D0 = STATE_READ_DONE;
                end else if ( (finish_error_flag_wire == 1'd1) ) begin
                    state_reg_D0 = STATE_ERROR;
                end else begin
                    state_reg_D0 = STATE_READ_FINISH;
                end
            end
            STATE_WRITE_REQ: begin
                if ( (request_status_ready_flag_wire == 1'd1) ) begin
                    state_reg_D0 = STATE_WRITE_FINISH;
                end else if ( (request_error_flag_wire == 1'd1) ) begin
                    state_reg_D0 = STATE_ERROR;
                end else begin
                    state_reg_D0 = STATE_WRITE_REQ;
                end
            end
            STATE_WRITE_DONE: begin
                state_reg_D0 = STATE_IDLE;
            end
            STATE_WRITE_FINISH: begin
                if ( ((if_ldst_RESPONSE0 == CP_RS_ACK) && ((rwcs_reg_Q0[16] == 1'd1) && (rwcs_new_ac_wire == 1'd0))) ) begin
                    state_reg_D0 = STATE_FLUSH;
                end else if ( (finish_ack_flag_wire == 1'd1) ) begin
                    state_reg_D0 = STATE_WRITE_DONE;
                end else if ( (finish_error_flag_wire == 1'd1) ) begin
                    state_reg_D0 = STATE_ERROR;
                end else begin
                    state_reg_D0 = STATE_WRITE_FINISH;
                end
            end
            STATE_FLUSH: begin
                if ( (request_status_ready_flag_wire == 1'd1) ) begin
                    state_reg_D0 = STATE_WRITE_DONE;
                end else if ( (request_error_flag_wire == 1'd1) ) begin
                    state_reg_D0 = STATE_ERROR;
                end else begin
                    state_reg_D0 = STATE_FLUSH;
                end
            end
            STATE_INVALIDATE: begin
                if ( (request_status_ready_flag_wire == 1'd1) ) begin
                    state_reg_D0 = STATE_READ_REQ;
                end else if ( (request_error_flag_wire == 1'd1) ) begin
                    state_reg_D0 = STATE_ERROR;
                end else begin
                    state_reg_D0 = STATE_INVALIDATE;
                end
            end
            // fault recovery
            default: begin
                state_reg_D0 = STATE_IDLE;
            end
        endcase
    end

    // child instances inside 'if_ldst' CodAL interface with Nexus support:
    // instance of 'rwcs_reg' register:
    d_ff_plain_rst_we_t #(
        .bit_width(32'd32),
        .default_value(32'b0),
        .reset_level(1'b0),
        .reset_sync(1'b0)
    ) rwcs_reg (
        .CLK(CLK),
        .RST(RST),
        .WE0(rwcs_reg_WE0),
        .D0(rwcs_reg_D0),
        .Q0(rwcs_reg_Q0)
    );

    // instance of 'update_delay_rwcs_reg' register:
    d_ff_plain_rst_t #(
        .bit_width(32'd1),
        .default_value(1'b0),
        .reset_level(1'b0),
        .reset_sync(1'b0)
    ) update_delay_rwcs_reg (
        .CLK(CLK),
        .RST(RST),
        .D0(update_delay_rwcs_reg_D0),
        .Q0(update_delay_rwcs_reg_Q0)
    );

    // instance of 'rwa_reg' register:
    d_ff_plain_rst_we_t #(
        .bit_width(32'd32),
        .default_value(32'b0),
        .reset_level(1'b0),
        .reset_sync(1'b0)
    ) rwa_reg (
        .CLK(CLK),
        .RST(RST),
        .WE0(rwa_reg_WE0),
        .D0(rwa_reg_D0),
        .Q0(rwa_reg_Q0)
    );

    // instance of 'rwd_reg' register:
    d_ff_plain_rst_we_t #(
        .bit_width(32'd32),
        .default_value(32'b0),
        .reset_level(1'b0),
        .reset_sync(1'b0)
    ) rwd_reg (
        .CLK(CLK),
        .RST(RST),
        .WE0(rwd_reg_WE0),
        .D0(rwd_reg_D0),
        .Q0(rwd_reg_Q0)
    );

    // instance of 'read_data_reg' register:
    d_ff_plain_rst_we_t #(
        .bit_width(32'd32),
        .default_value(32'b0),
        .reset_level(1'b0),
        .reset_sync(1'b0)
    ) read_data_reg (
        .CLK(CLK),
        .RST(RST),
        .WE0(read_data_reg_WE0),
        .D0(read_data_reg_D0),
        .Q0(read_data_reg_Q0)
    );

    // instance of 'update_delay_read_data_reg' register:
    d_ff_plain_rst_t #(
        .bit_width(32'd1),
        .default_value(1'b0),
        .reset_level(1'b0),
        .reset_sync(1'b0)
    ) update_delay_read_data_reg (
        .CLK(CLK),
        .RST(RST),
        .D0(update_delay_read_data_reg_D0),
        .Q0(update_delay_read_data_reg_Q0)
    );

    // instance of 'update_delay_write_data_reg' register:
    d_ff_plain_rst_t #(
        .bit_width(32'd1),
        .default_value(1'b0),
        .reset_level(1'b0),
        .reset_sync(1'b0)
    ) update_delay_write_data_reg (
        .CLK(CLK),
        .RST(RST),
        .D0(update_delay_write_data_reg_D0),
        .Q0(update_delay_write_data_reg_Q0)
    );

    // data-path code:
    assign request_status_ready_flag_wire = (if_ldst_STATUS0 == CP_ST_READY);
    assign request_error_flag_wire = ((if_ldst_STATUS0 != CP_ST_BUSY) || (rwcs_reg_Q0[31] == 1'd0));
    assign finish_ack_flag_wire = (if_ldst_RESPONSE0 == CP_RS_ACK);
    assign finish_error_flag_wire = ((if_ldst_RESPONSE0 != CP_RS_WAIT) || (rwcs_reg_Q0[31] == 1'd0));
    assign rwcs_select_wire = (NEXUS_RRS == 7'd7);
    assign rwa_select_wire = (NEXUS_RRS == 7'd9);
    assign rwd_select_wire = (NEXUS_RRS == 7'd10);
    assign update_access_wire = (((state_reg_Q0 == STATE_ERROR) || (state_reg_Q0 == STATE_READ_DONE)) || (state_reg_Q0 == STATE_WRITE_DONE));
    assign update_dv_wire = (((state_reg_Q0 == STATE_READ_REQ) || (state_reg_Q0 == STATE_WRITE_REQ)) || (state_reg_Q0 == STATE_INVALIDATE));
    assign rwcs_access_cntr_wire = (rwcs_reg_Q0[15:2] - 14'd1);
    assign rwcs_new_ac_wire = ((rwcs_reg_Q0[31] == 1'd1) && (rwcs_reg_Q0[15:2] <= 14'd1)) ? 1'd0 : rwcs_reg_Q0[31];
    assign rwcs_cif_new_wire = (rwcs_reg_Q0[16] & rwcs_new_ac_wire);
    assign rwcs_error_wire = (state_reg_Q0 == STATE_ERROR);
    assign rwcs_dv_wire = (state_reg_Q0 == STATE_READ_DONE) ? 1'd1 :
        (state_reg_Q0 == STATE_WRITE_DONE) ? 1'd0 : rwcs_reg_Q0[0];
    assign REQUEST_wire = ((rwcs_reg_Q0[31] == 1'd1) && (state_reg_Q0 == STATE_READ_REQ)) ? CP_CMD_READ :
        ((rwcs_reg_Q0[31] == 1'd1) && (state_reg_Q0 == STATE_WRITE_REQ)) ? CP_CMD_WRITE :
        ((rwcs_reg_Q0[31] == 1'd1) && (state_reg_Q0 == STATE_INVALIDATE)) ? CP_CMD_INVALIDATE_ALL :
        ((rwcs_reg_Q0[31] == 1'd1) && (state_reg_Q0 == STATE_FLUSH)) ? CP_CMD_FLUSH_ALL : CP_CMD_NONE;
    assign rwcs_reg_D0 = ((NEXUS_CLIENT_UPDATE & rwcs_select_wire) == 1'd1) ? NEXUS_CLIENT_D0 :
        (update_dv_wire == 1'd1) ? {rwcs_reg_Q0[31:2],{1'd0,rwcs_reg_Q0[30]}} : {rwcs_new_ac_wire,{rwcs_reg_Q0[30:17],{rwcs_cif_new_wire,{rwcs_access_cntr_wire,{rwcs_error_wire,rwcs_dv_wire}}}}};
    assign rwcs_reg_WE0 = ((NEXUS_CLIENT_UPDATE & rwcs_select_wire) | (update_access_wire | update_dv_wire));
    assign update_delay_rwcs_reg_D0 = (NEXUS_CLIENT_UPDATE & rwcs_select_wire);
    assign rwa_reg_D0 = ((NEXUS_CLIENT_UPDATE & rwa_select_wire) == 1'd1) ? NEXUS_CLIENT_D0 : (rwa_reg_Q0 + 32'd4);
    assign rwa_reg_WE0 = ((NEXUS_CLIENT_UPDATE & rwa_select_wire) | update_access_wire);
    assign rwd_reg_D0 = ((NEXUS_CLIENT_UPDATE & rwd_select_wire) == 1'd1) ? NEXUS_CLIENT_D0 : read_data_reg_Q0;
    assign rwd_reg_WE0 = ((NEXUS_CLIENT_UPDATE & rwd_select_wire) | rwd_update_wire);
    assign rwd_update_wire = (state_reg_Q0 == STATE_READ_DONE);
    assign read_data_reg_D0 = if_ldst_Q0;
    assign read_data_reg_WE0 = ((state_reg_Q0 == STATE_READ_FINISH) && (finish_ack_flag_wire == 1'd1));
    assign update_delay_read_data_reg_D0 = (rwd_select_wire & NEXUS_CLIENT_CAPTURE);
    assign update_delay_write_data_reg_D0 = (rwd_select_wire & NEXUS_CLIENT_UPDATE);
    assign NEXUS_CLIENT_Q0 = (rwcs_select_wire == 1'd1) ? rwcs_reg_Q0 :
        (rwa_select_wire == 1'd1) ? rwa_reg_Q0 :
        (rwd_select_wire == 1'd1) ? rwd_reg_Q0 : 32'd0;
    assign if_ldst_A0 = (rwcs_reg_Q0[31] == 1'd1) ? rwa_reg_Q0 : A0;
    assign if_ldst_BI0 = (rwcs_reg_Q0[31] == 1'd1) ? 2'd0 : BI0;
    assign if_ldst_BC0 = (rwcs_reg_Q0[31] == 1'd1) ? 3'd4 : BC0;
    assign if_ldst_D0 = (rwcs_reg_Q0[31] == 1'd1) ? rwd_reg_Q0 : D0;
    assign if_ldst_REQUEST0 = (rwcs_reg_Q0[31] == 1'd1) ? REQUEST_wire : REQUEST0;
    assign STATUS0 = (rwcs_reg_Q0[31] == 1'd1) ? CP_ST_BUSY : if_ldst_STATUS0;
    assign RESPONSE0 = (rwcs_reg_Q0[31] == 1'd1) ? CP_RS_IDLE : if_ldst_RESPONSE0;
    assign Q0 = (rwcs_reg_Q0[31] == 1'd1) ? 32'd0 : if_ldst_Q0;
endmodule
