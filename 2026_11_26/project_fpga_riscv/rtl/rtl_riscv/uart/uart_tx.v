`include "define_uart.vh"
module uart_tx #(
    parameter clk_freq = 27_000_000
) (
	input		clk,
	input		rst_n,
	output reg	tx_o,
	input[7:0]	tx_data_i,
	input		tx_data_valid_i,
	output 		tx_rdy_o
);

localparam clk_div_num = clk_freq / `baud_ratio;

reg[7:0]tx_data_buffer;
reg[9:0]clk_regenerate_cnt;
reg	clk_regenerate_cnt_en;
reg[3:0]main_state;
always@(posedge clk or negedge rst_n)
	if(~rst_n)				tx_data_buffer <= 8'h0;
	else if(tx_rdy_o &&tx_data_valid_i)	tx_data_buffer <= tx_data_i;

always@(posedge clk or negedge rst_n)
	if(~rst_n)					clk_regenerate_cnt <= 0;
	else if(clk_regenerate_cnt ==clk_div_num)	clk_regenerate_cnt <= 0;
	else if(clk_regenerate_cnt_en)			clk_regenerate_cnt <= clk_regenerate_cnt + 1'b1;		

always@(posedge clk or negedge rst_n)
	if(~rst_n)					clk_regenerate_cnt_en <= 1'b0;
	else if(main_state == 0 && tx_data_valid_i)	clk_regenerate_cnt_en <= 1'b1;
	else if(main_state == 0)			clk_regenerate_cnt_en <= 1'b0;

always@(posedge clk or negedge rst_n)
	if(~rst_n)		main_state <= 0;
	else case(main_state)
		0:if(tx_data_valid_i)			main_state <= 1;
		1:if(clk_regenerate_cnt==clk_div_num)		main_state <= 2;//start bit
		2:if(clk_regenerate_cnt==clk_div_num)		main_state <= 3;//bit0
		3:if(clk_regenerate_cnt==clk_div_num)		main_state <= 4;//bit1
		4:if(clk_regenerate_cnt==clk_div_num)		main_state <= 5;//bit2
		5:if(clk_regenerate_cnt==clk_div_num)		main_state <= 6;//bit3
		6:if(clk_regenerate_cnt==clk_div_num)		main_state <= 7;//bit4
		7:if(clk_regenerate_cnt==clk_div_num)		main_state <= 8;//bit5
		8:if(clk_regenerate_cnt==clk_div_num)		main_state <= 9;//bit6
		9:if(clk_regenerate_cnt==clk_div_num)		main_state <= 10;//bit7
		10:if(clk_regenerate_cnt==clk_div_num)		main_state <= 11;//end bit
		11:main_state <=0;
		default:	main_state <= 0;
	endcase

always@(posedge clk or negedge rst_n)
	if(~rst_n)		tx_o <= 1'b1;
	else case(main_state)
		1:tx_o <= 1'b0;//start bit
		2:tx_o <= tx_data_buffer[0];//bit0
		3:tx_o <= tx_data_buffer[1];//bit1
		4:tx_o <= tx_data_buffer[2];//bit2
		5:tx_o <= tx_data_buffer[3];//bit3
		6:tx_o <= tx_data_buffer[4];//bit4
		7:tx_o <= tx_data_buffer[5];//bit5
		8:tx_o <= tx_data_buffer[6];//bit6
		9:tx_o <= tx_data_buffer[7];//bit7
		10:tx_o <= 1'b1;//end bit
		default:tx_o <= 1'b1;
	endcase

assign 	tx_rdy_o = (main_state ==0) ? 1'b1 : 1'b0;

endmodule
