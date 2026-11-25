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
 *  \brief   Contains definition of generic shift register with synchronous write, configurable reset and positive edge detection.
 */

module shift_reg_edge_rst_t #(
    parameter integer bit_width = 32'sd8,
    parameter [bit_width-1:0] default_value = {bit_width{1'b0}},
    parameter [0:0] reset_level = 1'b0,
    parameter [0:0] reset_sync = 1'b0
) (
    input  wire CLK,
    input  wire RST,
    input  wire D0,
    output wire Q0
);
    // local register holding the value
    reg [bit_width-1:0] Q0_reg;

    // local wire to hold shifted value
    wire [bit_width-1:0] shift_D0_wire;

    generate
        if ( bit_width == 32'sd1 ) begin : ONEBIT
            assign shift_D0_wire = D0;
        end else begin : MULTIBIT
            assign shift_D0_wire = {D0, Q0_reg[bit_width-1:1]};
        end
    endgenerate

    generate
        if ( reset_sync ) begin : SYNC
            always @( posedge CLK ) begin
                if ( RST == reset_level ) begin
                    Q0_reg <= default_value;
                end else begin
                    Q0_reg <= shift_D0_wire;
                end
            end
        end else if ( reset_level ) begin : ASYNC_HIGH
            always @( posedge CLK or posedge RST ) begin
                if ( RST == 1'b1 ) begin
                    Q0_reg <= default_value;
                end else begin
                    Q0_reg <= shift_D0_wire;
                end
            end
        end else begin : ASYNC_LOW
            always @( posedge CLK or negedge RST ) begin
                if ( RST == 1'b0 ) begin
                    Q0_reg <= default_value;
                end else begin
                    Q0_reg <= shift_D0_wire;
                end
            end
        end
    endgenerate

    // positive edge detection
    assign Q0 = Q0_reg[1] & (~Q0_reg[0]);

endmodule
