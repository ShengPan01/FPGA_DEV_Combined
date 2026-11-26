// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2020.2 (win64) Build 3064766 Wed Nov 18 09:12:45 MST 2020
// Date        : Fri Nov 13 14:56:27 2026
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
