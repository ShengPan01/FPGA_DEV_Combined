// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2020.2 (win64) Build 3064766 Wed Nov 18 09:12:45 MST 2020
// Date        : Mon Nov 23 12:09:49 2026
// Host        : DESKTOP-566HR3S running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
//               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ dpsram_1280x8_sim_netlist.v
// Design      : dpsram_1280x8
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xczu9eg-ffvb1156-2-i
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "dpsram_1280x8,blk_mem_gen_v8_4_4,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "blk_mem_gen_v8_4_4,Vivado 2020.2" *) 
(* NotValidForBitStream *)
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix
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
  decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_blk_mem_gen_v8_4_4 U0
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
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 21648)
`pragma protect data_block
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
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
