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
 *  \brief   Contains module definition of the 'codix_berkelium_ca_core_ex_memory_t' functional unit.
 */

module codix_berkelium_ca_core_ex_memory_t(
    input  wire ACT,
    input  wire [1:0] if_ldst_STATUS0,
    input  wire [31:0] s_ex_add_result_Q0,
    input  wire [2:0] s_ex_mem_cmd_Q0,
    input  wire [2:0] s_ex_mem_type_Q0,
    input  wire s_ex_memop_Q0,
    input  wire s_ex_mul_div_stall_Q0,
    input  wire s_ex_raw_hazard_Q0,
    input  wire s_ex_request_stall_Q0,
    input  wire s_wb_exc_Q0,
    input  wire s_wb_irq_Q0,
    input  wire s_wb_mret_Q0,
    output wire [31:0] if_ldst_A0,
    output wire [2:0] if_ldst_BC0,
    output wire [1:0] if_ldst_BI0,
    output wire [2:0] if_ldst_REQUEST0,
    output wire s_ex_mem_error_D0,
    output wire s_ex_request_stall_D0,
    output wire s_ex_stall_ex_D0
);
    // type, wire and constant declarations:
    // signal/wire (inner)
    wire [2:0] codasip_tmp_var_0;
    // signal/wire (inner)
    wire codasip_tmp_var_1;
    // signal/wire (inner)
    wire [1:0] ex_mem_addr_mask_B0;
    // signal/wire (inner)
    wire [31:0] ex_mem_address_B0;
    // signal/wire (inner)
    wire ex_mem_ready_B0;
    // signal/wire (inner)
    wire [2:0] ex_mem_sbc_B0;
    // signal/wire (inner)
    wire [1:0] ex_mem_sbi_B0;
    // signal/wire (inner)
    wire [1:0] ex_request_rc_B0;

    // additional declarations:
    // temporal variable for multiplexer, should not be synthesized as register
    reg [1:0] tmp_codasip_conv_cs_ex_mem_addr_mask_B0_D0_mux_1;
    // temporal variable for multiplexer, should not be synthesized as register
    reg [1:0] tmp_codasip_conv_cs_ex_mem_sbi_B0_D0_mux_2;
    wire [31:0] tmp_codasip_conv_BITWISE_AND_5890_3;
    wire [31:0] tmp_codasip_conv_BITWISE_AND_5932_4;
    wire [31:0] tmp_codasip_conv_BITWISE_AND_5890_5;
    wire [31:0] tmp_codasip_conv_BITWISE_AND_5932_6;
    // temporal variable for multiplexer, should not be synthesized as register
    reg [2:0] tmp_codasip_conv_cs_ex_mem_sbc_B0_D0_mux_7;

    // conversions for data-path:
    assign tmp_codasip_conv_BITWISE_AND_5890_3 = $unsigned((s_ex_add_result_Q0 & 32'd3));
    assign tmp_codasip_conv_BITWISE_AND_5932_4 = $unsigned((s_ex_add_result_Q0 & 32'd2));
    assign tmp_codasip_conv_BITWISE_AND_5890_5 = $unsigned((s_ex_add_result_Q0 & 32'd3));
    assign tmp_codasip_conv_BITWISE_AND_5932_6 = $unsigned((s_ex_add_result_Q0 & 32'd2));
    // data-path code:
    assign codasip_tmp_var_0 = s_ex_mem_type_Q0;
    always @(*) begin
        case ( codasip_tmp_var_0 )
            3'd1: tmp_codasip_conv_cs_ex_mem_addr_mask_B0_D0_mux_1 = 2'd3;
            3'd2: tmp_codasip_conv_cs_ex_mem_addr_mask_B0_D0_mux_1 = 2'd2;
            3'd5: tmp_codasip_conv_cs_ex_mem_addr_mask_B0_D0_mux_1 = 2'd3;
            3'd6: tmp_codasip_conv_cs_ex_mem_addr_mask_B0_D0_mux_1 = 2'd2;
            default: tmp_codasip_conv_cs_ex_mem_addr_mask_B0_D0_mux_1 = 2'd0;
        endcase
    end
    assign ex_mem_addr_mask_B0 = tmp_codasip_conv_cs_ex_mem_addr_mask_B0_D0_mux_1;
    always @(*) begin
        case ( codasip_tmp_var_0 )
            3'd1: tmp_codasip_conv_cs_ex_mem_sbi_B0_D0_mux_2 = tmp_codasip_conv_BITWISE_AND_5890_3[1:0];
            3'd2: tmp_codasip_conv_cs_ex_mem_sbi_B0_D0_mux_2 = tmp_codasip_conv_BITWISE_AND_5932_4[1:0];
            3'd5: tmp_codasip_conv_cs_ex_mem_sbi_B0_D0_mux_2 = tmp_codasip_conv_BITWISE_AND_5890_5[1:0];
            3'd6: tmp_codasip_conv_cs_ex_mem_sbi_B0_D0_mux_2 = tmp_codasip_conv_BITWISE_AND_5932_6[1:0];
            default: tmp_codasip_conv_cs_ex_mem_sbi_B0_D0_mux_2 = 2'd0;
        endcase
    end
    assign ex_mem_sbi_B0 = tmp_codasip_conv_cs_ex_mem_sbi_B0_D0_mux_2;
    always @(*) begin
        case ( codasip_tmp_var_0 )
            3'd1: tmp_codasip_conv_cs_ex_mem_sbc_B0_D0_mux_7 = 3'd1;
            3'd2: tmp_codasip_conv_cs_ex_mem_sbc_B0_D0_mux_7 = 3'd2;
            3'd4: tmp_codasip_conv_cs_ex_mem_sbc_B0_D0_mux_7 = 3'd4;
            3'd5: tmp_codasip_conv_cs_ex_mem_sbc_B0_D0_mux_7 = 3'd1;
            3'd6: tmp_codasip_conv_cs_ex_mem_sbc_B0_D0_mux_7 = 3'd2;
            default: tmp_codasip_conv_cs_ex_mem_sbc_B0_D0_mux_7 = 3'd0;
        endcase
    end
    assign ex_mem_sbc_B0 = tmp_codasip_conv_cs_ex_mem_sbc_B0_D0_mux_7;
    assign ex_mem_address_B0 = (s_ex_add_result_Q0 & (~{{30{1'b0}}, ex_mem_addr_mask_B0}));
    assign ex_mem_ready_B0 = (((s_ex_memop_Q0 && (!s_ex_raw_hazard_Q0)) && (!s_wb_exc_Q0)) && (!s_wb_mret_Q0));
    assign codasip_tmp_var_1 = ex_mem_ready_B0;
    assign ex_request_rc_B0 = codasip_tmp_var_1 ? if_ldst_STATUS0 : 2'd1;
    assign if_ldst_A0 = ex_mem_address_B0;
    assign if_ldst_BC0 = ex_mem_sbc_B0;
    assign if_ldst_BI0 = ex_mem_sbi_B0;
    assign if_ldst_REQUEST0 = ((ACT == 1'd1) && codasip_tmp_var_1) ? s_ex_mem_cmd_Q0 : 3'd0;
    assign s_ex_mem_error_D0 = (ACT == 1'd1) ? ((ex_request_rc_B0 != 2'd0) && (ex_request_rc_B0 != 2'd1)) : 1'd0;
    assign s_ex_request_stall_D0 = (ACT == 1'd1) ? (ex_request_rc_B0 == 2'd0) : 1'd0;
    assign s_ex_stall_ex_D0 = (ACT == 1'd1) ? ((((s_ex_request_stall_Q0 || s_ex_raw_hazard_Q0) || (s_ex_mul_div_stall_Q0 && (!s_wb_irq_Q0))) && (!s_wb_exc_Q0)) && (!s_wb_mret_Q0)) : 1'd0;
endmodule
