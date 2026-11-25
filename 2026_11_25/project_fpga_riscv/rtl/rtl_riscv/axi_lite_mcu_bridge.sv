 /*
 * Copyright (c) 2026. All rights reserved.
 *
 * Unauthorized copying, modification, distribution, or use
 * of this code is strictly prohibited without prior
 * written permission from the copyright owner.
 *
 * Date: 2026-11-11
 */
 

module axi_lite_mcu_bridge #(
    parameter A_BASE = 32'h0,
    parameter A_WIDTH = 16,
    parameter D_WIDTH = 8
) (
    axi_lite_intf.slave axis,

    output        mcum_rd_en,   // Read strobe, active high
    output [D_WIDTH/8-1:0] mcum_wr_en,   // Write strobe, active high
    output reg [A_WIDTH-1:0] mcum_addr,   // Address
    output [D_WIDTH-1:0] mcum_wdata,   // Write data
    input [1:0] mcum_rdata_latency,
    input [D_WIDTH-1:0] mcum_rdata   // Read data
);

localparam IDLE = 2'h0;
localparam B_WR = 2'h1;
localparam B_RD = 2'h2;

reg [1:0] brdg_state;
reg [1:0] next_brdg_state;
reg wr_grant;
reg rd_grant;
reg [A_WIDTH-1:0] mcum_waddr_t;
reg waddr_ready;
reg [D_WIDTH-1:0] mcum_wdata_t;
reg wdata_ready;
reg bvalid;
reg [A_WIDTH-1:0] mcum_raddr_t;
reg rvalid;
reg rvalid_d;
reg [D_WIDTH-1:0] rdata;
reg [1:0] rresp;

always @(posedge axis.a_clk or negedge axis.a_reset_n)
    if (!axis.a_reset_n)
        brdg_state <= IDLE;
    else
        brdg_state <= next_brdg_state;

always @(*)
begin
    next_brdg_state = brdg_state;
    wr_grant = 1'b0;
    rd_grant = 1'b0;
    case (brdg_state)
    IDLE: 
        if (axis.awvalid)
            {next_brdg_state, wr_grant} = {B_WR, 1'b1};
        else if (axis.arvalid)
            {next_brdg_state, rd_grant} = {B_RD, 1'b1};
    B_WR:
        if (axis.bvalid && axis.bready)
            casez ({axis.arvalid, axis.awvalid})
            2'b1?: {next_brdg_state, rd_grant} = {B_RD, 1'b1};
            2'b01: {next_brdg_state, wr_grant} = {B_WR, 1'b1};
            default: next_brdg_state = IDLE;
            endcase
    B_RD:
        if (axis.rvalid && axis.rready)
            casez ({axis.awvalid, axis.arvalid})
            2'b1?: {next_brdg_state, wr_grant} = {B_WR, 1'b1};
            2'b01: {next_brdg_state, rd_grant} = {B_RD, 1'b1};
            default: next_brdg_state = IDLE;
            endcase
    endcase
end

/// write logic ///

wire write_addr_out_of_range;
reg  write_addr_out_of_range_save;
reg [1:0] bresp;

wire [31:0] awaddr_minus_base = axis.awaddr - A_BASE;

