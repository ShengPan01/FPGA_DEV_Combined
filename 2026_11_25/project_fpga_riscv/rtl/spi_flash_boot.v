 /*
 * Copyright (c) 2026. All rights reserved.
 *
 * Unauthorized copying, modification, distribution, or use
 * of this code is strictly prohibited without prior
 * written permission from the copyright owner.
 * Author: Sheng Pan
 * Date: 2026-11-11
 * Revision history
 * 2026/11/13: change DRAM load address from 0x20_0000 to 0x2_1000
 */

// Power-on SPI NOR loader. Mode 0, MSB first, standard 03h/24-bit READ.
// The uploader stores raw bytes, so copy both complete 128 KiB RAM windows.
module spi_flash_boot #(
    parameter integer ENABLE = 1,
    parameter integer CLK_HZ = 27000000,
    parameter integer SCK_DIV = 4, // SCK = CLK_HZ / (2*SCK_DIV)
    parameter integer STARTUP_CYCLES = CLK_HZ / 100, // 10 ms after PLL lock
    parameter integer REGION_BYTES = 131072
) (
    input wire clk,
    input wire reset_n,
    input wire miso,
    output reg cs_n,
    output reg sck,
    output reg mosi,
    output reg busy,
    output reg done,
    output reg error,
    output reg [31:0] wr_addr,
    output reg [7:0] wr_data,
    output reg wr_en
);
    localparam WAIT_POWER=0, BEGIN_READ=1, COMMAND=2, DATA=3,
               END_READ=4, FINISH=5, IDLE=6;
    reg [2:0] state;
    reg region;
    reg [31:0] wait_count;
    reg [31:0] div_count;
    reg [31:0] byte_count;
    reg [31:0] command_shift;
    reg [5:0] command_bit;
    reg [2:0] data_bit;
    reg [7:0] rx_shift;
    reg [31:0] reset_word;

    always @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            state <= (ENABLE != 0) ? WAIT_POWER : IDLE;
            busy <= ENABLE != 0;
            done <= 0;
            error <= 0;
            cs_n <= 1;
            sck <= 0;
            mosi <= 0;
            wr_en <= 0;
            wr_addr <= 0;
            wr_data <= 0;
            region <= 0;
            wait_count <= 0;
            div_count <= 0;
            byte_count <= 0;
            command_shift <= 0;
            command_bit <= 0;
            data_bit <= 0;
            rx_shift <= 0;
            reset_word <= 0;
        end else begin
            wr_en <= 0;
            case (state)
                WAIT_POWER: begin
                    if (wait_count >= STARTUP_CYCLES-1) begin
                        wait_count <= 0;
                        state <= BEGIN_READ;
                    end else wait_count <= wait_count + 1;
                end
                BEGIN_READ: begin
                    cs_n <= 0;
                    sck <= 0;
                    command_shift <= region ? 32'h03021000 : 32'h03001000;
                    mosi <= 0; // bit 31 of both commands
                    command_bit <= 31;
                    byte_count <= 0;
                    data_bit <= 7;
                    div_count <= 0;
                    state <= COMMAND;
                end
                COMMAND, DATA: begin
                    if (div_count == SCK_DIV-1) begin
                        div_count <= 0;
                        sck <= ~sck;
                        if (!sck) begin // rising edge: Flash samples MOSI, host samples MISO
                            if (state == DATA) begin
                                rx_shift <= {rx_shift[6:0], miso};
                                if (data_bit == 0) begin
                                    wr_data <= {rx_shift[6:0], miso};
                                    wr_addr <= (region ? 32'h7ff80000 : 32'h1000) + byte_count;
                                    wr_en <= 1;
                                    if (!region && byte_count < 4)
                                        reset_word <= {reset_word[23:0], rx_shift[6:0], miso};
                                end
                            end
                        end else begin // falling edge: advance to the next bit
                            if (state == COMMAND) begin
                                if (command_bit == 0) begin
                                    state <= DATA;
                                    mosi <= 0;
                                end else begin
                                    command_shift <= {command_shift[30:0], 1'b0};
                                    mosi <= command_shift[30];
                                    command_bit <= command_bit - 1'b1;
                                end
                            end else if (data_bit == 0) begin
                                data_bit <= 7;
                                if (byte_count == REGION_BYTES-1)
                                    state <= END_READ;
                                else byte_count <= byte_count + 1;
                            end else data_bit <= data_bit - 1'b1;
                        end
                    end else div_count <= div_count + 1;
                end
                END_READ: begin
                    cs_n <= 1;
                    sck <= 0;
                    // Keep CS high for at least a full SPI clock between reads.
                    if (wait_count == 2*SCK_DIV-1) begin
                        wait_count <= 0;
                        if (!region && (reset_word == 32'hffffffff || reset_word == 0)) begin
                            error <= 1;
                            busy <= 0;
                            state <= IDLE; // leave UART recovery available
                        end else if (!region) begin
                            region <= 1;
                            state <= BEGIN_READ;
                        end else state <= FINISH;
                    end else wait_count <= wait_count + 1;
                end
                FINISH: begin // all BRAM writes have committed before CPU release
                    busy <= 0;
                    done <= 1;
                    state <= IDLE;
                end
                default: begin end
            endcase
        end
    end
endmodule
