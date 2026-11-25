`timescale 1ns/1ps
// Standalone boot regression: full windows, physical SPI addresses and CPU addresses.
module tb_flash_layout(input clk, reset_n);
    reg miso=0;
    wire cs_n,sck,mosi,busy,done,error,wr_en;
    wire [31:0] wr_addr;
    wire [7:0] wr_data;
    spi_flash_boot #(.STARTUP_CYCLES(5),.SCK_DIV(1)) dut(.*);
    integer bits=0, transactions=0, writes=0, bit_index=7;
    reg [31:0] command=0, physical=0, expected_addr;
    function automatic [7:0] payload(input [31:0] a);
        payload = a[7:0] ^ a[15:8] ^ a[23:16] ^ 8'h5a;
    endfunction
    always @(negedge cs_n) begin
        bits=0; command=0; bit_index=7; transactions=transactions+1;
    end
    always @(posedge sck) if (!cs_n) begin
        if (bits<32) begin
            command={command[30:0],mosi};
            if (bits==31) begin
                if (command !== (transactions==1 ? 32'h03001000 : 32'h03021000))
                    $fatal(1,"Incorrect physical read address: %h",command);
                physical={8'b0,command[23:0]};
            end
        end else if (bit_index==0) begin
            physical=physical+1; bit_index=7;
        end else bit_index=bit_index-1;
        bits=bits+1;
    end
    always @(negedge sck) if (!cs_n && bits>=32)
        miso=1'((payload(physical) >> bit_index));
    always @(negedge clk) if (reset_n) begin
        if (error) $fatal(1,"Boot error");
        if (wr_en) begin
            expected_addr = writes<131072 ? 32'h1000+writes : 32'h7ff80000+(writes-131072);
            if (wr_addr !== expected_addr ||
                wr_data !== payload(32'h1000+writes))
                $fatal(1,"Incorrect RAM write %0d: %h %h",writes,wr_addr,wr_data);
            writes=writes+1;
        end
        if (done) begin
            if (writes!=147456 || transactions!=2 || busy || !cs_n)
                $fatal(1,"Incomplete boot");
            $display("PASS: 147456 bytes, Flash DMEM 021000..024fff, CPU DMEM 7ff80000..7ff83fff; certificate excluded");
            $finish;
        end
    end
endmodule
