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
 *  \brief   Contains module definition of the 'codix_berkelium_ca_if_fetch_t' CodAL interface.
 */

module codix_berkelium_ca_if_fetch_t(
    input  wire [1:0] if_fetch_STATUS0,
    input  wire [2:0] if_fetch_RESPONSE0,
    input  wire [31:0] if_fetch_Q0,
    input  wire [2:0] REQUEST0,
    input  wire [31:0] A0,
    input  wire [1:0] BI0,
    input  wire [2:0] BC0,
    input  wire [31:0] D0,
    output wire [2:0] if_fetch_REQUEST0,
    output wire [31:0] if_fetch_A0,
    output wire [1:0] if_fetch_BI0,
    output wire [2:0] if_fetch_BC0,
    output wire [31:0] if_fetch_D0,
    output wire [1:0] STATUS0,
    output wire [2:0] RESPONSE0,
    output wire [31:0] Q0
);
    // type, wire and constant declarations:

    // data-path code:
    assign if_fetch_A0 = A0;
    assign if_fetch_BI0 = BI0;
    assign if_fetch_BC0 = BC0;
    assign if_fetch_REQUEST0 = REQUEST0;
    assign STATUS0 = if_fetch_STATUS0;
    assign RESPONSE0 = if_fetch_RESPONSE0;
    assign Q0 = if_fetch_Q0;
    assign if_fetch_D0 = D0;
endmodule
