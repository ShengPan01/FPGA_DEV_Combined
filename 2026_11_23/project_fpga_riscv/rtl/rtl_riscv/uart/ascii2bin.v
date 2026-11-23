module ascii2bin(
	input		clk,
	input		rst_n,
	input[7:0]	ascii_high_i,
	input[7:0]	ascii_low_i,
	input		ascii_valid_i,
	output reg[7:0]	bin_data_o,
	output	reg	bin_valid_o
);

always@(posedge clk or negedge rst_n)
	if(~rst_n)		bin_data_o <= 8'hff;
	else if(ascii_valid_i)
		begin
		case(ascii_high_i)
			//0-9
			8'h30:		bin_data_o[7:4] <= 4'h0;
			8'h31:		bin_data_o[7:4] <= 4'h1;
			8'h32:		bin_data_o[7:4] <= 4'h2;
			8'h33:		bin_data_o[7:4] <= 4'h3;
			8'h34:		bin_data_o[7:4] <= 4'h4;
			8'h35:		bin_data_o[7:4] <= 4'h5;
			8'h36:		bin_data_o[7:4] <= 4'h6;
			8'h37:		bin_data_o[7:4] <= 4'h7;
			8'h38:		bin_data_o[7:4] <= 4'h8;
			8'h39:		bin_data_o[7:4] <= 4'h9;
			//A-F,a-f
			8'h41,8'h61:	bin_data_o[7:4] <= 4'ha;
			8'h42,8'h62:	bin_data_o[7:4] <= 4'hb;
			8'h43,8'h63:	bin_data_o[7:4] <= 4'hc;
			8'h44,8'h64:	bin_data_o[7:4] <= 4'hd;
			8'h45,8'h65:	bin_data_o[7:4] <= 4'he;
			8'h46,8'h66:	bin_data_o[7:4] <= 4'hf;
			default:bin_data_o[7:4] <= 4'hf;
		endcase
		case(ascii_low_i)
			//0-9
			8'h30:		bin_data_o[3:0] <= 4'h0;
			8'h31:		bin_data_o[3:0] <= 4'h1;
			8'h32:		bin_data_o[3:0] <= 4'h2;
			8'h33:		bin_data_o[3:0] <= 4'h3;
			8'h34:		bin_data_o[3:0] <= 4'h4;
			8'h35:		bin_data_o[3:0] <= 4'h5;
			8'h36:		bin_data_o[3:0] <= 4'h6;
			8'h37:		bin_data_o[3:0] <= 4'h7;
			8'h38:		bin_data_o[3:0] <= 4'h8;
			8'h39:		bin_data_o[3:0] <= 4'h9;
			//A-F,a-f
			8'h41,8'h61:	bin_data_o[3:0] <= 4'ha;
			8'h42,8'h62:	bin_data_o[3:0] <= 4'hb;
			8'h43,8'h63:	bin_data_o[3:0] <= 4'hc;
			8'h44,8'h64:	bin_data_o[3:0] <= 4'hd;
			8'h45,8'h65:	bin_data_o[3:0] <= 4'he;
			8'h46,8'h66:	bin_data_o[3:0] <= 4'hf;
			default:bin_data_o[3:0] <= 4'hf;
		endcase
		end
	else			bin_data_o <= 8'hff;
always@(posedge clk or negedge rst_n)
	if(~rst_n)		bin_valid_o<= 1'b0;
	else if(ascii_valid_i)	bin_valid_o<= 1'b1;
	else			bin_valid_o<= 1'b0;

endmodule

