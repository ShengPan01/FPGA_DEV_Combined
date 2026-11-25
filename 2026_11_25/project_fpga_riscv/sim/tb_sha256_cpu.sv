// Exercise the production CPU wrapper and SHA-256 bus0 address decoder.
module tb_sha256_cpu (
    input clk, reset_n, boot_busy, boot_done, boot_wr_en,
    input [31:0] boot_wr_addr,
    input [7:0] boot_wr_data,
    input suppress_done,
    output sha_poll, sha_start,
    output wr,
    output [23:0] addr,
    output [31:0] wdata
);
    `include "bus_conn.v"

    wire [7:0] sha_rdata;
    wire sha_control = sha256_mcus_addr[3:0] == 4'h4;
    assign sha_poll = sha256_mcus_rd_en && sha_control;
    assign sha_start = sha256_mcus_wr_en && sha_control && sha256_mcus_wdata[0];
    assign sha256_mcus_rdata = suppress_done && sha_poll ? 8'd1 : sha_rdata;
    assign hw_cfg_mcus_rdata = 8'b0;
    assign spi_mcus_rdata = 8'b0;
    assign spi_buf_mcus_rdata = 8'b0;
    assign imu_i2c_mcus_rdata = 8'b0;

    bk3imcpj_wrapper cpu (
        .clk(clk), .reset_n(reset_n), .boot_busy(boot_busy), .boot_done(boot_done),
        .boot_wr_addr(boot_wr_addr), .boot_wr_data(boot_wr_data), .boot_wr_en(boot_wr_en),
        .uart_rx_i(1'b1), .uart_tx_o(), .uart_data_error(), .data_ready_o(),
        .interrupt(1'b0), .mcum_rd_en(bk3_mcum_rd_en), .mcum_wr_en(bk3_mcum_wr_en),
        .mcum_addr(bk3_mcum_addr), .mcum_wdata(bk3_mcum_wdata),
        .mcum_rdata_latency(2'b0), .mcum_rdata(bk3_mcum_rdata),
        .mcum_rd_en_1(), .mcum_wr_en_1(wr), .mcum_addr_1(addr), .mcum_wdata_1(wdata),
        .mcum_rdata_latency_1(2'b0), .mcum_rdata_1(32'b0),
        .jtag_load(1'b0), .TCK(1'b0), .TMS(1'b0), .TDI(1'b0), .TDO()
    );
    sha256_accel sha (
        .clk(clk), .reset_n(reset_n), .rd_en(sha256_mcus_rd_en),
        .wr_en(sha256_mcus_wr_en), .addr(sha256_mcus_addr[3:0]),
        .wdata(sha256_mcus_wdata), .rdata(sha_rdata)
    );
endmodule

// Inferred simulation model for the Vivado single-port BRAM IP.
module s_32kx32(input clka, ena, input [3:0] wea, input [14:0] addra,
                input [31:0] dina, output reg [31:0] douta);
    reg [31:0] mem [0:32767];
    always @(posedge clka) if (ena) begin
        douta <= mem[addra];
        for (integer i = 0; i < 4; i = i + 1)
            if (wea[i]) mem[addra][8*i+:8] <= dina[8*i+:8];
    end
endmodule
