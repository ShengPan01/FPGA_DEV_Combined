
module bk3imcpj_wrapper #(
    parameter clk_freq = 27_000_000,
    parameter bus1_addr_width = 8'd24
) (
    input clk,
    input reset_n,
    input boot_busy,
    input boot_done,
    input [31:0] boot_wr_addr,
    input [7:0] boot_wr_data,
    input boot_wr_en,
	
 /// uart interface
    input uart_rx_i,
    output uart_tx_o,
    //output uart_sel,
    output uart_data_error,
    output data_ready_o,
   
    input interrupt,
 
/// 8bit register interface, bus0
    output        mcum_rd_en,   // Read strobe, active high
    output        mcum_wr_en,   // Write strobe, active high
    output [15:0] mcum_addr,   // Address
    output [7:0] mcum_wdata,   // Write data
    input [1:0] mcum_rdata_latency,
    input [7:0] mcum_rdata,   // Read data
    
/// 32bit register interface, bus1
    output        mcum_rd_en_1,   // Read strobe, active high
    output        mcum_wr_en_1,   // Write strobe, active high
    output [bus1_addr_width-1:0] mcum_addr_1,   // Address
    output [31:0] mcum_wdata_1,   // Write data
    input [1:0] mcum_rdata_latency_1,
    input [31:0] mcum_rdata_1,   // Read data

    input jtag_load,  // 1: jtag mode,0: normal mode 
	
    input  wire TCK,
    input  wire TMS,
    input  wire TDI,
    output wire TDO


);

reg bk3_core_reset_n;
wire download_reset_n;
//wire data_ready_o;

wire [15:0]ram_wr_addr_h;
wire[15:0]ram_wr_addr;
wire[7:0] ram_wr_data;
wire      ram_wr_en;

always @(posedge clk or negedge reset_n)
    if (!reset_n)
        bk3_core_reset_n <= 1'b0;
    else
        bk3_core_reset_n <= download_reset_n;

wire [1:0] mcum_rdata_latency_core;
wire [31:0] mcum_rdata_core;
wire [15:0] mcum_addr_core;

wire [1:0] mcum_rdata_latency_core_1;
wire [31:0] mcum_addr_core_1;

axi_lite_intf i_axi (
    .a_clk(clk), 
    .a_reset_n(bk3_core_reset_n)
);

axi_lite_intf d_axi (
    .a_clk(clk), 
    .a_reset_n(bk3_core_reset_n)
);

