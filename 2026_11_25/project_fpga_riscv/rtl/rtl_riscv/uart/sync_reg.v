//*****************************************************************************
// Copyright (c) 2002 ~ 2007 Analogix Semiconductor Incorporated
// All Rights Reserved
//
// THIS IS UNPUBLISHED PROPRIETARY SOURCE CODE of Analogix Semiconductor Inc.
// The copyright notice above does not evidence any actual or intended
// publication of such source code.
//
// No part of this code may be reproduced, stored in a retrieval system,
// or transmitted, in any form or by any means, electronic, mechanical,
// photocopying, recording, or otherwise, without the prior written
// permission of Analogix Semiconductor Inc.
//
//*****************************************************************************
`ifndef FFD
    `define FFD 1
`endif

module sync_reg(
    clk,
    din,

    dout);

parameter size = 1;

input clk;
input [size-1:0] din;
output [size-1:0] dout;

reg [size-1:0] dout;

// RTL begins here

reg [size-1:0] din_d;

always @(posedge clk) begin
   din_d <= #`FFD din;
   dout <= #`FFD din_d;
end

endmodule


