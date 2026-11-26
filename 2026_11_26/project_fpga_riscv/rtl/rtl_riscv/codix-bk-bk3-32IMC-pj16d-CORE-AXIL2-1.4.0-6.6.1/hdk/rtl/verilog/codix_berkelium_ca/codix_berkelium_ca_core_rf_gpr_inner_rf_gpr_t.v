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
 *  \brief   Contains module definition of the 'codix_berkelium_ca_core_rf_gpr_inner_rf_gpr_t' register file.
 *           size: 32
 *           width: 32 bits
 *           reset: yes
 *           address width: 5 bits
 *           number of read data ports: 2
 *           number of write data ports: 1
 */

module codix_berkelium_ca_core_rf_gpr_inner_rf_gpr_t(
    input  wire CLK,
    input  wire RST,
    input  wire RE0,
    input  wire [4:0] RA0,
    input  wire RE1,
    input  wire [4:0] RA1,
    input  wire WE0,
    input  wire [4:0] WA0,
    input  wire [31:0] D0,
    output wire [31:0] Q0,
    output wire [31:0] Q1
);
    // memory storage
    reg [31:0] RAM[0:31];

    // reset loop counter
    integer ii;

    always @( posedge CLK or negedge RST ) begin
        if ( RST == 1'b0 ) begin
            for ( ii = 32'd0; ii < 32'd32; ii = ii + 32'd1 ) begin
                RAM[ii] <= 32'b0;
            end
        end else begin
            if ( WE0 == 1'b1 ) begin
                RAM[WA0] <= D0;
            end
        end
    end
    assign Q0 = (RE0 == 1'b1) ? RAM[RA0] : 32'b0;
    assign Q1 = (RE1 == 1'b1) ? RAM[RA1] : 32'b0;
endmodule
