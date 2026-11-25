
interface axi_lite_intf #(
    parameter A_WIDTH = 32,
    parameter D_WIDTH = 32
) (
    input a_clk,
    input a_reset_n
);

wire awvalid;
wire awready;
wire [A_WIDTH-1:0] awaddr;
wire [2:0] awprot;
wire wvalid;
wire wready;
wire [D_WIDTH-1:0] wdata;
wire [D_WIDTH/8-1:0] wstrb;
wire bvalid;
wire bready;
wire [1:0] bresp;
wire arvalid;
wire arready;
wire [A_WIDTH-1:0] araddr;
wire [2:0] arprot;
wire rvalid;
wire rready;
wire [D_WIDTH-1:0] rdata;
wire [1:0] rresp;

modport master (
    input a_clk,
    input a_reset_n,
    
    output awvalid,
    input awready,
    output awaddr,
    output awprot,
    
    output wvalid,
    input wready,
    output wdata,
    output wstrb,
    
    input bvalid,
    output bready,
    input bresp,
    
    output arvalid,
    input arready,
    output araddr,
    output arprot,
    
    input rvalid,
    output rready,
    input rdata,
    input rresp
);

modport slave (
    input a_clk,
    input a_reset_n,

    input awvalid,
    output awready,
    input awaddr,
    input awprot,
    
    input wvalid,
    output wready,
    input wdata,
    input wstrb,
    
    output bvalid,
    input bready,
    output bresp,
    
    input arvalid,
    output arready,
    input araddr,
    input arprot,
    
    output rvalid,
    input rready,
    output rdata,
    output rresp
);

endinterface
