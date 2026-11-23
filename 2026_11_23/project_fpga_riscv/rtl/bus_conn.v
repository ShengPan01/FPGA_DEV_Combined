 /*
 * Copyright (c) 2026. All rights reserved.
 *
 * Unauthorized copying, modification, distribution, or use
 * of this code is strictly prohibited without prior
 * written permission from the copyright owner.
 *
 * Date: 2026-11-11
 */
 


/*
module          start   end
----------------------------
uart            0000    000f    // reserved for BK3IMPJ UART used
axi_brdg        0010    001f
img_gen         0020    002f
video_crop      0030    003f
clk_measure     0040    004f
spi             0050    005f
video_expnd     0060    006f
imu_i2c         0070    007f
vbist           0080    009f
vid_merge       00a0    00bf
hw_cfg          00c0    00cf // C0: RO {major[3:0], minor[3:0]}; C1-CF: RW, reset 0
spi_buf         0800    0fff

dp_phy          0100    017f
dptx0           0200    02ff
dptx1           0300    03ff
dptx2           0400    04ff

vr_proc         1000    1fff

*/

//(*mark_debug="true"*)wire        bk3_mcum_rd_en;

wire        bk3_mcum_rd_en;
wire        bk3_mcum_wr_en;
wire [15:0] bk3_mcum_addr;
wire [7:0] bk3_mcum_wdata;
wire [7:0] bk3_mcum_rdata;

wire        spi_mcus_rd_en;
wire        spi_mcus_wr_en;
wire [15:0] spi_mcus_addr;
wire [7:0] spi_mcus_wdata;
wire [7:0] spi_mcus_rdata;

wire        spi_buf_mcus_rd_en;
wire        spi_buf_mcus_wr_en;
wire [15:0] spi_buf_mcus_addr;
wire [7:0] spi_buf_mcus_wdata;
wire [7:0] spi_buf_mcus_rdata;

wire        imu_i2c_mcus_rd_en;
wire        imu_i2c_mcus_wr_en;
wire [15:0] imu_i2c_mcus_addr;
wire [7:0] imu_i2c_mcus_wdata;
wire [7:0] imu_i2c_mcus_rdata;

wire        hw_cfg_mcus_rd_en;
wire        hw_cfg_mcus_wr_en;
wire [15:0] hw_cfg_mcus_addr;
wire [7:0] hw_cfg_mcus_wdata;
wire [7:0] hw_cfg_mcus_rdata;



reg [7:0] bk3_mcum_rdata_1;
reg imu_i2c_mcus_sel;
reg spi_mcus_sel;
reg spi_buf_mcus_sel;
reg hw_cfg_mcus_sel;

//for h/w configure
assign hw_cfg_mcus_wr_en = hw_cfg_mcus_sel & bk3_mcum_wr_en;
assign hw_cfg_mcus_rd_en = hw_cfg_mcus_sel & bk3_mcum_rd_en;
assign hw_cfg_mcus_addr = 'hf & bk3_mcum_addr;
assign hw_cfg_mcus_wdata = bk3_mcum_wdata;

assign imu_i2c_mcus_wr_en = imu_i2c_mcus_sel & bk3_mcum_wr_en;
assign imu_i2c_mcus_rd_en = imu_i2c_mcus_sel & bk3_mcum_rd_en;
assign imu_i2c_mcus_addr = 'hf & bk3_mcum_addr;
assign imu_i2c_mcus_wdata = bk3_mcum_wdata;

assign spi_mcus_wr_en = spi_mcus_sel & bk3_mcum_wr_en;
assign spi_mcus_rd_en = spi_mcus_sel & bk3_mcum_rd_en;
assign spi_mcus_addr = 'hf & bk3_mcum_addr;
assign spi_mcus_wdata = bk3_mcum_wdata;

assign spi_buf_mcus_wr_en = spi_buf_mcus_sel & bk3_mcum_wr_en;
assign spi_buf_mcus_rd_en = spi_buf_mcus_sel & bk3_mcum_rd_en;
assign spi_buf_mcus_addr = 'h7ff & bk3_mcum_addr;
assign spi_buf_mcus_wdata = bk3_mcum_wdata;

assign bk3_mcum_rdata = bk3_mcum_rdata_1;

always @(*)
begin
    imu_i2c_mcus_sel = 1'b0;
    spi_mcus_sel = 1'b0;
    spi_buf_mcus_sel = 1'b0;
    hw_cfg_mcus_sel = 1'b0;

    casez (bk3_mcum_addr)
    16'h00c?: begin bk3_mcum_rdata_1 = hw_cfg_mcus_rdata; hw_cfg_mcus_sel = 1'b1; end
    16'h005?: begin bk3_mcum_rdata_1 = spi_mcus_rdata; spi_mcus_sel = 1'b1; end
    16'h007?: begin bk3_mcum_rdata_1 = imu_i2c_mcus_rdata; imu_i2c_mcus_sel = 1'b1; end
    16'b0000_1???_????_????: begin bk3_mcum_rdata_1 = spi_buf_mcus_rdata; spi_buf_mcus_sel = 1'b1; end
    default: bk3_mcum_rdata_1 = 8'h0;
    endcase
end


/*{ source_processed }*/

