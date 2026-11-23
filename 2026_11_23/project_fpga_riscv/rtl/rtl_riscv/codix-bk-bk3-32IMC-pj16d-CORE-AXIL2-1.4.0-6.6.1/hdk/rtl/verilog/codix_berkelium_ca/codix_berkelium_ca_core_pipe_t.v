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
 *  \brief   Contains module definition of the 'codix_berkelium_ca_core_pipe_t' pipeline controller.
 */

module codix_berkelium_ca_core_pipe_t(
    input  wire EX_clear_D0,
    input  wire EX_stall_D0,
    input  wire WB_clear_D0,
    input  wire WB_stall_D0,
    output wire EX_clear_Q0,
    output wire EX_stall_Q0,
    output wire WB_clear_Q0,
    output wire WB_stall_Q0
);
    // type, wire and constant declarations:

    // data-path code:
    assign EX_clear_Q0 = EX_clear_D0;
    assign EX_stall_Q0 = EX_stall_D0;
    assign WB_clear_Q0 = WB_clear_D0;
    assign WB_stall_Q0 = WB_stall_D0;
endmodule
