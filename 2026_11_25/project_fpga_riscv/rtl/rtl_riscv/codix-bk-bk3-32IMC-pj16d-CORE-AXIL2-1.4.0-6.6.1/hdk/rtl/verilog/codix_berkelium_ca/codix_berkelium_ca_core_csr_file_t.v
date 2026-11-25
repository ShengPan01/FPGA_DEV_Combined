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
 *  \brief   Contains module definition of the 'codix_berkelium_ca_core_csr_file_t' functional unit.
 */

module codix_berkelium_ca_core_csr_file_t(
    input  wire CLK,
    input  wire RST,
    input  wire ACT,
    input  wire p_meip_Q0,
    input  wire p_msip_Q0,
    input  wire p_mtip_Q0,
    input  wire [31:0] r_csr_mbadaddr_Q0,
    input  wire [31:0] r_csr_mcause_Q0,
    input  wire [31:0] r_csr_mepc_Q0,
    input  wire [31:0] r_csr_mie_Q0,
    input  wire [31:0] r_csr_mscratch_Q0,
    input  wire [31:0] r_csr_mstatus_Q0,
    input  wire [31:0] r_csr_mtvec_Q0,
    input  wire r_wb_16b_instr_Q0,
    input  wire [4:0] r_wb_addrW_Q0,
    input  wire r_wb_branch_ex_Q0,
    input  wire [11:0] r_wb_csr_addr_Q0,
    input  wire [31:0] r_wb_csr_data_Q0,
    input  wire [2:0] r_wb_csr_funct_Q0,
    input  wire r_wb_csr_read_Q0,
    input  wire r_wb_csr_write_Q0,
    input  wire [3:0] r_wb_exc_code_Q0,
    input  wire [31:0] r_wb_exc_instr_addr_Q0,
    input  wire r_wb_exc_Q0,
    input  wire r_wb_instr_fin_Q0,
    input  wire r_wb_instr_val_Q0,
    input  wire [2:0] r_wb_mem_cmd_Q0,
    input  wire [31:0] r_wb_pc_Q0,
    input  wire [31:0] r_wb_result_Q0,
    input  wire [4:0] r_wb_zimm_Q0,
    input  wire s_irq_Q0,
    input  wire [31:0] s_wb_csr_data_Q0,
    input  wire s_wb_irq_Q0,
    input  wire s_wb_irq_taken_Q0,
    input  wire s_wb_mem_error_Q0,
    input  wire s_wb_mem_unaligned_Q0,
    input  wire [31:0] s_wb_next_pc_Q0,
    input  wire s_wb_stall_wb_Q0,
    output wire [31:0] r_csr_mbadaddr_D0,
    output wire r_csr_mbadaddr_WE0,
    output wire [31:0] r_csr_mcause_D0,
    output wire r_csr_mcause_WE0,
    output wire [31:0] r_csr_mepc_D0,
    output wire r_csr_mepc_WE0,
    output wire [31:0] r_csr_mie_D0,
    output wire r_csr_mie_WE0,
    output wire [31:0] r_csr_mscratch_D0,
    output wire r_csr_mscratch_WE0,
    output wire [31:0] r_csr_mstatus_D0,
    output wire r_csr_mstatus_WE0,
    output wire [31:0] r_csr_mtvec_D0,
    output wire r_csr_mtvec_WE0,
    output wire [31:0] s_wb_csr_data_D0,
    output wire s_wb_exc_D0,
    output wire s_wb_irq_D0,
    output wire s_wb_irq_taken_D0,
    output wire s_wb_mret_D0,
    output wire [31:0] s_wb_next_pc_D0
);
    // type, wire and constant declarations:
    // signal/wire (inner)
    wire [11:0] codasip_tmp_var_0;
    // signal/wire (inner)
    wire codasip_tmp_var_1;
    // signal/wire (inner)
    wire codasip_tmp_var_10;
    // signal/wire (inner)
    wire codasip_tmp_var_11;
    // signal/wire (inner)
    wire codasip_tmp_var_12;
    // signal/wire (inner)
    wire codasip_tmp_var_13;
    // signal/wire (inner)
    wire codasip_tmp_var_14;
    // signal/wire (inner)
    wire codasip_tmp_var_15;
    // signal/wire (inner)
    wire codasip_tmp_var_16;
    // signal/wire (inner)
    wire codasip_tmp_var_17;
    // signal/wire (inner)
    wire codasip_tmp_var_18;
    // signal/wire (inner)
    wire codasip_tmp_var_19;
    // signal/wire (inner)
    wire codasip_tmp_var_2;
    // signal/wire (inner)
    wire codasip_tmp_var_20;
    // signal/wire (inner)
    wire codasip_tmp_var_21;
    // signal/wire (inner)
    wire codasip_tmp_var_22;
    // signal/wire (inner)
    wire codasip_tmp_var_23;
    // signal/wire (inner)
    wire codasip_tmp_var_24;
    // signal/wire (inner)
    wire codasip_tmp_var_25;
    // signal/wire (inner)
    wire [2:0] codasip_tmp_var_3;
    // signal/wire (inner)
    wire codasip_tmp_var_4;
    // signal/wire (inner)
    wire codasip_tmp_var_5;
    // signal/wire (inner)
    wire codasip_tmp_var_6;
    // signal/wire (inner)
    wire codasip_tmp_var_7;
    // signal/wire (inner)
    wire codasip_tmp_var_8;
    // signal/wire (inner)
    wire codasip_tmp_var_9;
    // signal/wire (inner)
    wire [31:0] csr_data_write_B0;
    // signal/wire (inner)
    wire exception_taken_B0;
    // signal/wire (inner)
    wire [1:0] irq_code_B0;
    // signal/wire (inner)
    wire [31:0] s_wb_csr_data_D0_ACT_wire;

    // additional declarations:
    wire r_wb_irq_WE0;
    wire r_wb_irq_D0;
    wire r_wb_irq_Q0;
    // temporal variable for multiplexer, should not be synthesized as register
    reg [31:0] tmp_codasip_conv_cs_csr_data_write_B0_D0_mux_1;

    // child instances inside 'csr_file' functional unit:
    // instance of 'r_wb_irq' register:
    d_ff_plain_rst_we_t #(
        .bit_width(32'd1),
        .default_value(1'b0),
        .reset_level(1'b0),
        .reset_sync(1'b0)
    ) r_wb_irq (
        .CLK(CLK),
        .RST(RST),
        .WE0(r_wb_irq_WE0),
        .D0(r_wb_irq_D0),
        .Q0(r_wb_irq_Q0)
    );

    // data-path code:
    assign codasip_tmp_var_0 = r_wb_csr_addr_Q0;
    assign s_wb_csr_data_D0_ACT_wire = (codasip_tmp_var_0 == 12'd769) ? 32'd1073746180 :
        (codasip_tmp_var_0 == 12'd768) ? r_csr_mstatus_Q0 :
        (codasip_tmp_var_0 == 12'd773) ? r_csr_mtvec_Q0 :
        (codasip_tmp_var_0 == 12'd833) ? r_csr_mepc_Q0 :
        (codasip_tmp_var_0 == 12'd834) ? r_csr_mcause_Q0 :
        (codasip_tmp_var_0 == 12'd836) ? {{20{1'b0}}, (({p_meip_Q0,11'd0} | {{4{1'b0}}, {p_mtip_Q0,7'd0}}) | {{8{1'b0}}, {p_msip_Q0,3'd0}})} :
        (codasip_tmp_var_0 == 12'd772) ? r_csr_mie_Q0 :
        (codasip_tmp_var_0 == 12'd832) ? r_csr_mscratch_Q0 :
        (codasip_tmp_var_0 == 12'd835) ? r_csr_mbadaddr_Q0 : 32'd0;
    assign codasip_tmp_var_1 = r_wb_instr_val_Q0;
    assign codasip_tmp_var_2 = (!codasip_tmp_var_1) ? s_wb_irq_Q0 : 1'd0;
    assign r_wb_irq_WE0 = ((ACT == 1'd1) && codasip_tmp_var_1) ? 1'd1 :
        ((ACT == 1'd1) && codasip_tmp_var_2) ? 1'd1 : 1'd0;
    assign r_wb_irq_D0 = codasip_tmp_var_1 ? 1'd0 :
        codasip_tmp_var_2 ? 1'd1 : 1'd0;
    assign irq_code_B0 = (((p_meip_Q0 && r_csr_mie_Q0[11])) ? 2'd2 : (((p_mtip_Q0 && r_csr_mie_Q0[7])) ? 2'd1 : 2'd0));
    assign codasip_tmp_var_3 = r_wb_csr_funct_Q0;
    always @(*) begin
        case ( codasip_tmp_var_3 )
            3'd0: tmp_codasip_conv_cs_csr_data_write_B0_D0_mux_1 = r_wb_csr_data_Q0;
            3'd1: tmp_codasip_conv_cs_csr_data_write_B0_D0_mux_1 = (s_wb_csr_data_Q0 | r_wb_csr_data_Q0);
            3'd2: tmp_codasip_conv_cs_csr_data_write_B0_D0_mux_1 = (s_wb_csr_data_Q0 & (~r_wb_csr_data_Q0));
            3'd3: tmp_codasip_conv_cs_csr_data_write_B0_D0_mux_1 = {{27{1'b0}}, r_wb_zimm_Q0};
            3'd4: tmp_codasip_conv_cs_csr_data_write_B0_D0_mux_1 = (s_wb_csr_data_Q0 | {{27{1'b0}}, r_wb_zimm_Q0});
            3'd5: tmp_codasip_conv_cs_csr_data_write_B0_D0_mux_1 = (s_wb_csr_data_Q0 & (~{{27{1'b0}}, r_wb_zimm_Q0}));
            default: tmp_codasip_conv_cs_csr_data_write_B0_D0_mux_1 = 32'd0;
        endcase
    end
    assign csr_data_write_B0 = tmp_codasip_conv_cs_csr_data_write_B0_D0_mux_1;
    assign codasip_tmp_var_4 = (r_wb_csr_write_Q0 && (r_wb_csr_addr_Q0 == 12'd773));
    assign codasip_tmp_var_5 = (r_wb_csr_write_Q0 && (r_wb_csr_addr_Q0 == 12'd832));
    assign codasip_tmp_var_6 = (r_wb_csr_write_Q0 && (r_wb_csr_addr_Q0 == 12'd772));
    assign codasip_tmp_var_7 = (((((((((((r_wb_csr_write_Q0 || r_wb_csr_read_Q0) && (r_wb_csr_addr_Q0 != 12'd768)) && (r_wb_csr_addr_Q0 != 12'd833)) && (r_wb_csr_addr_Q0 != 12'd834)) && (r_wb_csr_addr_Q0 != 12'd773)) && (r_wb_csr_addr_Q0 != 12'd836)) && (r_wb_csr_addr_Q0 != 12'd772)) && (r_wb_csr_addr_Q0 != 12'd832)) && (r_wb_csr_addr_Q0 != 12'd835)) && (r_wb_csr_addr_Q0 != 12'd769)) && ((r_wb_csr_addr_Q0 != 12'd2303) || (r_wb_addrW_Q0 != 5'd0)));
    assign codasip_tmp_var_8 = (!codasip_tmp_var_7) ? r_wb_exc_Q0 : 1'd0;
    assign codasip_tmp_var_9 = codasip_tmp_var_8 ? (r_wb_exc_code_Q0 == 4'd0) : 1'd0;
    assign codasip_tmp_var_10 = codasip_tmp_var_8 ? ((r_wb_exc_code_Q0 == 4'd5) || (r_wb_exc_code_Q0 == 4'd7)) : 1'd0;
    assign codasip_tmp_var_11 = ((!codasip_tmp_var_10) && codasip_tmp_var_8) ? (r_wb_exc_code_Q0 == 4'd2) : 1'd0;
    assign codasip_tmp_var_12 = ((!codasip_tmp_var_8) && (!codasip_tmp_var_7)) ? s_wb_mem_error_Q0 : 1'd0;
    assign codasip_tmp_var_13 = codasip_tmp_var_12 ? s_wb_mem_unaligned_Q0 : 1'd0;
    assign codasip_tmp_var_14 = (((!codasip_tmp_var_12) && (!codasip_tmp_var_8)) && (!codasip_tmp_var_7)) ? s_wb_irq_taken_Q0 : 1'd0;
    assign codasip_tmp_var_15 = codasip_tmp_var_14 ? r_wb_branch_ex_Q0 : 1'd0;
    assign codasip_tmp_var_16 = ((!codasip_tmp_var_15) && codasip_tmp_var_14) ? (r_wb_instr_fin_Q0 && (r_wb_csr_funct_Q0 != 3'd6)) : 1'd0;
    assign codasip_tmp_var_17 = codasip_tmp_var_14 ? (r_wb_csr_write_Q0 && (r_wb_csr_addr_Q0 == 12'd835)) : 1'd0;
    assign codasip_tmp_var_18 = ((((!codasip_tmp_var_14) && (!codasip_tmp_var_12)) && (!codasip_tmp_var_8)) && (!codasip_tmp_var_7)) ? (r_wb_csr_funct_Q0 == 3'd6) : 1'd0;
    assign exception_taken_B0 = codasip_tmp_var_7 ? 1'd1 :
        (((codasip_tmp_var_18 || codasip_tmp_var_12) || codasip_tmp_var_8) || codasip_tmp_var_14) ? 1'd1 : 1'd0;
    assign codasip_tmp_var_19 = (((((!codasip_tmp_var_18) && (!codasip_tmp_var_14)) && (!codasip_tmp_var_12)) && (!codasip_tmp_var_8)) && (!codasip_tmp_var_7)) ? r_wb_csr_write_Q0 : 1'd0;
    assign codasip_tmp_var_20 = codasip_tmp_var_19 ? (r_wb_csr_addr_Q0 == 12'd833) : 1'd0;
    assign codasip_tmp_var_21 = codasip_tmp_var_19 ? (r_wb_csr_addr_Q0 == 12'd834) : 1'd0;
    assign codasip_tmp_var_22 = codasip_tmp_var_19 ? (r_wb_csr_addr_Q0 == 12'd835) : 1'd0;
    assign codasip_tmp_var_23 = (r_wb_csr_write_Q0 && (r_wb_csr_addr_Q0 == 12'd768));
    assign codasip_tmp_var_24 = (!codasip_tmp_var_23) ? exception_taken_B0 : 1'd0;
    assign codasip_tmp_var_25 = ((!codasip_tmp_var_24) && (!codasip_tmp_var_23)) ? (r_wb_csr_funct_Q0 == 3'd7) : 1'd0;
    assign r_csr_mbadaddr_D0 = codasip_tmp_var_7 ? r_wb_result_Q0 :
        (codasip_tmp_var_10 || codasip_tmp_var_12) ? r_wb_result_Q0 :
        codasip_tmp_var_11 ? 32'd0 :
        codasip_tmp_var_8 ? r_wb_pc_Q0 :
        codasip_tmp_var_17 ? csr_data_write_B0 :
        codasip_tmp_var_18 ? 32'd0 :
        codasip_tmp_var_22 ? csr_data_write_B0 : 32'd0;
    assign r_csr_mbadaddr_WE0 = ((ACT == 1'd1) && codasip_tmp_var_7) ? 1'd1 :
        ((ACT == 1'd1) && (codasip_tmp_var_10 || codasip_tmp_var_12)) ? 1'd1 :
        ((ACT == 1'd1) && codasip_tmp_var_11) ? 1'd1 :
        ((ACT == 1'd1) && codasip_tmp_var_8) ? 1'd1 :
        ((ACT == 1'd1) && codasip_tmp_var_17) ? 1'd1 :
        ((ACT == 1'd1) && codasip_tmp_var_18) ? 1'd1 :
        ((ACT == 1'd1) && codasip_tmp_var_22) ? 1'd1 : 1'd0;
    assign r_csr_mcause_D0 = codasip_tmp_var_7 ? 32'd2 :
        codasip_tmp_var_8 ? {{28{1'b0}}, r_wb_exc_code_Q0} :
        codasip_tmp_var_13 ? $unsigned((((r_wb_mem_cmd_Q0 == 3'd1)) ? 32'sd4 : 32'sd6)) :
        codasip_tmp_var_12 ? $unsigned((((r_wb_mem_cmd_Q0 == 3'd1)) ? 32'sd5 : 32'sd7)) :
        codasip_tmp_var_14 ? {{28'd134217728,irq_code_B0},2'd3} :
        codasip_tmp_var_18 ? 32'd11 :
        codasip_tmp_var_21 ? {{csr_data_write_B0[31],27'd0},csr_data_write_B0[3:0]} : 32'd0;
    assign r_csr_mcause_WE0 = ((ACT == 1'd1) && codasip_tmp_var_7) ? 1'd1 :
        ((ACT == 1'd1) && codasip_tmp_var_8) ? 1'd1 :
        ((ACT == 1'd1) && codasip_tmp_var_13) ? 1'd1 :
        ((ACT == 1'd1) && codasip_tmp_var_12) ? 1'd1 :
        ((ACT == 1'd1) && codasip_tmp_var_14) ? 1'd1 :
        ((ACT == 1'd1) && codasip_tmp_var_18) ? 1'd1 :
        ((ACT == 1'd1) && codasip_tmp_var_21) ? 1'd1 : 1'd0;
    assign r_csr_mepc_D0 = codasip_tmp_var_7 ? (r_wb_pc_Q0 & 32'd4294967294) :
        codasip_tmp_var_9 ? (r_wb_exc_instr_addr_Q0 & 32'd4294967294) :
        (codasip_tmp_var_8 || codasip_tmp_var_12) ? (r_wb_pc_Q0 & 32'd4294967294) :
        codasip_tmp_var_15 ? (r_wb_result_Q0 & 32'd4294967294) :
        codasip_tmp_var_16 ? (s_wb_next_pc_Q0 & 32'd4294967294) :
        (codasip_tmp_var_18 || codasip_tmp_var_14) ? (r_wb_pc_Q0 & 32'd4294967294) :
        codasip_tmp_var_20 ? (csr_data_write_B0 & 32'd4294967294) : 32'd0;
    assign r_csr_mepc_WE0 = ((ACT == 1'd1) && codasip_tmp_var_7) ? 1'd1 :
        ((ACT == 1'd1) && codasip_tmp_var_9) ? 1'd1 :
        ((ACT == 1'd1) && (codasip_tmp_var_8 || codasip_tmp_var_12)) ? 1'd1 :
        ((ACT == 1'd1) && codasip_tmp_var_15) ? 1'd1 :
        ((ACT == 1'd1) && codasip_tmp_var_16) ? 1'd1 :
        ((ACT == 1'd1) && (codasip_tmp_var_18 || codasip_tmp_var_14)) ? 1'd1 :
        ((ACT == 1'd1) && codasip_tmp_var_20) ? 1'd1 : 1'd0;
    assign r_csr_mie_D0 = (csr_data_write_B0 & 32'd2184);
    assign r_csr_mie_WE0 = ((ACT == 1'd1) && codasip_tmp_var_6) ? 1'd1 : 1'd0;
    assign r_csr_mscratch_D0 = csr_data_write_B0;
    assign r_csr_mscratch_WE0 = ((ACT == 1'd1) && codasip_tmp_var_5) ? 1'd1 : 1'd0;
    assign r_csr_mstatus_D0 = codasip_tmp_var_23 ? {{3{1'b0}}, (((({csr_data_write_B0[28:24],24'd0} | {{11{1'b0}}, {csr_data_write_B0[17],17'd0}}) | 29'd6144) | {{21{1'b0}}, {csr_data_write_B0[7],7'd0}}) | {{25{1'b0}}, {csr_data_write_B0[3],3'd0}})} :
        codasip_tmp_var_24 ? {{3{1'b0}}, ((({r_csr_mstatus_Q0[28:24],24'd0} | {{11{1'b0}}, {r_csr_mstatus_Q0[17],17'd0}}) | 29'd6144) | {{21{1'b0}}, {r_csr_mstatus_Q0[3],7'd0}})} :
        codasip_tmp_var_25 ? {{3{1'b0}}, (({r_csr_mstatus_Q0[28:24],24'd0} | {{11{1'b0}}, {r_csr_mstatus_Q0[17],17'd0}}) | {{25{1'b0}}, {r_csr_mstatus_Q0[7],3'd0}})} : 32'd0;
    assign r_csr_mstatus_WE0 = ((ACT == 1'd1) && codasip_tmp_var_23) ? 1'd1 :
        ((ACT == 1'd1) && codasip_tmp_var_24) ? 1'd1 :
        ((ACT == 1'd1) && codasip_tmp_var_25) ? 1'd1 : 1'd0;
    assign r_csr_mtvec_D0 = (csr_data_write_B0 & 32'd4294967294);
    assign r_csr_mtvec_WE0 = ((ACT == 1'd1) && codasip_tmp_var_4) ? 1'd1 : 1'd0;
    assign s_wb_csr_data_D0 = (ACT == 1'd1) ? s_wb_csr_data_D0_ACT_wire : 32'd0;
    assign s_wb_exc_D0 = (ACT == 1'd1) ? exception_taken_B0 : 1'd0;
    assign s_wb_irq_D0 = (ACT == 1'd1) ? ((((s_irq_Q0 || r_wb_irq_Q0) && (!s_wb_stall_wb_Q0)) && r_csr_mstatus_Q0[3]) && (r_wb_csr_funct_Q0 != 3'd7)) : 1'd0;
    assign s_wb_irq_taken_D0 = (ACT == 1'd1) ? (s_wb_irq_Q0 && r_wb_instr_val_Q0) : 1'd0;
    assign s_wb_mret_D0 = (ACT == 1'd1) ? (r_wb_csr_funct_Q0 == 3'd7) : 1'd0;
    assign s_wb_next_pc_D0 = (ACT == 1'd1) ? ((r_wb_16b_instr_Q0) ? (r_wb_pc_Q0 + 32'd2) : (r_wb_pc_Q0 + 32'd4)) : 32'd0;
endmodule
