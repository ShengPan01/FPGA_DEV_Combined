`include "define_uart.vh"
module	uart_rx #(
    parameter clk_freq = 27_000_000
) (
	input		    clk,
	input		    rst_n,
	input		    rx_i,
	output reg[7:0]	rx_data_o,
	output reg	    rx_data_valid_o
);

localparam clk_div_num = clk_freq / `baud_ratio;
localparam clk_div_num_half = clk_freq / `baud_ratio/2;

reg[9:0] clk_sample_cnt;
reg      clk_sample_cnt_en;
reg      sample_valid;
reg[15:0]	rx_shift;
reg		rx_debounce;
reg[3:0]	main_state;	
// debounce the rx	
always@(posedge clk or negedge rst_n)
	if(~rst_n)	rx_shift <= 16'hffff;
	else		rx_shift <= {rx_shift[14:0],rx_i};
		
always@(posedge clk or negedge rst_n)
	if(~rst_n)		rx_debounce <= 1'b1;
	else if(&rx_shift)	rx_debounce <= 1'b1;
	else if(~|rx_shift)	rx_debounce <= 1'b0;

always@(posedge clk or negedge rst_n)
	if(~rst_n)				clk_sample_cnt <= 0;
	else if(main_state==0)			clk_sample_cnt <= 0;
	else if(clk_sample_cnt ==clk_div_num)	clk_sample_cnt <= 0;
	else if(clk_sample_cnt_en)		clk_sample_cnt <= clk_sample_cnt + 1'b1;

always@(posedge clk or negedge rst_n)
	if(~rst_n)                                     sample_valid <= 1'b0;
	else if(clk_sample_cnt == clk_div_num_half)   sample_valid <= 1'b1;
	else                                           sample_valid <= 1'b0;

always@(posedge clk or negedge rst_n)
	if(~rst_n)		main_state <= 0;
	else case(main_state)
		0: if(~rx_debounce)		main_state <= 1;
		1: if(clk_sample_cnt == clk_div_num)	main_state <= 2;//start bit
		2: if(clk_sample_cnt == clk_div_num)	main_state <= 3;//bit0
		3: if(clk_sample_cnt == clk_div_num)	main_state <= 4;//bit1
		4: if(clk_sample_cnt == clk_div_num)	main_state <= 5;//bit2
		5: if(clk_sample_cnt == clk_div_num)	main_state <= 6;//bit3
		6: if(clk_sample_cnt == clk_div_num)	main_state <= 7;//bit4
		7: if(clk_sample_cnt == clk_div_num)	main_state <= 8;//bit5
		8: if(clk_sample_cnt == clk_div_num)	main_state <= 9;//bit6
		9: if(clk_sample_cnt == clk_div_num)	main_state <= 10;//bit7
		10:if(clk_sample_cnt == clk_div_num_half)main_state <= 11;//end bit
		11:main_state <= 0;
		default:main_state <= 0;
	endcase			
always@(posedge clk or negedge rst_n)
	if(~rst_n)				clk_sample_cnt_en <= 1'b0;
	else if(main_state==0 && ~rx_debounce)	clk_sample_cnt_en <= 1'b1;
	else if(main_state ==0)			clk_sample_cnt_en <= 1'b0;		

always@(posedge clk or negedge rst_n)
	if(~rst_n)							rx_data_o 	<= 8'h0;
	else if(main_state==2 && sample_valid)	rx_data_o[0]	<= rx_debounce;
	else if(main_state==3 && sample_valid)	rx_data_o[1]	<= rx_debounce;
	else if(main_state==4 && sample_valid)	rx_data_o[2]	<= rx_debounce;
	else if(main_state==5 && sample_valid)	rx_data_o[3]	<= rx_debounce;
	else if(main_state==6 && sample_valid)	rx_data_o[4]	<= rx_debounce;
	else if(main_state==7 && sample_valid)	rx_data_o[5]	<= rx_debounce;
	else if(main_state==8 && sample_valid)	rx_data_o[6]	<= rx_debounce;
	else if(main_state==9 && sample_valid)	rx_data_o[7]	<= rx_debounce;
	else								rx_data_o	<= rx_data_o; 
always@(posedge clk or negedge rst_n)
	if(~rst_n)			rx_data_valid_o <= 1'b0;
	else if(main_state == 11)	rx_data_valid_o <= 1'b1;
	else				rx_data_valid_o <= 1'b0;

endmodule
