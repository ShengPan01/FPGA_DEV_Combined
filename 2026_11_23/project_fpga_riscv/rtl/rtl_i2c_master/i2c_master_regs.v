 /*
 * Copyright (c) 2026. All rights reserved.
 *
 * Unauthorized copying, modification, distribution, or use
 * of this code is strictly prohibited without prior
 * written permission from the copyright owner.
 *
 * Date: 2026-11-11
 */
 

`include "i2c_master_define.v"
module i2c_master_regs (
    //constant input
    input        clk                    ,
    input        resetn                 ,
    input        mcus_rd_en,   // Read strobe, active high
    input        mcus_wr_en,   // Write strobe, active high
    input [15:0] mcus_addr,   // Address
    input [7:0] mcus_wdata,   // Write data
    // inputs reg
    input      reg_i2cm_master_error,
    input      reg_i2cm_occupy,
    input      reg_i2cm_fifo_full,
    input      reg_i2cm_fifo_empt,
    input      reg_i2cm_no_ack,
    input      reg_i2cm_timeout,
    input      reg_i2cm_error,
    input      reg_i2cm_progress,
    input [7:0]     reg_i2cm_fifo_cnt,
    input      reg_intp_fifo_full,
    input      reg_intp_fifo_empty,
    input      reg_intp_fifo_half,
    input      reg_intp_acc_done,

    //add other inputs here

    //constant output
    output [7:0] mcus_rdata,   // Read data
    output reg [7:0]     reg_i2cm_dev_addr,
    output reg [7:0]     reg_i2cm_sgmt_addr,
    output reg [7:0]     reg_i2cm_offset,
    output reg [2:0]     reg_i2cm_access_cmd,
    output reg [7:0]     reg_i2cm_access_num,
    output reg [1:0]     reg_i2cm_access_num1,
    output reg      reg_intp_fifo_full_clr,
    output reg      reg_intp_fifo_empty_clr,
    output reg      reg_intp_fifo_half_clr,
    output reg      reg_intp_acc_done_clr,
    output reg      reg_i2cm_no_stop,
    output reg      reg_i2cm_no_ack_ignore,
    output reg      reg_i2cm_eddc_no_ack,
    output reg      reg_i2cm_glitch_sel,
    output reg      reg_i2cm_mode,
    output reg [1:0]     reg_i2cm_speed
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
        reg_intp_fifo_full_clr <= #`FFD 1'h0;
    else if (bus_wr & (bus_addr[23:0] == `I2CM_INT_ST) & (bus_wdata[3] ==1'b1))
        reg_intp_fifo_full_clr <= #`FFD ~reg_intp_fifo_full_clr;

always @(posedge clk or negedge resetn)
    if (~resetn)
        reg_intp_fifo_empty_clr <= #`FFD 1'h0;
    else if (bus_wr & (bus_addr[23:0] == `I2CM_INT_ST) & (bus_wdata[2] ==1'b1))
        reg_intp_fifo_empty_clr <= #`FFD ~reg_intp_fifo_empty_clr;

always @(posedge clk or negedge resetn)
    if (~resetn)
        reg_intp_fifo_half_clr <= #`FFD 1'h0;
    else if (bus_wr & (bus_addr[23:0] == `I2CM_INT_ST) & (bus_wdata[1] ==1'b1))
        reg_intp_fifo_half_clr <= #`FFD ~reg_intp_fifo_half_clr;

always @(posedge clk or negedge resetn)
    if (~resetn)
        reg_intp_acc_done_clr <= #`FFD 1'h0;
    else if (bus_wr & (bus_addr[23:0] == `I2CM_INT_ST) & (bus_wdata[0] ==1'b1))
        reg_intp_acc_done_clr <= #`FFD ~reg_intp_acc_done_clr;

always @(posedge clk or negedge resetn)
    if (~resetn)
        reg_i2cm_dev_addr[7:0]      <= #`FFD 8'h0;
    else if (bus_wr & (bus_addr[23:0] == `I2CM_DEV_ADDR))
        reg_i2cm_dev_addr[7:0]  <= #`FFD bus_wdata[7:0];

always @(posedge clk or negedge resetn)
    if (~resetn)
        reg_i2cm_sgmt_addr[7:0]      <= #`FFD 8'h0;
    else if (bus_wr & (bus_addr[23:0] == `I2CM_SGMT_ADDR))
        reg_i2cm_sgmt_addr[7:0]  <= #`FFD bus_wdata[7:0];

always @(posedge clk or negedge resetn)
    if (~resetn)
        reg_i2cm_offset[7:0]      <= #`FFD 8'h0;
    else if (bus_wr & (bus_addr[23:0] == `I2CM_OFFSET))
        reg_i2cm_offset[7:0]  <= #`FFD bus_wdata[7:0];

always @(posedge clk or negedge resetn)
    if (~resetn)
        reg_i2cm_access_cmd[2:0]      <= #`FFD 3'h0;
    else if (bus_wr & (bus_addr[23:0] == `I2CM_CMD))
        reg_i2cm_access_cmd[2:0]  <= #`FFD bus_wdata[2:0];

always @(posedge clk or negedge resetn)
    if (~resetn)
        reg_i2cm_access_num[7:0]      <= #`FFD 8'h0;
    else if (bus_wr & (bus_addr[23:0] == `I2CM_NUM0))
        reg_i2cm_access_num[7:0]  <= #`FFD bus_wdata[7:0];

always @(posedge clk or negedge resetn)
    if (~resetn)
        reg_i2cm_access_num1[1:0]      <= #`FFD 2'h0;
    else if (bus_wr & (bus_addr[23:0] == `I2CM_NUM1))
        reg_i2cm_access_num1[1:0]  <= #`FFD bus_wdata[1:0];

always @(posedge clk or negedge resetn)
    if (~resetn)
        reg_i2cm_no_stop              <= #`FFD 1'h0;
    else if (bus_wr & (bus_addr[23:0] == `I2CM_FSM_CTRL))
        reg_i2cm_no_stop  <= #`FFD bus_wdata[6];

always @(posedge clk or negedge resetn)
    if (~resetn)
        reg_i2cm_no_ack_ignore              <= #`FFD 1'h0;
    else if (bus_wr & (bus_addr[23:0] == `I2CM_FSM_CTRL))
        reg_i2cm_no_ack_ignore  <= #`FFD bus_wdata[5];

always @(posedge clk or negedge resetn)
    if (~resetn)
        reg_i2cm_eddc_no_ack              <= #`FFD 1'h0;
    else if (bus_wr & (bus_addr[23:0] == `I2CM_FSM_CTRL))
        reg_i2cm_eddc_no_ack  <= #`FFD bus_wdata[4];

always @(posedge clk or negedge resetn)
    if (~resetn)
        reg_i2cm_glitch_sel              <= #`FFD 1'h0;
    else if (bus_wr & (bus_addr[23:0] == `I2CM_FSM_CTRL))
        reg_i2cm_glitch_sel  <= #`FFD bus_wdata[3];

always @(posedge clk or negedge resetn)
    if (~resetn)
        reg_i2cm_mode              <= #`FFD 1'h1;
    else if (bus_wr & (bus_addr[23:0] == `I2CM_FSM_CTRL))
        reg_i2cm_mode  <= #`FFD bus_wdata[2];

always @(posedge clk or negedge resetn)
    if (~resetn)
        reg_i2cm_speed[1:0]      <= #`FFD 2'h3;
    else if (bus_wr & (bus_addr[23:0] == `I2CM_FSM_CTRL))
        reg_i2cm_speed[1:0]  <= #`FFD bus_wdata[1:0];

always @(*)
begin
    bus_rdata = 32'h00;
    if (1/*bus_rd*/) begin
        case(bus_addr[23:0])
        `I2CM_DEV_ADDR          :  bus_rdata = {24'h00,reg_i2cm_dev_addr};
        `I2CM_SGMT_ADDR          :  bus_rdata = {24'h00,reg_i2cm_sgmt_addr};
        `I2CM_OFFSET          :  bus_rdata = {24'h00,reg_i2cm_offset};
        `I2CM_CMD          :  bus_rdata = {24'h00,5'h0,reg_i2cm_access_cmd};
        `I2CM_NUM0          :  bus_rdata = {24'h00,reg_i2cm_access_num};
        `I2CM_NUM1          :  bus_rdata = {24'h00,6'h0,reg_i2cm_access_num1};
        `I2CM_STATUS          :  bus_rdata = {24'h00,reg_i2cm_master_error,reg_i2cm_occupy,reg_i2cm_fifo_full,reg_i2cm_fifo_empt,reg_i2cm_no_ack,reg_i2cm_timeout,reg_i2cm_error,reg_i2cm_progress};
        `I2CM_FIFO_CNT          :  bus_rdata = {24'h00,reg_i2cm_fifo_cnt};
        `I2CM_INT_ST          :  bus_rdata = {24'h00,4'h0,reg_intp_fifo_full,reg_intp_fifo_empty,reg_intp_fifo_half,reg_intp_acc_done};
        `I2CM_FSM_CTRL          :  bus_rdata = {24'h00,1'h0,reg_i2cm_no_stop,reg_i2cm_no_ack_ignore,reg_i2cm_eddc_no_ack,reg_i2cm_glitch_sel,reg_i2cm_mode,reg_i2cm_speed};
        endcase
    end
end

endmodule


/*{ source_processed }*/

