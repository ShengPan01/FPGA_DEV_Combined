`timescale 1ns/1ps
// Full FPGA behavioral simulation. All force statements are testbench-only.
module tb_firmware;
    reg sys_clk = 0;
    reg sys_reset = 1;
    always #1.666667 sys_clk = ~sys_clk; // 300 MHz differential input
    tri1 spi_cs, spi_mosi, imu_scl, imu_sda;
    tri0 spi_ck, spi_miso;
    wire uart_tx, uart_rts;
    top #(.FLASH_BOOT_ENABLE(0)) dut (
        .sys_diff_clk_p(sys_clk), .sys_diff_clk_n(~sys_clk),
        .sys_reset(sys_reset), .spi_cs(spi_cs), .spi_ck(spi_ck),
        .spi_mosi(spi_mosi), .spi_miso(spi_miso), .rst_iic(1'b0),
        .imu_scl(imu_scl), .imu_sda(imu_sda), .uart_rx(1'b1),
        .uart_tx(uart_tx), .uart_cts(1'b0), .uart_rts(uart_rts)
    );
    reg [31:0] load_addr = 0;
    reg [7:0] load_data = 0;
    reg load_we = 0;
    reg started = 0;
    integer fd, status, count = 0;
    integer predictor_index;
    integer fetches = 0;
    integer timeout_ms = 100;
    reg [71:0] uart_tail = 0; // "Init done"

    initial begin
        if ($value$plusargs("TIMEOUT_MS=%d", timeout_ms)) begin end
        if (timeout_ms <= 0) $fatal(1, "TIMEOUT_MS must be positive");
        #(timeout_ms * 1000000.0);
        $fatal(1, "Firmware timeout: loaded=%0d fetches=%0d", count, fetches);
    end

    initial begin : load_firmware
        string firmware = "firmware.mem";
        if ($value$plusargs("FW_MEM=%s", firmware)) begin end
        for (predictor_index = 0; predictor_index < 16; predictor_index = predictor_index + 1)
            dut.bk3imcpj_wrapper.codix_berkelium_top_ca.codix_berkelium.predictor_mem.storage.subblock0.RAM[predictor_index] = 54'b0;
        force dut.bk3imcpj_wrapper.uart_top.data_ready_o = 1'b0;
        force dut.bk3imcpj_wrapper.ram_wr_addr_h = load_addr[31:16];
        force dut.bk3imcpj_wrapper.ram_wr_addr = load_addr[15:0];
        force dut.bk3imcpj_wrapper.ram_wr_data = load_data;
        force dut.bk3imcpj_wrapper.ram_wr_en = load_we;
        #200 sys_reset = 0;
        wait (dut.osc_reset_n === 1'b1);
        fd = $fopen(firmware, "r");
        if (!fd) $fatal(1, "Cannot open %s; run ihex_to_mem.py first", firmware);
        status = $fscanf(fd, "%h %h", load_addr, load_data);
        while (status == 2) begin
            if (!((load_addr >= 32'h1000 && load_addr <= 32'h20fff) ||
                  (load_addr >= 32'h7ff80000 && load_addr <= 32'h7ff9ffff)))
                $fatal(1, "Firmware address outside RAM: %h", load_addr);
            @(negedge dut.osc_clk);
            load_we = 1;
            @(negedge dut.osc_clk);
            load_we = 0;
            count = count + 1;
            status = $fscanf(fd, "%h %h", load_addr, load_data);
        end
        if (!$feof(fd) || status == 1 || count == 0)
            $fatal(1, "Empty or malformed firmware file");
        $fclose(fd);
        repeat (2) @(negedge dut.osc_clk);
        release dut.bk3imcpj_wrapper.ram_wr_addr_h;
        release dut.bk3imcpj_wrapper.ram_wr_addr;
        release dut.bk3imcpj_wrapper.ram_wr_data;
        release dut.bk3imcpj_wrapper.ram_wr_en;
        force dut.bk3imcpj_wrapper.uart_top.data_ready_o = 1'b1;
        started = 1;
        $display("Loaded %0d bytes; releasing RISC-V CPU", count);
    end

    always @(posedge dut.osc_clk) begin
        if (started && dut.bk3imcpj_wrapper.bk3_core_reset_n) begin
            if (dut.bk3imcpj_wrapper.i_axi.arvalid && dut.bk3imcpj_wrapper.i_axi.arready) begin
                if (fetches == 0 && dut.bk3imcpj_wrapper.i_axi.araddr !== 32'h1000)
                    $fatal(1, "Unexpected initial fetch: %h", dut.bk3imcpj_wrapper.i_axi.araddr);
                fetches = fetches + 1;
            end
            if (dut.bk3imcpj_wrapper.i_axi.rvalid && dut.bk3imcpj_wrapper.i_axi.rready &&
                dut.bk3imcpj_wrapper.i_axi.rresp !== 2'b00)
                $fatal(1, "Instruction AXI response error");
            if (dut.bk3imcpj_wrapper.uart_mcus_wr_en &&
                dut.bk3imcpj_wrapper.mcum_addr == 16'h0000) begin
                $write("%c", dut.bk3imcpj_wrapper.mcum_wdata);
                uart_tail = {uart_tail[63:0], dut.bk3imcpj_wrapper.mcum_wdata};
                if (uart_tail == "Init done" && fetches > 0) begin
                    $display("\nPASS: RISC-V firmware reached Init done (%0d fetches)", fetches);
                    $finish;
                end
            end
        end
    end
endmodule
