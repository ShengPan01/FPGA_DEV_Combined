 /*
 * Copyright (c) 2026. All rights reserved.
 *
 * Unauthorized copying, modification, distribution, or use
 * of this code is strictly prohibited without prior
 * written permission from the copyright owner.
 *
 * Date: 2026-11-11
 */
 
module top #(
    parameter FLASH_BOOT_ENABLE = 1
)(
    input sys_diff_clk_p,
    input sys_diff_clk_n,
    input sys_reset,

// spi master
    inout               spi_cs,
    inout               spi_ck,
    inout               spi_mosi,
    inout               spi_miso,

    input       rst_iic,
    inout       imu_scl,
    inout       imu_sda,

    input       uart_rx,
    output      uart_tx,
    input       uart_cts,
    output      uart_rts,
    //output --led---//
    output wire [3:0]  mode_gpio,
    output wire [7:0]  mio23_led

);

// spi
wire            spi_cs_in;
wire            spi_ck_in;
wire            spi_mosi_in;
wire            spi_miso_in;

//wire            spi_rst_n;

// i2c
wire            imu_sda_out;
wire            imu_sda_out_en;
wire            imu_sda_in;
wire            imu_scl_out;
wire            imu_scl_out_en;
wire            imu_scl_in;
wire            i2c_10us_pulse;

