//
// Codasip Ltd
//
// CONFIDENTIAL
//
// Copyright <YEAR> Codasip Ltd
//
// All Rights Reserved.
//
// NOTICE: All information contained in this file, is and shall remain the property of Codasip Ltd
// and its suppliers, if any.
//
// The intellectual and technical concepts contained herein are confidential and proprietary to
// Codasip Ltd and are protected by trade secret and copyright law. In addition, elements of the
// technical concepts may be patent pending.
//
// This file is part of the Codasip Studio product. No part of the Studio product, including this
// file, may be use, copied, modified, or distributed except in accordance with the terms contained
// in Codasip license agreement under which you obtained this file.
//
// @file   clb2axilite.v
// @author Codasip
// @email  support@codasip.com
// @date
// @brief  CLBv2 => AXI4 Lite Bridge (master - master)


module clb2axilite #(
           // K is addr width
           parameter integer K = 32,
           // N = 2 for 32-bit, 3 for 64-bit data bus
           parameter integer N = 2
)(
           input  wire                CLK,
           input  wire                RST,

           // CLBv2
           input  wire [2:0]          if_clb_REQUEST0,
           output reg  [1:0]          if_clb_STATUS0,
           output reg  [2:0]          if_clb_RESPONSE0,
           input  wire [K-1:0]        if_clb_A0,
           input  wire [N-1:0]        if_clb_BI0,
           input  wire [N:0]          if_clb_BC0,
           input  wire [8*(2**N)-1:0] if_clb_D0,
           output wire [8*(2**N)-1:0] if_clb_Q0,

           // AXI4 Lite
           output reg                 AWVALID,
           input  wire                AWREADY,
           output reg  [K-1:0]        AWADDR,
           output wire [2:0]          AWPROT,
           output reg                 WVALID,
           input  wire                WREADY,
           output wire [8*(2**N)-1:0] WDATA,
           output wire [(2**N)-1:0]   WSTRB,
           input  wire                BVALID,
           output reg                 BREADY,
           input  wire [1:0]          BRESP,
           output reg                 ARVALID,
           input  wire                ARREADY,
           output reg  [K-1:0]        ARADDR,
           output wire [2:0]          ARPROT,
           input  wire                RVALID,
           output reg                 RREADY,
           input  wire [8*(2**N)-1:0] RDATA,
           input  wire [1:0]          RRESP
);

    //---------------------------------------------------------------------------------------------
    // constants
    // constant for signals ARPROT and AWPROT
    localparam AXPROT         = 3'b010;

    // request cmd constants in CLB
    localparam CP_RQ_NONE     = 3'b000;
    localparam CP_RQ_WRITE    = 3'b010;
    localparam CP_RQ_READ     = 3'b001;

    // status constants in CLB
    localparam CP_ST_READY    = 2'b01;
    localparam CP_ST_BUSY     = 2'b00;

    // responce constants in CLB
    localparam CP_RC_IDLE     = 3'b000;
    localparam CP_RC_ACK      = 3'b001;
    localparam CP_RC_WAIT     = 3'b010;
    localparam CP_RC_ERROR    = 3'b011;

    // resp constants in AXI4
    localparam AXI4_OKEY      = 2'b00;

    // signals ------------------------------------------------------------------------------------
    reg  [N:0] sc_reg,sc_d;

    reg  [N-1:0] si_reg, si_d;

    wire [8*(2**N)-1:0] data_mask;
    reg [7:0] wstrb_8bit;
    wire [7:0] wstrb_shift;

    wire [N+1:0] cntrl_count;

    wire [3:0] sc_4bit;

    wire [K-1:0] addr;
    reg  [2:0] request_reg, request_d;

    reg  [K-1:0] addr_q, addr_d;

    reg  awvalid_q, wvalid_q;
    reg  awvalid_d, wvalid_d;

    localparam s_RESET       = 2'd0;
    localparam s_READY       = 2'd1;
    localparam s_REQUESTED   = 2'd2;
    localparam s_WAIT_BVALID = 2'd3;

    reg  [1:0] state, next_state;

    // ---------------------------------------------------------------------------------------------
    // direct connection
    // ---------------------------------------------------------------------------------------------

    // data channels
    // data mask
    assign data_mask [31:0] = (sc_reg == 0) ? 32'h00000000 :
                              (sc_reg == 1) ? 32'h000000FF :
                              (sc_reg == 2) ? 32'h0000FFFF :
                              (sc_reg == 3) ? 32'h00FFFFFF :
                                              32'hFFFFFFFF;

    // for 64-bit data bus generate also higher part of the mask
    generate
        if ( N == 3 ) begin : gen_high_mask
            assign data_mask[63:32] = (sc_reg < 5)  ? 32'h00000000 :
                                      (sc_reg == 5) ? 32'h000000FF :
                                      (sc_reg == 6) ? 32'h0000FFFF :
                                      (sc_reg == 7) ? 32'h00FFFFFF :
                                                      32'hFFFFFFFF;
        end
    endgenerate

    // data channels
    // read data to if_clb_Q0
    assign if_clb_Q0 = (RDATA >> (8 * si_reg)) & data_mask;

    // if_clb_D0 to write data
    assign WDATA = if_clb_D0 << (8 * si_reg);

    // address is ADDR + BI, same for read and write
    assign addr = {if_clb_A0[K-1:N], {N{1'b0}}};

    // constant AXPROT to AxPROT signals
    assign AWPROT = AXPROT;
    assign ARPROT = AXPROT;

    // control count if BI, BC and N low bits of ADDR
    assign cntrl_count = if_clb_BI0 + if_clb_BC0 + if_clb_A0[N-1:0];

    // -----------------------------------------------------------------------------------------------
    // WSTRB from BC
    // -----------------------------------------------------------------------------------------------

    // resize BC to 4 bits
    assign sc_4bit = $unsigned(sc_reg);

    // wstrb_8bit decoded from sc_4bit
    always @(sc_4bit) begin
        case (sc_4bit)
            4'h0 :
                wstrb_8bit = 8'b00000000;
            4'h1 :
                wstrb_8bit = 8'b00000001;
            4'h2 :
                wstrb_8bit = 8'b00000011;
            4'h3 :
                wstrb_8bit = 8'b00000111;
            4'h4 :
                wstrb_8bit = 8'b00001111;
            4'h5 :
                wstrb_8bit = 8'b00011111;
            4'h6 :
                wstrb_8bit = 8'b00111111;
            4'h7 :
                wstrb_8bit = 8'b01111111;
            default :
                wstrb_8bit = 8'b11111111;
        endcase
    end


    assign wstrb_shift = wstrb_8bit << si_reg;

    // chop wstrb_8bit to actual WSTRB (8 or 4 bits)
    assign WSTRB = wstrb_shift[2**N-1:0];

    // -----------------------------------------------------------------------------------------------
    // registers
    // -----------------------------------------------------------------------------------------------
    always @(posedge(CLK) or negedge(RST)) begin
        if (RST == 1'b0) begin
            state       <= s_RESET;
            sc_reg      <= 0;
            si_reg      <= 0;
            request_reg <= CP_RQ_NONE;
            addr_q      <= 0;
            awvalid_q   <= 1'b0;
            wvalid_q    <= 1'b0;
        end
        else begin
            state       <= next_state;
            sc_reg      <= sc_d;
            si_reg      <= si_d;
            request_reg <= request_d;
            addr_q      <= addr_d;
            awvalid_q   <= awvalid_d;
            wvalid_q    <= wvalid_d;
        end
    end


    // ---------------------------------------------------------------------------------------------
    // FSM
    // ---------------------------------------------------------------------------------------------
    always @(*) begin
        next_state  = state;
        request_d   = request_reg;
        addr_d      = addr_q;
        awvalid_d   = awvalid_q;
        wvalid_d    = wvalid_q;

        if_clb_STATUS0   = CP_ST_BUSY;
        if_clb_RESPONSE0 = CP_RC_IDLE;
        AWVALID     = 1'b0;
        WVALID      = 1'b0;
        BREADY      = 1'b0;
        ARVALID     = 1'b0;
        RREADY      = 1'b0;

        sc_d        = sc_reg;
        si_d        = si_reg;

        ARADDR      = addr;
        AWADDR      = addr;

        case (state)
            s_RESET :
                begin
                    // state reset, after reset go to ready
                    next_state = s_READY;
                end
    // ---------------------------------------------------------------------------------------------
            s_READY :
                begin
                    // state ready, status is always READY
                    if_clb_STATUS0 = CP_ST_READY;

                    // when request come, aXvalid is set, status is set by axready,
                    // if axready is set -> request is stored to register and next
                    // state is requested.
                    // for unknown request, status is always ready and next state is requested.
                    if (if_clb_REQUEST0 != CP_RQ_NONE) begin
                        si_d = if_clb_BI0 + if_clb_A0[N-1:0];
                        sc_d = if_clb_BC0;
                        case (if_clb_REQUEST0)
                            CP_RQ_READ :                                // READ REQUEST
                                begin
                                    // READ
                                    if (cntrl_count > 2**N) begin
                                        // if countrol count is bigger then 2**N (4 or 8)
                                        // its invalid request - status always READY,
                                        // request_d is stored NONE, RESPONSE will be ERROR
                                        next_state  = s_REQUESTED;
                                        if_clb_STATUS0 = CP_ST_READY;
                                        request_d   = CP_RQ_NONE;
                                    end
                                    else begin
                                        ARVALID = 1'b1;
                                        if (ARREADY == 1'b1) begin
                                            if_clb_STATUS0 = CP_ST_READY;
                                            next_state  = s_REQUESTED;
                                            request_d   = if_clb_REQUEST0;
                                        end
                                        else begin
                                            if_clb_STATUS0 = CP_ST_BUSY;
                                        end
                                    end
                                end
                            CP_RQ_WRITE :                               // WRITE REQUEST
                                begin
                                    // WRITE
                                    if (cntrl_count > 2**N) begin
                                        // if INVALID REQUEST (cntrl_count > 2**N
                                        next_state  = s_REQUESTED;
                                        if_clb_STATUS0 = CP_ST_READY;
                                        request_d   = CP_RQ_NONE;
                                    end
                                    else begin
                                        AWVALID = 1'b1;
                                        AWADDR  = addr;

                                        if_clb_STATUS0 = CP_ST_READY;
                                        next_state  = s_REQUESTED;
                                        request_d   = if_clb_REQUEST0;
                                        wvalid_d = 1'b1;

                                        if (AWREADY == 1'b0) begin
                                            awvalid_d = 1'b1;
                                            addr_d    = addr;
                                        end
                                        else begin
                                            awvalid_d = 1'b0;
                                        end
                                    end
                                end
                            default :                                 // unknown REQUEST
                                begin
                                    // UNKNOWN REQUEST
                                    if_clb_STATUS0 = CP_ST_READY;
                                    next_state  = s_REQUESTED;
                                    request_d   = if_clb_REQUEST0;
                                end
                        endcase
                    end
                end
    // ---------------------------------------------------------------------------------------------
            s_REQUESTED :
                begin
                    // in requested state by previous request:
                    // READ:    RREADY set, waiting for RVALID; RRESP decoded to RESPONSE,
                    //          new request can be accepted
                    // WRITE:   WVALID set until WREADY, AWVALID set until AWREADY (if it was not accepted in first phase),
                    //          goes to state WAIT_BVALID to accept BRESP
                    // OTHERS:  set RESPONSE ERROR for invalid requests, IDLE for unsupported requests
                    //          new request can be accepted
                    case (request_reg)

                            CP_RQ_READ :                                // READ REQUESTED
                                begin
                                    // READ
                                    // RREADY is set to 1
                                    RREADY = 1'b1;

                                    // RVALID 1 means, read is finished, new request possible
                                    if (RVALID == 1'b1) begin                      // READ is FINISHED
                                        case (RRESP)
                                            // response
                                            AXI4_OKEY :
                                                if_clb_RESPONSE0 = CP_RC_ACK;
                                            default :
                                                if_clb_RESPONSE0 = CP_RC_ERROR;
                                        endcase

                                        // without new request, next state is ready
                                        next_state  = s_READY;
                                        if_clb_STATUS0 = CP_ST_READY;

                                        // if new request -> its like ready, but response gives
                                        // current request
                                        if (if_clb_REQUEST0 != CP_RQ_NONE) begin
                                            si_d = if_clb_BI0 + if_clb_A0[N-1:0];
                                            sc_d = if_clb_BC0;
                                            case (if_clb_REQUEST0)
                                                CP_RQ_READ :
                                                    begin
                                                        // new request READ
                                                        if (cntrl_count > 2**N) begin
                                                            // if INVALID REQUEST (cntrl_count > 2**N
                                                            next_state  = s_REQUESTED;
                                                            if_clb_STATUS0 = CP_ST_READY;
                                                            request_d   = CP_RQ_NONE;
                                                        end
                                                        else begin
                                                            ARVALID = 1'b1;
                                                            if (ARREADY == 1'b1) begin
                                                                if_clb_STATUS0 = CP_ST_READY;
                                                                next_state  = s_REQUESTED;
                                                                request_d   = if_clb_REQUEST0;
                                                            end
                                                            else begin
                                                                if_clb_STATUS0 = CP_ST_BUSY;
                                                                next_state  = s_READY;
                                                            end
                                                        end
                                                    end
                                                CP_RQ_WRITE :
                                                    begin
                                                        // new request WRITE
                                                        if (cntrl_count > 2**N) begin
                                                            // if INVALID REQUEST (cntrl_count > 2**N
                                                            next_state  = s_REQUESTED;
                                                            if_clb_STATUS0 = CP_ST_READY;
                                                            request_d   = CP_RQ_NONE;
                                                        end
                                                        else begin
                                                            AWVALID = 1'b1;
                                                            AWADDR  = addr;

                                                            if_clb_STATUS0 = CP_ST_READY;
                                                            next_state  = s_REQUESTED;
                                                            request_d   = if_clb_REQUEST0;
                                                            wvalid_d    = 1'b1;

                                                            if (AWREADY == 1'b0) begin
                                                                awvalid_d = 1'b1;
                                                                addr_d    = addr;
                                                            end
                                                            else begin
                                                                awvalid_d = 1'b0;
                                                            end
                                                        end
                                                    end
                                                default :
                                                    begin
                                                        // new request unknown
                                                        if_clb_STATUS0 = CP_ST_READY;
                                                        next_state  = s_REQUESTED;
                                                        request_d   = if_clb_REQUEST0;
                                                    end
                                            endcase
                                        end
                                    end
                                    else begin                                  // READ is NOT FINISHED yet
                                        // next state is requested, since waiting for RVALID,
                                        // response WAIT, status BUSY
                                        if_clb_RESPONSE0 = CP_RC_WAIT;
                                        next_state  = s_REQUESTED;
                                        if_clb_STATUS0 = CP_ST_BUSY;
                                    end
                                end

                            CP_RQ_WRITE :                                // WRITE REQUESTED
                                begin
                                    // WRITE
                                    // WVALID are set to 1 until acceoted by WREADY (flag cleared)
                                    WVALID = wvalid_q;

                                    // set AWVALID if it was not accepted in previous pahse
                                    // + address, clear register if AWREADY is set
                                    if (awvalid_q == 1'b1) begin
                                        AWVALID = 1'b1;
                                        AWADDR  = addr_q;

                                        if (AWREADY == 1'b1) begin
                                            awvalid_d = 1'b0;
                                        end
                                    end

                                    // clear WVALID register
                                    if (wvalid_q == 1'b1) begin
                                        if (WREADY == 1'b1) begin
                                            wvalid_d = 1'b0;
                                        end
                                    end

                                    // check if write finished (both address and data phase)
                                    if ((WREADY == 1'b1 || wvalid_q == 1'b0) && (AWREADY == 1'b1 || awvalid_q == 1'b0)) begin
                                        // both address and data phase finished
                                        // next state is wait_bvalid (to accept BRESP), response WAIT, status BUSY
                                        if_clb_RESPONSE0 = CP_RC_WAIT;
                                        next_state  = s_WAIT_BVALID;
                                        if_clb_STATUS0 = CP_ST_BUSY;
                                    end
                                    else begin                                   // WRITE is NOT FINISHED yet
                                        // both phases did not finished yet
                                        // next state is requested, since waiting for
                                        // WREADY or AWREADY, response WAIT, status BUSY
                                        if_clb_RESPONSE0 = CP_RC_WAIT;
                                        next_state  = s_REQUESTED;
                                        if_clb_STATUS0 = CP_ST_BUSY;
                                    end
                                end

                            default :                                  // UNKNOWN REQUESTED
                                begin
                                    // UNKNOWN REQUEST or INVALID REQUEST (NONE) in requested
                                    // finished with IDLE/ERROR on RESPONSE, new request possible.
                                    // if not new request, next_state is ready; status READY and
                                    // response IDLE
                                    next_state  = s_READY;
                                    if_clb_STATUS0 = CP_ST_READY;

                                    if (request_reg == CP_RQ_NONE) begin
                                        // response ERROR for invalid request (control count > 2**N
                                        if_clb_RESPONSE0 = CP_RC_ERROR;
                                    end
                                    else begin
                                        // response IDLE for unsupported request
                                        if_clb_RESPONSE0 = CP_RC_IDLE;
                                    end

                                    // if new request -> its like ready, but response IDLE
                                    if (if_clb_REQUEST0 != CP_RQ_NONE) begin
                                        si_d = if_clb_BI0 + if_clb_A0[N-1:0];
                                        sc_d = if_clb_BC0;
                                        case (if_clb_REQUEST0)
                                            CP_RQ_READ :
                                                begin
                                                    // new request READ
                                                    if (cntrl_count > 2**N) begin
                                                        // if INVALID REQUEST (cntrl_count > 2**N
                                                        next_state  = s_REQUESTED;
                                                        if_clb_STATUS0      = CP_ST_READY;
                                                        request_d   = CP_RQ_NONE;
                                                    end
                                                    else begin
                                                        ARVALID = 1'b1;
                                                        if (ARREADY == 1'b1) begin
                                                            if_clb_STATUS0 = CP_ST_READY;
                                                            next_state  = s_REQUESTED;
                                                            request_d   = if_clb_REQUEST0;
                                                        end
                                                        else begin
                                                            if_clb_STATUS0 = CP_ST_BUSY;
                                                            next_state  = s_READY;
                                                        end
                                                    end
                                                end
                                            CP_RQ_WRITE :
                                                begin
                                                    // new request WRITE
                                                    if (cntrl_count > 2**N) begin
                                                        // if INVALID REQUEST (cntrl_count > 2**N
                                                        next_state  = s_REQUESTED;
                                                        if_clb_STATUS0 = CP_ST_READY;
                                                        request_d   = CP_RQ_NONE;
                                                    end
                                                    else begin
                                                        AWVALID = 1'b1;
                                                        AWADDR  = addr;

                                                        if_clb_STATUS0 = CP_ST_READY;
                                                        next_state  = s_REQUESTED;
                                                        request_d   = if_clb_REQUEST0;
                                                        wvalid_d    = 1'b1;

                                                        if (AWREADY == 1'b0) begin
                                                            awvalid_d = 1'b1;
                                                            addr_d    = addr;
                                                        end
                                                        else begin
                                                            awvalid_d = 1'b0;
                                                        end
                                                    end
                                                end
                                            default :
                                                begin
                                                    // new request UNKNOWN
                                                    if_clb_STATUS0 = CP_ST_READY;
                                                    next_state  = s_REQUESTED;
                                                    request_d   = if_clb_REQUEST0;
                                                end
                                        endcase
                                    end
                                end
                    endcase
                end

    // ---------------------------------------------------------------------------------------------
            s_WAIT_BVALID :                                             // WRITE REQUESTED
                begin
                    // state wait_bvalid for write:
                    // in write request, WREADY was previosly set, but waiting for BVALID
                    //  WVALID is 0 (default), BREADY is set to 1
                    BREADY = 1'b1;

                    // BVALID set means, write is finished, new request possible
                    if (BVALID == 1'b1) begin                                 // WRITE is FINISHED
                        case (BRESP)
                            // response
                            AXI4_OKEY :
                                if_clb_RESPONSE0 = CP_RC_ACK;
                            default :
                                if_clb_RESPONSE0 = CP_RC_ERROR;
                        endcase

                        // without new request next state is ready
                        next_state = s_READY;
                        if_clb_STATUS0 = CP_ST_READY;

                        // if new request -> its like ready, but response gives current request
                        if (if_clb_REQUEST0 != CP_RQ_NONE) begin
                            si_d = if_clb_BI0 + if_clb_A0[N-1:0];
                            sc_d = if_clb_BC0;
                            case (if_clb_REQUEST0)
                                CP_RQ_READ :
                                    begin
                                        // new request READ
                                        if (cntrl_count > 2**N) begin
                                            // if INVALID REQUEST (cntrl_count > 2**N
                                            next_state  = s_REQUESTED;
                                            if_clb_STATUS0 = CP_ST_READY;
                                            request_d   = CP_RQ_NONE;
                                        end
                                        else begin
                                            ARVALID = 1'b1;
                                            if (ARREADY == 1'b1) begin
                                                if_clb_STATUS0 = CP_ST_READY;
                                                next_state  = s_REQUESTED;
                                                request_d   = if_clb_REQUEST0;
                                            end
                                            else begin
                                                if_clb_STATUS0      = CP_ST_BUSY;
                                                next_state  = s_READY;
                                            end
                                        end
                                    end
                                CP_RQ_WRITE :
                                    begin
                                        // new request WRITE
                                        if (cntrl_count > 2**N) begin
                                            // if INVALID REQUEST (cntrl_count > 2**N
                                            next_state  = s_REQUESTED;
                                            if_clb_STATUS0 = CP_ST_READY;
                                            request_d   = CP_RQ_NONE;
                                        end
                                        else begin
                                            AWVALID = 1'b1;
                                            AWADDR  = addr;

                                            if_clb_STATUS0 = CP_ST_READY;
                                            next_state  = s_REQUESTED;
                                            request_d   = if_clb_REQUEST0;
                                            wvalid_d    = 1'b1;

                                            if (AWREADY == 1'b0) begin
                                                awvalid_d = 1'b1;
                                                addr_d    = addr;
                                            end
                                            else begin
                                                awvalid_d = 1'b0;
                                            end
                                        end
                                    end
                                default :
                                    begin
                                        // new request unknown
                                        if_clb_STATUS0 = CP_ST_READY;
                                        next_state  = s_REQUESTED;
                                        request_d   = if_clb_REQUEST0;
                                    end
                            endcase
                        end
                    end
                    else begin                                           // WRITE is NOT FINISHED yet
                        // BVALID is 0 -> next state is wait_bvalid, since waiting for BVALID,
                        // response WAIT, status BUSY
                        if_clb_RESPONSE0 = CP_RC_WAIT;
                        next_state  = s_WAIT_BVALID;
                        if_clb_STATUS0 = CP_ST_BUSY;
                    end
                end
    // ---------------------------------------------------------------------------------------------
            default :
                begin
                    // others states -> ready
                    next_state = s_READY;
                end
        endcase
    end

endmodule

