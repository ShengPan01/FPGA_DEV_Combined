 /*
 * Copyright (c) 2026. All rights reserved.
 *
 * Unauthorized copying, modification, distribution, or use
 * of this code is strictly prohibited without prior
 * written permission from the copyright owner.
 *
 * Date: 2026-11-11
 */
 

`include "i2c_master_define.v"


module i2c_m_bus_detect_hds (
    //input ports
    i2c_clk, //i2c clock
    resetn,     //reset active low
    scl_linkin,    //SCL signal, after glitch delete
    sda_linkin,    //SDA signal, after glitch delete 

    //output ports
    sda_negedge,//SDA negedge indication
    sda_posedge, //SDA posedge indication
    scl_negedge,//SCL negedge indication to capture data of SDA
    scl_posedge, //SCL posedge indication
    i2c_start, //i2c start indication
    i2c_stop  //i2c stop indication
    );
    //input ports
input           i2c_clk;
input           resetn;
input           scl_linkin;
input           sda_linkin;     

    //output ports
output          sda_negedge;
output          sda_posedge;
output          scl_negedge;
output          scl_posedge;
output          i2c_start; 
output          i2c_stop;    

/**************************************************************
*******************I2C bus detect using delay capture**********
**************************************************************/
wire            sda_negedge;  //SDA negedge inidication
wire            sda_posedge;  //SDA posedge indicaiton
wire            scl_negedge;  //scl_negedge output register    
wire            scl_posedge;  //scl_posedge output register
reg             i2c_start;   //i2c_start output register
reg             i2c_stop;    //i2c_stop output    register

reg     [1:0]   scl_pulse_sp;  //scl pulse sample delay
reg     [1:0]   sda_pulse_sp;  //sda pulse sample delay

//shift data in to detect the pulse
always @(posedge i2c_clk)
begin 
    if(~resetn)
        scl_pulse_sp[1:0] <= #`FFD 2'b00;
    else
       scl_pulse_sp[1:0] <= #`FFD { scl_pulse_sp[0], scl_linkin};//shift datain 
end

always @(posedge i2c_clk)
begin 
    if(~resetn)
        sda_pulse_sp[1:0] <= #`FFD 2'b00;
    else
        sda_pulse_sp[1:0] <= #`FFD {sda_pulse_sp[0], sda_linkin};//shift datain
end
//check the I2C bus to find start point
always @(scl_pulse_sp or sda_pulse_sp)
begin 
    if((scl_pulse_sp[1:0] == 2'b11) && (sda_pulse_sp[1:0] == 2'b10))
        i2c_start = 1'b1;
    else
        i2c_start = 1'b0;
end
//check the i2c to find stop point
always @(scl_pulse_sp or sda_pulse_sp)
begin 
    if((scl_pulse_sp[1:0] == 2'b11) && (sda_pulse_sp[1:0] == 2'b01))
        i2c_stop = 1'b1;
    else
        i2c_stop = 1'b0;
end
//generate the scl negedge point for FSM 
    
//always @(scl_pulse_sp)
//begin 
//    if(scl_pulse_sp[1:0]== 2'b10)
//        scl_negedge <= 1'b1;
//    else
//        scl_negedge <= 1'b0;
//end
////generate the scl posedge point for FSM
//always @(scl_pulse_sp)
//begin 
//    if(scl_pulse_sp[1:0] == 2'b01)
//        scl_posedge <= 1'b1;
//    else
//        scl_posedge <= 1'b0;
//end

assign scl_posedge = (scl_pulse_sp[1:0] == 2'b01)? 1'b1 : 1'b0;
assign scl_negedge = (scl_pulse_sp[1:0] == 2'b10)? 1'b1 : 1'b0;

assign sda_posedge = (sda_pulse_sp[1:0] == 2'b01)? 1'b1 : 1'b0;
assign sda_negedge = (sda_pulse_sp[1:0] == 2'b10)? 1'b1 : 1'b0;



endmodule











