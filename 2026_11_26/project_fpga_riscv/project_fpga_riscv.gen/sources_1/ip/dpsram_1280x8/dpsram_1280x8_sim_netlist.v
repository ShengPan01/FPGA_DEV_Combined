// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2020.2 (win64) Build 3064766 Wed Nov 18 09:12:45 MST 2020
// Date        : Fri Nov 13 14:56:27 2026
// Host        : DESKTOP-566HR3S running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim -rename_top dpsram_1280x8 -prefix
//               dpsram_1280x8_ dpsram_1280x8_sim_netlist.v
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
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 21344)
`pragma protect data_block
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
zZiW/5ZwyNKXppD3n5kE4l6fSUPQ4szLRF0=
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
