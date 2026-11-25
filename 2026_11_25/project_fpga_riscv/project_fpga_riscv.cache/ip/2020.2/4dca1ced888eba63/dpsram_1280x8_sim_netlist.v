// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2020.2 (win64) Build 3064766 Wed Nov 18 09:12:45 MST 2020
// Date        : Wed Nov  4 13:44:52 2026
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
  (* C_EST_POWER_SUMMARY = "Estimated Power for IP     :     2.05356 mW" *) 
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
n11GLv7YIX1sz10ihcCYTxEhaISiwyAHCr6wLxMJt2+Zz5JTSUWEgDoxhFp5ZupxwuMr3pIL1rMs
BiQfpjVP0UQM5RoZPP2OSa2fks6GZlmyP+PaFz5q73uNhDGk58hPIY8xldcEx1RIBezcBlAZxHWK
1hZFjFsHiTvj++wTOzAk2y9vuhzuPb5jcJDh/eiuRvGxMU4RvT2nOlhgkWlqaXp1Ht2zYp24VgzS
tphcA6g69C7MQf3MbvhaVdwN166LPbfbn322W3I3L91/wJQFEAFNFuQiJf1gGGWp6+zekWJLgwjE
xCQSbVlLQSofRTFe2WgovUUZbCG15bX8F2kR6VMruPMdsPW2qUXLVGJ9rOjyWigIe86IfDdUavfP
7GnGsYwH7KKImX9szaDllve82da/AKo7qjX+mTMz4NfDY5wMaX7i7Q+FbakjY5PS2IHIaHb0FAV7
sDZUAgG28rN+m5rEeh+D1N8J6XrGeFFnd0Pq7+nLDNeoB42Gb0dK75uVkAN2CZXBdY54JUhcKbCb
I7P/Ffslp88f23ad6bVxAVk7eP2CVRhFP3jOWCEA/fl+HmB+G/lG70qIvylHRt/gJI/humyhCkz2
CCOEcuZ5eUboIid5LKFRy95gSCkTotEVG7muTl4fdxFJ0SB6F4d7tcL4vTAh8kEp5zcWurIeB4rZ
7n/N3imsYfduWeqt2sdAz1rdNw8SYWK55SN+gNQHBFLOAtNTrmezPFaFu19Bd2pTfC2inotcCntS
0xvxv99nwIjXpPkmUzmn9Oaxe9yfgfhcwqrC08Hj0JTAHV2Mn1CmlTxa3tHEPfC4Dxq8kTRVEjPE
Y6NVtp0ND26J18kAFW7IWpySFvSMgx12IHNC94Ac1CeHUmXxnx8eEV1o2KXCSgfemKYHeAGnWllB
P7yZ37DmUHv7RU1UhciKCjI6O8hYfQXBY+HUeWD7mfyJGkA70AyU65SuxVSOX21VuV8k0rSCGsmD
gyxMTkMXsnEvg6KnNZEL/FM49kvfUDZQ2L0KQRcIAIPjeX63LDms/PkuzparPZCBH+lvPAXz3pqN
Nf+jHeaIvKsRZHAOTdjiiEILtUejrlwKJSeJ9kJUNRM9MwsMuhFTe+6QMzXEBd7pdpP+WCng33bj
YMXem/l3AViWf1OyrwOio6CpKzQLunP/h1jjAGqx8Xvo+qXmZhqLPNaDBlxVb+SYt7Uvv9g0L68H
dShEgtpZcdVai5ZdzYthWtpXE+lH2foWW4zEXL6cQUz5UeRgVQ2V/IQ6QTQTvkVNmZQeS+Zb5Dih
3aZmxhbRPwJAStv5bqpO2fhaUT6lYaVIyd7mOnLUU/oE6e1fKe+5yQuxVjs0BFeKUlPKaVnNUvBv
fkxJ3gucf+sm0sdw63k8xQoau+h6ats01XdF/0Ce3JmtlqpgeOLedi9WoEySFjShwgfjRLfqTPbW
tE8D070SNtt8o70C+o2DUAnn9RUDu+QfZpjsKpxk1DjFZwU5f1QdD2OmeFhmIS94DDHrMz3C4yN3
pl6HfirMO/ajZqF8FekEvpkBZyFnmZDENz92+r1P8W7UzADWGjFbOU0jbHAw9+g1LNw+JV3tbYgw
QddsCz7aLcBIjPJm4KWqe4WPFNZsAvjSJn/4YZYVEvGu+D5ms3rmY5ml1hxXDDrC5kzOXG0AGlHh
yvD/kX5oGzbDINex7vJM1puS2zJZvwKlXQTvqxUn2LHPXzRsxuHhQZy/YeGCNxSRTj/1p5FO7u9X
6Uja58BxXBnrwOu72tR/iTMTBiWy/VKPJXPJgS6EAW3XrbwUnwL6jRy4g9pC0cxrVhFpoZGBeutK
JdRNqKcwamhO4Pn/O9/92sTJrvgcrwKihsEveP9Lz6Etut7lH4zPs0rzkMFV8obvuhyp5NtJeVhb
gMUHcSWpxPBJMjXLcFZQEcxNr7oN3CZagvwviYBbl6nGzIpPwHoDQNgeMh45vlq9HYF4M8Kh37PX
EPjguIKtB6zES5UfdDc0n1lbS6YhTz0F++6u6QizWxPYJEatB7TqynbfKCe6WCHDalIxMmUgeG1S
VejCbUx4Krxj6gVOTTAo8QKAWEZSgFdzilf+iAL5aSvM8gI8r9Xgn4ILPpxKwrBt+AJW6ORQvwsw
ppRW8DkK2cO4kY6+DRB5QL8cpKl+BWxlHQLmiXm/FwIBHUXBQ/OQ9ZAmnpv46IhgWInWJ3SegZHy
FsKYFifabDBPLze+ePs0Csxrr1i9QRB4wx2/18ckCZaEoAkwIHZ8SxUWJ/3lZS35DOT8YyGUGXYi
HMzf9WDJypcAOm5o2Wf406BNjRJU1x6rCyWDjQjnhlOnRPPSYcXn+BnvcGCqC2u+wC0O6y+MleCQ
sr1dB2VgRF+7sWBzqEo/RXJae5wpuI/pG1ktGCLCbWDmesXdjogIfCasrbqLOwW0XfZEiwF8jgFy
7XMtyjcKHJ3Y/xKNsN73kGl16GMS3Hyhbttak7YwmQRfD+BT3QjMRnFg91/Uiv6Wgb8JfyHA1o+W
/Lw4XH3ZA8fk8aHL8E1kxYNDd/Fzw0FVfIt/zbzg0Z2sf1D0e70ICyGWzEqpzK4dgi0IN1fNm3t/
z47B7yrAJVhLdAoTW62izRCSC2uJzgYyPKQNoAnWNJGUdv99K8+dmsG12DLMo2fnjZIvoDrIRufC
VgcypQZcJqyEI5QNj478Znb86C1iXMkxmHtdn+FaSVb95EX+9cnkp5cKo9RZJ93v/B0Ymg6LFb3w
KVdFBur61cy14/0+wjdn8Z99++Uca2+9tllfE5opkk4lNt20v+fUcc6NgSZWVGIXs8N0GHENi4AB
LMe1wpwyW/nAgaR01oAbGxPF6DESJneHnBinzAwVPUu40wRwetakmJtmMdiVDkkMBtMWAoUGCoaG
X4petRl8LK+mCcqIMErqlTfJ421NXa+3iuVwpDZSR0prk9aGURsjtMS+6AteDIUdtvvpHQGSDdS+
N1rLrJXX4c9gxOo3ZwL23O81o5bmUmHTFcCpb35L1OXrSEb/+2hgOgD3nyO04LeJsE/Ki7y4QMkn
8y8pRYNIdhgS8diIFExycUxa0CPDzs8bTR7x2NFi38OWMFfoMrB4Jy9RZCMnLlu0ZyMbbRW8efIR
HLLu9FtMLOYC7HM8blL7Flx+sDtyUb9rAlNBw8P1y4c/XF08LHMldwduQzqUCSftLqdfE2K03csl
2VRGq46ASCSAlNdTvKlTGvxa+nOVrHV7EcOMjjDlQudS/cFBEkWvwBjMbHLqerHmasbcX9vvWeNV
TWgDPCf6oY5dJ//CXO4vP9AeaJRy79lgBNO5YppgkQUfLDb2wD0+pqEIxdOrM/8Yfk1nUEKTET7l
/C3d0BINy8J8LK9doulHC0WTK+/sdnmcyhY0SBjYX68qARlHQp7d8ax0sZ3IrdjWnMv09Q5ao+1h
Dn7UVBEpz1S9/SC+nCHiXvHcE+f/B17lbFX86ftiP3+QWDIY6S4KkRbLpdps5jpQKpRw9PfrQHlm
j6PcaOqJHmTqHDnUXzvVfJuAjChK9uYe7x/+wbzVQ7HzkgqD+tVSWKTOoyVBhbZzb0TZIBARTVpp
fEncS5YFSXTCQ3N7eNI+a1NRwrRMR/fCgm6Fx8nEnAnGjdpjfC0mT9/3qJcgglrZ0tN62bIs9u8L
iJlOpOnt5w4ZrZN3NKKnvrvydp43BGFrzs4I51mOTLKbYoO9EEST8oj7F6TzPu7pvkTKA9nStl5X
jtlAxEs6wyHIDIdqlh2zRskEsnIF2hQF2m6uOvFKQn6DyxsT4m8uxY/nlMFIgf0OZbzByvDmaHFU
67QH5a3r33OIhumksvux3BTpI+SpkqN20tVY53xWK6sr6M+512Qxv7q2mNUmnR1kQMx6kjlUlkPX
RwJGYg4oTdX9uTasCuuX21ne6HBxalIb+7b8KmptqENMUJZuIvrX/G0wOFbVvLoUm03yykSUiHrg
+sbJmniQzRD/5vCO+AwtkrvpkTnFV6Pg2bOQqdXFOjzdRvXwbKFFCEV2xTMx9um0tJkUldHt56EG
uB103Ic+v0eL4SOvJX4SHZOi/Uz86kRTXjAZOTfdAfW9rRxWwrOgwDjShGdJbxBVAGF6tV7LmJo3
msAQfQzjnnoIwtboy+kI2Qwo0lBwiyCnScfj5hIk9q9LIkLCV9+UJ+We7nVr60iclfY+Wpa37TPn
DSsvKWkMa1lXP3s8Gywq2VVSqQxeYJO3y/rSyi15UyEPkxAoBenN9FGx3thWYuQI0G/G2poHznev
kwZwR7kTWh5Lv4aKy1xuOD/Pd2SbnAf29QhmNfYpvA/KAtYj76Czj+tzAkxrXgITehWlmgveqiqQ
hWJ76YnV2uUYiMWctjAv1LQnzb1nOnmCDpODQZd9vDnD8f0lw9wKUyFRq8xnfvR3kC5ZqL5U3mwt
KLN7Ewl5CU+TnEwGvKNeAkxoCd/AEEvrplviURAKOl7E2RCVVMhETtFuRmAZfo7LFgEfBH7n1Fhg
nH3Vx+KUGYuCBkI3jgesXaZ/kjUvkt531jIrYWpd3Q3YLGAlRwW6tzqD0DktgEF8wKjYCrxVf38f
AKGJbPTZrLNCmWvGvF2bdUTe4hMktIOv/Dbo5gFAj46eRzRoRPCNTTFbub4cuPbBPxrk9eFZJMfC
Ak6qI3PoUUb8cS8cwwRBjAELE+pLC4TqO1Fc+6dbTSFolOwgDs86ubfU+aJPj5UQZ3u1x6SWkmiB
ZtmyIR2LJBnhCxo0UjuxWektOCQ9FjPjZkrTv610+0uvOXSv+85mbAanTRPjp78LpCuJNj6biiFf
suWNm1QfhgGpqGWimuqAld0fErMvi9V5hJE4HKiE+6plL8ksMv+y8SAt2LzqCxT6iIZS2/u+1yt/
+ngM5z8XmgsOihMXq3hyXpFETC4n+9O50v0Mat9fNbwsAghU4KszniBOllxBn5j7LF5/xSXuW92y
sqZCN7bHiJ4g+2gTMB5r6FYaPjqLBE4I4FaqLda2TbTnxClerke5QA24FCgMl+jneSvCEx676o6Y
3x8vQxC4k+FMB+Mbfz/RDquxNWT9V1+0fxZR3mxu/CAHaP3SK40uPxpm7k/hzXfavX3taluT+cJM
kMbZ9JI+hNN0noOs5oPa593YzFEGe3nvk43SVwS61C+WnvL7tHlBf3/bVg57KNldh9TKxpiuHRxG
i9vCkxDU6allQXlrJQyT8S69X/F3HeLRg4gSGI/b+ADc2OHDQc5XCh9+ejr+USv2E0PRjsKvzueS
2zweadjdeAxQAwjDaIKoZAfRSHbUYBxS2cWxvELiDfD0J6VjUu7IEUq1OHwyB+3Ls2hK2hVrSr2O
aODfvdgj9bELYTazXQyAAPuZx2hZdR2qd7qhil6kkfV3Z7iEygrHsGOrGnrl4eS4ZKvVEevzfYk/
p5AKg9z1+i2j/b7tabG4WsmuV8cKeuhEGlKAWFAWdljfEgtcKoIYmTF55yUZjD7WmyXyWvP3jbcH
fVDYS0GvBn5tepxoVkUYnJ+BdzuVphZnUKa51lKqhbQMikrTY4orrWLiResED/elVCWj4rv5OAVx
wd/+9zcdTuc37CwW3IUzAxjLTCMcNID3WKL/CjJi7iMoNk6MZ8ik33kxDABb9C9sQC3QvmSxxqFU
0l73dArDqOIRq1FtX2eFLVCoyKtbnJTUmsXpNLOjkPthkOX18xTgUFTqVjbMhmwEIRnxR+G67JuC
3iYF7Is1m1yqL2F314Xk/FV1Ob50idIMhO4l9+QdJj0O293zUOH9E71kE29noMStl3WsgmaAsg81
DllDfjDuWQVmPmB/MjiipIfOshoEoMDKn24cva7QKNJyKcuiEx8+VAI+UXipQqJiUQGgcdov5IKb
0gJgOqRFfVaq8R0FQVi6+cq1Z9mKvyEKurDfeD9f7bMNrr5hsTSZy0oLFDjeAcu+1GfbC168N36c
q8EIzLSJ26tDQaeC6xfepGbQCz/1HMuqfJLBG4VYV+6EHTVmcjJx3OMRngYHNNRfOfS5v93ht1EL
5QB8m2oU01NbqVfP+YE3P4e1wWZaXNlH7P9dnBH8hZ9t7M2wU6JJR+RCbLaZyhECMfAp8pdJL1WX
hY4LGvllz9JRnfOQLt/kDkPysN5o2r11CGFkfSFjBc8mzey86QrnjUhr+SMK2B9xfNt+MxxpB5KI
MUoP/ojD+nSZ8ajofIqtO5BkinobC1x0rHVKbBYs2eFTPQbp2Vk8twejeFJExmWdYMSGfzpW6fSm
LNk/SMUA620nZLi5EoYbhCp+PZmBH+MhubU0kEhX8TW28pSo6yg/85bHjlu0y0XA0gHOgYowlUG2
iknGgSSz6ECq38oAF2zhymNhWg4+YxMNibVRdGMhdofygerJSoeOiHufWT8Kw3a9hzs922sQouF/
n+WRlWintEpkHwLrmyptFaKLINfv+IXVrv1r2Byfgj3eqvpalmVwx43BU6YCW3382S7oLbO5uAeV
4fj6iT4Invv2rbCvhkEu4yidsYOj21NpDKrPcQi7jeradTHB4ImVcc25j5565eGf4iKu2kXeAT2Z
CNxmqA3ZStyZEVWh4ewgrvDfroCJ0L0o3iZ3gK9zgSX9LCqX+Kr8LiFgiHOeepxYR6g8TW/crpb2
p/89mFY9hgbFAgfF0JCd+/5qfzwW/FpYt/CIYBP9GH3pFR09aj1PkIrCDH0Jw2llxBy9T6rEY8L/
HnWrRuTf4bILsuUDQ47tdEqOnS5LAKsFoXEcg48tuLNApOifiE/m6G8JtZPubEGtmsDfytY/sAdE
PjyaRza0q+jua/kdExhVME7O5VS6LlA/O1r6Zvt2s1Txo5kALF08QTNP78wu7F+ftI/5wui3FpgQ
UNMQL8OgGsifywxtWJy0QX9PSxgge3ddP+j/8uxutJ3HbfFDykSthTtQuXUwKlH41EQ8XX++Wrr4
3iZR7uTOw+hohlI6mb342jz6F/kXmUFZ3ppkRVixhwS5XUcztEDDflCi+od9U0RT/LosovJBQxeC
OG5wqQ9Y5SwZ+Se3BTbrXKyuBqLvwFijVBEgbigvohWWZbT+HPyiIMAcGAQeaPasVZ06h2SzFCZ5
9kjxLvnSZBHWrNO4Nu0fNivk3mKaGmmtjhM90H9Qq3Bdn1kvfsMEnTGCuZDR0bgbhF5dFrf2T6qp
Jfx5UkUISgov3Qxp38wx4wwVINCb8TV6q4nrkx3DErooAD+0VWh8Nl/BLOBHggodIJ4EdlnPf4/S
JT4xfJzZk9Vo6fTa85ddsd65TI6Y2mZk6VwV1kQXulpa0ghZhUtq9woGLoXXw9Czqnx/CbxvDJJT
BsIU7Av7yRKTARlXEiQPuJ0y3oQaSHwl4PQ5BQS1wXMcZa+8NPO9PHqtKGSTZLTOJJwghVSfmFcu
PIQKg//X52FkvQve3Vy8+hWtyX6R2C6nmVG39X7/BecZlsOUktSuOlY3FjwmeiX7KyNipsc/dGq4
P/tuupP64HpueRvXc+6sHx9mTZN3Lp68IscvyFc0NaXsfm7gPKT8XkE/j2m/EAjpfM9PmHKYyl7T
jp53zKwKc0Dzr+NreM+Z+WowmndBAe+GgInaK22iCJFnWHbvDaRQLyrqCZ4GhJptpatyEU/PvTgB
zRDZKYtmfWBCeCj98XUZaQT6NICD0S/de7zHzN+OOGPmELSJmSSwhuxLT7dx87mUsyMTd7NZ4iGH
rN8a60dytDZyu+adRWhkhdk3PGQY0Y6GRRGsJ5S304eCvewIlQLcVBhcUy5iJS6p3UD7cw6zxfQM
C+Ei6143usLEH+yrwt9GTfxIfIdjBld463ZBHpS+oiT6iznE9M7IHnRpJnzzNDfMWZelBe5WHTbS
G4iJd+BlBM1/LhlPoHkm+X1jGcjP0vwb7SQmCGcD5CT0DUu8JIMIyh5Rt4gvRv8hgrPka8iX62+o
Ae2QdNNe6GNBP/uoNr70DSIEzvVshAE36qSK4TXhiX5TVtuH61oMtmUpWZL+bQEbl646R8O2alWy
xEKrcRM0q8mspJjiS6tw75S383/e8zH/6y+agS4IMzRdIWCTBeqmQwPZBjw+CTRPNJk+1UXeOB1K
aoFJ6o1CUP6EBvbJoMQJDuo/jxXhmcVUnNgof5vxRMl/syoKDEDGOZb41GE7T5wfJu/7B0lbb77F
DCRPbJ43Q2say6S41923XqV7V8Ab8VeRzA9pVDJFn541J28ICTwxo5U1hPVVTgmPuQNtp/OVMcPQ
vsHgTKcAw6EsDeGg5XIy5zKFyQ2H9SFAtvf9I+yB4oRNZOgQo4cQyHWo+zqm/gkoUwht1oztOEnj
M8VFE8h91Xw0+VukOzlc+15Ms5aq3MBGylNki+OLkBKmyqPLTlWFBpIPagQkeHgsK0P4Ol0T1XRS
wvW5TFl5TYxwGjGHbw03p5OEMpJNS3poy4kBdpJJ9NdAc/eAreK8o4Tm7l7eV0RfhI1u9jjor4Nr
8j8k6v0+YSNma/+s6pDTsAXPIcg0aIkQGefOlTKGhPB2p9QK76xk7aX1WiNbbU2clO4rewVe87vd
oF9FVl+q3r3gmlUasrqCa+YagVQl3Q1BW5tc3lUugd1Fli9U1BEbxDhLonmS9bQZaTdhgWZ/rcR+
Yq6c1fhfZzrMZFgzV1b5ybikpH25DtnLsjINvsJJ2wvIWUfa4QpVv4O9KRXuF4v166f6juCJYpL4
NH/EGjAYI/eY3VyKWZd/nJC5jhE7H2ReqN8fxHS3qk86hVjMBttUFR++75zufTihZFnTsx7EARJO
E/dOBeqkZnmIPMc4AFd1is8NjLcEBhsnHDoAyPxnf9nhsu81DMk7HQrRA7hF51Psi6CoMtKtvc3u
3GBdztIbwiVcxJz9W/qrpDOaAY/L8zbKqnQf82vBk4v5nfx6dPXW+DtdNQN2WGSloYrpIYqyPMFl
FO++/u07XCTAVuNMfeLKcqP1KnrQXlJ4ZzbbNy7bx4NQloDFA+TMBWTQx99J1WYkqavL8Fq9yJ47
y34sPWklFImQBs/E/Juggx7X7G1xmx/eT1JIZVgZc42kyEYT3OgrDjhdXCjG0trgbMae5IrpZh9F
Kz7XpwDHQFG8qe+ZjjzixRomL6LulhPERlRmlBTVPpz1AXCP04P6LbQAnijKVxw3WAM0N3sUalBy
WnM9MdIOJGwr72LRxmXuQDn+83fatLH8R9aKseVH0zvGZXOg8oEUVmfg4x0N9zKin2yE1sX3sXBV
SmQI45Ym4fmo7ZjyO/aJeyT9MBrGbXAgGyCyuQhV7pD96pCD/57oaBAM2iqu2XGFJMTtvGXMZx3X
Ob+3AEQ+86CNZneyPdrxa5bgZqnNoVpVaWky9ZTMnmdq01n444j+J+TWAu0CbIEJrYc+xM9W8txp
xprCi1LKdqYcL4Lku+R62QGBLuvMQBC1Vj/ooiwTlDpknIPuazncEPx2JQmkRfjJqW8dBeFzHP5c
WvETiGXzB7HJ9IbkUVMTqcmhMo6q82DhQRDgTGW17cTsn5k3y+nPZ9peJb1vTcZAczdCUe+md+WZ
frQycnkd3TDH+vrOIFP1s/8iMPYN4HSPfHk6Ye6WtDRF3qELSK9pI3dDM/XrkoCz1g6a65D0DMK6
yrabmc1ZFI546r5sUKrm7g0zJRgkzuPMfwSJYN0u9hpJLNzpScEYJ3uORqc/O40+0WTB7DT3f4+J
V/sT7HhVmPrF3p8kUlB1isOj3XyZSixNyZWmcFzDgkxeFnX4BttKT6i9vPwB0GtckumY5LJWErtT
iCHrg6PN40mmP+qJteIzbQQgIoAS5qGnxeVj4J4x1v7jeg107BERc3UpKoPpmtiNzkQn7C7X0AV4
qlw6P81aJcPqyw4DrQwwZi/jxC+gQPLBOr2/0do/xsmqCPNvS2ifibtVSv5Pn5dPFhimbmodrFRf
DKHlHK9F4sUtBEJFxJN9CwSMVK7Pra/wBUmBq0zpQztztS3pBIHklf/seUM9QDgrFgA9NKFkiMKq
C7yctdI4abSFZZuiUuRO9R89dU0iSUO7NG32cdwZSqQDfB8XyVELKLWkTRkJnjmgWiQ2CuMJku0K
Xrv8Q6A/wdwkLRlCiN03UHivxg0AF773j+IjX0jinkyQUImSBnBznNV1xSTXY6NZ54ybqvIQ5Tt4
v/Q73GWMfGAhmrnHVeFrlvOE4XTdJnFBw3n3iBqrxLfhg3vy0VQ7Eg9KSmr+hr7rfB6Qab2ycsjW
EpH6h0vscHG8JTnjai9QOwlO0Zt8RyVMYh9MPEoaGSQEEfg7qnANHhUPaNlfLR70NR5WSCSUM8tJ
YTENWhCCD3RLmoANSYaRcDwFrRYOa/IQ6IwtISuvWP598XqORwhS0l8nZgtGJvDY0nm5SbjRRGFD
ig++6QIQLEzXjIkvB+D6d+EiZk4HUfxs6GLH8uQINvjroAipX4z7PXOIARU/UzBEzPWCZlnVNVTb
1TlsDMx5nI5k5hQdsZuYISVQqynAXfbdX09pak4g8xJgRZ187JUI95qVFN1lj0NiiUl47FhT8OcD
jFGHwrLbAA/uoltzo91LDNSij+9ymBmUvi8BfzxDTkdIu636eOdjJjB4i4/iFTv9B9qzUr5WQI40
NwoVkrFEs9O3rIIv/THdT/5/yFlppYqNxBWniTTIQ8J+W2u6+vhvBSN67Ku+wicEGVNPojIXsRzq
V6Eo4L5DG2jrBKfKCUadt90KPputHmCHkhR5ExH5ZnNdYzVJu6X2RhUl4Jlg4f3IBn15BSVt7geU
Bw55N4LRC1/pN6Et+KXib+d2XGR20mv0VpCq+hbrYxCRy01jv5Zl/aG57MXuXdXwX5t3BRS1MM35
ykbHWAFxHh05r7l20fS3MmSwAGFgKTSTwYwDrhjjcOv+yHNl6VzmK2uXlsT3KzAZw6JulRJXrPNF
4WUd9p7GMlNr8pxCwGzqRTE9d3i2dnclAbSAKnk2iC1Dqvf9PpoWhFlT02NFcT+SQpHDFprvg0zF
zTnluXiwjn6MNsfpK4XGUWVbyhfkpKPag/50QykpDAImtfmy8F+7VHtnoljpbD9D8WW6wD3MGE3+
Nej1D1aE2cQlz1j3voaheG3PFvtPJlX9ENJbG6wK40VXFawqhI3gzkLRMe/SXzCYsKBWGBmsKqh7
ttyl9osxN+n2vO7Q3gPxOaG1xwFHsgjokAmgWbB7xbgoc0IZxqd673+fHVUBMd54wbciD1reEEkf
/qF4rRtKYr2JDZ7pGvM6ytYSiVn1MThkadKaT0n2rMqH7D3/pe+uzuR+gAadqUeXbC/WkU/w5DoD
MLHluphHiP8ka8bNHRI5GivEpCya+WHXXFrblN5ChikFYY6JR+kVMxhfCUUct/KO5fvDOgJlr+zs
HpRU7bFkwe1mndrdCfEPJ4kOxkdtv54tiEgaE0J/dAgNFWfawa36VF5eM5M1Bt9UPvQmxo9ne9GK
Tozsk/fFSSVDDp+GjmOrbSrqErYaipdlKCtr+7JBhNiN3wAqPmHTIUD7a14Gug/9YQM5MBrRFxCp
lPYjHSBwfdnOzNAPnp4OYfUkfQbz72J4RHTB1rjoVd1omK5VjVuO+Y9urTwQ81uDHgHM9lExTfe6
tQoQ8O85/GtQd9Yym/b8iipfeAzCtAbUCVI4Iy6tF/D5JzaTYBXfvai89DwrhnfE60K+Cxc0DN/m
eje2zmmTkojVk+LAB1OEYSdUpiTCzbz6AdGrI8HUnz//uHS3+v0K1ktMAIStU0670yWmYYNXjyn1
XSPY9P/xJ5RZUSuaLz14gcuSClDzdmec9e98eN+5jlEj1fDY7+eBQELqItpzcl/JIk68aPKphcJR
eWP076WiYW0XunEz5BxgD/JsnNsTr+3WhIcdsEycWCAdYX4EADu1Lhzi8Y7v3VmWfTq3d51sZ1wr
uj9Sh4dZFeOm4/VZx3zhbLoQF3mpt8xjWFhtfcA6uYgiVtHecdktWzfIuqvT3rj4C0oAL13O76fM
GXwlBT7zbC504y9uuWAkF6wFoTO1ncWV/MJhXCcNEJU22rO0XCb0m31VQRrmmRsl3oH2z8OzuhUq
2DP0n+WAh5FHeGlZkSdlQf+J1bnYdmuU6TMYHB0OSF7QPGnZs9ULdjSqk8DHrZrMXTb80VFguGdv
0/kh6WeLvGRw18cB7D2dQvl987oOGfcNZ+hf/zknOKevplxKLwAS58dsqdq3h11u2qdC0Mz7OoHa
YFQr62KDh0Ks5GZiSgda6E352K3xKyL3e9LknZoCLjWUgAnrEV6CCFpxd3R8dHcERF7vpF3Z0CWX
s86e4AjZxruraiEQ6Mqw8RWTepeRPfHpT+UIUsuiTwhaMkHfHubW22pWQV4aHVr2MBjY6vVeofbx
uRW61G+RiipRrc71VYxgS9R3dZeDrjwOq8YItfQliVPGDVPFHMScmzIuk4lKT4wNHoP5V1/5Ksi3
25WInz2bF7hwbG6lWi4WCkGMkdHeQslCnj+tFOE45DZSGbQyyxUigOXsXIsQHaupaVCtfjkI1TML
QklNH8wof32YdoBzC4vQwPTA6sv8GMScjYJuY3WcvnU79LFVNvzdwiP8m3cI4kgopMDZ1Layhv1i
ICabDiazpD3abkW30fHvP1HYShNLYhF8sVIHltmGY04lFHK6nhBZXKHYEIKnnaICcxyJrZ7kNvvT
nT+0B+Yb7rMsbUzryBd2jSbLkkIKET1Q+jgnsBfYxPP3Ct9/c5x1R2+pP+9tCZ6q06VWpSyDaJy/
LljJZpZp+h0706UzclfPdeH+drVefN1VckmsDZXy7rCiprGWZEzOa9vA2eLXEPcEPb6mGWexpDoL
qSpYE4Jon0mdp6XZxTNP8dAH/t8is8znoTUPJSNaHeUh/s+irciUIbb6xbkX53R7JT1OejN0SLNu
cKPCPyWydyy631pM8e3i+fdtBClSAu6PfQl/LfLWdypc2aZrDRWL4a3X9b1kQOgXsVuY8vE60zVo
cANNm5bglGKwY/ZeaHpMfehT3WciW6HnZ6SkltoCxL1cE9YYuIAuC63c50G6qHiQ3+Zo+/Atf0IG
wuj2E8dgkoj2wafeFU0tLwIYlJqxKGYI6M4+mtd3bUEYMd3xdad8faFA1pSc2nq7AbmokDZXGZat
UN7Vgtn+mV2BoFPINFcKVFIjjg8jrJYwVD/s4ZdVJzeYfAg5KxQSr1+IL1FLqfnfX2/YaILCf9Pd
EYO4syAW+WCG5q4NBU6OVXEN7HNVdtzrCvuqPhYE7Qm3CVm1+j5CsiCaekb8iXYnPiRzCh9SleE5
gKtEXO++t0xtdWXLA7nS0Ml2KVccTBz6rZ9afVBKTCFbQlqhcNWMPgbv2NrQgJbWtvd6xy+q4IU0
KXMP016Y1TpY6UP2P+036cyFGugsVoRk75i7+wzPJnZa5BHHY1xALBr16Ggw5ekCfb+HpkSr8LJw
t5+LSH3R1iix2wvM1r/Ew9Rx+cbxHDlwcXLcFXPqDz43yz/4+5/SQ/Bjwpj8yNlbPNleby+XBGnb
G+jbTqYJ/ThZwt5pGQ79a/DqQ4jlQ4Aj/14Zwn5K+3P0X5L+1J/O1w7JO/JYf1lMx1rUwgY7oYpH
2+S7/Erstw+oO/UdEsc4KhKRjeBBoMV9kOSnWq4962C/y62vN1tobhWDDuh1RpyD7+VquGDoge+r
cgz1BIjMQ4IZtF1TMhqfrFtUawA2OT5uIJmDkA0KTZYWGULGsjuWjwqM7HqE2kDgoFlUdLjSkVpa
eKBdyFls84Z9flC3SoLte+No2pJCPAfugguwfg6PVEZlDi8UbnM3HqsNKCyK3a0CJnkZxYCOkp61
6IWCaOljQxcXV5P7T6WBJ1g5DAfSVEL084D0p0eQeLsweFjVew86SS/9J4HkeaPium1tsPhhwDCB
wWX5gqwtGj5J7Lyq6daZ4zO7QtnD7WhfgGy3SqQbqhLEKbNTuIzTWdcByWOP7qXqnmi3n6Mozhbi
YgbtEfXwVtGnI1QC3j4QdiQQ6gd/v1eX48BXFlF+wqHPwaQsUJ++oC8okhmBLglcYm0VTG1MNymD
LqZ7HjzJcfPl2elZq4P+QPdhhPrQmcqhG6dwiRStF9AtyfMD4hk/lM9FIt5dvb5E9nex9tBdVUns
lyYwZ0rS769NhOPa2QZr3Ve3GnIwuBMRKaKl98CxwlqXLF2hYx7eOhy6S0RY3P71N1GfjHgUak4J
dzyuY6Th+wTdkwK/MrGDVRg8RvJkKfrSEDKpGkXPwaNFBCvQBlNOXcy9SeF6N/dj3ITsEA8BlfVy
WgczqLtfr//KitlNzAm+vLX4Yft2hqbVab2Ns8n7jSvAYSnLRKy5QvgKHyW+voKKDBmvlFqPz9+u
mfbpCuF98CuCO4j4dv+6p+XbY5m1q/pMk4ouEI37x1U6EBWYNpT0/ytJVj2htOD82gUFEGk2DMre
vunycphUSxS7Vk+1f0StcZVmv9hwcaNilsFXwv+w02Jnw21LG22PZnyQRVqh45Lic5o7l9lPkjY1
vaXyF+HYpq8pl4XIqLqKjNHhzGy57VadgrWtAm9pPUjPTo6NTwhAot+7Po7c0bavVzsfjiyhLGzS
xeQI1SBICN2RdVkPtGbMcQZVoA34QsFBa99h6HgruGsRUAR77nmUSUqAM7DoZCTePWK3GNNu4+lU
VYqwisADHBzM6gZ+UMmE/3ucSJRsZUJt9Npxb1BJeJ3vqb4euVtX4Swp+NfrOVyrrZUzWpm89Uuc
gr1zCWD/VRjj/5nScUj+LBU4g6/gfKbtLFMtW7EYajyRclw96vyvmeIK0rQsVFuK5scbALrNj55H
y2N4ALkpXunet9Mg5we99Rsh4f9PR/jsPVYPKpJsa+Fr6V8CI6I4oSsxnS2S0zZiKD9K9xCOhpiL
2FWNFiMR/fXsBJXt95ktG21DYWSoQKWz7J1AwXYOLP8gLCHfIS/ddrEaG3U5ZpDszBLPnZO5Sr8f
yLKGZFDkWgCuueTBlpA6eTmyeDo2J4U35DkJ00jNLswQ5KQrEbx4MKhWHZxUueZtpcxHk1k4lFh6
mDijqeNLHSbhmggyW3oCVXuHkaO67r7jeTUesVx8vw5xvoFDGdcmwXwCXzvp1ZlEN5c8VNINHuPA
MYa/K5vwMaNAcABFUfBTx9UQbMizpQal0nqFpzdIl2b+MSrqTKUTrNpT5p1UennIpyfabsRQAVaq
9roMXXNEsh5IwkJpY7gyNGyhm+x2/5eTxa05PoDHmdEaZMsAX0AzE6HS6rNWcoaQAe7ii8HOmFHE
9hkFjdpCDGvp9b8p6M8vvI0oLQVZPCyHFHbF2XJyXfR84SMvMnohqZTiRGVP0xd+QxZxpH3NgBED
n36tvK6IeWlMD8YE7hC1WRCj4dkO7gWOrENFA+eC33f+vt5Dcsj7vfO1CTCWIqKXAYdpzz22Srpb
RFR6MWbEjkYql61KDYzC4zvHbEh37SGrX8axx4cFJlOCGQptIXCV0TSAXD2LUe5zAzt8ycV0U1Bu
/yebDlv2CCBtkg+Gu4gPON87MDJj/s6OZJoVFAFm7sm+OIjZJ1u+2aVvo71GGmuSIlFGMeEeKc7h
p10BZ8VbgHBtelbyTN1pL150cQUMvEkjnX3VFTIGm2sb32LlbAj5LAqn5Z/MsWIrf7dTZf8RKESA
qKMRHnXRYQ0WbqHXrrz8oXe/UsXcAr9roxGzvyV23zJpZ9Mqm31UoHO69B5BApXYMz5ZE8HjB0sl
MZuKPccWfkigfL1w3LfDBHDmzz6P5KH2i+sLax3MasDocXRtL2vLji51USwPEUN7fzWDA7kOgbf/
/hnATzp8wbmOoZIGqI5JREjFPJAgSl9zSDBwIMrm8vYQHTpKQsOemjcXBVIM60MjR2EcBx7kVIzO
dnh7v/MH6LJ3JIIlv2jn/azag7seE81wmylLWbc2vrNnkueC3enBbUonZ21HJHg2mGHgHMkKqqSX
VXLEjpXBhHWDysT/aHEbe2naopHIn/Bvwm9qgyjG2E7U59afosTiW4XG8iyKMXVE+2lfwwzeDQB/
fP11DJycyYS0fo74MySO9dcr6h9jBhzHWSgab9yEhKxX5Sofu0ReMFjC8T7eUmhQfNKjgrLl/e+t
676WxqJv8nn/UoYeHuzThdzbV8PbyzlsTw/VIUE2MQi7Qj0/ic8oRHlF2VI6NG3wnXcJXf9doMtZ
bhS7geJxmVR5EglOr2nhn+XnFFfVvtgph9X+y69xltNQHvAWlsrU9DrwCWMS69l5xtkarRdaBLtF
o4ks2ENYa6VtINdI1gPoveV/2rS8EdwHwMEjYvIb42p8L5eY/nzn3ObBcxCnB0MpLBBVLHdZM7W5
8Wp92U0VBJt/ND4SXMXptHqTumkNlzRRU7AVgfdqPvOYCpmDLZztBDFIS1hRMcLBFG6dauShS2mW
lEew/HjtXUmDMcLdxnZ43HWYaPPTHz2bYbkqkrE4F3ZLjTPGUxB3FDJcZDzi2oH2mObvu3g8I5sZ
YwKzVgKlbG8JF9Sg22Uc8PRcAzy85w+UI0w+1/VHN465LLDlZ5ENoiDh7p7R5seGBPal5H/Jfh/r
v4ByN82u27qiX36akB4Yg2hUbYbzHXjIT2IPnaKExRF5grcHh/hZYy/BTZDIVGcQHvjFRSaHfxl8
A8cEzL3wV+030ZGouBmPPhpOxTh26dGKDSiGcF7qaFBJKpfdPGdSvxdqTsadAPjJP2usi9XgyfpR
WHm9zifRaxNw9aKve7pe1CbVQ2CqBa7V18tHMD4wVQvZ8b0lIv+K58KrBz/eZAuKcsa4jnb0c1AP
oPDkq6sdRm49IMVS/yyil49ugzIbVPIrXsQsGaLzLhXdApMqHmHgnu8pKvfRRqNLnqqEhicAxjhS
rW3yTCHhc3qftr4yUsVy6q97Z823bsIOJdKO3T+PxKKcPNvldVgMyvItIHTivaC4wA+gbXUojr1X
Rdt48bUII9LskYaayVzZPXIQHJIuxmmcziirGLtq7iDEkqMV5e/oE5L+NSBOyd3yHdOcjeSKyGLR
fEckR5AUsmPaJhLc5ufe9FYr4msm+7QTI+xKYrY8f8d55vDqYTe6UPMtTdjinmYpcNHGnbcIKubr
gYM6jFl+Tqf4B3zk0Hlh3aHLLQ9HJqEFuSQOPbvkMd69W1hKOWbc9ezNtMVAWtwvVYtaQ6qXdAHP
kOlTLqKFOZX02+DacrDndOxk96vgin+53+2FUwfgBTXij0VriRcjWuVN803p+bZnw6wm6D3sN1aF
je1J/MNrRGg6Rpxzss7aKfY3EDtSEd3kgxtAh8cDQp+KI2qnFIuIvO3P1J2AFLcCoL5wD+yqL1uF
U7zNuIuIU3yPjnXdamIeKFWtOmfkNcg718wvHAZUjsz4wn29tGL/8T0hOJjklbf3B2ApyC5VcinF
1CrN9dORp+Ajgv2+uLYwblcPXOAhTpnceqVNCuLSVDcctFDa3T/X4Nj/Aokgay34DwIVdSjLBPNS
7qr7CjOk2Fnt6Ywjkyg0fr29Kana+BJt5GI7wsQIZf6axnlobJOcw4BHa9PHwCklghZYpwIu14Df
OQ2uRkC8epzmP2E0iIFKiQpJDiIEwZguiR709yjkHK3W5Y+KSW9gq3HoWerp+mHDW9NL9RHzXOCE
Cqdy4iGAx+P5+y545BP3CDAc2/iVeV5zOVzhLMc3WKZHiCjDGVQfUqOj6WNzeIlEwOx+N22HZvY7
mwG+cWKldni0CCx9/uheAYBxlhjhV4DKLQkwMTT3LZMFEbFXbJFJuaHALLferqRlSXE0RVr2U3/M
Totzl1gVDH5Yv/k7AUw3BSJjWIgOEA08rDbPU0Wt+J7pJdh/JG3qBDfXuzQKL9qu0dRTFcFoNaRL
7+yNT/2rsqzDdJL+ve39OVRZXNPSyvNb9FlSej5r+tgFD2fDjcEeS6a/AB6UMrHMZw6QHV6pz3lQ
PsCM0aTMDfuep3Smb6qKGLIx8z83s3QYn44zElH6s0sE1oJOTTyXn/nRAdY/qqCWrSi9q/G8NthA
+8OaCWAocH6OHb0prHB/Ga3M2gkWZPDYBarBEGl5+O6fTRxa+ED4Pn91HDEdtEGzgzK9crjac+4M
88ih1cQL/YEWwImXYKLG2KNma7NcJLgbdXJHFrIsH64eAlH0EHZ9eLJ0dxi0XYUTQJO5VctxCp+X
Ouqd9uRSStIOpe+5HkHR/VGoL6kL7fRa5xcEkhm1HLrsu44vPaGG1QSzVZBBM0S1Txg9qBbxPtpY
9iZwsx5kW5ArEIox3kwTWxZFu5MgsCEnQlp73FcQ/1Pmw1B15tNto9LDRBONnEL01SrN73nGn3d4
RDFrRi/dpkhhT149uKWdHyBuQCE7mVl7vTdANF3/q35Ac2HtxgF9xiT2YyDR/YRckqUFOJAsNUXJ
zTZDVv4/jXLNwiCN+V1S0ZX55c463LkGlE+cDckRsw+IoIvN6tPegZp4XUh0PXFbQWgJhGBHouth
ZXvjL7hnhxFh52u5iz/LaOpXNhIrGcyxjlHdzSZJflqKtR2oe8xseVv8YIGTeO35O7vWdKbN00SR
LPRF7o7IVMtqgoLa2T2aUOltgKcV+A5uNnrl7rfCNncMHkGIWWITQlPiyjRbCx6/O5BhysHAh9m6
efm3uO3u3q6pJ6FFW75iYhZaK2QMe+agqtd6bERDscc5mgFl1+NBGYgHpNLLteV+W8xSjZXIT8Yf
oUJhUyqr93YxlgrGTzKsIwqVLbMOXXaugj/AJUe3ecDzpygt4hN4+HDLmzd3uFTUQSA2VQQSPC36
GM4WwbuYDZF+ImDwbY79+dvTTFerT0i7edC9Pb9K6h7lF2h+ihVUOBew1nh51JqwzXqFEGm3MDA1
DcAoD8H4Y76jAwOuo5DGHbPVuRES/0GjCD7w55IECJ+e7Sr52EDVorlULi6+evBLlI62IeXk0a+r
1pS2+lrENpnG9xbGmqqm5JUPjBVPHc9o1W8jPuonCbXkV7db+lhsRhhgw2UgPey6KLW81q1JSnFX
jpYwFVVI5ZMpbLNhQXoGSDrzMFfvLvHmmPg+CeIc8MGmmyaKSdAjpzVHXxlfMlX3iIBh38xoLix5
OaOVjgfeAd4GQ3UuWKexyZwvzrI+LEmtXzjtfSUzQIBvEdGM7Cwi7V3MnAHUe9d2pmVe2QwiB4QH
oX5vgydfkJWnkMYQfgdIzJS2o7WsLVYBJB8HI5y+TYcbgnIM01ZWvZTYLQJEi1oCBNfH06VWE2rm
RX2m9wPp2fEWTO0vmd+MIvk61yWqyoMGXnu27JWWtxuGOVdzQ0HnI2fVq/y2uSJUgbBiQJMyvlr9
k/TRqLiF172uPEk3CwCeaxO/kcDAGYEXlhsTz5B/TRxe2pNRa2t6VscOylhNpfgRdEvkAyn4x6IW
elZUcM00yyDMXinh7DPJ8RqFIZmSgAzX8t+War0rqoSwtGlP/qdNyFIiiq+5uOiT37W6lUphmzVw
A+RRs7VLacfv7sH5bz25ZOAziyM5TVDwmBffXxxxUdu5cyLfKLd/fQRfXghIFpzixz3NebCsvnJt
408AeVm4457wkhTOAP36knglC4peN/B0SLDFDYA0Oe31ltIwHt4bklbwdCLEGDEx2ck7bJw4LHTZ
h+HonqMJfVDuhEc8OoaFtlW2ca/SEXKwjCl9Lr12PEePLuAD41HxCAfPgsqSgiWkSMrZLgRL9nI8
vr71RIJuSGp9/0DliKCkHG/6HAbiniMsmN4z0r7mUgMGKhkf6QkfMqbxuYmO5E5mxvHPUyiQ9DYy
Ihz53+P1kyRKFVzxY1cTQmtGBFp9CMT6ZPQJ4yRhIzO/CCz5CPDir5KIyVPTP1Yec8FvbmRaZSA9
fd2g4x0ZHxp1ZzvxJyM9YIkNQyQNXtlf7osX6i37j0fy5S64AVqH5ro0rP6keDA2JGO2xc4mncE0
MEOboHcZZu2+gAXURibEKESoE4okEtSk2j9EQou0BbVeW5t1GgUO0knM9qpag34Sc+kYrADK8jUO
Cn/UjB+hwuaxOSluvZKMgwbNKOoXrLsnFDRX2EE05iEK0euBHIgoVcaImppntwxbf7g+pSU3x63M
FcxVyFUJaIGVFSepVK4MTuOBTInFyyRYYXrZaq0fd1qsqPzWyWkwTL8mXZ9QbFCUDNNXMc1DLlrS
WghAArQK7LqpZHzUveSHWSopnZq7jBWocKEnKvfwmkZuvKQot7WGaA6LzBe2XsRhLZepCp/WmkqO
GtnmODtsk38UBgm1KeDoB7myDMgv80u65fMkkCfuVcJec6bbpiDXApLbObH/u3E5IoJuI1RuSLL0
XY67EvFaqFS0j3PGuD5eEOW0k5ZpT9+Tw8ECwYZAP8plARmYDBon4ftGDt+8BIKwTHlCf9Qed/HU
xI41hf3nXg+KWULTgH49MNc4gyhDUP8q48OVH0IxeA39mvNan3kmgpt/1/xRwsCjJhAakyXBjfW0
A68XKGgZZfCnX7AGfhqLv8fbTc7xP56xrk7OXpsfaHc4KVcIXb51qtd5YbI3VgNM24P2d8Cseihc
Re1sbSm+4MQV33xlTmkGEmfDGPcnQNBpmfHvVu1rlgaaTvTweX53/mxMGnQV6dfo2aK3M/StH5V8
MrMRERokyK4e1jeBHUkbqxmD80lN6OHqFbyR88DdluqJOBZtjNH/DHkgzOtAipI72fIhAwR8YVhb
j4ODXfcQcIxmB6jNG+qx9jGWIFlgah7a2DHcdpRwvHbdCev/ywBtCXSyAIrdcbnIt/Nvw8H2BTWs
PwAf1v92pEPkF8sk2bsIbxdOu3V0I08YIDwvT3yO9H0v2ak7MShVuU+OKGslP8KsU3f0YGSWubFG
7ySVTTDy9ZGkowYuN3nRePtJJXjO9E9xILYCS7zQPnyL/ctCzBpu26bbhCQsf/Fx1hnUQDqb4bev
ZwFC8Cui0Fp0jMVCLRRhFkf7tWgxPsElFvwRpPDtV3/7t+jlWp132+pw7Bm08rvpYkJXbIB0p2GM
wjP8TYPDI9xBd3/Lf0rf22eSzH61G/08EcdGyA5wuuvFrY1BMKjIgLTMCT7yMR62Z4IUvV2qsQ+r
fVTrq9zKmLPXOpUA9l5PPz9fNlsek7xer5zoS0K0PN/c6UDhWWpTPXyJ/8QiPsEChV0e7pH9ULJb
Pe1two1y2gx3yIFqi3uTAD1A2dwS7XBNx6HxcVimB6rEsdDZoTtuSlCGYg8eMCkVC/3RC9/h5d6m
adq8ma/wMtSam2t5tI94FtPIlDnEvxaGDJ6tNiQkKvt9V3hzPe7BCwbR9YdxNlXkk4XQoSaE+SpU
6jn+ASbze+6ANMizPpQ9YZU6+nbYOi3eSt8TUQ9p1pCKB7T9AFOZkjzUm0ZyF/HCEvA7pwBVvj6a
VZ/PeqyP5kP84sw4mpdm+phlev3/oULPwosvMgx3KRuAsG3PEIoTszEkRFXbz1DLKurkXuLIEiVx
JVGrX7Uf79QvGjJ12puxLOAyCEO4i7CExczj84CzwFjL1Wp9pbPyQP0udIdISDZbx9vU0R8lNRz6
udhzm6lt9kX2LcQOnq5BdVVCNAms3OxUEZ1j785Ew1IHsxRr9/KVKrJ/l9F4XvgMtnsoe4awLoDU
liLPp6Py5l/DG/XDWVYDjYjNN00v+Y3NHAWs0aB7kH8qMg+lfG857ataoYQyf8Y3MCOOXvnUrufW
1dtQFo/aJOJWDraDaoF/xTyolLbDz6jswO7EPrcynseto/p7pn5K3Q3RgNFqBRTZDQXzWwOsr+gk
MN+Qa+/ypEu5yTR2g/UpwRC3EZ4U0vJyVIcSn/1HSDsqs98HI/zIgrm8+4GvxB0uqVleFgUkazNh
UV6/XT20goHTrhfYIuLW1FDGYduKWPZKTpN/baCfL+kDpgruG8geWstPkt7+9ldznj20ITdrZEV4
mEq016UP/ifbCjLgTBuj2YTlVbepyvCpD+4cJvxf/+t/CXAsEMS3Fd2OkdJ/lrWC7Md3ka+VDLeh
PTMhScWxRfYG4A5RI8okZWWwIhCSzyZuRCnTMeP1h6Qr23Pf9OpFrvEI+u8+da3HAl/B/xCjE84l
wBmEXFJggTui+4US8zqWEvZybT8+oB/YcUK2x7FJxExGMcLfZnPuH5GGZDjxyKib1andoDHkEzZA
Nbm8/18d/Nqhodhh3wuASDgeZ14QqCHmuohpozML8QltydfePhkYcZOQvQM9UBEgudD1ii5Ghsn3
oa5+KwwN6izCvEE25+1kkq2PFN+5ImENk2SbiMFhZSWr4S8T3xEYlePF/kmzx3kNZhAmWS0z6flk
Pt1myMQkSE9O4BEwfSdPhIkECsS+7jlPiC4bGavZqYD0E0iC9ir2s4DsGk2jmonWshweAykHSJH0
aPHkbTajWF/B2cFJ6lOJ2Q3s3DpUGFbHlFNyzWoGKA0fR6SgTmkT2pkVpavNvkB2ZGUx4LCIVgBe
kySs/Kd9chu40vmKIrxInXfifWlMTgpxe+0Ze5tIM2pJQpQ5TuWQjx4Dfi0ZWCegVHLdGEzjfkwq
/CkDliS7pGhx56R7HkagbcIsXKqTmjML0na0mmfM1sxcB78X24pdJk4FlWObNwfiv5tA6ozIoAkW
0lgyI5BozjHs+rdmfs5aDNYtvI0Ua4QncRPfhnjkuws5LFM/0a4IUeq2b3maPpl23McYQQZ7I4t+
QebQtgdqZZjuN++gWZ83AFtDqj0Hj812on4eK4GDl8z9eY3qPpmGnD/Eovn6YnuV+NpFd7gSZCar
ELs7uVV8N9TZe64Znz9TYHj5ABOj8iI4xA106m1/DH8TqoK41a3VSexRDW53OtaGOyddeaDHXn1D
DHXJ61RZ4HE5m9DopRJvi/8hxaPeK7B6Sd93QPcbbXDuOs14y1X4eZLouEIw1LBgiw32G2RR2LU6
iip4BVR03xD13079Uzt9khkS6vnJPSi0s/DRgkDcrSPt1jA7E0ssL1KpyYHirI1BjxzfhAdS0Aaj
J9dECSR6jESPxXQOv5VRrpWywE20Xg4yBAF6ZoGWYFLHWbDzv1Bzgjx9sI2syNIuky99ywy4qyjg
cmPDsMlr3Szc2EpD7HXKx3uVra+pluM1Y5sjVSPNVeFOaUfPVfhyUM+HUBgPq73qtbWQe6Av0vaD
jsmJ5kT+z8vDxl0DNf/aBbLB9Nptt82QTLS9qslqkUVFO3ANs6bj3r0xaMxQGDMnxnG/eG46Gl3T
YqNOvrMb/pKVHbEAtyhXu5SpmRi5KsAoEd/jTBNxnwMsSu63Lz+kAYBjHfClMDaL3qyn9djd3Y7Y
ELuJ6iD8SiTmyu6sR1y9QSA6/Sl1HZUx8uvnqcdW6A64vhPbtmmVyrb4Ndh/Y8T741lAGWVrCxIm
YczKSm2zbrY6f8IlkYMQuV9jdNZvOwf/7NcNAUZ6GuybotU5UheUkIWPA/o7k0Po4ob5KxW8FoAu
8RzZS8tR/DYFp5dYFEMCFtnu5K8g6yN6/++2DFK/McxWgxh1YyoCD03PH3IYzWvkx60kS/U3z/vr
/BTqbjvUEMYWVzkwE6nbxIGxQPS5I7yc1ZASnIh8eBBMRqFpB87ThI59QBKyAYfuKpM4iLn00+lr
nHx4ICoGfaAywLcASVoQ01z0J+JdS62PuGjd0WSdpJ6CN/A4/s8wmuGVxMeXKprXcv7nimIg1+Su
hjHdh9GRsbHYpyzfPdJb1ss+JQWcmbDTziMNjwZhmN+4mwSJMY0MPu8eI/SNHRm9napKg7gPnCsy
/v9OGZ2N05wBw/kMV7QcHZGgqRiLq6BWI0wHpI6vEyN2vogeTpfj/vpdoJbbpOJhZKjU6jPC9Z8I
6yFn2M5R4syzQnlt/6pa38RsqwjoQzXbJS4qgA2XosCATkJicfrkcseYOAvenFTJ82MtyZQdxmfs
mD4KQ3RhOUvSGhPXBRXYhLA2HIqOsJpu9n4yTw4FMZR62Bf4jG4UsDJSc72e6oD236z9li57E9QZ
/EC0yz0Yy0dddIxWOR2Tk06CwYxjlmZgCJ8C2G2tRN3uKBes+ZRWGzjBfS3R0HdBz/mW+R+SFIMI
0cNJoaeBHt4FmVFfFjBiaBt6ucshHEe1MZxAP4f048mwlv1Y6G5Jbhy7RNWRYrpEW1uFpvcdOmTb
P02cqQtP5eYAxGmXhQ8+gAZA+xA3JfEk800A34C01CMtZ52Ur53xawwC0s08Uf2ay1y6/iYT/49x
NqktM4NjzgYnp7IZeRxZOfJWohrdnwgLC8CvrDwjX08MgXzpJJbYx9+F5bTmhz/Zj8aEr/c0UZV8
EKWKyvHXWQhq9qf0zVLT2ONTMHFq50QoSDOKo8n3Bu1+ZLtLuBneJlM+1kHk/PQXieht1SPcheY3
nePSTc+lwBJlSvb7Ujza/4zXhiaCgKST4+GCPPa9ez0T08QnZ8MyLOrj78r3l5iaauj+LHtWxDXO
OnYoPiC8YYbHsjmXBxpkVxdF32BrIWrCebBDa5KKhjI1H9C0jJDpb/NgRS7pz07YR7naHXsr9zfa
EjHVMYCjDAJDZFE5MI65fpbDNZchMCW4Ea17rs0j6o2FaQ1A1cECPCJVMP1y81OYf+8FTJ7XH0i3
LdfSGlL/tiq2nWj48c+s7vSoI6WOEXpaMjdBhcq9StuRdrkO8aGWa12IwQ93WZmZliSJmA+yide/
yUTlw5+FvddWs6jRN+KpAmNho6Baf7JGrQY99aqJG2NvfkUzBSblW8jRKU040oA4N2507gXEVoVC
cguWm9LoDnMnXLP5TxmEi8CN0jU3r2e3bwEQUYGLskatQ5vSoHosrxDJabBICdJ9si4UPipiQrCr
9xpqAwpiPo4/pg1rZXXRlUnAhC4fOsb6j92Z7PgsDdNawwCgJwerNX8SpL8Bu9+Amk1YSu/zMhw1
pRVMC/dgwU/TZM50Mh4g5AWYgg/v/s6qRgO7PgFpI4WhPPX3rdq6oiuMcVDGRLBh0WICw4RT5L8n
IQd028WPKAgmF+1ODp+zoIadjoWliLgtIG3EEcxJBgKV7Raf3MZc+BGKPWa0e8CnUG9YVwmrxg4Q
SAyvuWRcgXPVA1Q7QVqNKs3VC48ioubP3H7n9r7L/Hrx5JVpXNC5lWNRBhTjasLCeAUcAeCFLeam
v/cipeUWTawQwyRDzxtviLLuySsFk66DEiKA/5DB9+U2lEUO/0KhBW4Y/R7YBd34R4UL4bq9wUVG
IsPbsT1zUWEyTzOzU0KcoH5GIujsVZmXYibDH3Xx1S75jSiW018XXDHSD9jzyuV5aoRc4RuwV77/
bB5XczGD0lqjj/c6p0QgkBgi0CrLTr9ZdnZa6dCVqnBKX6ZsEmLsE2YbMHxg8GOhhdTi+3bLOnNu
hwVQK902TRmz7b3RYvkjgsbx5tSESeLN6PfDo/4mBN01CFz/qOWS7BpFbn2xSZn5AoeEqO0RfIKV
bL5VcLo4y5vxfAHi5Zl0iSvnQmSdX+Og5yk/wRfCNAPBwiiHlh+7sEwLyZCaaDo9A6GNiSgQrFqx
Rf8dbBUkmSsgsQscV6X27E2YJhIah4kN/k7IiSufj/UhPeG53BZrYgyivUZhPaL7hO1It7YWebCf
PqgxFOrd3FZHO9D1Jbl2Tm5ezYsmgHhVuHYPpmwZnCqJrQWWRpfDjQYDPnpBgtHEeSEYc00IJbwy
RNJSidl5EC4A1LJ+y9D8SKUEUA6oaNghjWo941M+1uEoQaN/U2Nu5Z52T05WUMoYhltKJ4eQrO5Y
0/8sI1qitg0hnhKHg2NDhWiiLBFAbAwrqXqdDWiVyXiu0jzixaS7yez7xU88NbHgFicsnSKSRxiS
WlNw16rY2QWxJTeZLm+cFMq1pGnE1ut95gvOZCjpurQq4OF0pfqXghNeDEjvzWTFO5dXxYhOxmzL
CIo39PSbKtO2PXMAPoRPzou3lEoSN+EzgVRDDDjKjdcucQIJ+RZv7m8IE4Vgfizl1ylgOYm/7b+w
A/SrvDy5Mxi7Dv6sJCFQWBf5CG0wxXLwUzLw5UfPRm/6vLc65EYuQZwsrZG/Qpe2Odksr/62ODxh
xj5pPNva09RYLUybO+R6993tb/zd8GX79sIqM2u9c+ntjhmDQuZMjg3SMcfhjmg5TVjkLdTh7n1k
y0l3Lvngp3wC5rzPIuH1ZSTuFoI+b7MU47Ol95d4Axcdf19PsGqZCTo+iogGd/PEcYDtYHoMm8im
c1mbGyXzbyBp7qZjdf67Z3t6nW0ObPcKuM8QYLTRxEuvXq/bjN0PjSGUijHdAY0crfFh5InVsTGg
pCxvIcIEdKDWaeBfqaLiKJ2Ksb5T1TU5ZTTODD9kcn6T4eESkStdsm5oFFqn+8dc+JjBJYeq21wu
Pj7QAmUplUG8QjDNmn4OVbHXc4tV7Es3bynM+r0KU+c6BDdUKdxZbybB4WD5HkPDeXcu5mQzueY3
25aTwON6S82dCv2vqvyO9efoYX3Gvw0EBN50wcwxnOgPrwoPT26HRu61DQhf1lzN/Jk9ZlfNlwdi
6FVNyljT/fsiJRXCp99OewbFmTpC6YrMQzM1RIfFm1K0nE6wZ82ssvSQLEODxwOF6eoss1afWhku
OEY8OwA5v73ofJ9Xl6QmVwK7QQvmHK7HWCh5WMqxbFGzQ06A1v04waLr/UOqBCzwUC3D2xCBf2nI
zkAFmV+WBRfto0eaoow5vEHF9Y07m2g1teHXR6WbTr86ghW4AsDZG8qiZMhgJ42eFva836FE77rZ
kWmA32KjepAxAbTFb55L9v2DBBqaYglDKiceU3EcBWJvekhQhRUhowDMz3ZGrtbF/a7xce/4uKGn
Bv90rn6ALdvrFolAYGpnoF7YuoaX4m8reo36bKTAdXI61avDUeLVXeIGFp3PV4ZuNa/XBTc0dKuY
M8NbBRFvlfYHrx7seCRpWNsIfyhdt7uvNWSiErRTEkyJ1eZSroAnvUIj5yp4WbYC9QP2YV2L9mSw
wPGQh2yFH5y22wtDHwgUMhTuPdObmfoPFzC2tfoUyGmeMXPjLy71xFZY5AbGG1ipRAgO+YWIfRnq
yYs3WI+I5yG1a1luXLbrEwwii2Nw0CuSMcraYrAy1VMfis+3PjfuNaSs+D0b80JMQNi5umKW07Uj
XTmBI4vF+VgR6aX8wfRk7R8X44BMlaGSW/dZK0vVWNlW89ZHzNtRuki3ozixwI+Ls/ULS8j3hIKV
Q2Va2CHkrjxuaa5vOvT/+CSQNXX36PDCvpDeLQqisxyljdDAjrCcM7jGoKsG4RLY6LbcirDCaT8i
IJqYnSgXVASbvFz8cN638pcNOZ12WaEPqOD6ACbi2uh51co33cOTA3FxmPzayTv1H73fl9a46hmD
AFEWUHasMPuHqk2BzP6mwPl5tfFshtbBAZbe6H3VwLtMLGl5Juz0qgBjBe+3kFlXKx1WmX+7tfc6
BoEnsDw9NfZ8RDdOctzB+ODIDcGiH3WoaMMGVRGhNG7e9RxutjCgnqvETEzlnsazYgpSxGpejahl
2trhx35YFEaV5QQ/IRkbJhhiSdWjBMNM4ahz98VTNe6STZ5qOO38Za9JtCCYue1LeNMPW/UcTmwY
f/j/iF56T1yQX9loaIAcdw3pwCcWdnr6hTZMQDAAbKvFn+DLsHNiFdq+yIlQC2H4f2jg3Zri/h/N
fBiQRtjY7cyu6o6v5YNa1Rz+i7tPsr355B15IM5isyTmRKaF/NpZfabnee5lljV/ijpeTlmtBaUA
DVWH6NQXObUceColznT22CxDgdg358pp5MHsC40MYexTQpG5XJ3Sl1eeGfSrIApe4vmmFffVjJBY
tXDMF0kmG80Z3teZsJD4NU3C8P09qk7Xl/c5XU/e3t0Ff6IhTiO4IJ0DK5hEq4VqE5Zx/LSZBDT6
HDFlEMsNyBquYnUegIN+xgZ+gWsr26pDSEER/5Eq1FtkQjbmrYS0ySvPs51PtmCmqguGJlI5piiu
QH8zQ2Xe7TVlS+bRab5vRmAgajfe3s4XPc87ulLz5Fxz7iPaIIDc3/Drzxxk07ww2X1941wEG84q
VQjeIjQmtf9u6LGa13L6NZ6X3UdEImhsfAv+E59JxchLPJ5j07deJ1GFBoANB4sIbOt8wUlQWUbQ
PWiXi1/xfeQijE7hkZmU0bmvDKoKR8DilnMhr8LhfsX9bC365roAkY4zo4xHtmb4iKL5+mM9XSyH
+iDNrhtCWUHwMWcq1B5jy132zlmgAI6KWMxIiMCBBi4gg1fYvizCuw1npW0KMWiQFWVpJ3HdAk7Z
PYq2PCVYKbzlXBG8IfR5moqIv57iHhvNsLAaZ6tauv6VqJk9iQm+YlgUenY0BQLsUfpR1x8He5kM
3H5Bwt9Dv0blqvTyjPSaIn/3TrZh0pKYw0bECyX+m7qEG04ZasdqedK1PsL7TyfotgSnJFGrOSoQ
2o697Twi/myiGgMsUwBbYeags35i76whw1eQvG7UXIZXSJEz/XYME+aNBXgAS0sPiMj0g9/eMe4f
Y7QHrY4sJk8T5oq8DTGqjrtquXQZJ/mzJVlfRNMBtyXvbbw1EUJ4x0NGdqfim9EUYTWP7sohFJdN
51UAOeqT+9SqCq1DersGX32rM/gHGJBLmR7vuZoH12tAeLSt06ycApbDe8IAyeiIlnDPDEuWfwjA
2sQp3Pu/9WZk0b+1ijAAGjI8KpEczyZyh+qne10bi8egb/qhbFesr4KUBBFYK+rpIXaIpfYLv37q
KVUlLsrle5fRFKd+0wAq3zRx8tzbQL15tLoDD8s+hvTHH9iOOlBe6djFsM16l0OyaOZZ932GIbSQ
yIwr8hnRGaRyMDE26O3ESNkjnloGl7nTU1TeIgpr1Jnfb21znyHzNhZEGc5mZicEB1DjJt8zW7hl
WETTgCdAfoNO8JOq8NvuIoqmpniMryiNhTzR2rK16qr00RaKnCF9mNS8gcH6rS0+62cvkJA076hL
EvnGLgcJI8oz9VI4Ng0yqBbi/SxeuvHmtFkKyKZTxzefWiM/N/6e2HpyhqpV
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
