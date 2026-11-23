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
 *  \brief   Contains module definition of the 'codasip_memory_predictor_mem_t' memory.
 *           size in words: 16
 *           size in bytes: 16
 *           memory address width: 8 bits
 *           word width: 54 bits
 *           least addressable unit: 54 bits
 *           read latency: {1}
 *           write latency: {1}
 *           endianness: little
 *           unaligned access: no
 *           sub-blocks: no
 */

// Implements memory data storage.
module codasip_memory_predictor_mem_t_storage_subblock0_t(
    input  wire CLK,
    input  wire [3:0] if_read_RA0,
    input  wire if_read_RE0,
    input  wire [53:0] if_write_D0,
    input  wire [3:0] if_write_WA0,
    input  wire if_write_WE0,
    output reg [53:0] if_read_Q0
);
    // memory storage
    reg [53:0] RAM[0:15];

    always @( posedge CLK ) begin
        if ( if_write_WE0 == 1'b1 ) begin
            RAM[if_write_WA0] <= if_write_D0;
        end
    end
    always @( posedge CLK ) begin
        if ( if_read_RE0 == 1'b1 ) begin
            if_read_Q0 <= RAM[if_read_RA0];
        end
    end
endmodule


// Implements sub-block logic/encapsulation.
module codasip_memory_predictor_mem_t_storage_t(
    input  wire CLK,
    input  wire RST,
    input  wire if_read_BC0,
    input  wire if_read_BI0,
    input  wire [3:0] if_read_RA0,
    input  wire if_read_RE0,
    input  wire if_write_BC0,
    input  wire if_write_BI0,
    input  wire [53:0] if_write_D0,
    input  wire [3:0] if_write_WA0,
    input  wire if_write_WE0,
    output wire [53:0] if_read_Q0
);
    // type, wire and constant declarations:
    // signal/wire (inner)
    wire [1:0] if_read_subblock_operation_wire;
    // signal/wire (inner)
    wire [3:0] if_read_address_base_wire;
    // signal/wire (inner)
    wire [1:0] if_write_subblock_operation_wire;
    // signal/wire (inner)
    wire [3:0] if_write_address_base_wire;

    // additional declarations:
    wire [3:0] subblock0_if_read_RA0;
    wire subblock0_if_read_RE0;
    wire [53:0] subblock0_if_write_D0;
    wire [3:0] subblock0_if_write_WA0;
    wire subblock0_if_write_WE0;
    wire [53:0] subblock0_if_read_Q0;
    wire [1:0] if_read_subblock_operation_reg_D0;
    wire [1:0] if_read_subblock_operation_reg_Q0;
    // temporal variable for multiplexer, should not be synthesized as register
    reg [53:0] tmp_codasip_conv_if_read_Q0_MUX_1;
    // temporal variable for multiplexer, should not be synthesized as register
    reg [53:0] tmp_codasip_conv_subblock0_if_write_D0_MUX_2;

    // child instances inside 'storage' Codasip memory sub-block storage:
    // instance of 'subblock0' Codasip memory data storage:
    codasip_memory_predictor_mem_t_storage_subblock0_t subblock0 (
        .CLK(CLK),
        .if_read_RA0(subblock0_if_read_RA0),
        .if_read_RE0(subblock0_if_read_RE0),
        .if_write_D0(subblock0_if_write_D0),
        .if_write_WA0(subblock0_if_write_WA0),
        .if_write_WE0(subblock0_if_write_WE0),
        .if_read_Q0(subblock0_if_read_Q0)
    );

    // instance of 'if_read_subblock_operation_reg' register:
    d_ff_plain_rst_t #(
        .bit_width(32'd2),
        .default_value(2'b0),
        .reset_level(1'b0),
        .reset_sync(1'b0)
    ) if_read_subblock_operation_reg (
        .CLK(CLK),
        .RST(RST),
        .D0(if_read_subblock_operation_reg_D0),
        .Q0(if_read_subblock_operation_reg_Q0)
    );

    // data-path code:
    assign if_read_address_base_wire = if_read_RA0;
    assign if_read_subblock_operation_wire = {if_read_BC0,if_read_BI0};
    assign if_read_subblock_operation_reg_D0 = if_read_subblock_operation_wire;
    assign if_write_address_base_wire = if_write_WA0;
    assign if_write_subblock_operation_wire = {if_write_BC0,if_write_BI0};
    assign subblock0_if_read_RE0 = if_read_RE0;
    assign subblock0_if_read_RA0 = if_read_address_base_wire;
    always @(*) begin
        case ( if_read_subblock_operation_reg_Q0 )
            2'd2: tmp_codasip_conv_if_read_Q0_MUX_1 = subblock0_if_read_Q0;
            default: tmp_codasip_conv_if_read_Q0_MUX_1 = 54'd0;
        endcase
    end
    assign if_read_Q0 = tmp_codasip_conv_if_read_Q0_MUX_1;
    assign subblock0_if_write_WE0 = (if_write_WE0 && (if_write_subblock_operation_wire == 2'd2));
    assign subblock0_if_write_WA0 = if_write_address_base_wire;
    always @(*) begin
        case ( if_write_subblock_operation_wire )
            2'd2: tmp_codasip_conv_subblock0_if_write_D0_MUX_2 = if_write_D0[53:0];
            default: tmp_codasip_conv_subblock0_if_write_D0_MUX_2 = 54'd0;
        endcase
    end
    assign subblock0_if_write_D0 = tmp_codasip_conv_subblock0_if_write_D0_MUX_2;
endmodule


// Implements request and latency logic/encapsulation.
module codasip_memory_predictor_mem_t(
    input  wire CLK,
    input  wire RST,
    input  wire [7:0] if_read_A0,
    input  wire if_read_BC0,
    input  wire if_read_BI0,
    input  wire [1:0] if_read_REQUEST0,
    input  wire [7:0] if_write_A0,
    input  wire if_write_BC0,
    input  wire if_write_BI0,
    input  wire [53:0] if_write_D0,
    input  wire [1:0] if_write_REQUEST0,
    output wire [53:0] if_read_Q0,
    output wire [2:0] if_read_QRESPONSE0,
    output wire [1:0] if_read_STATUS0,
    output wire [2:0] if_write_DRESPONSE0,
    output wire [1:0] if_write_STATUS0
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

    // signal/wire (inner)
    wire if_read_rdy_wire;
    // signal/wire (inner)
    wire if_read_oor_wire;
    // signal/wire (inner)
    wire if_read_err_wire;
    // signal/wire (inner)
    wire if_read_rreq_wire;
    // signal/wire (inner)
    wire [2:0] if_read_RESPONSE0_wire;
    // signal/wire (inner)
    wire if_read_RE0_wire;
    // signal/wire (inner)
    wire if_write_rdy_wire;
    // signal/wire (inner)
    wire if_write_oor_wire;
    // signal/wire (inner)
    wire if_write_err_wire;
    // signal/wire (inner)
    wire if_write_wreq_wire;
    // signal/wire (inner)
    wire [2:0] if_write_RESPONSE0_wire;
    // signal/wire (inner)
    wire if_write_WE0_wire;

    // additional declarations:
    wire storage_if_read_BC0;
    wire storage_if_read_BI0;
    wire [3:0] storage_if_read_RA0;
    wire storage_if_read_RE0;
    wire storage_if_write_BC0;
    wire storage_if_write_BI0;
    wire [53:0] storage_if_write_D0;
    wire [3:0] storage_if_write_WA0;
    wire storage_if_write_WE0;
    wire [53:0] storage_if_read_Q0;
    wire [1:0] if_read_STATUS0_reg_D0;
    wire [1:0] if_read_STATUS0_reg_Q0;
    wire [2:0] if_read_QRESPONSE0_reg_D0;
    wire [2:0] if_read_QRESPONSE0_reg_Q0;
    wire [1:0] if_write_STATUS0_reg_D0;
    wire [1:0] if_write_STATUS0_reg_Q0;

    // child instances inside 'predictor_mem' Codasip memory:
    // instance of 'storage' Codasip memory sub-block storage:
    codasip_memory_predictor_mem_t_storage_t storage (
        .CLK(CLK),
        .RST(RST),
        .if_read_BC0(storage_if_read_BC0),
        .if_read_BI0(storage_if_read_BI0),
        .if_read_RA0(storage_if_read_RA0),
        .if_read_RE0(storage_if_read_RE0),
        .if_write_BC0(storage_if_write_BC0),
        .if_write_BI0(storage_if_write_BI0),
        .if_write_D0(storage_if_write_D0),
        .if_write_WA0(storage_if_write_WA0),
        .if_write_WE0(storage_if_write_WE0),
        .if_read_Q0(storage_if_read_Q0)
    );

    // instance of 'if_read_STATUS0_reg' register:
    d_ff_plain_rst_t #(
        .bit_width(32'd2),
        .default_value(2'b0),
        .reset_level(1'b0),
        .reset_sync(1'b0)
    ) if_read_STATUS0_reg (
        .CLK(CLK),
        .RST(RST),
        .D0(if_read_STATUS0_reg_D0),
        .Q0(if_read_STATUS0_reg_Q0)
    );

    // instance of 'if_read_QRESPONSE0_reg' register:
    d_ff_plain_rst_t #(
        .bit_width(32'd3),
        .default_value(3'b0),
        .reset_level(1'b0),
        .reset_sync(1'b0)
    ) if_read_QRESPONSE0_reg (
        .CLK(CLK),
        .RST(RST),
        .D0(if_read_QRESPONSE0_reg_D0),
        .Q0(if_read_QRESPONSE0_reg_Q0)
    );

    // instance of 'if_write_STATUS0_reg' register:
    d_ff_plain_rst_t #(
        .bit_width(32'd2),
        .default_value(2'b0),
        .reset_level(1'b0),
        .reset_sync(1'b0)
    ) if_write_STATUS0_reg (
        .CLK(CLK),
        .RST(RST),
        .D0(if_write_STATUS0_reg_D0),
        .Q0(if_write_STATUS0_reg_Q0)
    );

    // data-path code:
    assign if_read_rdy_wire = (if_read_STATUS0_reg_Q0 == CP_ST_READY);
    assign if_read_oor_wire = (if_read_A0 >= 8'd16);
    assign if_read_err_wire = (({{1{1'b0}}, if_read_BI0} + {{1{1'b0}}, if_read_BC0}) > 2'd1);
    assign if_read_rreq_wire = (if_read_REQUEST0 == CP_CMD_READ_MEM);
    assign if_read_STATUS0_reg_D0 = CP_ST_READY;
    assign if_read_STATUS0 = if_read_STATUS0_reg_Q0;
    assign if_read_RESPONSE0_wire = (if_read_rdy_wire == 1'd0) ? CP_RS_IDLE :
        (if_read_rreq_wire == 1'd0) ? CP_RS_IDLE :
        (if_read_oor_wire == 1'd1) ? CP_RS_OOR :
        (if_read_err_wire == 1'd1) ? CP_RS_ERROR : CP_RS_ACK;
    assign if_read_QRESPONSE0_reg_D0 = if_read_RESPONSE0_wire;
    assign if_read_QRESPONSE0 = if_read_QRESPONSE0_reg_Q0;
    assign if_read_RE0_wire = (if_read_RESPONSE0_wire == CP_RS_ACK);
    assign storage_if_read_RE0 = if_read_RE0_wire;
    assign storage_if_read_RA0 = if_read_A0[3:0];
    assign storage_if_read_BI0 = if_read_BI0;
    assign storage_if_read_BC0 = if_read_BC0;
    assign if_read_Q0 = (if_read_QRESPONSE0_reg_Q0 == CP_RS_ACK) ? storage_if_read_Q0 : 54'd0;
    assign if_write_rdy_wire = (if_write_STATUS0_reg_Q0 == CP_ST_READY);
    assign if_write_oor_wire = (if_write_A0 >= 8'd16);
    assign if_write_err_wire = (({{1{1'b0}}, if_write_BI0} + {{1{1'b0}}, if_write_BC0}) > 2'd1);
    assign if_write_wreq_wire = (if_write_REQUEST0 == CP_CMD_WRITE_MEM);
    assign if_write_STATUS0_reg_D0 = CP_ST_READY;
    assign if_write_STATUS0 = if_write_STATUS0_reg_Q0;
    assign if_write_RESPONSE0_wire = (if_write_rdy_wire == 1'd0) ? CP_RS_IDLE :
        (if_write_wreq_wire == 1'd0) ? CP_RS_IDLE :
        (if_write_oor_wire == 1'd1) ? CP_RS_OOR :
        (if_write_err_wire == 1'd1) ? CP_RS_ERROR : CP_RS_ACK;
    assign if_write_DRESPONSE0 = if_write_RESPONSE0_wire;
    assign if_write_WE0_wire = (if_write_RESPONSE0_wire == CP_RS_ACK);
    assign storage_if_write_WE0 = if_write_WE0_wire;
    assign storage_if_write_WA0 = if_write_A0[3:0];
    assign storage_if_write_BI0 = if_write_BI0;
    assign storage_if_write_BC0 = if_write_BC0;
    assign storage_if_write_D0 = if_write_D0;
endmodule
