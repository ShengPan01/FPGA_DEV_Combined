// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2020.2 (win64) Build 3064766 Wed Nov 18 09:12:45 MST 2020
// Date        : Mon Nov 23 12:09:49 2026
// Host        : DESKTOP-566HR3S running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               d:/FPGA_DEV/Github_combined/Github_combined_up/FPGA_DEV_Combined/2026_11_23/project_fpga_riscv/project_fpga_riscv.gen/sources_1/ip/dpsram_1280x8/dpsram_1280x8_sim_netlist.v
// Design      : dpsram_1280x8
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xczu9eg-ffvb1156-2-i
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "dpsram_1280x8,blk_mem_gen_v8_4_4,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "blk_mem_gen_v8_4_4,Vivado 2020.2" *) 
(* NotValidForBitStream *)
module dpsram_1280x8
   (clka,
    wea,
    addra,
    dina,
    douta,
    clkb,
    web,
    addrb,
    dinb,
    doutb);
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME BRAM_PORTA, MEM_SIZE 8192, MEM_WIDTH 32, MEM_ECC NONE, MASTER_TYPE OTHER, READ_LATENCY 1" *) input clka;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA WE" *) input [0:0]wea;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA ADDR" *) input [10:0]addra;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA DIN" *) input [7:0]dina;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA DOUT" *) output [7:0]douta;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME BRAM_PORTB, MEM_SIZE 8192, MEM_WIDTH 32, MEM_ECC NONE, MASTER_TYPE OTHER, READ_LATENCY 1" *) input clkb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB WE" *) input [0:0]web;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB ADDR" *) input [10:0]addrb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB DIN" *) input [7:0]dinb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB DOUT" *) output [7:0]doutb;

  wire [10:0]addra;
  wire [10:0]addrb;
  wire clka;
  wire clkb;
  wire [7:0]dina;
  wire [7:0]dinb;
  wire [7:0]douta;
  wire [7:0]doutb;
  wire [0:0]wea;
  wire [0:0]web;
  wire NLW_U0_dbiterr_UNCONNECTED;
  wire NLW_U0_rsta_busy_UNCONNECTED;
  wire NLW_U0_rstb_busy_UNCONNECTED;
  wire NLW_U0_s_axi_arready_UNCONNECTED;
  wire NLW_U0_s_axi_awready_UNCONNECTED;
  wire NLW_U0_s_axi_bvalid_UNCONNECTED;
  wire NLW_U0_s_axi_dbiterr_UNCONNECTED;
  wire NLW_U0_s_axi_rlast_UNCONNECTED;
  wire NLW_U0_s_axi_rvalid_UNCONNECTED;
  wire NLW_U0_s_axi_sbiterr_UNCONNECTED;
  wire NLW_U0_s_axi_wready_UNCONNECTED;
  wire NLW_U0_sbiterr_UNCONNECTED;
  wire [10:0]NLW_U0_rdaddrecc_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_bid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_bresp_UNCONNECTED;
  wire [10:0]NLW_U0_s_axi_rdaddrecc_UNCONNECTED;
  wire [7:0]NLW_U0_s_axi_rdata_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_rid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_rresp_UNCONNECTED;

  (* C_ADDRA_WIDTH = "11" *) 
  (* C_ADDRB_WIDTH = "11" *) 
  (* C_ALGORITHM = "1" *) 
  (* C_AXI_ID_WIDTH = "4" *) 
  (* C_AXI_SLAVE_TYPE = "0" *) 
  (* C_AXI_TYPE = "1" *) 
  (* C_BYTE_SIZE = "9" *) 
  (* C_COMMON_CLK = "0" *) 
  (* C_COUNT_18K_BRAM = "1" *) 
  (* C_COUNT_36K_BRAM = "0" *) 
  (* C_CTRL_ECC_ALGO = "NONE" *) 
  (* C_DEFAULT_DATA = "0" *) 
  (* C_DISABLE_WARN_BHV_COLL = "0" *) 
  (* C_DISABLE_WARN_BHV_RANGE = "0" *) 
  (* C_ELABORATION_DIR = "./" *) 
  (* C_ENABLE_32BIT_ADDRESS = "0" *) 
  (* C_EN_DEEPSLEEP_PIN = "0" *) 
  (* C_EN_ECC_PIPE = "0" *) 
  (* C_EN_RDADDRA_CHG = "0" *) 
  (* C_EN_RDADDRB_CHG = "0" *) 
  (* C_EN_SAFETY_CKT = "0" *) 
  (* C_EN_SHUTDOWN_PIN = "0" *) 
  (* C_EN_SLEEP_PIN = "0" *) 
  (* C_EST_POWER_SUMMARY = "Estimated Power for IP     :     0.893298 mW" *) 
  (* C_FAMILY = "zynquplus" *) 
  (* C_HAS_AXI_ID = "0" *) 
  (* C_HAS_ENA = "0" *) 
  (* C_HAS_ENB = "0" *) 
  (* C_HAS_INJECTERR = "0" *) 
  (* C_HAS_MEM_OUTPUT_REGS_A = "0" *) 
  (* C_HAS_MEM_OUTPUT_REGS_B = "0" *) 
  (* C_HAS_MUX_OUTPUT_REGS_A = "0" *) 
  (* C_HAS_MUX_OUTPUT_REGS_B = "0" *) 
  (* C_HAS_REGCEA = "0" *) 
  (* C_HAS_REGCEB = "0" *) 
  (* C_HAS_RSTA = "0" *) 
  (* C_HAS_RSTB = "0" *) 
  (* C_HAS_SOFTECC_INPUT_REGS_A = "0" *) 
  (* C_HAS_SOFTECC_OUTPUT_REGS_B = "0" *) 
  (* C_INITA_VAL = "0" *) 
  (* C_INITB_VAL = "0" *) 
  (* C_INIT_FILE = "dpsram_1280x8.mem" *) 
  (* C_INIT_FILE_NAME = "no_coe_file_loaded" *) 
  (* C_INTERFACE_TYPE = "0" *) 
  (* C_LOAD_INIT_FILE = "0" *) 
  (* C_MEM_TYPE = "2" *) 
  (* C_MUX_PIPELINE_STAGES = "0" *) 
  (* C_PRIM_TYPE = "1" *) 
  (* C_READ_DEPTH_A = "1280" *) 
  (* C_READ_DEPTH_B = "1280" *) 
  (* C_READ_LATENCY_A = "1" *) 
  (* C_READ_LATENCY_B = "1" *) 
  (* C_READ_WIDTH_A = "8" *) 
  (* C_READ_WIDTH_B = "8" *) 
  (* C_RSTRAM_A = "0" *) 
  (* C_RSTRAM_B = "0" *) 
  (* C_RST_PRIORITY_A = "CE" *) 
  (* C_RST_PRIORITY_B = "CE" *) 
  (* C_SIM_COLLISION_CHECK = "ALL" *) 
  (* C_USE_BRAM_BLOCK = "0" *) 
  (* C_USE_BYTE_WEA = "0" *) 
  (* C_USE_BYTE_WEB = "0" *) 
  (* C_USE_DEFAULT_DATA = "0" *) 
  (* C_USE_ECC = "0" *) 
  (* C_USE_SOFTECC = "0" *) 
  (* C_USE_URAM = "0" *) 
  (* C_WEA_WIDTH = "1" *) 
  (* C_WEB_WIDTH = "1" *) 
  (* C_WRITE_DEPTH_A = "1280" *) 
  (* C_WRITE_DEPTH_B = "1280" *) 
  (* C_WRITE_MODE_A = "WRITE_FIRST" *) 
  (* C_WRITE_MODE_B = "WRITE_FIRST" *) 
  (* C_WRITE_WIDTH_A = "8" *) 
  (* C_WRITE_WIDTH_B = "8" *) 
  (* C_XDEVICEFAMILY = "zynquplus" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  (* is_du_within_envelope = "true" *) 
  dpsram_1280x8_blk_mem_gen_v8_4_4 U0
       (.addra(addra),
        .addrb(addrb),
        .clka(clka),
        .clkb(clkb),
        .dbiterr(NLW_U0_dbiterr_UNCONNECTED),
        .deepsleep(1'b0),
        .dina(dina),
        .dinb(dinb),
        .douta(douta),
        .doutb(doutb),
        .eccpipece(1'b0),
        .ena(1'b0),
        .enb(1'b0),
        .injectdbiterr(1'b0),
        .injectsbiterr(1'b0),
        .rdaddrecc(NLW_U0_rdaddrecc_UNCONNECTED[10:0]),
        .regcea(1'b0),
        .regceb(1'b0),
        .rsta(1'b0),
        .rsta_busy(NLW_U0_rsta_busy_UNCONNECTED),
        .rstb(1'b0),
        .rstb_busy(NLW_U0_rstb_busy_UNCONNECTED),
        .s_aclk(1'b0),
        .s_aresetn(1'b0),
        .s_axi_araddr({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arburst({1'b0,1'b0}),
        .s_axi_arid({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arlen({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arready(NLW_U0_s_axi_arready_UNCONNECTED),
        .s_axi_arsize({1'b0,1'b0,1'b0}),
        .s_axi_arvalid(1'b0),
        .s_axi_awaddr({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awburst({1'b0,1'b0}),
        .s_axi_awid({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awlen({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awready(NLW_U0_s_axi_awready_UNCONNECTED),
        .s_axi_awsize({1'b0,1'b0,1'b0}),
        .s_axi_awvalid(1'b0),
        .s_axi_bid(NLW_U0_s_axi_bid_UNCONNECTED[3:0]),
        .s_axi_bready(1'b0),
        .s_axi_bresp(NLW_U0_s_axi_bresp_UNCONNECTED[1:0]),
        .s_axi_bvalid(NLW_U0_s_axi_bvalid_UNCONNECTED),
        .s_axi_dbiterr(NLW_U0_s_axi_dbiterr_UNCONNECTED),
        .s_axi_injectdbiterr(1'b0),
        .s_axi_injectsbiterr(1'b0),
        .s_axi_rdaddrecc(NLW_U0_s_axi_rdaddrecc_UNCONNECTED[10:0]),
        .s_axi_rdata(NLW_U0_s_axi_rdata_UNCONNECTED[7:0]),
        .s_axi_rid(NLW_U0_s_axi_rid_UNCONNECTED[3:0]),
        .s_axi_rlast(NLW_U0_s_axi_rlast_UNCONNECTED),
        .s_axi_rready(1'b0),
        .s_axi_rresp(NLW_U0_s_axi_rresp_UNCONNECTED[1:0]),
        .s_axi_rvalid(NLW_U0_s_axi_rvalid_UNCONNECTED),
        .s_axi_sbiterr(NLW_U0_s_axi_sbiterr_UNCONNECTED),
        .s_axi_wdata({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_wlast(1'b0),
        .s_axi_wready(NLW_U0_s_axi_wready_UNCONNECTED),
        .s_axi_wstrb(1'b0),
        .s_axi_wvalid(1'b0),
        .sbiterr(NLW_U0_sbiterr_UNCONNECTED),
        .shutdown(1'b0),
        .sleep(1'b0),
        .wea(wea),
        .web(web));
endmodule
`pragma protect begin_protected
`pragma protect version = 1
`pragma protect encrypt_agent = "XILINX"
`pragma protect encrypt_agent_info = "Xilinx Encryption Tool 2020.2"
`pragma protect key_keyowner="Cadence Design Systems.", key_keyname="cds_rsa_key", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=64)
`pragma protect key_block
QGLtnqZzRetDH6gCWT4Js6wuLlZfrNx/VJp3sfR2NF+cxypO5AxN0oDKLJJtmdrtE/ueNDg+Qf7Z
TqBNRojORA==

`pragma protect key_keyowner="Synopsys", key_keyname="SNPS-VCS-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
B6Ger3hRvfjHkaJ+W8639Kl3TzC9TogLuklOXEiMNdc4Im+DjEUzxb3DKlzu0VW3zxZqjJ3+wsW/
LnRmPCESi5Y9eRJaLFXg79EMfoj4X+nTdHAP6yCfltBADKegZ12gpnB/8ey5yn2KA74LUtPC7jna
iyjqSfsWLGnz6UdXzwk=

`pragma protect key_keyowner="Aldec", key_keyname="ALDEC15_001", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
BX+DxgMPRyZbYojCUR9Sk8Lq+3ZigBz4yMFHQkmurfdfDzyTPJCE827eGiPyTenK1QPVhEtf9g06
0BFXq/0COPuU1BWJwdkz1c4dE6/exDwhvEh+hPx3vRY6z8fDEf6aGVIXrHDvrmddehe7yMSIpo+k
aXHR06EEdfHCFY4TggYwhcJVXjkE+ApsVuyfmEfPmYjo8hCWyQyBsUWIOY03q1+MvUjjsmTwgs9g
fh5MY9ToaLfoJxPKdCpsqrBX4LJ+VDGFlAqIcqHTE2jCmPiToZAFXB7fzf1wDjFCBlJyFVDBGi0i
m+CouLSb7X1mvVhdDZgNrZDJMV688Bu3o54vew==

`pragma protect key_keyowner="ATRENTA", key_keyname="ATR-SG-2015-RSA-3", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
DaIU/Ddc8USbZ2mURzujJDWDH1JbHl5tFVOOQ2aVaUPIA71yyE38OXVLEtF8rNmujYH30nEeQ+FV
LVJ16aaHw+iiuaqorTM3K5KLohVlN+WlcEtSXHuPNHjw8ddqtzpaX7pH1zqZH+YmfCL5oaNLqDH4
rkBnUl0/Gm/hzSwKjYhXGQFYQ+gGP99OjXakzrAqZzp/Iq4gt+Z5902/JV9thd/isHQImJ0QyK8M
EKM579iPAfXGes2mbiNYHcvDmSPYmW1zlhOE++N1EKeea7j/msnKeyhlC+hGE4Xfn4TVvqgQexCT
rp/wS/MosY6WH1aKFQlFH2hEppA7KXUaQlvG+w==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VELOCE-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
XmWoAt4X8hrCJ5yTyug4ajJW5UhfkLNibzjihWzZ4Cr9hQSvWZoTc8rjGsLPbz6Le+/9iI5KxecS
eR0wiAO+G2IkwhZgVBeZdKoFnlnTVAyLjk9wMAFXNyJZM6b1NDbfXlPcUsC6JePvPlwwdWknkSsC
r3KvgkWAS+O3xvRmaNw=

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VERIF-SIM-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
Hw3Y+rShKrXiUViyNU1/O2qv6TgheLHBnFMj1i9MUGrHYqh9pLfLYUgWR7S2vj4jv4S+Ks0BpP4p
dKEqVAFmTCfQNEUHaVcFPkOHgig6L4mhLY6HUUKJoRgiQepgLi/W3V+ZZPQSQFkB3CU4MsJzhXvR
yLcpDriZy8cnAHD87Zi5DrNGBzj3kigJeM0du6lCQbxtF5aEdoaNP+YTnIFtcqYhoYnswQlYt0sV
HKgFA8VzqzL5WYnpH7+1IKmFkJBHkyqHCa9wPK0qCKnxkuDj70YzPVqQ+cocdKU+/gNdpCOdZlci
F2HTxrgfrXndJru3TiDqu4UavqAe0MNuFp3t0w==

`pragma protect key_keyowner="Real Intent", key_keyname="RI-RSA-KEY-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
XPVggoWL6aXz+MpODTOZhEUQDa0vfEnUDaYeEHXm2vGyqKJujN2c/FFAFBeBYdJATLsIsQ+BqoPc
pBbcFYXDBfOtFIW2dH6Y1OoD65KyJ/hAq8coa21kFgq4hFat5vzZ2iIfkCpTUr4vDZO7Xne8cZO9
WsHffoTCt5rS59wWm2b8I5R8Eh2TUbQg3RCyrcnD66cvcEnlXe1CNMQ4/loVJpA4IBinBf820Wjc
vw2fZbGI0jXC+ACSHOviH63Xwmn+aRV5Ppkup7IYoon/ieKapRQeASu3TTY37xSBXiInSdtMTzJ6
+4GfO4eSHVriCk/sWbuTBzfRzoSShrnHjzz5LA==

`pragma protect key_keyowner="Xilinx", key_keyname="xilinxt_2020_08", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
L78XuiswVcgO2gtebzL7SA9BC/jJGAM0v6S9pzmyqL+QYzRneiYeGyDmsW33jEVVSTuNjTXkBLY7
yTOKQruatwe4V0OLi6174saSAmPgerSV1GyLP7KhmusLV/N61avC9TPam+tekhKeE0tds4EnJ3et
4JdLh+SE4Z4pcuqCjB5MFneIYKKWDx7siU6oesAQtoSJOesfMchX63MhOjOHFP/ch+1gHv3T45hg
IGF7V7TrdREVE4f9631tlVJ1o2Dypsmo/76Itz5WCGlTMjAnWXN8IXxKN+PZ3dyt1wjrZm2P/td+
xiGszFnSLrRvw/HferwtSmRx8q0fiHZ88roGTw==

`pragma protect key_keyowner="Metrics Technologies Inc.", key_keyname="DSim", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
kDX5kq2QEe25429T6vQqBCFvV1McKTJRYfK99ymVNK2GGvGLXSzgwJHwB2fj9rM0wme3zYYY0vQR
x+9F4L7KLlOVY6qY3LB59uDzyXBI3mMZaS905HXHJkdZHWtQWpfHhl27LqL+8FSluaD6F+KFfYOV
CwIOVuCIp/XjxFXpNBik7YiPt4kHOlDA97IXNLnYUn/g1csGqeNWce4UTne50ggWvLYGbTFGmTjT
N67TpUiGRVRCSv8Tax72GWFIMFZk3Tlp68ZUSQEybZMWX1U9XdMdtxfvNGhf8mi5jQJ2SupSzKu4
T/+53IN9T8aLePAiGBKKG1ZBj4y1ZyYA7XYvjw==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 21632)
`pragma protect data_block
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
Y6kxpx1XyER8Qr/CVrJ6vruuUrUWkxFd5ukJUpU=
`pragma protect end_protected
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;
    parameter GRES_WIDTH = 10000;
    parameter GRES_START = 10000;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    wire GRESTORE;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;
    reg GRESTORE_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;
    assign (strong1, weak0) GRESTORE = GRESTORE_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

    initial begin 
	GRESTORE_int = 1'b0;
	#(GRES_START);
	GRESTORE_int = 1'b1;
	#(GRES_WIDTH);
	GRESTORE_int = 1'b0;
    end

endmodule
`endif
