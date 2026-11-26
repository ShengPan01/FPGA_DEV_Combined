 /*
 * Copyright (c) 2026. All rights reserved.
 *
 * Unauthorized copying, modification, distribution, or use
 * of this code is strictly prohibited without prior
 * written permission from the copyright owner.
 *
 * Date: 2026-11-11
 */
 

`include "spi_define.v"
module spi_regs (
    //constant input
    input        clk                    ,
    input        resetn                 ,
    input        mcus_rd_en,   // Read strobe, active high
    input        mcus_wr_en,   // Write strobe, active high
    input [15:0] mcus_addr,   // Address
    input [7:0] mcus_wdata,   // Write data
    // inputs reg
    input      reg_pin_clk_i,
    input      reg_pin_miso_i,
    input      reg_pin_mosi_i,
    input      reg_pin_cs_i,
    input      reg_spi_op_done,

    //add other inputs here

    //constant output
    output [7:0] mcus_rdata,   // Read data
    output reg      reg_pin_clk_oe,
    output reg      reg_pin_clk_o,
    output reg      reg_pin_miso_oe,
    output reg      reg_pin_miso_o,
    output reg      reg_pin_mosi_oe,
    output reg      reg_pin_mosi_o,
    output reg      reg_pin_cs_oe,
    output reg      reg_pin_cs_o,
    output reg      reg_no_wait_miso_set,
    output reg [2:0]     reg_spi_speed,
    output reg      reg_spi_mode,
    output reg      reg_rd_no_wait,
    output reg      reg_cs_end,
    output reg      reg_cs_start,
    output reg [2:0]     reg_spi_op_cmd,
    output reg      reg_spi_op_en,
    output reg [7:0]     reg_tx_byte_num0,
    output reg [7:0]     reg_tx_byte_num1,
    output reg [7:0]     reg_rx_byte_num0,
    output reg [7:0]     reg_rx_byte_num1
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


reg [3:0] spi_op_en_cnt;
always @(posedge clk)
begin
  if (~resetn)
    spi_op_en_cnt[3:0]  <= #`FFD 4'h0;
  else
    if(spi_op_en_cnt[3:0] == 4'hf)
      spi_op_en_cnt[3:0]  <= #`FFD 4'h0;
    else
      if(reg_spi_op_en == 1'b1)
        spi_op_en_cnt[3:0]  <= #`FFD spi_op_en_cnt[3:0] + 1'b1;
      else
        spi_op_en_cnt[3:0]  <= #`FFD 4'h0;
end
always @(posedge clk)
    if (~resetn)
        reg_pin_clk_oe              <= #`FFD 1'h0;
    else if (bus_wr & (bus_addr[23:0] == `SPI_PIN_CTRL))
        reg_pin_clk_oe  <= #`FFD bus_wdata[7];

always @(posedge clk)
    if (~resetn)
        reg_pin_clk_o              <= #`FFD 1'h0;
    else if (bus_wr & (bus_addr[23:0] == `SPI_PIN_CTRL))
        reg_pin_clk_o  <= #`FFD bus_wdata[6];

always @(posedge clk)
    if (~resetn)
        reg_pin_miso_oe              <= #`FFD 1'h0;
    else if (bus_wr & (bus_addr[23:0] == `SPI_PIN_CTRL))
        reg_pin_miso_oe  <= #`FFD bus_wdata[5];

always @(posedge clk)
    if (~resetn)
        reg_pin_miso_o              <= #`FFD 1'h0;
    else if (bus_wr & (bus_addr[23:0] == `SPI_PIN_CTRL))
        reg_pin_miso_o  <= #`FFD bus_wdata[4];

always @(posedge clk)
    if (~resetn)
        reg_pin_mosi_oe              <= #`FFD 1'h0;
    else if (bus_wr & (bus_addr[23:0] == `SPI_PIN_CTRL))
        reg_pin_mosi_oe  <= #`FFD bus_wdata[3];

always @(posedge clk)
    if (~resetn)
        reg_pin_mosi_o              <= #`FFD 1'h0;
    else if (bus_wr & (bus_addr[23:0] == `SPI_PIN_CTRL))
        reg_pin_mosi_o  <= #`FFD bus_wdata[2];

always @(posedge clk)
    if (~resetn)
        reg_pin_cs_oe              <= #`FFD 1'h0;
    else if (bus_wr & (bus_addr[23:0] == `SPI_PIN_CTRL))
        reg_pin_cs_oe  <= #`FFD bus_wdata[1];

always @(posedge clk)
    if (~resetn)
        reg_pin_cs_o              <= #`FFD 1'h0;
    else if (bus_wr & (bus_addr[23:0] == `SPI_PIN_CTRL))
        reg_pin_cs_o  <= #`FFD bus_wdata[0];

always @(posedge clk)
    if (~resetn)
        reg_no_wait_miso_set              <= #`FFD 1'h0;
    else if (bus_wr & (bus_addr[23:0] == `SPI_SET))
        reg_no_wait_miso_set  <= #`FFD bus_wdata[4];

always @(posedge clk)
    if (~resetn)
        reg_spi_speed[2:0]      <= #`FFD 3'h0;
    else if (bus_wr & (bus_addr[23:0] == `SPI_SET))
        reg_spi_speed[2:0]  <= #`FFD bus_wdata[3:1];

always @(posedge clk)
    if (~resetn)
        reg_spi_mode              <= #`FFD 1'h0;
    else if (bus_wr & (bus_addr[23:0] == `SPI_SET))
        reg_spi_mode  <= #`FFD bus_wdata[0];

always @(posedge clk)
    if (~resetn)
        reg_rd_no_wait              <= #`FFD 1'h0;
    else if (bus_wr & (bus_addr[23:0] == `SPI_CTRL))
        reg_rd_no_wait  <= #`FFD bus_wdata[6];

always @(posedge clk)
    if (~resetn)
        reg_cs_end              <= #`FFD 1'h0;
    else if (bus_wr & (bus_addr[23:0] == `SPI_CTRL))
        reg_cs_end  <= #`FFD bus_wdata[5];

always @(posedge clk)
    if (~resetn)
        reg_cs_start              <= #`FFD 1'h0;
    else if (bus_wr & (bus_addr[23:0] == `SPI_CTRL))
        reg_cs_start  <= #`FFD bus_wdata[4];

always @(posedge clk)
    if (~resetn)
        reg_spi_op_cmd[2:0]      <= #`FFD 3'h0;
    else if (bus_wr & (bus_addr[23:0] == `SPI_CTRL))
        reg_spi_op_cmd[2:0]  <= #`FFD bus_wdata[3:1];

always @(posedge clk)
    if (~resetn)
        reg_spi_op_en              <= #`FFD 1'h1;
else
  if(spi_op_en_cnt[3:0] == 4'hf)
    reg_spi_op_en            <= #`FFD 1'h0;
    else if (bus_wr & (bus_addr[23:0] == `SPI_CTRL))
        reg_spi_op_en  <= #`FFD bus_wdata[0];

always @(posedge clk)
    if (~resetn)
        reg_tx_byte_num0[7:0]      <= #`FFD 8'h0;
    else if (bus_wr & (bus_addr[23:0] == `TX_BYTE_NUM0))
        reg_tx_byte_num0[7:0]  <= #`FFD bus_wdata[7:0];

always @(posedge clk)
    if (~resetn)
        reg_tx_byte_num1[7:0]      <= #`FFD 8'h0;
    else if (bus_wr & (bus_addr[23:0] == `TX_BYTE_NUM1))
        reg_tx_byte_num1[7:0]  <= #`FFD bus_wdata[7:0];

always @(posedge clk)
    if (~resetn)
        reg_rx_byte_num0[7:0]      <= #`FFD 8'h0;
    else if (bus_wr & (bus_addr[23:0] == `RX_BYTE_NUM0))
        reg_rx_byte_num0[7:0]  <= #`FFD bus_wdata[7:0];

always @(posedge clk)
    if (~resetn)
        reg_rx_byte_num1[7:0]      <= #`FFD 8'h0;
    else if (bus_wr & (bus_addr[23:0] == `RX_BYTE_NUM1))
        reg_rx_byte_num1[7:0]  <= #`FFD bus_wdata[7:0];

always @(*)
begin
    bus_rdata = 32'h00;
    if (1/*bus_rd*/) begin
        case(bus_addr[23:0])
        `SPI_PIN_STAT          :  bus_rdata = {24'h00,4'h0,reg_pin_clk_i,reg_pin_miso_i,reg_pin_mosi_i,reg_pin_cs_i};
        `SPI_PIN_CTRL          :  bus_rdata = {24'h00,reg_pin_clk_oe,reg_pin_clk_o,reg_pin_miso_oe,reg_pin_miso_o,reg_pin_mosi_oe,reg_pin_mosi_o,reg_pin_cs_oe,reg_pin_cs_o};
        `SPI_SET          :  bus_rdata = {24'h00,3'h0,reg_no_wait_miso_set,reg_spi_speed,reg_spi_mode};
        `SPI_CTRL          :  bus_rdata = {24'h00,reg_spi_op_done,reg_rd_no_wait,reg_cs_end,reg_cs_start,reg_spi_op_cmd,reg_spi_op_en};
        `TX_BYTE_NUM0          :  bus_rdata = {24'h00,reg_tx_byte_num0};
        `TX_BYTE_NUM1          :  bus_rdata = {24'h00,reg_tx_byte_num1};
        `RX_BYTE_NUM0          :  bus_rdata = {24'h00,reg_rx_byte_num0};
        `RX_BYTE_NUM1          :  bus_rdata = {24'h00,reg_rx_byte_num1};
        endcase
    end
end

endmodule


/*{ source_processed }*/

