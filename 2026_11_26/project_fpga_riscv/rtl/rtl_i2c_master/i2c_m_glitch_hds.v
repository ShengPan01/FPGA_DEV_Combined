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


module i2c_m_glitch_hds (        
//i2c_glitch input ports
     scl_in,   //I2C protocol SCL input 
     sda_in,   //I2C protocol SDA input
     i2c_clk,  //I2C signal sample clock
     resetn,   //sync reset active low]
     //add by wangxin 0323
     i2c_glh_sel,
//i2c_glitch output ports
     scl_linkin,  //deleted glitch scl
     sda_linkin      //deleted glitch sda
     );

//i2c_glitch input ports
input scl_in;   //I2C protocol SCL input 
input sda_in;   //I2C protocol SDA input
input i2c_clk;  //I2C signal sample clock
input resetn;   //sync reset active low
//add by wangxin 0323
input i2c_glh_sel;
//i2c_glitch output ports
output scl_linkin;  //deleted glitch scl
output sda_linkin;      //deleted glitch sda           



reg scl_linkin;    //scl output register
reg sda_linkin;    //sda output register
reg scl_in0, scl_in1; //double latch input data
reg sda_in0, sda_in1; //double latch input data

reg [4:0]scl_sample_shifter; //delete glitch shifter
reg [4:0]sda_sample_shifter; //delete glitch shifter
reg scl_glitch_indi; //indication glitch of scl
reg sda_glitch_indi; //indication glitch of sda
//add by wangxin 0323
reg scl_glitch_indi_0; //indication glitch of scl
reg sda_glitch_indi_0; //indication glitch of sda


//double latch data input
always @(posedge i2c_clk)
begin 
    scl_in0 <= #`FFD scl_in;
    scl_in1 <= #`FFD scl_in0;
end

always @(posedge i2c_clk)
begin 
    sda_in0 <= #`FFD sda_in;
    sda_in1 <= #`FFD sda_in0;
end

//shift data input
always @(posedge i2c_clk)
begin 
    if(~resetn)
         scl_sample_shifter[4:0] <= #`FFD 5'b00000;
    else
         scl_sample_shifter[4:0] <= #`FFD {scl_sample_shifter[3:0], scl_in1};
end
always @(posedge i2c_clk)
begin 
    if(~resetn)
        sda_sample_shifter[4:0] <= #`FFD 5'b00000;
    else
        sda_sample_shifter[4:0] <= #`FFD {sda_sample_shifter[3:0], sda_in1};
end

//generated scl and sda glitch indication 
//SCL
always @(posedge i2c_clk)
begin 
    if(~resetn)
        scl_glitch_indi <= #`FFD 1'b0;
    else
        if(scl_sample_shifter[4:0] == 5'b00000 || scl_sample_shifter[4:0] == 5'b00001 ||
            scl_sample_shifter[4:0] == 5'b00011 || scl_sample_shifter[4:0] == 5'b00111 || 
            scl_sample_shifter[4:0] == 5'b01111 || scl_sample_shifter[4:0] == 5'b10000 ||
            scl_sample_shifter[4:0] == 5'b11000 || scl_sample_shifter[4:0] == 5'b11100 ||
            scl_sample_shifter[4:0] == 5'b11110 || scl_sample_shifter[4:0] == 5'b11111)    
            //if has glitch 
            scl_glitch_indi <= #`FFD 1'b0;
        else
            scl_glitch_indi <= #`FFD 1'b1;
end
//SDA
always @(posedge i2c_clk)
begin 
    if(~resetn)
        sda_glitch_indi <= #`FFD 1'b0;
    else
        if(sda_sample_shifter[4:0] == 5'b00000 || sda_sample_shifter[4:0] == 5'b00001 ||
            sda_sample_shifter[4:0] == 5'b00011 || sda_sample_shifter[4:0] == 5'b00111 || 
            sda_sample_shifter[4:0] == 5'b01111 || sda_sample_shifter[4:0] == 5'b10000 ||
            sda_sample_shifter[4:0] == 5'b11000 || sda_sample_shifter[4:0] == 5'b11100 ||
            sda_sample_shifter[4:0] == 5'b11110 || sda_sample_shifter[4:0] == 5'b11111)    
            //if has glitch
            sda_glitch_indi <= #`FFD 1'b0;
        else
            sda_glitch_indi <= #`FFD 1'b1;
end

//add by wangxin 0323
//SCL
always @(posedge i2c_clk)
begin 
    if(~resetn)
        scl_glitch_indi_0 <= #`FFD 1'b0;
    else
        if(scl_sample_shifter[2:0]==3'b101||scl_sample_shifter[2:0]==3'b010)    
            //if has glitch 
            scl_glitch_indi_0 <= #`FFD 1'b1;
        else
            scl_glitch_indi_0 <= #`FFD 1'b0;
end
//SDA
always @(posedge i2c_clk)
begin 
    if(~resetn)
        sda_glitch_indi_0 <= #`FFD 1'b0;
    else
        if(sda_sample_shifter[2:0]==3'b101||sda_sample_shifter[2:0]==3'b010)    
            //if has glitch
            sda_glitch_indi_0 <= #`FFD 1'b1;
        else
            sda_glitch_indi_0 <= #`FFD 1'b0;
end


//final signal generate
always @(scl_glitch_indi or scl_sample_shifter[4:0] or sda_glitch_indi or sda_sample_shifter[4:0] or scl_glitch_indi_0 or sda_glitch_indi_0 or i2c_glh_sel)
begin 
  if(i2c_glh_sel)
    begin
    scl_linkin = scl_glitch_indi ^ scl_sample_shifter[4];
    sda_linkin = sda_glitch_indi ^ sda_sample_shifter[4];
    end
  else
    begin
      scl_linkin = scl_glitch_indi_0 ^ scl_sample_shifter[2];
      sda_linkin = sda_glitch_indi_0 ^ sda_sample_shifter[2];
    end
end



endmodule


