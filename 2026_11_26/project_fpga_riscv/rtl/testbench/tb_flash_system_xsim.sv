`timescale 1ns/1ps
// Standalone event-driven driver for the cycle-driven integration test.
module tb_flash_system_xsim;
    reg clk=0, reset_n=0, miso=0;
    wire cs_n, sck, mosi, busy, done, error, wr_en, cpu_running, passed;
    wire [31:0] wr_addr;
    wire [7:0] wr_data;
    tb_flash_system system_test(.*);
    always #5 clk=~clk;

    reg [7:0] flash [0:4194303];
    string firmware;
    integer fd, status, i, bits=0, bit_index=7, transactions=0, writes=0;
    reg [31:0] address, value, command=0, physical=0;
    initial begin
        for (i=0; i<4194304; i=i+1) flash[i]=8'hff;
        if (!$value$plusargs("FW_MEM=%s",firmware)) $fatal(1,"Missing FW_MEM");
        fd=$fopen(firmware,"r");
        if (!fd) $fatal(1,"Cannot open firmware: %s",firmware);
        status=$fscanf(fd,"%h %h",address,value);
        while (status==2) begin
            if (address>=32'h1000 && address<32'h21000)
                flash[address]=value[7:0];
            else if (address>=32'h7ff80000 && address<32'h7ff84000)
                flash[address-32'h7ff80000+32'h021000]=value[7:0];
            else $fatal(1,"Firmware address outside boot regions: %h",address);
            status=$fscanf(fd,"%h %h",address,value);
        end
        $fclose(fd);
        repeat (4) @(negedge clk);
        reset_n=1;
        repeat (12000000) @(negedge clk);
        $fatal(1,"Firmware timeout");
    end

    always @(negedge cs_n) begin
        bits=0;
        bit_index=7;
        command=0;
        transactions=transactions+1;
    end
    always @(posedge sck) if (!cs_n) begin
        if (bits<32) begin
            command={command[30:0],mosi};
            if (bits==31) begin
                if (command !== (transactions==1 ? 32'h03001000 : 32'h03021000))
                    $fatal(1,"Unexpected SPI command/address: %h",command);
                physical={8'b0,command[23:0]};
            end
        end else if (bit_index==0) begin
            physical=physical+1;
            bit_index=7;
        end else bit_index=bit_index-1;
        bits=bits+1;
    end
    always @(negedge sck) if (!cs_n && bits>=32)
        miso=flash[physical][bit_index];

    always @(posedge clk) if (reset_n) begin
        if (error) $fatal(1,"Flash boot error");
        if (wr_en) begin
            if (wr_data !== flash[wr_addr>=32'h7ff80000 ?
                    wr_addr-32'h7ff80000+32'h021000 : wr_addr])
                $fatal(1,"SPI byte mismatch at %h",wr_addr);
            writes=writes+1;
        end
    end
    always @(negedge clk) if (passed) begin
        if (writes!=147456 || transactions!=2)
            $fatal(1,"Incorrect transfer length/count: %0d/%0d",writes,transactions);
        $display("PASS: automatic Flash boot, %0d bytes",writes);
        $finish;
    end
endmodule
