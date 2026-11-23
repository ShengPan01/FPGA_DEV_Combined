module hex_analysis(
	input		clk,
	input		rst_n,	
	input[7:0]	rx_data_i,
	input		rx_data_valid_i,
    input       tx_rdy,
    output reg[15:0]ram_addr_h_o,
	output reg[15:0]ram_addr_o,
	output reg[7:0]	ram_data_o,
	output reg	ram_we_o,
	output		error_o,
	output [3:0] debug_state_o,
	output		final_done_o
);
reg [7:0]	line_data_length;
reg [15:0]	line_offset_addr;
reg [7:0]	line_data_type;//here we only support 0x00:data 0x01:end of file
reg [7:0]	ascii_high_in;
reg [7:0]	ascii_low_in;
reg		ascii_valid_in;
reg  		flag_highorlow;
wire[7:0]	bin_data_out;
wire		bin_valid_out;
reg [7:0]	data_cnt;
reg [7:0]	accsum;
wire[7:0]	checksum;

parameter HA_IDLE = 0;
parameter HA_END_OF_FILE = 11;
parameter HA_WAIT_FILE_END1 = 13;
parameter HA_WAIT_FILE_END2 = 14;

reg [3:0] 	main_state;
assign debug_state_o = main_state;
always@(posedge clk or negedge rst_n)
	if(~rst_n)	main_state <= HA_IDLE;
	else case(main_state)
		0:if(rx_data_i ==8'h3a && rx_data_valid_i)		main_state <= 1;//:
		1:if(bin_valid_out)					main_state <= 2;//1st byte
		2:if(bin_valid_out)					main_state <= 3;//2nd byte
		3:if(bin_valid_out)					main_state <= 4;//3rd byte
		4:/*if(bin_valid_out && bin_data_out==8'h00)		main_state <= 5;//4th byte
		  else*/ if(bin_valid_out && bin_data_out==8'h01)		main_state <= 10;
          else if(bin_valid_out)     main_state <= 5;
		5:if(data_cnt==line_data_length-1 && bin_valid_out)	main_state <= 6;//data
		6:if(bin_valid_out && (bin_data_out == checksum) )	main_state <= 8;//checksum
		  else if(bin_valid_out && (bin_data_out != checksum))  main_state <= 12;
		7:if(rx_data_i ==8'h0d && rx_data_valid_i)		main_state <= 8;
		  else if(rx_data_i !=8'h0d && rx_data_valid_i)		main_state <= 12;
		8: if (rx_data_valid_i)
        begin
            if (rx_data_i == 8'h0a)
                main_state <= 9;
            else if (rx_data_i ==8'h0d)
                main_state <= 8;
            else
                main_state <= 12;
        end
		9:							main_state <= 0;
		10:if(bin_valid_out && bin_data_out ==8'hff)		main_state <= HA_WAIT_FILE_END1;
	           else if(bin_valid_out && bin_data_out !=8'hff)	main_state <= 12;
	        HA_END_OF_FILE:							main_state <= HA_IDLE;
		12:							main_state <= 12;
        HA_WAIT_FILE_END1: 
            if (rx_data_valid_i && (rx_data_i == 8'h0a))
                main_state <= HA_WAIT_FILE_END2;
        HA_WAIT_FILE_END2:
            if (tx_rdy)
                main_state <= HA_END_OF_FILE;
//        13: if(data_cnt==line_data_length-1 && bin_valid_out) main_state <= 6; // high linear address
		default:						main_state <= HA_IDLE;
	endcase

always@(posedge clk or negedge rst_n)
	if(~rst_n)					flag_highorlow <= 1'b0;
	else if(main_state ==HA_IDLE)				flag_highorlow <= 1'b0;
	else if(rx_data_valid_i)			flag_highorlow <= ~flag_highorlow;
			
always@(posedge clk or negedge rst_n)
	if(~rst_n)					ascii_high_in <= 8'hff;
	else if(main_state ==HA_IDLE)				ascii_high_in <= 8'hff;
	else if(rx_data_valid_i &&  ~flag_highorlow)	ascii_high_in <= rx_data_i;	

always@(posedge clk or negedge rst_n)
	if(~rst_n)					ascii_low_in <= 8'hff;
	else if(main_state ==HA_IDLE)				ascii_low_in <= 8'hff;
	else if(rx_data_valid_i &&  flag_highorlow)	ascii_low_in <= rx_data_i;

always@(posedge clk or negedge rst_n)
	if(~rst_n)					ascii_valid_in <= 1'b0;
	else if(main_state ==HA_IDLE)				ascii_valid_in <= 1'b0;
	else if(rx_data_valid_i &&  flag_highorlow)	ascii_valid_in <= 1'b1;
	else						ascii_valid_in <= 1'b0;

always@(posedge clk or negedge rst_n)
	if(~rst_n)					line_data_length<= 8'h00;
	else if(main_state==HA_IDLE)				line_data_length<= 8'h00;
	else if(main_state==1 && bin_valid_out)		line_data_length<= bin_data_out;

always@(posedge clk or negedge rst_n)
	if(~rst_n)					line_offset_addr[15:8]<= 8'h00;
	else if(main_state==HA_IDLE)				line_offset_addr[15:8]<= 8'h00;
	else if(main_state==2 && bin_valid_out)		line_offset_addr[15:8]<= bin_data_out;

always@(posedge clk or negedge rst_n)
	if(~rst_n)					line_offset_addr[7:0]<= 8'h00;
	else if(main_state==HA_IDLE)				line_offset_addr[7:0]<= 8'h00;
	else if(main_state==3 && bin_valid_out)		line_offset_addr[7:0]<= bin_data_out;

always@(posedge clk or negedge rst_n)
	if(~rst_n)					line_data_type <= 8'h00;
	else if(main_state==HA_IDLE)				line_data_type <= 8'h00;
	else if(main_state==4 && bin_valid_out)		line_data_type <= bin_data_out;
		
always@(posedge clk or negedge rst_n)
	if(~rst_n)					data_cnt <= 0;
	else if(main_state==HA_IDLE)				data_cnt <= 0;
	else if((main_state==5)  && bin_valid_out)		data_cnt <= data_cnt + 1'b1;

always@(posedge clk or negedge rst_n)
	if(~rst_n)							accsum <= 8'h00;
	else if(main_state==HA_IDLE)						accsum <= 8'h00;
	else if((main_state>=1 && main_state<=5) && bin_valid_out)	accsum <= accsum + bin_data_out;
assign checksum = 9'h100 - accsum;

always@(posedge clk or negedge rst_n)
	if(~rst_n)			ram_addr_o <=16'h0;
	else if(main_state==5)		ram_addr_o <= line_offset_addr + data_cnt;

reg load_data;
reg load_addr_h;
reg load_ext_seg_addr_h;
always@(posedge clk or negedge rst_n)
    if(~rst_n)
    begin
        ram_addr_h_o <= 16'h0;
        load_addr_h <= 1'b0; 
        load_ext_seg_addr_h <= 1'b0; 
    end else if ((main_state == 4) && bin_valid_out && bin_data_out==8'h04)
        load_addr_h <= 1'b1;
    else if ((main_state == 4) && bin_valid_out && bin_data_out==8'h02)
        load_ext_seg_addr_h <= 1'b1;
    else if (main_state == 6)
        begin load_addr_h <= 1'b0;
		      load_ext_seg_addr_h <= 1'b0;
		end
    else if ((main_state == 5) && load_addr_h && bin_valid_out)
        ram_addr_h_o <= {ram_addr_h_o[7:0], bin_data_out};
    else if ((main_state == 5) && load_ext_seg_addr_h && bin_valid_out)
        ram_addr_h_o <= {12'h0,4'h1};

always@(posedge clk or negedge rst_n)
    if(~rst_n)
        load_data <= 1'b0;
    else if ((main_state == 4) && bin_valid_out && bin_data_out==8'h00)
        load_data <= 1'b1;
    else if ((main_state == 6) || (main_state == HA_IDLE))
        load_data <= 1'b0;
        
always@(posedge clk or negedge rst_n)
	if(~rst_n)			ram_data_o <= 8'h0;
	else if(main_state==5)		ram_data_o <= bin_data_out;

always@(posedge clk or negedge rst_n)
	if(~rst_n)			ram_we_o <= 1'b0;
	else if(main_state==5)		ram_we_o <= bin_valid_out & load_data;
	else				ram_we_o <= 1'b0;

assign final_done_o = (main_state == HA_END_OF_FILE) ? 1'b1 : 1'b0;
assign error_o	    = (main_state == 12) ? 1'b1 : 1'b0;
ascii2bin u1_ascii2bin(
	.clk		(clk),
	.rst_n		(rst_n),
	.ascii_high_i	(ascii_high_in),
	.ascii_low_i	(ascii_low_in),
	.ascii_valid_i	(ascii_valid_in),
	.bin_data_o	(bin_data_out),
	.bin_valid_o	(bin_valid_out)
);

endmodule
