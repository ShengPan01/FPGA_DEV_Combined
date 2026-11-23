
`include "spi_define.v"

module spi(
    input        reg_clk                    ,
    input        reg_reset_n                 ,
    input        mcus_rd_en,   // Read strobe, active high
    input        mcus_wr_en,   // Write strobe, active high
    input [15:0] mcus_addr,   // Address
    input [7:0] mcus_wdata,   // Write data
    output [7:0] mcus_rdata,   // Read data
    
    input spi_clk,
    input spi_reset_n,

    input spi_cs_in,
    output spi_cs_out,
    output spi_cs_out_en,

    input spi_clk_in,
    output spi_clk_out,
    output spi_clk_out_en,

    input spi_mosi_in,
    output spi_mosi_out,
    output spi_mosi_out_en,

    input spi_miso_in,
    output spi_miso_out,
    output spi_miso_out_en,
    
    input sram_clk,
    input [10:0] sram_addr,
    input [7:0] sram_data_in,
    input sram_we,
    output [7:0] sram_data_out
    
);

wire [2:0] reg_spi_speed;
wire [2:0] reg_spi_op_cmd;
wire [7:0] reg_tx_byte_num0;
wire [7:0] reg_tx_byte_num1;
wire [7:0] reg_rx_byte_num0;
wire [7:0] reg_rx_byte_num1;
reg reg_spi_op_done;

spi_regs spi_regs (

    .clk       (reg_clk)             ,
    .resetn    (reg_reset_n)         ,
    .mcus_rd_en(mcus_rd_en),   // Read strobe, active high
    .mcus_wr_en(mcus_wr_en),   // Write strobe, active high
    .mcus_addr (mcus_addr),   // Address
    .mcus_wdata(mcus_wdata),   // Write data
    .mcus_rdata(mcus_rdata),   // Read data

    .reg_pin_clk_i(spi_clk_in),
    .reg_pin_miso_i(spi_miso_in),
    .reg_pin_mosi_i(spi_mosi_in),
    .reg_pin_cs_i(spi_cs_in),

    .reg_pin_clk_oe(spi_clk_out_en_gpio),
    .reg_pin_clk_o(spi_clk_out_gpio),
    .reg_pin_miso_oe(spi_miso_out_en_gpio),
    .reg_pin_miso_o(spi_miso_out_gpio),
    .reg_pin_mosi_oe(spi_mosi_out_en_gpio),
    .reg_pin_mosi_o(spi_mosi_out_gpio),
    .reg_pin_cs_oe(spi_cs_out_en_gpio),
    .reg_pin_cs_o(spi_cs_out_gpio),

    .reg_spi_op_done(reg_spi_op_done),

    .reg_no_wait_miso_set(),
    .reg_spi_speed(reg_spi_speed[2:0]),
    .reg_spi_mode(reg_spi_mode),
    .reg_rd_no_wait(reg_rd_no_wait),
    .reg_cs_end(reg_cs_end),
    .reg_cs_start(reg_cs_start),
    .reg_spi_op_cmd(reg_spi_op_cmd[2:0]),
    .reg_spi_op_en(reg_spi_op_en),
    .reg_tx_byte_num0(reg_tx_byte_num0[7:0]),
    .reg_tx_byte_num1(reg_tx_byte_num1[7:0]),
    .reg_rx_byte_num0(reg_rx_byte_num0[7:0]),
    .reg_rx_byte_num1(reg_rx_byte_num1[7:0])

);

// Both clocks come from clk_wiz_0 and remain synchronously timed. Stage
// configuration at the SPI boundary so the short inter-clock requirement
// covers only register-to-register routing, not SPI decode/counter logic.
// Do not false-path these buses: individual bits must meet setup/hold.
// The existing two-cycle command synchronizer lets this stage settle before
// start_op, including control bits written together with reg_spi_op_en.
// Software must keep configuration stable throughout an active operation.
reg [2:0] reg_spi_speed_spi;
reg [2:0] reg_spi_op_cmd_spi;
reg [7:0] reg_tx_byte_num0_spi;
reg [7:0] reg_tx_byte_num1_spi;
reg [7:0] reg_rx_byte_num0_spi;
reg [7:0] reg_rx_byte_num1_spi;
reg reg_rd_no_wait_spi;
reg reg_cs_end_spi;
reg reg_cs_start_spi;

always @(posedge spi_clk or negedge spi_reset_n)
    if (!spi_reset_n) begin
        reg_spi_speed_spi <= 0;
        reg_spi_op_cmd_spi <= 0;
        reg_tx_byte_num0_spi <= 0;
        reg_tx_byte_num1_spi <= 0;
        reg_rx_byte_num0_spi <= 0;
        reg_rx_byte_num1_spi <= 0;
        reg_rd_no_wait_spi <= 0;
        reg_cs_end_spi <= 0;
        reg_cs_start_spi <= 0;
    end else begin
        reg_spi_speed_spi <= reg_spi_speed;
        reg_spi_op_cmd_spi <= reg_spi_op_cmd;
        reg_tx_byte_num0_spi <= reg_tx_byte_num0;
        reg_tx_byte_num1_spi <= reg_tx_byte_num1;
        reg_rx_byte_num0_spi <= reg_rx_byte_num0;
        reg_rx_byte_num1_spi <= reg_rx_byte_num1;
        reg_rd_no_wait_spi <= reg_rd_no_wait;
        reg_cs_end_spi <= reg_cs_end;
        reg_cs_start_spi <= reg_cs_start;
    end

parameter TX_BUF_BASE = 11'h0;
parameter RX_BUF_BASE = 11'h280;

reg [10:0] spi_buf_addr;
wire [7:0] spi_buf_din;
wire spi_buf_we;
wire [7:0] spi_buf_dout;

spi_buf_wrapper spi_buf_wrapper(
    .clk_a(sram_clk),
    .addr_a(sram_addr[10:0]),
    .data_in_a(sram_data_in[7:0]),
    .we_a(sram_we),
    .data_out_a(sram_data_out[7:0]),
    .clk_b(spi_clk),
    .addr_b(spi_buf_addr[10:0]),
    .data_in_b(spi_buf_din[7:0]),
    .we_b(spi_buf_we),
    .data_out_b(spi_buf_dout[7:0])
);

parameter SPI_CMD_WR = 3'h1;
parameter SPI_CMD_RD = 3'h2;
parameter SPI_CMD_WR_RD = 3'h3;
parameter SPI_CMD_SET_CS = 3'h4;

parameter SPI_IDLE      = 2'h0;
parameter SPI_WR        = 2'h1;
parameter SPI_RD_WAIT   = 2'h2;
parameter SPI_RD        = 2'h3;

reg [1:0] spi_state;
reg [1:0] next_spi_state;
reg [7:0] speed_cntr;
reg [3:0] bit_cntr;
reg [9:0] byte_cntr;
wire [7:0] speed_cntr_th = (1 << reg_spi_speed_spi[2:0]) - 1;
reg [7:0] tx_byte_shift;
wire tx_bit_done = (speed_cntr == speed_cntr_th) && bit_cntr[0];
wire tx_byte_done = tx_bit_done && (bit_cntr[3:1] == 3'h7);
wire rx_bit_latch = (speed_cntr == speed_cntr_th) && !bit_cntr[0];
wire rx_byte_latch = rx_bit_latch && (bit_cntr[3:1] == 3'h7);
reg [7:0] rx_byte_shift;
reg [7:0] spi_rx_byte;
reg rx_byte_valid;

always @(posedge spi_clk or negedge spi_reset_n)
    if (!spi_reset_n)
        speed_cntr <= 8'h0;
    else if ((spi_state == SPI_IDLE) || (speed_cntr == speed_cntr_th))
        speed_cntr <= 8'h0;
    else
        speed_cntr <= speed_cntr + 8'h1;
        
always @(posedge spi_clk or negedge spi_reset_n)
    if (!spi_reset_n)
        bit_cntr <= 4'h0;
    else if ((spi_state == SPI_IDLE))
        bit_cntr <= 4'h0;
    else if (speed_cntr == speed_cntr_th)
        bit_cntr <= bit_cntr + 4'h1;
    
always @(posedge spi_clk or negedge spi_reset_n)
    if (!spi_reset_n)
        byte_cntr <= 10'h1;
    else if (spi_state == SPI_IDLE)
        byte_cntr <= 10'h1;
    else 
        case (spi_state)
        SPI_WR:
            if (tx_byte_done)
            begin
                if (next_spi_state != SPI_WR)
                    byte_cntr <= 10'h1;
                else
                    byte_cntr <= byte_cntr + 10'h1;
            end
        SPI_RD_WAIT:
            if (rx_byte_valid && (next_spi_state == SPI_RD))
                byte_cntr <= byte_cntr + 10'h1;
        SPI_RD:
            if (rx_byte_valid)
                byte_cntr <= byte_cntr + 10'h1;
        endcase
                
sync_reg reg_spi_op_en_sync_reg(.clk(spi_clk), .din(reg_spi_op_en), .dout(reg_spi_op_en_sync));        

reg reg_spi_op_en_sync_d;

always @(posedge spi_clk)
    reg_spi_op_en_sync_d <= reg_spi_op_en_sync;

wire start_op = reg_spi_op_en_sync & ~reg_spi_op_en_sync_d;

always @(posedge spi_clk or negedge spi_reset_n)
    if (!spi_reset_n)
        spi_state <= SPI_IDLE;
    else
        spi_state <= next_spi_state;

always @(*)
begin
    next_spi_state = spi_state;
    case (spi_state)
    SPI_IDLE:
        if (start_op)
        begin
            if (((reg_spi_op_cmd_spi[2:0] == SPI_CMD_WR) || (reg_spi_op_cmd_spi[2:0] == SPI_CMD_WR_RD)) && ({reg_tx_byte_num1_spi[7:0], reg_tx_byte_num0_spi[7:0]} != 0))
                next_spi_state = SPI_WR;
            else if ((reg_spi_op_cmd_spi[2:0] == SPI_CMD_RD) && ({reg_rx_byte_num1_spi[7:0], reg_rx_byte_num0_spi[7:0]} != 0))
                next_spi_state = reg_rd_no_wait_spi ? SPI_RD : SPI_RD_WAIT;
        end
    SPI_WR:
        if (tx_byte_done && ({reg_tx_byte_num1_spi[7:0], reg_tx_byte_num0_spi[7:0]} == byte_cntr))
            if (reg_spi_op_cmd_spi[2:0] == SPI_CMD_WR_RD)
                next_spi_state = SPI_RD_WAIT;
            else
                next_spi_state = SPI_IDLE;
    SPI_RD_WAIT:
        if (rx_byte_valid && (spi_rx_byte[7:0] != 8'hff))
        begin
            if ({reg_rx_byte_num1_spi[7:0], reg_rx_byte_num0_spi[7:0]} != byte_cntr)
                next_spi_state = SPI_RD;
            else
                next_spi_state = SPI_IDLE;
        end
    SPI_RD:
        if (rx_byte_valid)
            if ({reg_rx_byte_num1_spi[7:0], reg_rx_byte_num0_spi[7:0]} == byte_cntr)
                next_spi_state = SPI_IDLE;
    endcase
end

always @(posedge spi_clk or negedge spi_reset_n)
    if (!spi_reset_n)
        spi_buf_addr <= TX_BUF_BASE;
    else if (spi_state == SPI_IDLE)
    begin
        if (next_spi_state == SPI_RD)
            spi_buf_addr <= RX_BUF_BASE;
        else if (next_spi_state == SPI_WR)
            spi_buf_addr <= spi_buf_addr + 11'h1;
        else
            spi_buf_addr <= TX_BUF_BASE;
    end else if (spi_state == SPI_RD_WAIT)
    begin
        if (rx_byte_valid && (spi_rx_byte != 8'hff))
            spi_buf_addr <= spi_buf_addr + 1;
        else
            spi_buf_addr <= RX_BUF_BASE;
    end else if ((spi_state == SPI_WR) && tx_byte_done || (spi_state == SPI_RD) && rx_byte_valid)
        spi_buf_addr <= spi_buf_addr + 11'h1;

always @(posedge spi_clk or negedge spi_reset_n)
    if (!spi_reset_n)
        tx_byte_shift <= 8'hff;
    else if ((spi_state == SPI_IDLE) && (next_spi_state == SPI_WR) || (spi_state == SPI_WR) && tx_byte_done)
        tx_byte_shift <= spi_buf_dout[7:0];
    else if ((spi_state == SPI_WR) && tx_bit_done)
        tx_byte_shift <= {tx_byte_shift[6:0], 1'b1};

wire mosi_hw_out = tx_byte_shift[7];
reg cs_hw_out;
reg clk_hw_out;

always @(posedge spi_clk or negedge spi_reset_n)
    if (!spi_reset_n)
        cs_hw_out <= 1'b1;
    else if ((spi_state == SPI_IDLE) && (next_spi_state != SPI_IDLE))
        cs_hw_out <= reg_cs_start_spi;
    else if ((spi_state != SPI_IDLE) && (next_spi_state == SPI_IDLE) || 
        (spi_state == SPI_IDLE) && start_op && (reg_spi_op_cmd_spi[2:0] == SPI_CMD_SET_CS))
        cs_hw_out <= reg_cs_end_spi;

always @(posedge spi_clk or negedge spi_reset_n)
    if (!spi_reset_n)
        clk_hw_out <= 1'b0;
    else if ((spi_state != SPI_IDLE) && tx_bit_done/*(speed_cntr == speed_cntr_th) && bit_cntr[0]*/)
        clk_hw_out <= 1'b0;
    else if ((spi_state != SPI_IDLE) && rx_bit_latch/*(speed_cntr == speed_cntr_th) && !bit_cntr[0]*/)
        clk_hw_out <= 1'b1;
       
always @(posedge spi_clk or negedge spi_reset_n)
    if (!spi_reset_n)
        rx_byte_shift <= 8'hff;
    else if (((spi_state == SPI_RD_WAIT) || (spi_state == SPI_RD)) && rx_bit_latch)
        rx_byte_shift <= {rx_byte_shift[6:0], spi_miso_in};

always @(*)
    spi_rx_byte = rx_byte_shift;

reg rx_byte_valid_long;

always @(posedge spi_clk or negedge spi_reset_n)
    if (!spi_reset_n)
        rx_byte_valid_long <= 1'b0;
    else if (((spi_state == SPI_RD_WAIT) || (spi_state == SPI_RD)) && rx_byte_latch)
        rx_byte_valid_long <= 1'b1;
    else if (((spi_state == SPI_RD_WAIT) || (spi_state == SPI_RD)) && tx_byte_done)
        rx_byte_valid_long <= 1'b0;
        
always @(*)
    rx_byte_valid = rx_byte_valid_long & tx_byte_done;

assign spi_buf_din = spi_rx_byte;
assign spi_buf_we = rx_byte_valid;

reg spi_op_done_toggle;

always @(posedge spi_clk or negedge spi_reset_n)
    if (!spi_reset_n)
        spi_op_done_toggle <= 1'b0;
    else if ((spi_state != SPI_IDLE) && (next_spi_state == SPI_IDLE))
        spi_op_done_toggle <= ~spi_op_done_toggle;

/// sync operation done to reg_clk domain ///

sync_reg spi_op_done_toggle_sync_reg(.clk(reg_clk), .din(spi_op_done_toggle), .dout(spi_op_done_toggle_sync));

reg spi_op_done_toggle_sync_d;

always @(posedge reg_clk or negedge reg_reset_n)
    if (!reg_reset_n)
        spi_op_done_toggle_sync_d <= 1'b0;
    else
        spi_op_done_toggle_sync_d <= spi_op_done_toggle_sync;

always @(posedge reg_clk or negedge reg_reset_n)
    if (!reg_reset_n)
        reg_spi_op_done <= 1'b1;
    else if (mcus_wr_en & (mcus_addr == `SPI_CTRL) && mcus_wdata[0] && (mcus_wdata[3:1] != SPI_CMD_SET_CS))
        reg_spi_op_done <= 1'b0;
//    ((spi_state == SPI_IDLE) && (next_spi_state != SPI_IDLE))
//        reg_spi_op_done <= 1'b0;
    else if (spi_op_done_toggle_sync ^ spi_op_done_toggle_sync_d)
        reg_spi_op_done <= 1'b1;

/// pin MUX ///

assign spi_cs_out = reg_spi_mode ? cs_hw_out : spi_cs_out_gpio;
assign spi_cs_out_en = reg_spi_mode ? 1'b1 : spi_cs_out_en_gpio;
assign spi_clk_out = reg_spi_mode ? clk_hw_out : spi_clk_out_gpio;
assign spi_clk_out_en = reg_spi_mode ? 1'b1 : spi_clk_out_en_gpio;
assign spi_mosi_out = reg_spi_mode ? mosi_hw_out : spi_mosi_out_gpio;
assign spi_mosi_out_en = reg_spi_mode ? 1'b1 : spi_mosi_out_en_gpio;
assign spi_miso_out = reg_spi_mode ? 1'b0 : spi_miso_out_gpio;
assign spi_miso_out_en = reg_spi_mode ? 1'b0 : spi_miso_out_en_gpio;

endmodule
