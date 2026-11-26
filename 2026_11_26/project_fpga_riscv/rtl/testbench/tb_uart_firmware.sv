`timescale 1ns/1ps
// Pin-level UART download and firmware console integration test.
module tb_uart_firmware;
    reg sys_clk = 0, sys_reset = 1, uart_rx = 1;
    always #1.666667 sys_clk = ~sys_clk;
    tri1 spi_cs, spi_mosi, imu_scl, imu_sda;
    tri0 spi_ck, spi_miso;
    wire uart_tx, uart_rts;
    top #(.FLASH_BOOT_ENABLE(0)) dut (
        .sys_diff_clk_p(sys_clk), .sys_diff_clk_n(~sys_clk),
        .sys_reset(sys_reset), .spi_cs(spi_cs), .spi_ck(spi_ck),
        .spi_mosi(spi_mosi), .spi_miso(spi_miso), .rst_iic(1'b0),
        .imu_scl(imu_scl), .imu_sda(imu_sda), .uart_rx(uart_rx),
        .uart_tx(uart_tx), .uart_cts(1'b0), .uart_rts(uart_rts)
    );
    localparam real HOST_BIT_NS = 1.0e9 / 115200;
    // RTL divider counts from zero through clk_freq/baud inclusive.
    localparam real DUT_BIT_NS = 235.0 * 1.0e9 / 27000000;
    integer fd, log_fd, ch, i, ack_before, lines = 0, chars = 0;
    integer acks = 0, writes = 0, fetches = 0;
    integer timeout_ms = 40000;
    reg downloaded = 0;
    reg completion_ack_seen = 0;
    reg [71:0] tail_text = 0;
    reg [7:0] received;
    string firmware = "test.ihex";
    string console_log = "uart_console.log";

    task automatic send_byte(input [7:0] value);
        uart_rx = 0;
        #(HOST_BIT_NS);
        for (integer bit_no = 0; bit_no < 8; bit_no = bit_no + 1) begin
            uart_rx = value[bit_no];
            #(HOST_BIT_NS);
        end
        uart_rx = 1;
        #(HOST_BIT_NS);
    endtask

    initial begin
        if ($value$plusargs("TIMEOUT_MS=%d", timeout_ms)) begin end
        if (timeout_ms <= 0) $fatal(1, "TIMEOUT_MS must be positive");
        #(timeout_ms * 1000000.0);
        $fatal(1, "Timeout: lines=%0d chars=%0d writes=%0d acks=%0d ready=%b fetches=%0d",
            lines, chars, writes, acks, downloaded, fetches);
    end

    initial begin
        if ($value$plusargs("FW_IHEX=%s", firmware)) begin end
        if ($value$plusargs("UART_LOG=%s", console_log)) begin end
        fd = $fopen(firmware, "r");
        if (!fd) $fatal(1, "Cannot open %s", firmware);
        log_fd = $fopen(console_log, "w");
        if (!log_fd) $fatal(1, "Cannot open UART log %s", console_log);
        // Match the existing firmware bench's deterministic predictor startup.
        // Download, memory writes and CPU release all use the actual RTL path.
        for (i = 0; i < 16; i = i + 1)
            dut.bk3imcpj_wrapper.codix_berkelium_top_ca.codix_berkelium.predictor_mem.storage.subblock0.RAM[i] = 54'b0;
        #200 sys_reset = 0;
        wait (dut.osc_reset_n === 1'b1);
        repeat (100) @(negedge dut.osc_clk);
        $display("Downloading %s over UART 115200 8N1", firmware);
        ack_before = acks;
        ch = $fgetc(fd);
        while (ch != -1) begin
            send_byte(ch[7:0]);
            chars = chars + 1;
            if (ch == 10) begin
                lines = lines + 1;
                // Every LF produces one '.'; do not overrun the loader TX.
                wait (acks > ack_before);
                ack_before = acks;
                if ((lines % 256) == 0) $display("\nDownload: %0d lines, %0d RAM bytes", lines, writes);
            end
            ch = $fgetc(fd);
        end
        $fclose(fd);
        if (chars == 0 || lines == 0) $fatal(1, "Empty IHEX or missing final LF");
        wait (downloaded);
        $display("\nDownload complete: %0d lines, %0d bytes; waiting for firmware console", lines, writes);
    end

    // Decode the physical TX pin, including loader acknowledgements.
    initial begin
        wait (dut.osc_reset_n === 1'b1);
        forever begin
            @(negedge uart_tx);
            #(DUT_BIT_NS / 2.0);
            if (uart_tx !== 1'b0) $fatal(1, "UART false start");
            for (integer bit_no = 0; bit_no < 8; bit_no = bit_no + 1) begin
                #(DUT_BIT_NS);
                received[bit_no] = uart_tx;
            end
            #(DUT_BIT_NS);
            if (uart_tx !== 1'b1) $fatal(1, "UART framing error");
            $write("%c", received);
            $fwrite(log_fd, "%c", received);
            $fflush(log_fd);
            if (!downloaded) begin
                if (received !== 8'h2e) $fatal(1, "Unexpected loader acknowledgement %h", received);
                acks = acks + 1;
            end else if (!completion_ack_seen) begin
                if (received !== 8'h21)
                    $fatal(1, "Expected download completion acknowledgement '!', received %h", received);
                completion_ack_seen = 1;
            end else begin
                tail_text = {tail_text[63:0], received};
                if (tail_text == "Init done" && fetches > 0) begin
                    $display("\nPASS: UART-downloaded firmware printed Init done (%0d fetches)", fetches);
                    $fclose(log_fd);
                    $finish;
                end
            end
        end
    end

    always @(posedge dut.osc_clk) if (dut.osc_reset_n) begin
        if (dut.uart_data_err) $fatal(1, "IHEX parser error at line %0d", lines + 1);
        if (dut.bk3imcpj_wrapper.ram_wr_en) writes = writes + 1;
        if (dut.bk3imcpj_wrapper.bk3_core_reset_n &&
            !dut.bk3imcpj_wrapper.uart_download_ack_done)
            $fatal(1, "CPU reset released before completion acknowledgement finished");
        // EOF sets data_ready before its final '.' has finished transmitting.
        // Switch console phase only after that acknowledgement is decoded.
        if (dut.data_rdy_o && acks == lines && lines > 0) downloaded = 1;
        if (dut.bk3imcpj_wrapper.bk3_core_reset_n &&
            dut.bk3imcpj_wrapper.i_axi.arvalid && dut.bk3imcpj_wrapper.i_axi.arready) begin
            if (fetches == 0 && dut.bk3imcpj_wrapper.i_axi.araddr !== 32'h1000)
                $fatal(1, "Unexpected reset fetch address");
            fetches = fetches + 1;
        end
    end
endmodule
