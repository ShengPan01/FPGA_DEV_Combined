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
 *  \brief   Contains module definition of the 'codix_berkelium_ca_core_wb_t' functional unit.
 */

module codix_berkelium_ca_core_wb_t(
    input  wire ACT,
    input  wire [31:0] if_ldst_Q0,
    input  wire [2:0] if_ldst_RESPONSE0,
    input  wire [2:0] r_wb_mem_type_Q0,
    input  wire r_wb_memop_Q0,
    input  wire [31:0] r_wb_writedata_Q0,
    input  wire s_wb_finish_stall_Q0,
    output wire [31:0] if_ldst_D0,
    output wire s_wb_finish_stall_D0,
    output wire [31:0] s_wb_mem_D0,
    output wire s_wb_mem_error_D0,
    output wire s_wb_mem_unaligned_D0,
    output wire s_wb_stall_wb_D0
);
    // type, wire and constant declarations:
    // signal/wire (inner)
    wire [31:0] data_mem_B0;
    // signal/wire (inner)
    wire [31:0] wb_response_rc_B0;

    // additional declarations:
    wire signed [31:0] tmp_codasip_conv_STATIC_CAST_2767_1;
    wire signed [31:0] tmp_codasip_conv_STATIC_CAST_2764_2;

    // conversions for data-path:
    assign tmp_codasip_conv_STATIC_CAST_2767_1 = $signed(data_mem_B0[7:0]);
    assign tmp_codasip_conv_STATIC_CAST_2764_2 = $signed(data_mem_B0[15:0]);
    // data-path code:
    assign wb_response_rc_B0 = {{29{1'b0}}, if_ldst_RESPONSE0};
    assign data_mem_B0 = if_ldst_Q0;
    assign if_ldst_D0 = r_wb_writedata_Q0;
    assign s_wb_finish_stall_D0 = (ACT == 1'd1) ? (wb_response_rc_B0 == 32'd2) : 1'd0;
    assign s_wb_mem_D0 = (ACT == 1'd1) ? $unsigned((((r_wb_mem_type_Q0 == 3'd1)) ? tmp_codasip_conv_STATIC_CAST_2767_1 : (((r_wb_mem_type_Q0 == 3'd2)) ? tmp_codasip_conv_STATIC_CAST_2764_2 : (((r_wb_mem_type_Q0 == 3'd5)) ? $signed({{24{1'b0}}, data_mem_B0[7:0]}) : (((r_wb_mem_type_Q0 == 3'd6)) ? $signed({{16{1'b0}}, data_mem_B0[15:0]}) : $signed(data_mem_B0)))))) : 32'd0;
    assign s_wb_mem_error_D0 = (ACT == 1'd1) ? (r_wb_memop_Q0 && ((wb_response_rc_B0 != 32'd2) && (wb_response_rc_B0 != 32'd1))) : 1'd0;
    assign s_wb_mem_unaligned_D0 = (ACT == 1'd1) ? (wb_response_rc_B0 == 32'd4) : 1'd0;
    assign s_wb_stall_wb_D0 = (ACT == 1'd1) ? s_wb_finish_stall_Q0 : 1'd0;
endmodule
