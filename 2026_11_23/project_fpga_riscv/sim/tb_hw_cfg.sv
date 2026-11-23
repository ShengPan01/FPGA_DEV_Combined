module tb_hw_cfg(input clk, input reset_n, input rd, input wr, input [15:0] addr, input [7:0] wdata, output [7:0] rdata);
`include "bus_conn.v"
assign bk3_mcum_rd_en = rd;
assign bk3_mcum_wr_en = wr;
assign bk3_mcum_addr = addr;
assign bk3_mcum_wdata = wdata;
assign spi_mcus_rdata = 8'h55;
assign imu_i2c_mcus_rdata = 8'h77;
assign spi_buf_mcus_rdata = 8'h88;
hw_cfg_top dut (
    .reg_clk(clk), .reg_reset_n(reset_n),
    .mcus_rd_en(hw_cfg_mcus_rd_en), .mcus_wr_en(hw_cfg_mcus_wr_en),
    .mcus_addr(hw_cfg_mcus_addr), .mcus_wdata(hw_cfg_mcus_wdata),
    .mcus_rdata(hw_cfg_mcus_rdata)
);
assign rdata = bk3_mcum_rdata;
endmodule