always @(posedge axis.a_clk or negedge axis.a_reset_n)
    if (!axis.a_reset_n)
    begin
        mcum_waddr_t <= {A_WIDTH{1'b0}};
        write_addr_out_of_range_save <= 1'b0;
        waddr_ready <= 1'b0;
    end else if (axis.awvalid && axis.awready)
    begin
        mcum_waddr_t <= awaddr_minus_base[A_WIDTH-1:0];
        write_addr_out_of_range_save <= write_addr_out_of_range;
        waddr_ready <= 1'b1;
    end else if (axis.bvalid && axis.bready)
        waddr_ready <= 1'b0;
    
always @(posedge axis.a_clk or negedge axis.a_reset_n)
    if (!axis.a_reset_n)
    begin
        mcum_wdata_t <= {D_WIDTH{1'b0}};
        wdata_ready <= 1'b0;
    end else if (axis.wvalid && axis.wready)
    begin
        mcum_wdata_t <= axis.wdata[D_WIDTH-1:0];
        wdata_ready <= 1'b1;
    end else if (axis.bvalid && axis.bready)
        wdata_ready <= 1'b0;

assign axis.awready = wr_grant;
assign axis.wready = 1'b1;
assign axis.bresp = bresp;

always @(posedge axis.a_clk or negedge axis.a_reset_n)
    if (!axis.a_reset_n)
    begin
        bvalid <= 1'b0;
        bresp <= 2'h0;
    end else if (bvalid && axis.bready)
    begin
        bvalid <= 1'b0;
        bresp <= 2'h0;
    end else if ((axis.awvalid && axis.awready || waddr_ready) && (axis.wvalid && axis.wready || wdata_ready))
    begin
        bvalid <= 1'b1;
        bresp <= (write_addr_out_of_range | write_addr_out_of_range_save) ? 2'b11 : 2'b00;
    end

assign axis.bvalid = bvalid;

/// read logic ///

wire read_addr_out_of_range;

reg [1:0] latency_count;

//always @(posedge axis.a_clk or negedge axis.a_reset_n)
//    if (!axis.a_reset_n)
//        mcum_raddr_t <= {A_WIDTH{1'b0}};
//    else if (axis.arvalid && axis.arready)
//        mcum_raddr_t <= axis.araddr[A_WIDTH-1:0];

always @(posedge axis.a_clk or negedge axis.a_reset_n)
    if (!axis.a_reset_n)
        latency_count <= 2'h0;
    else if (mcum_rd_en)
        latency_count <= mcum_rdata_latency;
    else if (latency_count != 0)
        latency_count <= latency_count - 2'h1;

reg [1:0] latency_count_d;
always @(posedge axis.a_clk or negedge axis.a_reset_n)
    if (!axis.a_reset_n)
        latency_count_d <= 2'h0;
    else 
        latency_count_d <= latency_count;
wire latency_2cycle_en = (latency_count_d == 2'h2 || latency_count == 2'h2) ? 1'b1 : 1'b0;

always @(posedge axis.a_clk or negedge axis.a_reset_n)
    if (!axis.a_reset_n)
        rdata <= {D_WIDTH{1'b0}};
    else if (mcum_rd_en && mcum_rdata_latency==0)
        rdata <= mcum_rdata;
    else/* if (latency_count == 1)*/
        rdata <= mcum_rdata;

assign axis.arready = rd_grant;

always @(posedge axis.a_clk or negedge axis.a_reset_n)
    if (!axis.a_reset_n)
        rvalid <= 1'b0;
    else if (axis.arvalid && axis.arready)/* && read_addr_out_of_range)
        rvalid <= 1'b1;
    else if ((axis.arvalid && axis.arready && !read_addr_out_of_range && mcum_rdata_latency==0) || (latency_count == 1))*/
        rvalid <= 1'b1;
    else if (axis.rready)
        rvalid <= 1'b0;

always @(posedge axis.a_clk or negedge axis.a_reset_n)
    if (!axis.a_reset_n)
        rvalid_d <= 1'b0;
    else 
        rvalid_d <= rvalid;


assign axis.rvalid = (latency_2cycle_en ==1'b1)? rvalid_d :rvalid;
//assign axis.rvalid = rvalid;

assign axis.rdata = (latency_count == 1) ? mcum_rdata : rdata;
assign axis.rresp = rresp;

always @(posedge axis.a_clk or negedge axis.a_reset_n)
    if (!axis.a_reset_n)
        rresp <= 2'h0;
    else if (axis.arvalid && axis.arready)
        rresp <= read_addr_out_of_range ? 2'b11 : 2'b00;

///

wire [31:0] araddr_minus_base = axis.araddr - A_BASE;

always @(*)
begin
    mcum_addr = {A_WIDTH{1'b0}};
    if (axis.arvalid && axis.arready)
        mcum_addr = araddr_minus_base[A_WIDTH-1:0];
    else /*if (axis.awvalid && axis.awready)
        mcum_addr = awaddr_minus_base[A_WIDTH-1:0];
    else */if (brdg_state == B_WR)
        mcum_addr = mcum_waddr_t;
   /*    else if (brdg_state == B_RD)
        mcum_addr = mcum_raddr_t;*/
end

generate
    if (A_WIDTH == 32)
    begin
        assign read_addr_out_of_range = 1'b0;
        assign write_addr_out_of_range = 1'b0;
    end else
    begin
        assign read_addr_out_of_range = araddr_minus_base[31:A_WIDTH] != 0;
        assign write_addr_out_of_range = awaddr_minus_base[31:A_WIDTH] != 0;
    end
endgenerate

assign mcum_rd_en = !read_addr_out_of_range && axis.arvalid && axis.arready;
assign mcum_wr_en = !write_addr_out_of_range_save ? ({(D_WIDTH/8){axis.wvalid && axis.wready}} & axis.wstrb) : {(D_WIDTH/8){1'b0}};
assign mcum_wdata = /*(axis.wvalid && axis.wready) ?*/ axis.wdata[D_WIDTH-1:0] /*: mcum_wdata_t*/;

endmodule
