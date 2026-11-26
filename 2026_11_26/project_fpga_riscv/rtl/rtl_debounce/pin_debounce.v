 /*
 * Copyright (c) 2026. All rights reserved.
 *
 * Unauthorized copying, modification, distribution, or use
 * of this code is strictly prohibited without prior
 * written permission from the copyright owner.
 *
 * Date: 2026-11-11
 */
 

module pin_debounce(
	input	clk,//CLK 1m
	input	rst_n,
	input	pin_in,
	output	pin_out
);
reg [1:0] state;
reg [19:0]cnt;
always@(posedge clk or negedge rst_n)
	if(~rst_n)					state <= 0;
	else case(state)
		0:if(pin_in)			state <= 1;
		1:if(~pin_in)			state <= 0;
		  else if(cnt ==27_000_0)	state <= 2;
		2:if(~pin_in)			state <= 0;
		default:				state <= 0;
	endcase

always@(posedge clk or negedge rst_n)
	if(~rst_n)					cnt <= 0;
	else if(state ==1)			cnt <= cnt + 1'b1;
	else						cnt <= 0;

assign pin_out = (state==2) ? 1'b1 : 1'b0;

endmodule
