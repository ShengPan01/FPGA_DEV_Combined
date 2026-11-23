//*****************************************************************************
// Copyright (c) 2002 ~ 2009 Analogix Semiconductor Incorporated
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

`include "uart_define.v"
module uart_regs (
    //constant input
    input        clk                    ,
    input        resetn                 ,
    input        mcus_rd_en,   // Read strobe, active high
    input        mcus_wr_en,   // Write strobe, active high
    input [15:0] mcus_addr,   // Address
    input [7:0] mcus_wdata,   // Write data
    // inputs reg
    input      reg_uart_tx_busy,
    input [7:0]     reg_uart_rx_buf,
    input      reg_uart_ti,
    input      reg_uart_ri,

    //add other inputs here

    //constant output
    output [7:0] mcus_rdata,   // Read data
    output reg [7:0]     reg_uart_tx_buf,
    output reg      reg_uart_ti_clr,
    output reg      reg_uart_ri_clr,
    output reg      reg_uart_ti_en,
    output reg      reg_uart_ri_en
);

wire bus_wr;
wire bus_rd;
wire [23:0] bus_addr;
wire [31:0] bus_wdata;
reg [31:0] bus_rdata;
reg [31:0] mcus_rdata_1;

assign bus_wr = mcus_wr_en;
assign bus_rd = mcus_rd_en;
assign bus_addr = {8'h0, mcus_addr};
assign bus_wdata = {24'h0, mcus_wdata};

always @(*)
        mcus_rdata_1 = bus_rdata;

assign mcus_rdata = mcus_rdata_1[7:0];


always @(posedge clk or negedge resetn)
    if (~resetn)
        reg_uart_ti_clr <= #`FFD 1'h0;
    else if (bus_wr & (bus_addr[23:0] == `UART_INT) & (bus_wdata[1] ==1'b1))
        reg_uart_ti_clr <= #`FFD ~reg_uart_ti_clr;

always @(posedge clk or negedge resetn)
    if (~resetn)
        reg_uart_ri_clr <= #`FFD 1'h0;
    else if (bus_wr & (bus_addr[23:0] == `UART_INT) & (bus_wdata[0] ==1'b1))
        reg_uart_ri_clr <= #`FFD ~reg_uart_ri_clr;

always @(posedge clk or negedge resetn)
    if (~resetn)
        reg_uart_tx_buf[7:0]      <= #`FFD 8'h0;
    else if (bus_wr & (bus_addr[23:0] == `UART_TX_BUF))
        reg_uart_tx_buf[7:0]  <= #`FFD bus_wdata[7:0];

always @(posedge clk or negedge resetn)
    if (~resetn)
        reg_uart_ti_en              <= #`FFD 1'h0;
    else if (bus_wr & (bus_addr[23:0] == `UART_INT_EN))
        reg_uart_ti_en  <= #`FFD bus_wdata[1];

always @(posedge clk or negedge resetn)
    if (~resetn)
        reg_uart_ri_en              <= #`FFD 1'h0;
    else if (bus_wr & (bus_addr[23:0] == `UART_INT_EN))
        reg_uart_ri_en  <= #`FFD bus_wdata[0];

always @(*)
begin
    bus_rdata = 32'h00;
    if (1/*bus_rd*/) begin
        case(bus_addr[23:0])
        `UART_TX_BUF          :  bus_rdata = {24'h00,reg_uart_tx_buf};
        `UART_TX_ST          :  bus_rdata = {24'h00,7'h0,reg_uart_tx_busy};
        `UART_RX_BUF          :  bus_rdata = {24'h00,reg_uart_rx_buf};
        `UART_INT          :  bus_rdata = {24'h00,6'h0,reg_uart_ti,reg_uart_ri};
        `UART_INT_EN          :  bus_rdata = {24'h00,6'h0,reg_uart_ti_en,reg_uart_ri_en};
        endcase
    end
end

endmodule


/*{ source_processed }*/

