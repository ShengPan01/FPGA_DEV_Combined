/**
 *  Codasip Ltd
 * 
 *  Copyright 2017 Codasip Ltd
 * 
 *  All Rights Reserved.
 *  This file is part of the Codasip Studio product. No part of the Studio product, including this
 *  file, may be use, copied, modified, or distributed except in accordance with the terms contained
 *  in Codasip license agreement under which you obtained this file.
 * 
 *  \file
 *  \date    2017-05-25 15:05:01
 *  \author  Codasip (c) HW generator
 *  \version 6.6.1-0.centos.6.7
 *  \brief   Contains module definition of the 'codix_berkelium_ca' ASIP.
 */

module codix_berkelium_ca(
    input  wire CLK,
    input  wire TCK,
    input  wire RST,
    input  wire TRST,
    input  wire TMS,
    input  wire TDI,
    input  wire [31:0] if_fetch_Q0,
    input  wire [2:0] if_fetch_RESPONSE0,
    input  wire [1:0] if_fetch_STATUS0,
    input  wire [31:0] if_ldst_Q0,
    input  wire [2:0] if_ldst_RESPONSE0,
    input  wire [1:0] if_ldst_STATUS0,
    input  wire p_meip,
    input  wire p_msip,
    input  wire p_mtip,
    output wire TDO,
    output wire [31:0] if_fetch_A0,
    output wire [2:0] if_fetch_BC0,
    output wire [1:0] if_fetch_BI0,
    output wire [31:0] if_fetch_D0,
    output wire [2:0] if_fetch_REQUEST0,
    output wire [31:0] if_ldst_A0,
    output wire [2:0] if_ldst_BC0,
    output wire [1:0] if_ldst_BI0,
    output wire [31:0] if_ldst_D0,
    output wire [2:0] if_ldst_REQUEST0,
    output wire p_wfi
);
    // type, wire and constant declarations:
    // signal/wire (inner)
    wire codasip_halt_wire;
    // signal/wire (CodAL)
    wire s_port_break_en;
    // signal/wire (CodAL)
    wire s_port_break_hw;
    // signal/wire (CodAL)
    wire s_port_break_sw;

    // additional declarations:
    wire nexus_client_NEXUS_CLIENT_RST_REQUEST_0;
    wire codasip_irst_IRST_1;
    wire [6:0] nexus_port_NEXUS_RRS_2;
    wire [31:0] core_if_ldst_A0_ex_memory_1763_3;
    wire [2:0] core_if_ldst_BC0_ex_memory_1769_4;
    wire [1:0] core_if_ldst_BI0_ex_memory_1766_5;
    wire [31:0] core_if_ldst_D0_wb_732_6;
    wire nexus_port_if_ldst_NEXUS_CLIENT_CAPTURE_7;
    wire [31:0] nexus_port_if_ldst_NEXUS_CLIENT_D0_8;
    wire nexus_port_if_ldst_NEXUS_CLIENT_UPDATE_9;
    wire [2:0] core_if_ldst_REQUEST0_ex_memory_1760_10;
    wire [31:0] if_ldst_NEXUS_CLIENT_Q0_11;
    wire [31:0] if_ldst_Q0_12;
    wire [2:0] if_ldst_RESPONSE0_13;
    wire [1:0] if_ldst_STATUS0_14;
    wire [2:0] core_if_fetch_REQUEST0_npc_922_15;
    wire [31:0] core_if_fetch_A0_npc_925_16;
    wire [1:0] core_if_fetch_BI0_npc_928_17;
    wire [2:0] core_if_fetch_BC0_npc_931_18;
    wire [1:0] if_fetch_STATUS0_19;
    wire [2:0] if_fetch_RESPONSE0_20;
    wire [31:0] if_fetch_Q0_21;
    wire [7:0] core_predictor_mem_if_read_A0_npc_949_22;
    wire core_predictor_mem_if_read_BC0_npc_955_23;
    wire core_predictor_mem_if_read_BI0_npc_953_24;
    wire [1:0] core_predictor_mem_if_read_REQUEST0_npc_947_25;
    wire [7:0] core_predictor_mem_if_write_A0_ex_output_1919_26;
    wire core_predictor_mem_if_write_BC0_ex_output_1925_27;
    wire core_predictor_mem_if_write_BI0_ex_output_1922_28;
    wire [53:0] core_predictor_mem_if_write_D0_ex_output_1929_29;
    wire [1:0] core_predictor_mem_if_write_REQUEST0_ex_output_1916_30;
    wire [53:0] predictor_mem_if_read_Q0_31;
    wire [31:0] nexus_client_r_PC_BSC_D0_32;
    wire nexus_client_r_PC_BSC_UPDATE0_33;
    wire nexus_client_DEBUG_MODE_34;
    wire [31:0] nexus_client_rf_gpr_BSC_D0_35;
    wire [1:0] nexus_client_rf_gpr_BSC_UPDATE0_36;
    wire [31:0] core_core_r_ex_pc_Q0_4827_37;
    wire core_core_r_ex_valid_Q0_4830_38;
    wire [31:0] core_nexus_client_r_PC_BSC_Q0_r_PC_465_39;
    wire [31:0] core_nexus_client_rf_gpr_BSC_Q0_rf_gpr_470_40;
    wire nexus_port_NEXUS_BAR_41;
    wire nexus_port_nexus_client_NEXUS_CLIENT_CAPTURE_42;
    wire [31:0] nexus_port_nexus_client_NEXUS_CLIENT_D0_43;
    wire nexus_port_nexus_client_NEXUS_CLIENT_UPDATE_44;
    wire [31:0] nexus_client_NEXUS_CLIENT_Q0_45;

    // child instances inside 'codix_berkelium' ASIP:
    // instance of 'codasip_irst' reset encapsulation unit:
    codasip_reset_gen_t codasip_irst (
        .RST(RST),
        .NEXUS_CLIENT_RST_REQUEST(nexus_client_NEXUS_CLIENT_RST_REQUEST_0),
        .IRST(codasip_irst_IRST_1)
    );

    // instance of 'if_ldst' CodAL interface with Nexus support:
    codix_berkelium_ca_if_ldst_t if_ldst (
        .CLK(CLK),
        .RST(RST),
        .NEXUS_RRS(nexus_port_NEXUS_RRS_2),
        .A0(core_if_ldst_A0_ex_memory_1763_3),
        .BC0(core_if_ldst_BC0_ex_memory_1769_4),
        .BI0(core_if_ldst_BI0_ex_memory_1766_5),
        .D0(core_if_ldst_D0_wb_732_6),
        .if_ldst_Q0(if_ldst_Q0),
        .if_ldst_RESPONSE0(if_ldst_RESPONSE0),
        .if_ldst_STATUS0(if_ldst_STATUS0),
        .NEXUS_CLIENT_CAPTURE(nexus_port_if_ldst_NEXUS_CLIENT_CAPTURE_7),
        .NEXUS_CLIENT_D0(nexus_port_if_ldst_NEXUS_CLIENT_D0_8),
        .NEXUS_CLIENT_UPDATE(nexus_port_if_ldst_NEXUS_CLIENT_UPDATE_9),
        .REQUEST0(core_if_ldst_REQUEST0_ex_memory_1760_10),
        .if_ldst_A0(if_ldst_A0),
        .if_ldst_BC0(if_ldst_BC0),
        .if_ldst_BI0(if_ldst_BI0),
        .if_ldst_D0(if_ldst_D0),
        .if_ldst_REQUEST0(if_ldst_REQUEST0),
        .NEXUS_CLIENT_Q0(if_ldst_NEXUS_CLIENT_Q0_11),
        .Q0(if_ldst_Q0_12),
        .RESPONSE0(if_ldst_RESPONSE0_13),
        .STATUS0(if_ldst_STATUS0_14)
    );

    // instance of 'if_fetch' CodAL interface:
    codix_berkelium_ca_if_fetch_t if_fetch (
        .if_fetch_STATUS0(if_fetch_STATUS0),
        .if_fetch_RESPONSE0(if_fetch_RESPONSE0),
        .if_fetch_Q0(if_fetch_Q0),
        .REQUEST0(core_if_fetch_REQUEST0_npc_922_15),
        .A0(core_if_fetch_A0_npc_925_16),
        .BI0(core_if_fetch_BI0_npc_928_17),
        .BC0(core_if_fetch_BC0_npc_931_18),
        .D0(32'b0),
        .if_fetch_REQUEST0(if_fetch_REQUEST0),
        .if_fetch_A0(if_fetch_A0),
        .if_fetch_BI0(if_fetch_BI0),
        .if_fetch_BC0(if_fetch_BC0),
        .if_fetch_D0(if_fetch_D0),
        .STATUS0(if_fetch_STATUS0_19),
        .RESPONSE0(if_fetch_RESPONSE0_20),
        .Q0(if_fetch_Q0_21)
    );

    // instance of 'predictor_mem' Codasip memory:
    codasip_memory_predictor_mem_t predictor_mem (
        .CLK(CLK),
        .RST(codasip_irst_IRST_1),
        .if_read_A0(core_predictor_mem_if_read_A0_npc_949_22),
        .if_read_BC0(core_predictor_mem_if_read_BC0_npc_955_23),
        .if_read_BI0(core_predictor_mem_if_read_BI0_npc_953_24),
        .if_read_REQUEST0(core_predictor_mem_if_read_REQUEST0_npc_947_25),
        .if_write_A0(core_predictor_mem_if_write_A0_ex_output_1919_26),
        .if_write_BC0(core_predictor_mem_if_write_BC0_ex_output_1925_27),
        .if_write_BI0(core_predictor_mem_if_write_BI0_ex_output_1922_28),
        .if_write_D0(core_predictor_mem_if_write_D0_ex_output_1929_29),
        .if_write_REQUEST0(core_predictor_mem_if_write_REQUEST0_ex_output_1916_30),
        .if_read_Q0(predictor_mem_if_read_Q0_31),
        .if_read_QRESPONSE0(),
        .if_read_STATUS0(),
        .if_write_DRESPONSE0(),
        .if_write_STATUS0()
    );

    // instance of 'core' ASIP core:
    codix_berkelium_ca_core_t core (
        .CLK(CLK),
        .RST(codasip_irst_IRST_1),
        .if_fetch_Q0(if_fetch_Q0_21),
        .if_fetch_RESPONSE0(if_fetch_RESPONSE0_20),
        .if_fetch_STATUS0(if_fetch_STATUS0_19),
        .if_ldst_Q0(if_ldst_Q0_12),
        .if_ldst_RESPONSE0(if_ldst_RESPONSE0_13),
        .if_ldst_STATUS0(if_ldst_STATUS0_14),
        .nexus_client_r_PC_BSC_D0(nexus_client_r_PC_BSC_D0_32),
        .nexus_client_r_PC_BSC_UPDATE0(nexus_client_r_PC_BSC_UPDATE0_33),
        .nexus_client_r_PC_DEBUG_MODE(nexus_client_DEBUG_MODE_34),
        .nexus_client_rf_gpr_BSC_D0(nexus_client_rf_gpr_BSC_D0_35),
        .nexus_client_rf_gpr_BSC_UPDATE0(nexus_client_rf_gpr_BSC_UPDATE0_36),
        .nexus_client_rf_gpr_DEBUG_MODE(nexus_client_DEBUG_MODE_34),
        .p_meip_Q0(p_meip),
        .p_msip_Q0(p_msip),
        .p_mtip_Q0(p_mtip),
        .predictor_mem_if_read_Q0(predictor_mem_if_read_Q0_31),
        .s_port_break_en_Q0(s_port_break_en),
        .s_port_break_hw_Q0(s_port_break_hw),
        .codasip_halt_wire_D0_halt_1041(codasip_halt_wire),
        .core_r_ex_pc_Q0_4827(core_core_r_ex_pc_Q0_4827_37),
        .core_r_ex_valid_Q0_4830(core_core_r_ex_valid_Q0_4830_38),
        .if_fetch_A0_npc_925(core_if_fetch_A0_npc_925_16),
        .if_fetch_BC0_npc_931(core_if_fetch_BC0_npc_931_18),
        .if_fetch_BI0_npc_928(core_if_fetch_BI0_npc_928_17),
        .if_fetch_REQUEST0_npc_922(core_if_fetch_REQUEST0_npc_922_15),
        .if_ldst_A0_ex_memory_1763(core_if_ldst_A0_ex_memory_1763_3),
        .if_ldst_BC0_ex_memory_1769(core_if_ldst_BC0_ex_memory_1769_4),
        .if_ldst_BI0_ex_memory_1766(core_if_ldst_BI0_ex_memory_1766_5),
        .if_ldst_D0_wb_732(core_if_ldst_D0_wb_732_6),
        .if_ldst_REQUEST0_ex_memory_1760(core_if_ldst_REQUEST0_ex_memory_1760_10),
        .nexus_client_r_PC_BSC_Q0_r_PC_465(core_nexus_client_r_PC_BSC_Q0_r_PC_465_39),
        .nexus_client_rf_gpr_BSC_Q0_rf_gpr_470(core_nexus_client_rf_gpr_BSC_Q0_rf_gpr_470_40),
        .p_wfi_D0_ports_1046(p_wfi),
        .predictor_mem_if_read_A0_npc_949(core_predictor_mem_if_read_A0_npc_949_22),
        .predictor_mem_if_read_BC0_npc_955(core_predictor_mem_if_read_BC0_npc_955_23),
        .predictor_mem_if_read_BI0_npc_953(core_predictor_mem_if_read_BI0_npc_953_24),
        .predictor_mem_if_read_REQUEST0_npc_947(core_predictor_mem_if_read_REQUEST0_npc_947_25),
        .predictor_mem_if_write_A0_ex_output_1919(core_predictor_mem_if_write_A0_ex_output_1919_26),
        .predictor_mem_if_write_BC0_ex_output_1925(core_predictor_mem_if_write_BC0_ex_output_1925_27),
        .predictor_mem_if_write_BI0_ex_output_1922(core_predictor_mem_if_write_BI0_ex_output_1922_28),
        .predictor_mem_if_write_D0_ex_output_1929(core_predictor_mem_if_write_D0_ex_output_1929_29),
        .predictor_mem_if_write_REQUEST0_ex_output_1916(core_predictor_mem_if_write_REQUEST0_ex_output_1916_30),
        .s_port_break_sw_D0_jtag_fsm_1651(s_port_break_sw)
    );

    // instance of 'nexus_client' Nexus ASIP client:
    codix_berkelium_ca_nexus_client_t nexus_client (
        .CLK(CLK),
        .RST(RST),
        .NEXUS_BAR(nexus_port_NEXUS_BAR_41),
        .NEXUS_RRS(nexus_port_NEXUS_RRS_2),
        .codix_berkelium_core_r_ex_pc_Q0(core_core_r_ex_pc_Q0_4827_37),
        .codix_berkelium_core_r_ex_valid_Q0(core_core_r_ex_valid_Q0_4830_38),
        .NEXUS_CLIENT_CAPTURE(nexus_port_nexus_client_NEXUS_CLIENT_CAPTURE_42),
        .NEXUS_CLIENT_D0(nexus_port_nexus_client_NEXUS_CLIENT_D0_43),
        .NEXUS_CLIENT_UPDATE(nexus_port_nexus_client_NEXUS_CLIENT_UPDATE_44),
        .r_PC_BSC_Q0(core_nexus_client_r_PC_BSC_Q0_r_PC_465_39),
        .rf_gpr_BSC_Q0(core_nexus_client_rf_gpr_BSC_Q0_rf_gpr_470_40),
        .s_port_break_sw_Q0(s_port_break_sw),
        .DEBUG_MODE(nexus_client_DEBUG_MODE_34),
        .NEXUS_CLIENT_Q0(nexus_client_NEXUS_CLIENT_Q0_45),
        .NEXUS_CLIENT_RST_REQUEST(nexus_client_NEXUS_CLIENT_RST_REQUEST_0),
        .r_PC_BSC_D0(nexus_client_r_PC_BSC_D0_32),
        .r_PC_BSC_UPDATE0(nexus_client_r_PC_BSC_UPDATE0_33),
        .rf_gpr_BSC_D0(nexus_client_rf_gpr_BSC_D0_35),
        .rf_gpr_BSC_UPDATE0(nexus_client_rf_gpr_BSC_UPDATE0_36),
        .s_port_break_en_D0(s_port_break_en),
        .s_port_break_hw_D0(s_port_break_hw)
    );

    // instance of 'nexus_port' Nexus port:
    codix_berkelium_ca_nexus_port_t nexus_port (
        .CLK(CLK),
        .TCK(TCK),
        .RST(RST),
        .TRST(TRST),
        .TMS(TMS),
        .TDI(TDI),
        .DEBUG_MODE(nexus_client_DEBUG_MODE_34),
        .if_ldst_NEXUS_CLIENT_Q0(if_ldst_NEXUS_CLIENT_Q0_11),
        .nexus_client_NEXUS_CLIENT_Q0(nexus_client_NEXUS_CLIENT_Q0_45),
        .TDO(TDO),
        .NEXUS_BAR(nexus_port_NEXUS_BAR_41),
        .NEXUS_RRS(nexus_port_NEXUS_RRS_2),
        .if_ldst_NEXUS_CLIENT_CAPTURE(nexus_port_if_ldst_NEXUS_CLIENT_CAPTURE_7),
        .if_ldst_NEXUS_CLIENT_D0(nexus_port_if_ldst_NEXUS_CLIENT_D0_8),
        .if_ldst_NEXUS_CLIENT_UPDATE(nexus_port_if_ldst_NEXUS_CLIENT_UPDATE_9),
        .nexus_client_NEXUS_CLIENT_CAPTURE(nexus_port_nexus_client_NEXUS_CLIENT_CAPTURE_42),
        .nexus_client_NEXUS_CLIENT_D0(nexus_port_nexus_client_NEXUS_CLIENT_D0_43),
        .nexus_client_NEXUS_CLIENT_UPDATE(nexus_port_nexus_client_NEXUS_CLIENT_UPDATE_44)
    );

endmodule
