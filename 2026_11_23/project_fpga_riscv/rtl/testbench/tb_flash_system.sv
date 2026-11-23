// Cycle-driven integration test: real loader, wrapper, AXI and RISC-V core.
module tb_flash_system(input clk, reset_n, miso,
    output cs_n, sck, mosi, busy, done, error,
    output [31:0] wr_addr, output [7:0] wr_data, output wr_en,
    output cpu_running, output reg passed=0);
    spi_flash_boot #(.STARTUP_CYCLES(5),.SCK_DIV(1)) loader(.*);
    bk3imcpj_wrapper dut (
        .clk(clk),.reset_n(reset_n),.boot_busy(busy),.boot_done(done),
        .boot_wr_addr(wr_addr),.boot_wr_data(wr_data),.boot_wr_en(wr_en),
        .uart_rx_i(1'b1),.uart_tx_o(),.uart_data_error(),.interrupt(1'b0),
        .mcum_rd_en(),.mcum_wr_en(),.mcum_addr(),.mcum_wdata(),
        .mcum_rdata_latency(2'b0),.mcum_rdata(8'b0),
        .mcum_rd_en_1(),.mcum_wr_en_1(),.mcum_addr_1(),.mcum_wdata_1(),
        .mcum_rdata_latency_1(2'b0),.mcum_rdata_1(32'b0),
        .jtag_load(1'b0),.TCK(1'b0),.TMS(1'b0),.TDI(1'b0),.TDO()
    );
    assign cpu_running=dut.bk3_core_reset_n;
    // The Verilator flow uses boot_ram_model.v; Vivado uses the generated BRAM IP.
    function automatic [31:0] imem_word(input [14:0] index);
`ifdef VERILATOR
        imem_word = dut.i_mem.mem[index];
`else
        imem_word = dut.i_mem.inst.native_mem_module.blk_mem_gen_v8_4_4_inst.memory[index];
`endif
    endfunction
    function automatic [31:0] dmem_word(input [14:0] index);
`ifdef VERILATOR
        dmem_word = dut.d_mem.mem[index];
`else
        dmem_word = dut.d_mem.inst.native_mem_module.blk_mem_gen_v8_4_4_inst.memory[index];
`endif
    endfunction
    reg [31:0] actual_word;
    reg checked=0;
    integer fd, status, n=0;
    reg [31:0] a;
    reg [7:0] b;
    reg [71:0] tail_text=0;
    string firmware;
    always @(posedge clk) if (reset_n) begin
        if (busy && cpu_running) $fatal(1,"CPU released during loading");
        if (done && !checked) begin
            if (cpu_running) $fatal(1,"CPU released before memory verification");
            if (!$value$plusargs("FW_MEM=%s",firmware)) $fatal(1,"Missing FW_MEM");
            fd=$fopen(firmware,"r");
            if (!fd) $fatal(1,"Cannot open firmware");
            status=$fscanf(fd,"%h %h",a,b);
            while(status==2) begin
                if (a<32'h7ff80000) begin
                    actual_word = imem_word((a-32'h1000)>>2);
                    if (actual_word[8*a[1:0]+:8] !== b)
                        $fatal(1,"IMEM differs from IHEX at %h",a);
                end else begin
                    actual_word = dmem_word((a-32'h7ff80000)>>2);
                    if (actual_word[8*a[1:0]+:8] !== b)
                        $fatal(1,"DMEM differs from IHEX at %h",a);
                end
                status=$fscanf(fd,"%h %h",a,b);
            end
            $fclose(fd);
            checked=1;
            $display("PASS: all IHEX bytes match IMEM and DMEM before CPU release");
        end
        if (cpu_running) begin
            if (dut.i_axi.arvalid && dut.i_axi.arready) begin
                if (n==0 && dut.i_axi.araddr!=32'h1000) $fatal(1,"Reset fetch address");
                n=n+1;
            end
            if (dut.i_axi.rvalid && dut.i_axi.rready && dut.i_axi.rresp!=0)
                $fatal(1,"Instruction bus error");
            if (dut.uart_mcus_wr_en && dut.mcum_addr==0) begin
                $write("%c",dut.mcum_wdata);
                tail_text={tail_text[63:0],dut.mcum_wdata};
                if (tail_text=="Init done" && n>0) begin
                    passed=1;
                    $display("\nPASS: Flash-loaded firmware reached Init done (%0d fetches)",n);
                end
            end
        end
    end
endmodule
