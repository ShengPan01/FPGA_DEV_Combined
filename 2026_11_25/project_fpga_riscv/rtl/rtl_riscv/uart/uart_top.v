
`include "uart_define.v"

module uart_top #(
    parameter clk_freq = 27_000_000
) (
    input       clk,
    input       rst_n,
    input       jtag_load,
    output uart_intr,
    output [31:0] debug_status_o,
    output reg  download_ack_done_o,
//flash interface
    input       rden_i,
    output[7:0] rd_qout_o,
    output reg  data_ready_o,   
    output	uart_data_error, 
    
    output wire [15:0]ram_wr_addr_h,
    output wire[15:0]ram_wr_addr,
    output wire[7:0] ram_wr_data,
    output wire      ram_wr_en,

//uart interface   
    input       uart_rx_i,
    output      uart_tx_o,
    input       uart_cts_i,
    output      uart_rts_o,
    
    input        reg_clk                    ,
    input        reg_reset_n                 ,
    input        mcus_rd_en,   // Read strobe, active high
    input        mcus_wr_en,   // Write strobe, active high
    input [15:0] mcus_addr,   // Address
    input [7:0] mcus_wdata,   // Write data
    output [7:0] mcus_rdata   // Read data
    
);
wire[7:0] rx_data;
wire      rx_data_valid;
reg[15:0] ram_rd_addr;
wire	  tx_rdy;
wire	  tx_error;
wire   final_done;
wire [3:0] hex_debug_state;
assign    tx_error = (~tx_rdy && rx_data_valid) ? 1'b1 : 1'b0;
//Note: It is strongly recommended to reset the system before the uart transmition,especially after the operation failed. 

    
always@(posedge clk or negedge rst_n)   
        if(~rst_n)		ram_rd_addr <= 0;
        else if(rden_i)		ram_rd_addr <= ram_rd_addr + 1'b1;
always@(posedge clk or negedge rst_n)
	if(~rst_n)		data_ready_o<= 1'b0;
	else if(jtag_load)  data_ready_o<= 1'b1;
	else if(rden_i)		data_ready_o<= 1'b0;
	else if(final_done)	data_ready_o<= 1'b1;		

uart_rx #(
    .clk_freq(clk_freq)
) u1_uart_rx(
	.clk		(clk),
	.rst_n		(rst_n),
	.rx_i		(uart_rx_i),
	.rx_data_o	(rx_data),
	.rx_data_valid_o(rx_data_valid)
);

reg [7:0] reg_uart_rx_buf;
wire reg_uart_ri_clr;

always @(posedge clk or negedge rst_n)
    if (!rst_n)
        reg_uart_rx_buf <= 8'h0;
    else if (data_ready_o && rx_data_valid)
        reg_uart_rx_buf <= rx_data;

sync_reg reg_uart_ri_clr_sync_reg(.clk(clk), .din(reg_uart_ri_clr), .dout(reg_uart_ri_clr_sync));

reg reg_uart_ri_clr_sync_d;

always @(posedge clk)
    reg_uart_ri_clr_sync_d <= reg_uart_ri_clr_sync;

reg reg_uart_ri;

always @(posedge clk or negedge rst_n)
    if (!rst_n)
        reg_uart_ri <= 1'b0;
    else if (data_ready_o && rx_data_valid)
        reg_uart_ri <= 1'b1;
    else if (data_ready_o && (reg_uart_ri_clr_sync ^ reg_uart_ri_clr_sync_d))
        reg_uart_ri <= 1'b0;


wire [7:0] reg_uart_tx_buf;
reg reg_tx_data_valid_i;
reg reg_uart_tx_busy;

sync_reg reg_uart_ti_clr_sync_reg(.clk(clk), .din(reg_uart_ti_clr), .dout(reg_uart_ti_clr_sync));

reg reg_uart_ti_clr_sync_d;

always @(posedge clk)
    reg_uart_ti_clr_sync_d <= reg_uart_ti_clr_sync;


reg final_done_d;
reg completion_tx_pending;
reg completion_tx_active;

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        final_done_d          <= 1'b0;
        completion_tx_pending <= 1'b0;
        completion_tx_active  <= 1'b0;
        download_ack_done_o   <= 1'b1;
    end else begin
        final_done_d <= final_done;

        if (final_done && !final_done_d) begin
            completion_tx_pending <= 1'b1;
            download_ack_done_o <= 1'b0;
        end else if (completion_tx_pending && tx_rdy) begin
            completion_tx_pending <= 1'b0;
            completion_tx_active <= 1'b1;
        end else if (completion_tx_active && tx_rdy) begin
            completion_tx_active <= 1'b0;
            download_ack_done_o <= 1'b1;
        end
    end
end

wire [7:0] tx_data_i = completion_tx_pending ? 8'h21 :
                       (data_ready_o ? reg_uart_tx_buf[7:0] : 8'h2e);

wire tx_data_valid_i = completion_tx_pending ? tx_rdy :
                       (data_ready_o ? reg_tx_data_valid_i :
                        rx_data_valid && (rx_data == 8'h0a));


reg reg_uart_ti;
reg tx_rdy_d;

always @(posedge clk or negedge rst_n)
    if (!rst_n)
    begin
        reg_uart_ti <= 1'b0;
        tx_rdy_d <= 1'b0;
    end else 
    begin
        tx_rdy_d <= tx_rdy;
        if (data_ready_o && (tx_rdy && !tx_rdy_d))
            reg_uart_ti <= 1'b1;
        else if (reg_uart_ti_clr_sync ^ reg_uart_ti_clr_sync_d)
            reg_uart_ti <= 1'b0;
    end

uart_tx #(
    .clk_freq(clk_freq)
) u1_uart_tx(
	.clk		(clk),
	.rst_n		(rst_n),
	.tx_o		(uart_tx_o),
	.tx_data_i	(tx_data_i),
	.tx_data_valid_i(tx_data_valid_i),
	.tx_rdy_o	(tx_rdy)
);
assign debug_status_o = {rx_data, hex_debug_state, 4'b0000,
    reg_uart_ri_en, reg_uart_ti_en, reg_uart_ri, reg_uart_ti,
    uart_intr, reg_uart_tx_busy, reg_tx_data_valid_i, tx_rdy,
    uart_tx_o, uart_rx_i, tx_error, uart_data_error,
    ram_wr_en, final_done, data_ready_o, rx_data_valid};

hex_analysis u1_hex_analysis(
    .debug_state_o(hex_debug_state),
	.clk		(clk),
	.rst_n		(rst_n),	
	.rx_data_i	(rx_data),
	.rx_data_valid_i(rx_data_valid),
    .tx_rdy     (tx_rdy),
    .ram_addr_h_o(ram_wr_addr_h[15:0]),
	.ram_addr_o	(ram_wr_addr),
	.ram_data_o	(ram_wr_data),
	.ram_we_o	(ram_wr_en),
	.error_o	(uart_data_error),
	.final_done_o	(final_done)
);


/*SDPRAM_65536x8 uart_SDPRAM_65536x8 (
    .clka(clk),    // input wire clka
    .wea(ram_wr_en),      // input wire [0 : 0] wea
    .addra(ram_wr_addr),  // input wire [12 : 0] addra
    .dina(ram_wr_data),    // input wire [7 : 0] dina
    .clkb(clk),    // input wire clkb
    .addrb(ram_rd_addr),  // input wire [12 : 0] addrb
    .doutb(rd_qout_o)  // output wire [7 : 0] doutb
    );*/
assign rd_qout_o = ram_rd_addr[7:0];//use for debug    
assign uart_rts_o = 1'b0;

/// UART register ///

always @(posedge reg_clk or negedge reg_reset_n)
    if (!reg_reset_n)
        reg_tx_data_valid_i <= 1'b0;
    else if (mcus_wr_en && (mcus_addr == `UART_TX_BUF))
        reg_tx_data_valid_i <= 1'b1;
    else
        reg_tx_data_valid_i <= 1'b0;

