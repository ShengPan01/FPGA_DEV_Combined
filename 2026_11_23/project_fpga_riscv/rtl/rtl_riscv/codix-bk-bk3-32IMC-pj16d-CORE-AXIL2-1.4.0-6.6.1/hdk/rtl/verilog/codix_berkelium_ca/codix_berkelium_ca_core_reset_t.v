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
 *  \brief   Contains module definition of the 'codix_berkelium_ca_core_reset_t' functional unit.
 */

module codix_berkelium_ca_core_reset_t(
    input  wire CLK,
    input  wire RST,
    input  wire ACT,
    output wire FIN,
    output wire [31:0] rf_gpr_D0,
    output wire [4:0] rf_gpr_WA0,
    output wire rf_gpr_WE0
);
    // type, wire and constant declarations:
    // signal/wire (inner)
    wire [5:0] codasip_tmp_var_1;
    // FSM state constants
    localparam [1:0] s0 = 2'b0;
    localparam [1:0] s1 = 2'b01;
    localparam [1:0] s2 = 2'b10;
    // FSM state register (current state)
    reg [1:0] state_reg_Q0;
    // FSM state register (next state)
    reg [1:0] state_reg_D0;

    // additional declarations:
    wire codasip_tmp_var_0_WE0;
    wire codasip_tmp_var_0_D0;
    wire codasip_tmp_var_0_Q0;
    wire i_B0_WE0;
    wire [5:0] i_B0_D0;
    wire [5:0] i_B0_Q0;

    // child instances inside 'reset' functional unit:
    // FSM state register
    always @( posedge CLK or negedge RST ) begin
        if ( RST == 1'b0 ) begin
            state_reg_Q0 <= s0;
        end else begin
            state_reg_Q0 <= state_reg_D0;
        end
    end
    // FSM transitions (next state logic)
    always @(*) begin
        case ( state_reg_Q0 )
            s0: begin
                if ( (ACT == 1'd1) ) begin
                    state_reg_D0 = s1;
                end else begin
                    state_reg_D0 = s0;
                end
            end
            s1: begin
                if ( (!codasip_tmp_var_0_Q0) ) begin
                    state_reg_D0 = s2;
                end else begin
                    state_reg_D0 = s1;
                end
            end
            s2: begin
                state_reg_D0 = s0;
            end
            // fault recovery
            default: begin
                state_reg_D0 = s0;
            end
        endcase
    end

    // instance of 'codasip_tmp_var_0' register:
    d_ff_plain_rst_we_t #(
        .bit_width(32'd1),
        .default_value(1'b0),
        .reset_level(1'b0),
        .reset_sync(1'b0)
    ) codasip_tmp_var_0 (
        .CLK(CLK),
        .RST(RST),
        .WE0(codasip_tmp_var_0_WE0),
        .D0(codasip_tmp_var_0_D0),
        .Q0(codasip_tmp_var_0_Q0)
    );

    // instance of 'i_B0' register:
    d_ff_plain_rst_we_t #(
        .bit_width(32'd6),
        .default_value(6'b0),
        .reset_level(1'b0),
        .reset_sync(1'b0)
    ) i_B0 (
        .CLK(CLK),
        .RST(RST),
        .WE0(i_B0_WE0),
        .D0(i_B0_D0),
        .Q0(i_B0_Q0)
    );

    // data-path code:
    assign codasip_tmp_var_0_D0 = ((ACT == 1'd1) && (state_reg_Q0 == s0)) ? 1'd1 :
        ((state_reg_Q0 == s1) && codasip_tmp_var_0_Q0) ? (codasip_tmp_var_1 < 6'd32) : 1'd0;
    assign codasip_tmp_var_0_WE0 = ((ACT == 1'd1) && (state_reg_Q0 == s0)) ? 1'd1 :
        ((state_reg_Q0 == s1) && codasip_tmp_var_0_Q0) ? 1'd1 : 1'd0;
    assign codasip_tmp_var_1 = ((state_reg_Q0 == s1) && codasip_tmp_var_0_Q0) ? (i_B0_Q0 + 6'd1) : 6'd0;
    assign i_B0_D0 = ((ACT == 1'd1) && (state_reg_Q0 == s0)) ? 6'd0 :
        ((state_reg_Q0 == s1) && codasip_tmp_var_0_Q0) ? codasip_tmp_var_1 : 6'd0;
    assign i_B0_WE0 = ((ACT == 1'd1) && (state_reg_Q0 == s0)) ? 1'd1 :
        ((state_reg_Q0 == s1) && codasip_tmp_var_0_Q0) ? 1'd1 : 1'd0;
    assign FIN = (state_reg_Q0 == s2);
    assign rf_gpr_D0 = ((state_reg_Q0 == s1) && codasip_tmp_var_0_Q0) ? 32'd0 : 32'd0;
    assign rf_gpr_WA0 = ((state_reg_Q0 == s1) && codasip_tmp_var_0_Q0) ? i_B0_Q0[4:0] : 5'd0;
    assign rf_gpr_WE0 = ((state_reg_Q0 == s1) && codasip_tmp_var_0_Q0) ? 1'd1 : 1'd0;
endmodule