`include "bus_conn.v"

  clk_wiz_1 clk_wiz_inst
  (
  // Clock out ports  
  .clk_out1(osc_clk),
  .clk_out2(spi_clk),
  // Status and control signals               
  .reset(sys_reset), 
  .locked(clk_gen_locked),
 // Clock in ports
  .clk_in1_p(sys_diff_clk_p),
  .clk_in1_n(sys_diff_clk_n)
  );


reset_sync osc_clk_reset_sync (
    .clk(osc_clk),
    .reset_in(clk_gen_locked),
    .reset_out(osc_reset_n)
);

reset_sync spi_clk_reset_sync (
    .clk(spi_clk),
    .reset_in(clk_gen_locked),
    .reset_out(spi_reset_n)
);

wire flash_boot_busy, flash_boot_done, flash_boot_error;
(* mark_debug = "true", keep = "true" *)wire data_rdy_o ;
wire uart_data_err;

wire gpio_0_led;
assign mio23_led = {gpio_0_led, osc_reset_n, clk_gen_locked, uart_data_err, data_rdy_o, flash_boot_busy, flash_boot_error, flash_boot_done};
wire boot_cs_n, boot_sck, boot_mosi;
wire [31:0] boot_wr_addr;
wire [7:0] boot_wr_data;
wire boot_wr_en;

spi_flash_boot #(.ENABLE(FLASH_BOOT_ENABLE)) flash_boot (
    .clk(osc_clk), .reset_n(osc_reset_n), .miso(spi_miso_in),
    .cs_n(boot_cs_n), .sck(boot_sck), .mosi(boot_mosi),
    .busy(flash_boot_busy), .done(flash_boot_done), .error(flash_boot_error),
    .wr_addr(boot_wr_addr), .wr_data(boot_wr_data), .wr_en(boot_wr_en)
);

wire [1:0] mcus_rdata_latency = spi_buf_mcus_sel  ? 2'h1 : 2'h0;

bk3imcpj_wrapper bk3imcpj_wrapper(
    .clk(osc_clk),
    .reset_n(osc_reset_n),
    .boot_busy(flash_boot_busy),
    .boot_done(flash_boot_done),
    .boot_wr_addr(boot_wr_addr),
    .boot_wr_data(boot_wr_data),
    .boot_wr_en(boot_wr_en),

/// uart interface
    .uart_rx_i(uart_rx),
    .uart_tx_o(uart_tx),
    //output uart_sel,
    .uart_data_error(uart_data_err),
    .data_ready_o(data_rdy_o),
    .interrupt(1'b0),
    
/// register interface
    .mcum_rd_en(bk3_mcum_rd_en),   // Read strobe, active high
    .mcum_wr_en(bk3_mcum_wr_en),   // Write strobe, active high
    .mcum_addr(bk3_mcum_addr[15:0]),   // Address
    .mcum_wdata(bk3_mcum_wdata[7:0]),   // Write data
    .mcum_rdata_latency(mcus_rdata_latency),
    .mcum_rdata(bk3_mcum_rdata[7:0]),  // Read data


    .mcum_rd_en_1(),
    .mcum_wr_en_1(),
    .mcum_addr_1(),
    .mcum_wdata_1(),
    .mcum_rdata_latency_1(2'd0),
    .mcum_rdata_1(32'd0),

    .jtag_load(1'b0),  // 1: jtag mode,0: normal mode 
    
    .TCK(1'b0),
    .TMS(1'b0),
    .TDI(1'b0),
    .TDO()
);


assign uart_rts = 1'b0;

// I2C for IMU
time_pulse #(
    .CNT_WIDTH(9),
    .TIME_TH(270)
) time_pulse_10us (
    .clk(osc_clk),
    .reset_n(osc_reset_n),
    .pulse_out(i2c_10us_pulse)
);

IOBUF imu_sda_iobuf(.I(1'b0), .O(imu_sda_in), .T(imu_sda_oen), .IO(imu_sda));
IOBUF imu_scl_iobuf(.I(1'b0), .O(imu_scl_in), .T(imu_scl_oen), .IO(imu_scl));

 pin_debounce pin_debounce(
	.clk       (osc_clk),//CLK 1m
	.rst_n     (osc_reset_n),
	.pin_in    (rst_iic),
	.pin_out   (debug_rst_iic)
);

i2c_master_top i2c_master_top_imu (
    .i2c_clk(osc_clk),
    .reset_n(osc_reset_n & ~debug_rst_iic), 
    .i2c_10us_pulse(i2c_10us_pulse),
    
    .sda_in(imu_sda_in),
    .scl_in(imu_scl_in),
    .sda_out(imu_sda_out),
    .sda_out_en(imu_sda_out_en),
    .scl_out(imu_scl_out),
    .scl_out_en(imu_scl_out_en),

    .reg_clk(osc_clk),
    .reg_reset_n(osc_reset_n),
    .mcus_rd_en(imu_i2c_mcus_rd_en),   // Read strobe, active high
    .mcus_wr_en(imu_i2c_mcus_wr_en),   // Write strobe, active high
    .mcus_addr(imu_i2c_mcus_addr[15:0]),   // Address
    .mcus_wdata(imu_i2c_mcus_wdata[7:0]),   // Write data
    .mcus_rdata(imu_i2c_mcus_rdata[7:0])   // Read data
);
assign imu_sda_oen = ~(imu_sda_out_en & ~imu_sda_out);
assign imu_scl_oen = ~(imu_scl_out_en & ~imu_scl_out);




// Hardware configuration registers, MCU addresses 0x00c0..0x00cf.
hw_cfg_top hw_cfg (
    .reg_clk(osc_clk),
    .reg_reset_n(osc_reset_n),
    .mcus_rd_en(hw_cfg_mcus_rd_en),
    .mcus_wr_en(hw_cfg_mcus_wr_en),
    .mcus_addr(hw_cfg_mcus_addr),
    .mcus_wdata(hw_cfg_mcus_wdata),
    .mcus_rdata(hw_cfg_mcus_rdata),
    .mode_gpio(mode_gpio[3:0]),
    .gpio_0(gpio_0_led)
);

// SHA-256 accelerator, MCU addresses 0x00d0..0x00df.
sha256_accel lms_sha256 (
    .clk(osc_clk),
    .reset_n(osc_reset_n),
    .rd_en(sha256_mcus_rd_en),
    .wr_en(sha256_mcus_wr_en),
    .addr(sha256_mcus_addr[3:0]),
    .wdata(sha256_mcus_wdata),
    .rdata(sha256_mcus_rdata)
);

// SPI module
spi spi(
    .reg_clk(osc_clk),
    .reg_reset_n(osc_reset_n),
    .mcus_rd_en(spi_mcus_rd_en),   // Read strobe, active high
    .mcus_wr_en(spi_mcus_wr_en),   // Write strobe, active high
    .mcus_addr(spi_mcus_addr),   // Address
    .mcus_wdata(spi_mcus_wdata),   // Write data
    .mcus_rdata(spi_mcus_rdata),   // Read data
    
    .spi_clk(spi_clk),
    .spi_reset_n(spi_reset_n),

    .spi_cs_in(spi_cs_in),
    .spi_cs_out(spi_cs_out),
    .spi_cs_out_en(spi_cs_out_en),

    .spi_clk_in(spi_ck_in),
    .spi_clk_out(spi_ck_out),
    .spi_clk_out_en(spi_ck_out_en),

    .spi_mosi_in(spi_mosi_in),
    .spi_mosi_out(spi_mosi_out),
    .spi_mosi_out_en(spi_mosi_out_en),

    .spi_miso_in(spi_miso_in),
    .spi_miso_out(spi_miso_out),
    .spi_miso_out_en(spi_miso_out_en),
    
    .sram_clk(osc_clk),
    .sram_addr(spi_buf_mcus_addr[10:0]),
    .sram_data_in(spi_buf_mcus_wdata[7:0]),
    .sram_we(spi_buf_mcus_wr_en),
    .sram_data_out(spi_buf_mcus_rdata[7:0])
);
IOBUF spi_cs_io(.IO(spi_cs), .O(spi_cs_in), .T(flash_boot_busy ? 1'b0 : ~spi_cs_out_en), .I(flash_boot_busy ? boot_cs_n : spi_cs_out));
IOBUF spi_ck_io(.IO(spi_ck), .O(spi_ck_in), .T(flash_boot_busy ? 1'b0 : ~spi_ck_out_en), .I(flash_boot_busy ? boot_sck : spi_ck_out));
IOBUF spi_mosi_io(.IO(spi_mosi), .O(spi_mosi_in), .T(flash_boot_busy ? 1'b0 : ~spi_mosi_out_en), .I(flash_boot_busy ? boot_mosi : spi_mosi_out));
IOBUF spi_miso_io(.IO(spi_miso), .O(spi_miso_in), .T(flash_boot_busy ? 1'b1 : ~spi_miso_out_en), .I(spi_miso_out));


endmodule