wire uart_intr;
wire uart_download_ack_done;
(* mark_debug = "true", keep = "true" *) wire [31:0] dbg_uart_status;
wire p_meip = uart_intr | interrupt;
codix_berkelium_top_ca codix_berkelium_top_ca(
    .TCK(TCK),
    .TRST(bk3_core_reset_n),
    .TMS(TMS),
    .TDI(TDI),
    .TDO(TDO),
    
    .CLK(clk),
    .RST(bk3_core_reset_n),
    .D_ARREADY(d_axi.arready),
    .D_AWREADY(d_axi.awready),
    .D_BRESP(d_axi.bresp[1:0]),
    .D_BVALID(d_axi.bvalid),
    .D_RDATA(d_axi.rdata[31:0]),
    .D_RRESP(d_axi.rresp[1:0]),
    .D_RVALID(d_axi.rvalid),
    .D_WREADY(d_axi.wready),
    .D_ARADDR(d_axi.araddr[31:0]),
    .D_ARPROT(d_axi.arprot[2:0]),
    .D_ARVALID(d_axi.arvalid),
    .D_AWADDR(d_axi.awaddr[31:0]),
    .D_AWPROT(d_axi.awprot[2:0]),
    .D_AWVALID(d_axi.awvalid),
    .D_BREADY(d_axi.bready),
    .D_RREADY(d_axi.rready),
    .D_WDATA(d_axi.wdata),
    .D_WSTRB(d_axi.wstrb[3:0]),
    .D_WVALID(d_axi.wvalid),
    
    .I_ARREADY(i_axi.arready),
    .I_AWREADY(i_axi.awready),
    .I_BRESP(i_axi.bresp[1:0]),
    .I_BVALID(i_axi.bvalid),
    .I_RDATA(i_axi.rdata[31:0]),
    .I_RRESP(i_axi.rresp[1:0]),
    .I_RVALID(i_axi.rvalid),
    .I_WREADY(i_axi.wready),
    .I_ARADDR(i_axi.araddr[31:0]),
    .I_ARPROT(i_axi.arprot[2:0]),
    .I_ARVALID(i_axi.arvalid),
    .I_AWADDR(i_axi.awaddr[31:0]),
    .I_AWPROT(i_axi.awprot[2:0]),
    .I_AWVALID(i_axi.awvalid),
    .I_BREADY(i_axi.bready),
    .I_RREADY(i_axi.rready),
    .I_WDATA(i_axi.wdata),
    .I_WSTRB(i_axi.wstrb[3:0]),
    .I_WVALID(i_axi.wvalid),

    .p_meip(p_meip),
    .p_msip(1'b0),
    .p_mtip(mtip)

);

axi_lite_intf d_axi_i (.a_clk(clk), .a_reset_n(bk3_core_reset_n));
axi_lite_intf d_axi_d (.a_clk(clk), .a_reset_n(bk3_core_reset_n));
axi_lite_intf i_mem_axi (.a_clk(clk), .a_reset_n(bk3_core_reset_n));
axi_lite_intf d_timer_axi (.a_clk(clk), .a_reset_n(bk3_core_reset_n));

machine_timer machine_timer (
    .axis(d_axi),
    .axim(d_timer_axi),
    .mtip(mtip)
);

axi_lite_1_to_2 #(
    .MASTER_BASE_0(32'h0),
    .MASTER_MASK_0(32'h000fffff),
    .MASTER_BASE_1(32'h7ff80000),
    .MASTER_MASK_1(32'h0fffffff)
) axi_lite_1_to_2 (
    .axis_0(d_timer_axi),
    .axim_0(d_axi_i),
    .axim_1(d_axi_d)
);

axi_lite_2_to_1 axi_lite_2_to_1 (
    .axis_0(i_axi),
    .axis_1(d_axi_i),
    .axim_0(i_mem_axi)

);

// Program BRAM: 0x1000 .. 0x20fff (128 KiB).
// One download port owns both BRAMs while the CPU is held in reset.
wire [31:0] uart_wr_addr = boot_busy ? boot_wr_addr : {ram_wr_addr_h, ram_wr_addr};
wire load_wr_en = boot_busy ? boot_wr_en : ram_wr_en;
wire [7:0] load_wr_data = boot_busy ? boot_wr_data : ram_wr_data;
wire [3:0] i_mem_wr_en_uart = load_wr_en && (uart_wr_addr >= 32'h1000 && uart_wr_addr < 32'h21000) ? (4'b0001 << uart_wr_addr[1:0]) : 4'h0;
wire [31:0] i_mem_wr_addr_uart = (uart_wr_addr - 32'h00001000)>>2;
wire [31:0] i_mem_wr_data_uart = {4{load_wr_data}};

// Data BRAM: 0x7ff80000 .. 0x7ff9ffff (128 KiB).
wire [3:0] d_mem_wr_en_uart = load_wr_en && (uart_wr_addr >= 32'h7ff80000 && uart_wr_addr < 32'h7ffa0000) ? (4'b0001 << uart_wr_addr[1:0]) : 4'h0;
wire [31:0] d_mem_wr_addr_uart = (uart_wr_addr - 32'h7ff80000)>>2;
wire [31:0] d_mem_wr_data_uart = {4{load_wr_data}};


wire i_mem_rd_en;
wire [3:0] i_mem_wr_en;
wire [16:0] i_mem_addr;
wire [31:0] i_mem_wdata;
wire [31:0] i_mem_rdata;

axi_lite_mcu_bridge #(
    .A_BASE(32'h1000),
    .A_WIDTH(17),
    .D_WIDTH(32)
) i_mem_axi_brdg (
    .axis(i_mem_axi),

    .mcum_rd_en(i_mem_rd_en),   // Read strobe, active high
    .mcum_wr_en(i_mem_wr_en[3:0]),   // Write strobe, active high
    .mcum_addr(i_mem_addr[16:0]),   // Address
    .mcum_wdata(i_mem_wdata[31:0]),   // Write data
    .mcum_rdata_latency(2'h1),
    .mcum_rdata(i_mem_rdata[31:0])   // Read data
);

// Probe the BRAM port after the download/AXI muxes.
// Control bits: [5] enable, [4] AXI read strobe, [3:0] byte write enables.
(* mark_debug = "true", keep = "true" *) wire [5:0] dbg_imem_ctrl = {
    i_mem_rd_en | (|i_mem_wr_en) | load_wr_en,
    i_mem_rd_en,
    i_mem_wr_en | i_mem_wr_en_uart
};
(* mark_debug = "true", keep = "true" *) wire [14:0] dbg_imem_addr =
    (|i_mem_wr_en_uart) ? i_mem_wr_addr_uart[14:0] : i_mem_addr[16:2];
(* mark_debug = "true", keep = "true" *) wire [31:0] dbg_imem_din =
    (|i_mem_wr_en_uart) ? i_mem_wr_data_uart : i_mem_wdata;
(* mark_debug = "true", keep = "true" *) wire [31:0] dbg_imem_dout;
assign i_mem_rdata = dbg_imem_dout;

s_32kx32 i_mem(
  .clka(clk),
  .ena(dbg_imem_ctrl[5]),
  .wea(dbg_imem_ctrl[3:0]),
  .addra(dbg_imem_addr),
  .dina(dbg_imem_din),
  .douta(dbg_imem_dout)
);

wire d_mem_rd_en;
wire [3:0] d_mem_wr_en;
wire [31:0] d_mem_addr;
wire [31:0] d_mem_wdata;
wire [31:0] d_mem_rdata;
wire [1:0] d_mem_rdata_latency;

axi_lite_mcu_bridge #(
    .A_WIDTH(32),
    .D_WIDTH(32)
) d_mem_axi_brdg (
    .axis(d_axi_d),

    .mcum_rd_en(d_mem_rd_en),   // Read strobe, active high
    .mcum_wr_en(d_mem_wr_en[3:0]),   // Write strobe, active high
    .mcum_addr(d_mem_addr[31:0]),   // Address
    .mcum_wdata(d_mem_wdata[31:0]),   // Write data
    .mcum_rdata_latency(d_mem_rdata_latency[1:0]),
    .mcum_rdata(d_mem_rdata[31:0])   // Read data
);

// SRAM address range: 32'h00000000 ~ 32'h0007ffff
wire d_mem_sram_sel = (d_mem_addr[31:20] == 12'h000) && (d_mem_addr[19] == 1'h0);
wire d_mem_sram_rd_en = d_mem_rd_en && d_mem_sram_sel;
wire [3:0] d_mem_sram_wr_en = d_mem_sram_sel ? d_mem_wr_en[3:0] : 4'h0;
wire [14:0] d_mem_sram_addr = d_mem_addr[16:2];
wire [31:0] d_mem_sram_wdata = d_mem_wdata[31:0];
wire [31:0] d_mem_sram_rdata;

s_32kx32 d_mem(
  .clka(clk),
  .ena(d_mem_sram_rd_en | (|d_mem_sram_wr_en[3:0]) | load_wr_en),
  .wea(d_mem_sram_wr_en[3:0] | d_mem_wr_en_uart[3:0]),
  .addra((d_mem_wr_en_uart[3:0] != 0) ? d_mem_wr_addr_uart[14:0] : d_mem_sram_addr[14:0]),
  .dina((d_mem_wr_en_uart[3:0] != 0) ? d_mem_wr_data_uart[31:0] : d_mem_sram_wdata[31:0]),
  .douta(d_mem_sram_rdata[31:0])
);

// periphral address range: 32'h00080000 ~ 32'h000bffff
wire d_mem_periphral_sel = (d_mem_addr[31:20] == 12'h000) && (d_mem_addr[19:18] == 2'b10);
assign mcum_rd_en = d_mem_periphral_sel && d_mem_rd_en;
assign mcum_wr_en = d_mem_periphral_sel && d_mem_wr_en[0];
assign mcum_addr_core = d_mem_addr[17:2];
assign mcum_wdata = d_mem_wdata[7:0];

//wide address, periphral address range: 32'h000c0000 ~ 32'h0fffffff
wire d_mem_periphral_sel_1 = (!d_mem_periphral_sel)&(!d_mem_sram_sel);
assign mcum_rd_en_1 = d_mem_periphral_sel_1 && d_mem_rd_en;
assign mcum_wr_en_1 = d_mem_periphral_sel_1 && d_mem_wr_en[0];
assign mcum_addr_core_1 = d_mem_addr-20'hc0000;
assign mcum_wdata_1 = d_mem_wdata;

assign d_mem_rdata_latency = d_mem_sram_sel ? 2'h1 : {d_mem_periphral_sel ? mcum_rdata_latency_core[1:0] : mcum_rdata_latency_core_1[1:0]};

reg d_mem_sram_rd_en_d;
reg d_mem_periphral_sel_d;

always @(posedge clk)
begin
    d_mem_sram_rd_en_d <= d_mem_sram_rd_en;
    d_mem_periphral_sel_d <= d_mem_periphral_sel;
end

assign d_mem_rdata = (/*d_mem_sram_sel | */d_mem_sram_rd_en_d) ? d_mem_sram_rdata[31:0] : mcum_rdata_core ;

/*
codix_berkelium_top_ca codix_berkelium_top_ca(
    .CLK(clk),
    .RST(bk3_core_reset_n),
    .p_meip(uart_intr),
    .p_msip(1'b0),

    .ram_wr_addr_h(ram_wr_addr_h[15:0]),
    .ram_wr_addr(ram_wr_addr[15:0]),
    .ram_wr_data(ram_wr_data[7:0]),
    .ram_wr_en(ram_wr_en),

        .mcum_rd_en(mcum_rd_en),   // Read strobe, active high
        .mcum_wr_en(mcum_wr_en),   // Write strobe, active high
        .mcum_addr(mcum_addr_core[15:0]),   // Address
        .mcum_wdata(mcum_wdata[7:0]),   // Write data
        .mcum_rdata_latency(mcum_rdata_latency_core[1:0]),
        .mcum_rdata(mcum_rdata_core[7:0])   // Read data
);

*/


wire uart_sel = mcum_addr_core[15:4] == 12'h000;
wire uart_mcus_rd_en = uart_sel & mcum_rd_en;
wire uart_mcus_wr_en = uart_sel & mcum_wr_en;
wire [7:0] uart_mcus_rdata;

assign mcum_rdata_latency_core = uart_sel ? 2'h0 : mcum_rdata_latency;
assign mcum_rdata_latency_core_1 =  mcum_rdata_latency_1;

//wire mcum_rdata_latency_0_en = (mcum_rdata_latency_core == 2'h0) && mcum_rd_en;
reg mcum_rdata_latency_1_en;
reg mcum_rdata_latency_1_en_1;
reg mcum_rdata_latency_2_en_1;
reg mcum_rdata_latency_2d_en_1;

always @(posedge clk or negedge reset_n)
    if (!reset_n)
        mcum_rdata_latency_1_en <= 1'b0;
    else
        mcum_rdata_latency_1_en <= (mcum_rdata_latency_core == 2'h1) && mcum_rd_en;

always @(posedge clk or negedge reset_n)
    if (!reset_n)
        mcum_rdata_latency_1_en_1 <= 1'b0;
    else
        mcum_rdata_latency_1_en_1 <= (mcum_rdata_latency_core_1 == 2'h1) && mcum_rd_en_1;


always @(posedge clk or negedge reset_n)
    if (!reset_n)
        mcum_rdata_latency_2_en_1 <= 1'b0;
    else begin
        mcum_rdata_latency_2_en_1 <= (mcum_rdata_latency_core_1 == 2'h2) && mcum_rd_en_1;
        mcum_rdata_latency_2d_en_1 <= (mcum_rdata_latency_core_1 == 2'h2) && mcum_rdata_latency_2_en_1;
   end

assign mcum_rdata_core = (uart_sel && mcum_rd_en) ? {24'h0,uart_mcus_rdata[7:0]} : {(mcum_rdata_latency_2d_en_1||mcum_rdata_latency_1_en_1||mcum_rd_en_1) ? mcum_rdata_1 :mcum_rdata[7:0]};

uart_top #(
    .clk_freq(clk_freq)
) uart_top(
    .clk(clk),
    .rst_n(reset_n),
    .jtag_load(jtag_load | boot_done),

    .uart_intr(uart_intr),
    .debug_status_o(dbg_uart_status),
    .download_ack_done_o(uart_download_ack_done),
//flash interface
    .rden_i(1'b0),
    .rd_qout_o(),
    .data_ready_o(data_ready_o),   
    .uart_data_error(uart_data_error), 
// SRAM interface
    .ram_wr_addr_h(ram_wr_addr_h[15:0]),
    .ram_wr_addr(ram_wr_addr[15:0]),
    .ram_wr_data(ram_wr_data[7:0]),
    .ram_wr_en(ram_wr_en),
//uart interface   
    .uart_rx_i(uart_rx_i),
    .uart_tx_o(uart_tx_o),
    .uart_cts_i(1'b0),
    .uart_rts_o(),

    .reg_clk                    (clk),
    .reg_reset_n                (reset_n),
    .mcus_rd_en(uart_mcus_rd_en),   // Read strobe, active high
    .mcus_wr_en(uart_mcus_wr_en),   // Write strobe, active high
    .mcus_addr(mcum_addr[15:0]),   // Address
    .mcus_wdata(mcum_wdata[7:0]),   // Write data
    .mcus_rdata(uart_mcus_rdata[7:0])   // Read data
);

reg [15:0] mcum_addr_d;
reg [31:0] mcum_addr_d_1;

always @(posedge clk or negedge reset_n)
    if (!reset_n)
        mcum_addr_d <= 16'h0;
    else
        mcum_addr_d <= mcum_addr_core[15:0];

always @(posedge clk or negedge reset_n)
    if (!reset_n)
        mcum_addr_d_1 <= 16'h0;
    else
        mcum_addr_d_1 <= mcum_addr_core_1;

assign mcum_addr = mcum_rdata_latency_1_en ? mcum_addr_d[15:0] : mcum_addr_core[15:0];
assign mcum_addr_1 = mcum_rdata_latency_1_en_1 ? mcum_addr_d_1[bus1_addr_width-1:0] : mcum_addr_core_1[bus1_addr_width-1:0];

assign download_reset_n = data_ready_o && uart_download_ack_done && !boot_busy;

// Passive boot diagnostics. History survives CPU reset; only reset_n clears it.
// All probes use clk (top-level osc_clk). No functional control is changed.
(* mark_debug = "true", keep = "true" *) wire [7:0] dbg_boot_status =
    {2'b00, mtip, p_meip, bk3_core_reset_n, download_reset_n, boot_done, boot_busy};
(* mark_debug = "true", keep = "true" *) wire [31:0] dbg_load_addr = uart_wr_addr;
(* mark_debug = "true", keep = "true" *) wire [7:0] dbg_load_data = load_wr_data;
(* mark_debug = "true", keep = "true" *) wire [8:0] dbg_load_en =
    {load_wr_en, i_mem_wr_en_uart, d_mem_wr_en_uart};
(* mark_debug = "true", keep = "true" *) wire [31:0] dbg_if_addr = i_axi.araddr;
(* mark_debug = "true", keep = "true" *) wire [31:0] dbg_if_data = i_axi.rdata;
(* mark_debug = "true", keep = "true" *) wire [5:0] dbg_if_status =
    {i_axi.rresp, i_axi.rvalid, i_axi.rready, i_axi.arvalid, i_axi.arready};
(* mark_debug = "true", keep = "true" *) wire [31:0] dbg_data_raddr = d_axi.araddr;
(* mark_debug = "true", keep = "true" *) wire [31:0] dbg_data_rdata = d_axi.rdata;
(* mark_debug = "true", keep = "true" *) wire [31:0] dbg_data_waddr = d_axi.awaddr;
(* mark_debug = "true", keep = "true" *) wire [31:0] dbg_data_wdata = d_axi.wdata;
(* mark_debug = "true", keep = "true" *) wire [15:0] dbg_data_status =
    {d_axi.wstrb, d_axi.bresp, d_axi.rresp, d_axi.bvalid, d_axi.bready,
     d_axi.wvalid, d_axi.wready, d_axi.awvalid, d_axi.awready,
     d_axi.arvalid, d_axi.arready};
(* mark_debug = "true", keep = "true" *) wire [1:0] dbg_data_read_status =
    {d_axi.rvalid, d_axi.rready};
(* mark_debug = "true", keep = "true" *) wire [15:0] dbg_mcu_addr = mcum_addr;
(* mark_debug = "true", keep = "true" *) wire [7:0] dbg_mcu_wdata = mcum_wdata;
(* mark_debug = "true", keep = "true" *) wire [31:0] dbg_mcu_rdata = mcum_rdata_core;
(* mark_debug = "true", keep = "true" *) wire [4:0] dbg_mcu_status =
    {uart_intr, uart_mcus_wr_en, uart_mcus_rd_en, mcum_wr_en, mcum_rd_en};
(* mark_debug = "true", keep = "true" *) reg [31:0] dbg_load_count;
(* mark_debug = "true", keep = "true" *) reg [31:0] dbg_fetch_count;
(* mark_debug = "true", keep = "true" *) reg [31:0] dbg_uart_tx_count;
(* mark_debug = "true", keep = "true" *) reg [31:0] dbg_last_if_addr;
(* mark_debug = "true", keep = "true" *) reg [7:0] dbg_seen;

always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
        dbg_load_count <= 0;
        dbg_fetch_count <= 0;
        dbg_uart_tx_count <= 0;
        dbg_last_if_addr <= 0;
        dbg_seen <= 0;
    end else begin
        if (|i_mem_wr_en_uart || |d_mem_wr_en_uart)
            dbg_load_count <= dbg_load_count + 1'b1;
        if (uart_data_error) dbg_seen[0] <= 1'b1;
        if (data_ready_o) dbg_seen[1] <= 1'b1;
        if (bk3_core_reset_n) begin
            dbg_seen[2] <= 1'b1;
            if (i_axi.arvalid && i_axi.arready) begin
                dbg_fetch_count <= dbg_fetch_count + 1'b1;
                dbg_last_if_addr <= i_axi.araddr;
                dbg_seen[3] <= 1'b1;
            end
            if (uart_mcus_wr_en && mcum_addr == 16'h0000) begin
                dbg_uart_tx_count <= dbg_uart_tx_count + 1'b1;
                dbg_seen[4] <= 1'b1;
            end
            if (i_axi.rvalid && i_axi.rready && i_axi.rresp != 2'b00)
                dbg_seen[5] <= 1'b1;
            if (d_axi.rvalid && d_axi.rready && d_axi.rresp != 2'b00)
                dbg_seen[6] <= 1'b1;
            if (d_axi.bvalid && d_axi.bready && d_axi.bresp != 2'b00)
                dbg_seen[7] <= 1'b1;
        end
    end
end

endmodule
