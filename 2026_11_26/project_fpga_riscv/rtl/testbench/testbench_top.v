`timescale 1ns/1ps

module testbench_top;
	localparam [15:0] SPI_SET = 16'h0002;
	localparam [15:0] SPI_CTRL = 16'h0003;
	localparam [15:0] TX_BYTE_NUM0 = 16'h0004;
	localparam [15:0] RX_BYTE_NUM0 = 16'h0006;
	localparam [10:0] TX_BUF_BASE = 11'h000;
	localparam [10:0] RX_BUF_BASE = 11'h280;
	localparam [2:0] SPI_CMD_WR = 3'h1;
	localparam [2:0] SPI_CMD_RD = 3'h2;

	reg clk = 1'b0;
	reg reset_n = 1'b0;
	reg mcus_rd_en = 1'b0;
	reg mcus_wr_en = 1'b0;
	reg [15:0] mcus_addr = 16'h0000;
	reg [7:0] mcus_wdata = 8'h00;
	wire [7:0] mcus_rdata;
	reg [10:0] sram_addr = 11'h000;
	reg [7:0] sram_data_in = 8'h00;
	reg sram_we = 1'b0;
	wire [7:0] sram_data_out;
	wire spi_cs_out;
	wire spi_cs_out_en;
	wire spi_clk_out;
	wire spi_clk_out_en;
	wire spi_mosi_out;
	wire spi_mosi_out_en;
	wire spi_miso_out;
	wire spi_miso_out_en;
	wire spi_cs_in;
	wire spi_clk_in;
	wire spi_mosi_in;
	wire spi_miso_in;
	wire device_miso;
	integer errors = 0;
	reg [7:0] status;
	reg [7:0] received;
	integer i;

	always #5 clk = ~clk;

	assign spi_cs_in = spi_cs_out_en ? spi_cs_out : 1'b1;
	assign spi_clk_in = spi_clk_out_en ? spi_clk_out : 1'b0;
	assign spi_mosi_in = spi_mosi_out_en ? spi_mosi_out : 1'b1;
	assign spi_miso_in = device_miso;

	spi dut (
		.reg_clk(clk),
		.reg_reset_n(reset_n),
		.mcus_rd_en(mcus_rd_en),
		.mcus_wr_en(mcus_wr_en),
		.mcus_addr(mcus_addr),
		.mcus_wdata(mcus_wdata),
		.mcus_rdata(mcus_rdata),
		.spi_clk(clk),
		.spi_reset_n(reset_n),
		.spi_cs_in(spi_cs_in),
		.spi_cs_out(spi_cs_out),
		.spi_cs_out_en(spi_cs_out_en),
		.spi_clk_in(spi_clk_in),
		.spi_clk_out(spi_clk_out),
		.spi_clk_out_en(spi_clk_out_en),
		.spi_mosi_in(spi_mosi_in),
		.spi_mosi_out(spi_mosi_out),
		.spi_mosi_out_en(spi_mosi_out_en),
		.spi_miso_in(spi_miso_in),
		.spi_miso_out(spi_miso_out),
		.spi_miso_out_en(spi_miso_out_en),
		.sram_clk(clk),
		.sram_addr(sram_addr),
		.sram_data_in(sram_data_in),
		.sram_we(sram_we),
		.sram_data_out(sram_data_out)
	);

	spi_device device (
		.cs_n(spi_cs_in),
		.sclk(spi_clk_in),
		.mosi(spi_mosi_in),
		.miso(device_miso)
	);

	task write_register;
		input [15:0] address;
		input [7:0] value;
		begin
			@(negedge clk);
			mcus_addr = address;
			mcus_wdata = value;
			mcus_wr_en = 1'b1;
			@(negedge clk);
			mcus_wr_en = 1'b0;
		end
	endtask

	task read_register;
		input [15:0] address;
		output [7:0] value;
		begin
			@(negedge clk);
			mcus_addr = address;
			mcus_rd_en = 1'b1;
			#1 value = mcus_rdata;
			@(negedge clk);
			mcus_rd_en = 1'b0;
		end
	endtask

	task write_buffer;
		input [10:0] address;
		input [7:0] value;
		begin
			@(negedge clk);
			sram_addr = address;
			sram_data_in = value;
			sram_we = 1'b1;
			@(negedge clk);
			sram_we = 1'b0;
		end
	endtask

	task read_buffer;
		input [10:0] address;
		output [7:0] value;
		begin
			@(negedge clk);
			sram_addr = address;
			@(posedge clk);
			#1 value = sram_data_out;
		end
	endtask

	task start_operation;
		input [2:0] command;
		input [7:0] tx_count;
		input [7:0] rx_count;
		integer timeout;
		begin
			write_register(TX_BYTE_NUM0, tx_count);
			write_register(RX_BYTE_NUM0, rx_count);
			write_register(SPI_CTRL, {2'b00, 1'b1, 1'b0, command, 1'b0});
			write_register(SPI_CTRL, {2'b00, 1'b1, 1'b0, command, 1'b1});
			timeout = 0;
			status = 8'h00;
			while ((status[7] !== 1'b1) && (timeout < 2000)) begin
				read_register(SPI_CTRL, status);
			timeout = timeout + 1;
			end
			if (status[7] !== 1'b1) begin
				$display("ERROR: SPI command %0d timed out, status=%02h", command, status);
				errors = errors + 1;
			end
			write_register(SPI_CTRL, {2'b00, 1'b1, 1'b0, command, 1'b0});
			repeat (4) @(negedge clk);
		end
	endtask

	task check_read;
		input [7:0] address;
		input [7:0] expected;
		begin
			write_buffer(TX_BUF_BASE, 8'h03);
			write_buffer(TX_BUF_BASE + 11'h1, address);
			start_operation(SPI_CMD_WR, 8'd2, 8'd0);
			start_operation(SPI_CMD_RD, 8'd0, 8'd3);
			read_buffer(RX_BUF_BASE + 11'h1, received);
			if (received !== expected) begin
				$display("ERROR: address=%02h expected=%02h actual=%02h", address, expected, received);
				errors = errors + 1;
			end else begin
				$display("PASS: address=%02h data=%02h", address, received);
			end
		end
	endtask

	initial begin
		$dumpfile("testbench_top.vcd");
		$dumpvars(0, testbench_top);
		repeat (5) @(negedge clk);
		reset_n = 1'b1;
		repeat (20) @(negedge clk);
		write_register(SPI_SET, 8'h01);
		write_register(SPI_CTRL, 8'h20);

		write_buffer(TX_BUF_BASE, 8'h02);
		write_buffer(TX_BUF_BASE + 11'h1, 8'h10);
		write_buffer(TX_BUF_BASE + 11'h2, 8'hA5);
		start_operation(SPI_CMD_WR, 8'd3, 8'd0);
		check_read(8'h10, 8'hA5);

		write_buffer(TX_BUF_BASE, 8'h02);
		write_buffer(TX_BUF_BASE + 11'h1, 8'h20);
		write_buffer(TX_BUF_BASE + 11'h2, 8'h5A);
		start_operation(SPI_CMD_WR, 8'd3, 8'd0);
		check_read(8'h20, 8'h5A);
		check_read(8'h10, 8'hA5);

		if (errors != 0)
			$fatal(1, "SPI tests failed: %0d errors", errors);
		$display("PASS: SPI device write/read tests completed");
		$finish;
	end

	initial begin
		#10000000;
		$fatal(1, "SPI simulation timeout");
	end
endmodule

module spi_device(
	input cs_n,
	input sclk,
	input mosi,
	output reg miso
);
	reg [7:0] memory [0:255];
	reg [7:0] command;
	reg [7:0] address;
	reg [7:0] shift_in;
	reg [2:0] bit_count;
	reg [1:0] phase;
	reg read_pending;
	reg read_active;
	integer byte_index;
	integer i;

	initial begin
		command = 8'h00;
		address = 8'h00;
		shift_in = 8'h00;
		bit_count = 3'h0;
		phase = 2'h0;
		read_pending = 1'b0;
		read_active = 1'b0;
		byte_index = 0;
		miso = 1'b0;
		for (i = 0; i < 256; i = i + 1)
			memory[i] = 8'h00;
	end

	// Mode 0: capture MOSI on rising edges and prepare MISO on falling edges.
	always @(negedge cs_n) begin
		bit_count = 3'h0;
		phase = 2'h0;
		shift_in = 8'h00;
		byte_index = 0;
		read_active = read_pending;
		if (read_pending)
			read_pending = 1'b0;
		miso = 1'b0;
	end

	always @(posedge cs_n)
		read_active = 1'b0;

	always @(posedge sclk) begin
		if (!cs_n) begin
			shift_in = {shift_in[6:0], mosi};
			if (bit_count == 3'd7) begin
				bit_count = 3'h0;
				if (!read_active) begin
					case (phase)
						2'd0: begin
							command = shift_in;
							phase = 2'd1;
						end
						2'd1: begin
							address = shift_in;
							read_pending = (command == 8'h03);
							phase = 2'd2;
						end
						2'd2: begin
							if (command == 8'h02)
								memory[address] = shift_in;
							phase = 2'd3;
						end
						default: phase = 2'd3;
					endcase
				end
				byte_index = byte_index + 1;
			end else begin
				bit_count = bit_count + 1'b1;
			end
		end
	end

	always @(negedge sclk) begin
		if (cs_n || !read_active)
			miso = 1'b0;
		else if (byte_index == 0)
			miso = 1'b1;
		else if (byte_index == 1)
			miso = 1'b0;
		else if (byte_index == 2)
			miso = memory[address][7 - bit_count];
		else
			miso = 1'b1;
	end
endmodule
