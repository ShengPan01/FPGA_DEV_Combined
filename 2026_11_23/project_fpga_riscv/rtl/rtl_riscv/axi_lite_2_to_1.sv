//*****************************************************************************
// Copyright (c) 2002 ~ 2017 Analogix Semiconductor Incorporated
// All Rights Reserved
//
// THIS IS UNPUBLISHED PROPRIETARY SOURCE CODE of Analogix Semiconductor Inc.
// The copyright notice above does not evidence any actual or intended
// publication of such source code.
//
// No part of this code may be reproduced, stored in a retrieval system,
// or transmitted, in any form or by any means, electronic, mechanical,
// photocopying, recording, or otherwise, without the prior written
// permission of Analogix Semiconductor Inc.
//
//*****************************************************************************
//

module axi_lite_2_to_1 #(
    parameter A_WIDTH = 32,
    parameter D_WIDTH = 32
) (
    axi_lite_intf.slave axis_0,
    axi_lite_intf.slave axis_1,
    axi_lite_intf.master axim_0

);

/// read address arbitor ///

reg [1:0] next_grant;
reg [1:0] grant;
reg [1:0] ar_req_pending;
reg [A_WIDTH-1:0] araddr_save;
reg [2:0] arprot_save;
reg [1:0] resp_pending;

always @(*)
begin
    next_grant = 2'h0;
    casez ({(ar_req_pending!=0), grant[1:0], axis_1.arvalid, axis_0.arvalid})
    5'b0??01: next_grant = 2'b01;
    5'b0??10: next_grant = 2'b10;
    5'b0?011: next_grant = 2'b01;
    5'b00111: next_grant = 2'b10;
    default: next_grant = 2'b00;
    endcase
end

assign axis_0.arready = next_grant[0];
assign axis_1.arready = next_grant[1];

always @(posedge axim_0.a_clk or negedge axim_0.a_reset_n)
    if (!axim_0.a_reset_n)
        ar_req_pending <= 2'h0;
    else if (axim_0.arvalid && axim_0.arready)
        ar_req_pending <= 2'h0;
    else if (axis_0.arvalid && axis_0.arready)
        ar_req_pending <= 2'b01;
    else if (axis_1.arvalid && axis_1.arready) 
        ar_req_pending <= 2'b10;

assign axim_0.arvalid = (next_grant != 2'h0) || (ar_req_pending != 2'h0);

always @(posedge axim_0.a_clk or negedge axim_0.a_reset_n)
    if (!axim_0.a_reset_n)
        araddr_save <= {A_WIDTH{1'b0}};
    else if (axis_0.arvalid && axis_0.arready)
        araddr_save <= axis_0.araddr;
    else if (axis_1.arvalid && axis_1.arready)
        araddr_save <= axis_1.araddr;

always @(posedge axim_0.a_clk or negedge axim_0.a_reset_n)
    if (!axim_0.a_reset_n)
        arprot_save <= {A_WIDTH{1'b0}};
    else if (axis_0.arvalid && axis_0.arready)
        arprot_save <= axis_0.arprot;
    else if (axis_1.arvalid && axis_1.arready)
        arprot_save <= axis_1.arprot;

assign axim_0.araddr = next_grant[0] ? axis_0.araddr :
    next_grant[1] ? axis_1.araddr : araddr_save;
assign axim_0.arprot = next_grant[0] ? axis_0.arprot :
    next_grant[1] ? axis_1.arprot : arprot_save;

always @(posedge axim_0.a_clk or negedge axim_0.a_reset_n)
    if (!axim_0.a_reset_n)
        grant <= 2'h0;
    else if (next_grant)
        grant <= next_grant;

always @(posedge axim_0.a_clk or negedge axim_0.a_reset_n)
    if (!axim_0.a_reset_n)
        resp_pending <= 2'h0;
    else if (axim_0.arvalid && axim_0.arready)
        resp_pending <= (next_grant != 2'h0) ? next_grant : ar_req_pending;
    else if (axim_0.rvalid && axim_0.rready)
        resp_pending <= 2'h0;

/// read data channel ///

assign axis_0.rvalid = axim_0.rvalid & resp_pending[0];
assign axis_0.rdata = axim_0.rdata;
assign axis_0.rresp = axim_0.rresp;
assign axis_1.rvalid = axim_0.rvalid & resp_pending[1];
assign axis_1.rdata = axim_0.rdata;
assign axis_1.rresp = axim_0.rresp;

assign axim_0.rready = resp_pending[0] ? axis_0.rready :
    resp_pending[1] ? axis_1.rready : 1'b0;

/// write address ///

/// ...
assign axim_0.awvalid = axis_1.awvalid;//1'b0;
assign axim_0.awaddr = axis_1.awaddr;//32'b0;
assign axim_0.awprot = axis_1.awprot;//3'b0;
assign axim_0.wvalid = axis_1.wvalid;//1'b0;
assign axim_0.wdata = axis_1.wdata;//32'b0;
assign axim_0.wstrb = axis_1.wstrb;//4'b0;
assign axim_0.bready = axis_1.bready;//1'b0;
assign axis_0.awready = 1'b0;
assign axis_0.wready = 1'b0;
assign axis_0.bvalid = 1'b0;
assign axis_0.bresp = 2'b0;
assign axis_1.awready = axim_0.awready;//1'b0;
assign axis_1.wready = axim_0.wready;//1'b0;
assign axis_1.bvalid = axim_0.bvalid;//1'b0;
assign axis_1.bresp = axim_0.bresp;//2'b0;

endmodule