sync_reg tx_rdy_d_sync_reg(.clk(reg_clk), .din(tx_rdy_d), .dout(tx_rdy_d_sync));

reg tx_rdy_d_sync_d;

always @(posedge reg_clk)
    tx_rdy_d_sync_d <= tx_rdy_d_sync;

always @(posedge reg_clk or negedge reg_reset_n)
    if (!reg_reset_n)
        reg_uart_tx_busy <= 1'b0;
    else if (mcus_wr_en && (mcus_addr == `UART_TX_BUF))
        reg_uart_tx_busy <= 1'b1;
    else if (tx_rdy_d_sync & !tx_rdy_d_sync_d)
        reg_uart_tx_busy <= 1'b0;

uart_regs uart_regs (
    //constant input
    .clk                    (reg_clk),
    .resetn                 (reg_reset_n),
    .mcus_rd_en(mcus_rd_en),   // Read strobe, active high
    .mcus_wr_en(mcus_wr_en),   // Write strobe, active high
    .mcus_addr(mcus_addr[15:0]),   // Address
    .mcus_wdata(mcus_wdata[7:0]),   // Write data
    .mcus_rdata(mcus_rdata[7:0]),   // Read data
    // inputs reg
    .reg_uart_tx_busy(reg_uart_tx_busy),
    .reg_uart_ti(reg_uart_ti),
    .reg_uart_rx_buf(reg_uart_rx_buf[7:0]),
    .reg_uart_ri(reg_uart_ri),

    //add other inputs here

    //constant output
    .reg_uart_tx_buf(reg_uart_tx_buf[7:0]),
    .reg_uart_ti_clr(reg_uart_ti_clr),
    .reg_uart_ri_clr(reg_uart_ri_clr),
    .reg_uart_ti_en(reg_uart_ti_en),
    .reg_uart_ri_en(reg_uart_ri_en)
);

assign uart_intr = reg_uart_ti_en & reg_uart_ti | reg_uart_ri_en & reg_uart_ri;

endmodule
