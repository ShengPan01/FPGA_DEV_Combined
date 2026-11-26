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
 *  \brief   Contains module definition of the 'codix_berkelium_ca_core_halt_t' functional unit.
 */

module codix_berkelium_ca_core_halt_t(
    input  wire ACT,
    output wire codasip_halt_wire_D0
);
    // type, wire and constant declarations:

    // data-path code:
    assign codasip_halt_wire_D0 = (ACT == 1'd1) ? 1'd1 : 1'd0;
endmodule
