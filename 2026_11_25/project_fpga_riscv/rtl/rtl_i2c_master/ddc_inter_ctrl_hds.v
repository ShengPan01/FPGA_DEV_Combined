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

module ddc_inter_ctrl_hds ( 
    //input ports
    i2c_clk,
    resetn,
    i2c_inter_start,   //start indication
    i2c_inter_stop,       //stop indication
    inter_ddc_cmd,
    dev_addr, //slave address
    segment_pointer,    // segment pointer in segment address of E_DDC
    offset_addr, //register address
    inter_ddc_data,
    inter_ddc_not_rdy,
    i2c_cycle,
    rcv_data,
    rcv_data_en,
    link_free,
    ddc_finish,
    i2c_link_stop,
    bus_arbt_lose,
    sda_chg_err,
    //abort_ddc_acs,
    reg_ddc_no_ack,
    reg_eddc_no_ack,
    
    //output ports
    ddc_busy,
    ddc_inter_rd, //i2c read data enable
    ddc_inter_data, //i2c read data bus
    data_line,
    ddc_tx_en, //write data enable: write active high
    ddc_rx_en, //read data enable: read active high
    ddc_rst_start,
    ddc_restart,
    ddc_stop,
    ddc_wait,
    ddc_master_err,
    ddc_no_ack,
    crnt_ddc_state
    );

    //input ports
input           i2c_clk;
input           resetn;
input           i2c_inter_start;   //start indication
input           i2c_inter_stop;       //stop indication
input   [2:0]   inter_ddc_cmd;
input   [7:0]   dev_addr; //slave address
input   [7:0]   segment_pointer;
input   [7:0]   offset_addr; //register address
input   [7:0]   inter_ddc_data;
input           inter_ddc_not_rdy;
input           i2c_cycle;
input           rcv_data;
input           rcv_data_en;
input           ddc_finish;
input           i2c_link_stop;
input           bus_arbt_lose;
input           sda_chg_err;
//input           abort_ddc_acs;
input           reg_ddc_no_ack;
input           reg_eddc_no_ack;
input           link_free;

    //output ports
output          ddc_busy;
output          ddc_inter_rd; //i2c read data enable
output  [7:0]   ddc_inter_data; //i2c read data bus
output          data_line;
output          ddc_tx_en; //write data enable: write active high
output          ddc_rx_en; //read data enable: read active high
output          ddc_rst_start;
output          ddc_restart;
output          ddc_stop;
output          ddc_wait;
output          ddc_master_err; // Debug information
output          ddc_no_ack;
output  [4:0]   crnt_ddc_state;

reg             ddc_busy;
reg             ddc_inter_rd; //i2c read data enable
reg     [7:0]   ddc_inter_data; //i2c read data bus
reg             data_line;
reg             ddc_tx_en; //write data enable: write active high
reg             ddc_rx_en; //read data enable: read active high
reg             ddc_restart;
reg             ddc_stop;
reg             ddc_wait;
reg             ddc_master_err;
reg             ddc_no_ack;

//list of register and signals
reg             slave_ack;
reg     [6:0]   sla_addr;
reg     [7:0]   segment_addr;
reg     [7:0]   sgmt_pntr;
reg     [7:0]   offset;
reg     [7:0]   wr_data; 
reg     [7:0]   i2c_inter_rd_data;
reg     [3:0]   i2c_cycle_cnt;
reg     [4:0]   crnt_ddc_state;
reg     [4:0]   next_ddc_state;

// HDCP DDC (I2C) Master Inter control state
parameter DDC_IDLE          = 5'b00000;
parameter DDC_START         = 5'b00001;
parameter DDC_SLA_ADDR      = 5'b00010;
parameter DDC_WR_FLAG       = 5'b00011;
parameter DDC_1ST_ACK       = 5'b00100;
parameter DDC_REG_ADDR      = 5'b00101;
parameter DDC_2ND_ACK       = 5'b00110;
parameter DDC_RE_START      = 5'b00111;
parameter DDC_SLA_ADDR_2    = 5'b01000;
parameter DDC_WR_FLAG_2     = 5'b01001;
parameter DDC_3RD_ACK       = 5'b01010;
parameter DDC_BYTE_RD       = 5'b01011;
parameter DDC_BR_ACK        = 5'b01100;
parameter DDC_BYTE_WR       = 5'b01101;
parameter DDC_BW_ACK        = 5'b01110;
parameter DDC_MSG_RD        = 5'b01111;
parameter DDC_MR_ACK        = 5'b10000;
parameter DDC_STOP          = 5'b10001;
parameter E_DDC_SGMT_ADDR   = 5'b10010;
parameter E_DDC_1ST_ACK     = 5'b10011;
parameter E_DDC_SGMT_PNTR   = 5'b10100;
parameter E_DDC_2ND_ACK     = 5'b10101;
parameter E_DDC_RE_START    = 5'b10110;
parameter DDC_ACC_ERROR     = 5'b10111;
parameter I2C_RST_START     = 5'b11000;

//-----------------------------------------
// DDC command define
//-----------------------------------------
parameter BYTE_READ    = 3'b000;
parameter BYTE_WRITE   = 3'b001;
parameter MSG_READ     = 3'b010;
parameter E_DDC_READ   = 3'b011;
parameter I2C_RESET    = 3'b100;

assign  ddc_rst_start = (inter_ddc_cmd == I2C_RESET);

always @(/*AUTOSENSE*/crnt_ddc_state or ddc_finish or ddc_rst_start
	 or i2c_cycle or i2c_cycle_cnt or i2c_inter_start
	 or i2c_inter_stop or i2c_link_stop or inter_ddc_cmd
	 or link_free or reg_ddc_no_ack or reg_eddc_no_ack
	 or slave_ack) begin
    casez (crnt_ddc_state)
        DDC_IDLE : begin
            if (i2c_inter_start && ddc_rst_start && link_free)
                next_ddc_state = I2C_RST_START;
            else if (i2c_inter_start && link_free)
                next_ddc_state = DDC_START;
            else if (i2c_inter_start)
                next_ddc_state = DDC_ACC_ERROR;
            else
                next_ddc_state = DDC_IDLE;
          end
        I2C_RST_START : begin
            if (i2c_cycle)
                next_ddc_state = DDC_BYTE_RD; // For I2C reset command, state transter to read period
            else
                next_ddc_state = I2C_RST_START;
          end
        DDC_START : begin
            if (i2c_cycle && (inter_ddc_cmd == E_DDC_READ))
                next_ddc_state = E_DDC_SGMT_ADDR;
            else if (i2c_cycle)
                next_ddc_state = DDC_SLA_ADDR; //if write enable, means state will transter to write slave address
            else
                next_ddc_state = DDC_START;
          end
        E_DDC_SGMT_ADDR : begin
            if (i2c_cycle && (i2c_cycle_cnt == 4'd8))
                next_ddc_state = E_DDC_1ST_ACK;
            else
                next_ddc_state = E_DDC_SGMT_ADDR;
          end
        E_DDC_1ST_ACK : begin
            if (i2c_cycle && (!reg_eddc_no_ack) && slave_ack)
                next_ddc_state = DDC_STOP;
            else if (i2c_cycle)
                next_ddc_state = E_DDC_SGMT_PNTR;
            else
                next_ddc_state = E_DDC_1ST_ACK;
          end
        E_DDC_SGMT_PNTR : begin
            if (i2c_cycle && (i2c_cycle_cnt == 4'd8))
                next_ddc_state = E_DDC_2ND_ACK;
            else
                next_ddc_state = E_DDC_SGMT_PNTR;
          end
        E_DDC_2ND_ACK : begin
            if (i2c_cycle && (!reg_eddc_no_ack) && slave_ack)
                next_ddc_state = DDC_STOP;
            else if (i2c_cycle)
                next_ddc_state = E_DDC_RE_START;
            else
                next_ddc_state = E_DDC_2ND_ACK;
          end
        E_DDC_RE_START : begin
            if (i2c_cycle)
                next_ddc_state = DDC_SLA_ADDR;
            else
                next_ddc_state = E_DDC_RE_START;
          end
        DDC_SLA_ADDR : begin
            if (i2c_cycle && (i2c_cycle_cnt == 4'd7))
                next_ddc_state = DDC_WR_FLAG;
            else
                next_ddc_state = DDC_SLA_ADDR;
          end
        DDC_WR_FLAG : begin
            if(i2c_cycle)
                next_ddc_state = DDC_1ST_ACK;
            else
                next_ddc_state = DDC_WR_FLAG;
          end
        DDC_1ST_ACK : begin
            if (i2c_cycle && (!reg_ddc_no_ack) && slave_ack)
                next_ddc_state = DDC_STOP;
            else if (i2c_cycle && (inter_ddc_cmd == MSG_READ))
                next_ddc_state = DDC_MSG_RD;
            else if (i2c_cycle && (inter_ddc_cmd != MSG_READ))
                next_ddc_state = DDC_REG_ADDR;
            else
                next_ddc_state = DDC_1ST_ACK;
          end
        DDC_REG_ADDR : begin
            if (i2c_cycle && (i2c_cycle_cnt == 4'd8))
                next_ddc_state = DDC_2ND_ACK;
            else
                next_ddc_state = DDC_REG_ADDR;
          end
        DDC_2ND_ACK : begin
            if (i2c_cycle && (!reg_ddc_no_ack) && slave_ack)
                next_ddc_state = DDC_STOP;
            else if (i2c_cycle && (inter_ddc_cmd == BYTE_READ || inter_ddc_cmd == E_DDC_READ))
                next_ddc_state = DDC_RE_START;
            else if (i2c_cycle && (inter_ddc_cmd == BYTE_WRITE))
                next_ddc_state = DDC_BYTE_WR;
            else
                next_ddc_state = DDC_2ND_ACK;
          end
        DDC_RE_START : begin
            if (i2c_cycle)
                next_ddc_state = DDC_SLA_ADDR_2; //if write enable, means state will transter to write slave address
            else
                next_ddc_state = DDC_RE_START;
          end
        DDC_SLA_ADDR_2 : begin
            if (i2c_cycle && (i2c_cycle_cnt == 4'd7))
                next_ddc_state = DDC_WR_FLAG_2;
            else
                next_ddc_state = DDC_SLA_ADDR_2;
          end
        DDC_WR_FLAG_2 : begin
            if (i2c_cycle)
                next_ddc_state = DDC_3RD_ACK;
            else
                next_ddc_state = DDC_WR_FLAG_2;
          end
        DDC_3RD_ACK : begin
            if (i2c_cycle && (!reg_ddc_no_ack) && slave_ack)
                next_ddc_state = DDC_STOP;
            else if (i2c_cycle)
                next_ddc_state = DDC_BYTE_RD;
            else
                next_ddc_state = DDC_3RD_ACK;
          end
        DDC_BYTE_RD : begin
            if (i2c_cycle && (i2c_cycle_cnt == 4'd8))
                next_ddc_state = DDC_BR_ACK;
            else
                next_ddc_state = DDC_BYTE_RD;
          end
        DDC_BR_ACK : begin
            if (i2c_cycle && i2c_inter_stop)
                next_ddc_state = DDC_STOP;
            else if (i2c_cycle)
                next_ddc_state = DDC_BYTE_RD;
            else
                next_ddc_state = DDC_BR_ACK;
          end
        DDC_BYTE_WR : begin
            if (i2c_cycle && (i2c_cycle_cnt == 4'd8))
                next_ddc_state = DDC_BW_ACK;
            else
                next_ddc_state = DDC_BYTE_WR;
          end
        DDC_BW_ACK : begin
            if (i2c_cycle && ((!reg_ddc_no_ack) && slave_ack || i2c_inter_stop))
                next_ddc_state = DDC_STOP;
            else if (i2c_cycle)
                next_ddc_state = DDC_BYTE_WR;
            else
                next_ddc_state = DDC_BW_ACK;
          end
        DDC_MSG_RD : begin
            if(i2c_cycle && (i2c_cycle_cnt == 4'd8))
                next_ddc_state = DDC_MR_ACK;
            else
                next_ddc_state = DDC_MSG_RD;
          end
        DDC_MR_ACK : begin
            if(i2c_cycle && i2c_inter_stop)
                next_ddc_state = DDC_STOP;
            else if (i2c_cycle)
                next_ddc_state = DDC_MSG_RD;
            else
                next_ddc_state = DDC_MR_ACK;
          end
        DDC_STOP : begin
            if (ddc_finish)
                next_ddc_state = DDC_IDLE;
            else
                next_ddc_state = DDC_STOP;
          end
        DDC_ACC_ERROR : begin
            if (i2c_link_stop)
                next_ddc_state = DDC_IDLE;    //complete error report, back to DDC_IDLE
            else
                next_ddc_state = DDC_ACC_ERROR;
            end
        default : next_ddc_state = DDC_IDLE;
    endcase
  end

//sync part of the state machine
always @(posedge i2c_clk) begin
    if (!resetn)
        crnt_ddc_state <= #`FFD DDC_IDLE;
    //else if (abort_ddc_acs && (crnt_ddc_state != DDC_IDLE) && (crnt_ddc_state != DDC_START))
    //    crnt_ddc_state <= #`FFD DDC_STOP;
    else if (bus_arbt_lose && (crnt_ddc_state != DDC_ACC_ERROR))
        crnt_ddc_state <= #`FFD DDC_ACC_ERROR;
    else
        crnt_ddc_state <= #`FFD next_ddc_state;
  end     

/******************************************control and data lacth****************************/      
always @(posedge i2c_clk)
    if (~resetn)
        i2c_cycle_cnt <= #`FFD 4'h1;
    else begin
        casez (crnt_ddc_state)
            DDC_SLA_ADDR, DDC_REG_ADDR, DDC_SLA_ADDR_2,
            DDC_BYTE_RD, DDC_BYTE_WR, DDC_MSG_RD,
            E_DDC_SGMT_ADDR, E_DDC_SGMT_PNTR: begin
                if (i2c_cycle)
                    i2c_cycle_cnt <= #`FFD i2c_cycle_cnt + 1'b1;
              end
            default:
                i2c_cycle_cnt <= #`FFD 4'h1;
        endcase
      end

//latch the slave address
always @(posedge i2c_clk)
    if (~resetn)                
        sla_addr[6:0] <= #`FFD 7'h00;
    else if (((crnt_ddc_state == DDC_START) || (crnt_ddc_state == E_DDC_RE_START)) && i2c_cycle)
        sla_addr[6:0] <= #`FFD dev_addr[7:1];
    else if (((crnt_ddc_state == DDC_SLA_ADDR) || (crnt_ddc_state == DDC_SLA_ADDR_2)) && i2c_cycle)
        sla_addr[6:0] <= #`FFD {sla_addr[5:0], sla_addr[6]};

//latch the segment address
always @(posedge i2c_clk)
    if (~resetn)                
        segment_addr <= #`FFD 8'h60;
    else if ((crnt_ddc_state == DDC_START) && i2c_cycle)
        segment_addr <= #`FFD 8'h60;
    else if ((crnt_ddc_state == E_DDC_SGMT_ADDR) && i2c_cycle)
        segment_addr[7:0] <= #`FFD {segment_addr[6:0], segment_addr[7]};

//latch the segment address
always @(posedge i2c_clk)
    if (~resetn)                
        sgmt_pntr <= #`FFD 8'h00;
    else if ((crnt_ddc_state == E_DDC_1ST_ACK) && i2c_cycle)
        sgmt_pntr <= #`FFD segment_pointer;
    else if ((crnt_ddc_state == E_DDC_SGMT_PNTR) && i2c_cycle)
        sgmt_pntr[7:0] <= #`FFD {sgmt_pntr[6:0], sgmt_pntr[7]};

//latch the offset
always @(posedge i2c_clk) begin
    if(~resetn)
        offset <= #`FFD 8'h0;
    else if ((crnt_ddc_state == DDC_1ST_ACK) && i2c_cycle)
        offset <= #`FFD offset_addr;
    else if ((crnt_ddc_state == DDC_REG_ADDR) && i2c_cycle)
        offset <= #`FFD {offset[6:0], offset[7]};
  end

//latch the write data
always @(posedge i2c_clk) begin
    if(~resetn)
        wr_data <= #`FFD 8'h0;
    else if (((crnt_ddc_state == DDC_2ND_ACK) || (crnt_ddc_state == DDC_BW_ACK)) && i2c_cycle)
        wr_data <= #`FFD inter_ddc_data;
    else if ((crnt_ddc_state == DDC_BYTE_WR) && i2c_cycle)
        wr_data <= #`FFD {wr_data[6:0], wr_data[7]};
  end

//generate writing data and the ack for Link FSM
always @(posedge i2c_clk) begin
    if (~resetn)
        data_line <= #`FFD 1'b0;
    else if(crnt_ddc_state == E_DDC_SGMT_ADDR)   //the segment address for E_DDC
        data_line <= #`FFD segment_addr[7];
    else if(crnt_ddc_state == E_DDC_SGMT_PNTR)   //the segment point for E_DDC
        data_line <= #`FFD sgmt_pntr[7];
    else if(crnt_ddc_state == DDC_SLA_ADDR)   //the first slave address
        data_line <= #`FFD sla_addr[6];
    else if(crnt_ddc_state == DDC_WR_FLAG)   //write/read flag after the first slave address
        casez (inter_ddc_cmd)
            MSG_READ:
                data_line <= #`FFD 1'b1;
            BYTE_READ, BYTE_WRITE, E_DDC_READ:
                data_line <= #`FFD 1'b0;
        endcase
    else if(crnt_ddc_state == DDC_REG_ADDR)   //the offset address
        data_line <= #`FFD offset[7];
    else if(crnt_ddc_state == DDC_WR_FLAG_2)   //write/read flag after the second slave address
        data_line <= #`FFD 1'b1;
    else if(crnt_ddc_state == DDC_BYTE_WR)   //the writing data
        data_line <= #`FFD wr_data[7];
    else if(crnt_ddc_state == DDC_SLA_ADDR_2)   //the second slave address
        data_line <= #`FFD sla_addr[6];
    else if(((crnt_ddc_state == DDC_BR_ACK) || (crnt_ddc_state == DDC_MR_ACK)) && i2c_inter_stop)   //read ack
        data_line <= #`FFD 1'b1;
    else if((crnt_ddc_state == DDC_BR_ACK) || (crnt_ddc_state == DDC_MR_ACK))   //read ack
        data_line <= #`FFD 1'b0;
  end

//write control for Link timine FSM
always @(posedge i2c_clk) begin
    casez (crnt_ddc_state)
        DDC_START, DDC_SLA_ADDR, DDC_WR_FLAG, DDC_REG_ADDR, DDC_RE_START, DDC_STOP,
        DDC_SLA_ADDR_2, DDC_WR_FLAG_2, DDC_BYTE_WR, DDC_BR_ACK, DDC_MR_ACK,
        E_DDC_SGMT_ADDR, E_DDC_SGMT_PNTR, E_DDC_RE_START:
            ddc_tx_en <= #`FFD 1'b1;
        default:
            ddc_tx_en <= #`FFD 1'b0;
    endcase
  end

//read control for Link timine FSM
always @(posedge i2c_clk) begin
    casez (crnt_ddc_state)
        DDC_1ST_ACK, DDC_2ND_ACK, DDC_3RD_ACK, DDC_BYTE_RD, DDC_BW_ACK, DDC_MSG_RD,
        E_DDC_1ST_ACK, E_DDC_2ND_ACK :
            ddc_rx_en <= #`FFD 1'b1;
        default:
            ddc_rx_en <= #`FFD 1'b0;
    endcase
  end

//re-start control for Link timine FSM
always @(posedge i2c_clk) begin
    casez (crnt_ddc_state)
        DDC_RE_START, E_DDC_RE_START :
            ddc_restart <= #`FFD 1'b1;
        default:
            ddc_restart <= #`FFD 1'b0;
    endcase
  end

//stop control for Link timine FSM
always @(posedge i2c_clk) begin
    casez (crnt_ddc_state)
        DDC_STOP:
            ddc_stop <= #`FFD 1'b1;
        default:
            ddc_stop <= #`FFD 1'b0;
    endcase
  end

//Latch slave ack from Link timine FSM
always @(posedge i2c_clk) begin
    casez (crnt_ddc_state)
        DDC_1ST_ACK, DDC_2ND_ACK, DDC_3RD_ACK, DDC_BW_ACK,
        E_DDC_1ST_ACK, E_DDC_2ND_ACK:
            begin
                if (rcv_data_en)
                    slave_ack <= #`FFD rcv_data;
            end
        default:
            slave_ack <= #`FFD 1'b1;
    endcase
  end

//generate the new data enable and output data to inter logic
always @(posedge i2c_clk) begin
    if (~resetn)
        ddc_inter_data <= #`FFD 8'h0;
    else if (((crnt_ddc_state == DDC_BYTE_RD) || (crnt_ddc_state == DDC_MSG_RD)) && i2c_cycle && (i2c_cycle_cnt == 4'd8))
        ddc_inter_data <= #`FFD i2c_inter_rd_data; //data latch
  end

always @(posedge i2c_clk) begin
    if (~resetn)
        ddc_inter_rd <= #`FFD 1'b0;
    else if (((crnt_ddc_state == DDC_BYTE_RD) || (crnt_ddc_state == DDC_MSG_RD) || (crnt_ddc_state == DDC_BYTE_WR)) && i2c_cycle && (i2c_cycle_cnt == 4'd8))
        ddc_inter_rd <= #`FFD 1'b1;
    else
        ddc_inter_rd <= #`FFD 1'b0;
  end

//read data from ddc_link
always @(posedge i2c_clk) begin
    if (~resetn)
        i2c_inter_rd_data <= #`FFD 8'h0;
    else if (((crnt_ddc_state == DDC_BYTE_RD) || (crnt_ddc_state == DDC_MSG_RD)) && rcv_data_en)
        begin
            i2c_inter_rd_data[7:1] <= #`FFD i2c_inter_rd_data[6:0];
            i2c_inter_rd_data[0] <= #`FFD rcv_data;
        end
  end

//generate DDC busy signal
always @(posedge i2c_clk) begin
    casez (crnt_ddc_state)
        DDC_START, DDC_SLA_ADDR, DDC_WR_FLAG, DDC_1ST_ACK, DDC_REG_ADDR, DDC_2ND_ACK, DDC_RE_START, DDC_STOP,
        DDC_SLA_ADDR_2, DDC_WR_FLAG_2, DDC_3RD_ACK, DDC_BYTE_RD, DDC_BYTE_WR, DDC_BW_ACK, DDC_BR_ACK, DDC_MR_ACK,
        DDC_MSG_RD, E_DDC_SGMT_ADDR, E_DDC_1ST_ACK, E_DDC_SGMT_PNTR, E_DDC_2ND_ACK, E_DDC_RE_START, I2C_RST_START:
            ddc_busy <= #`FFD 1'b1;
        default:
            ddc_busy <= #`FFD 1'b0;
    endcase
  end

//generate DDC link wait signal
always @(posedge i2c_clk) begin
    if (~resetn)
        ddc_wait <= #`FFD 1'b0;
    else if (((crnt_ddc_state == DDC_BYTE_RD) || (crnt_ddc_state == DDC_MSG_RD)
             || (crnt_ddc_state == DDC_BYTE_WR)) && inter_ddc_not_rdy && (i2c_cycle_cnt == 4'd8))
        ddc_wait <= #`FFD 1'b1;
    else
        ddc_wait <= #`FFD 1'b0;
  end

// DDC Master Error Generation
always @(posedge i2c_clk)
    if(~resetn)
        ddc_master_err <= #`FFD 1'b0;
    else if((crnt_ddc_state == DDC_ACC_ERROR) || sda_chg_err)
        ddc_master_err <= #`FFD 1'b1;
    else
        ddc_master_err <= #`FFD 1'b0;

// DDC Master No-Ack Report
always @(posedge i2c_clk)
    if (~resetn)
        ddc_no_ack <= #`FFD 1'b0;
    else begin
        casez (crnt_ddc_state)
            E_DDC_1ST_ACK, E_DDC_2ND_ACK :
                if (i2c_cycle && slave_ack && (~reg_eddc_no_ack))
                    ddc_no_ack <= #`FFD 1'b1;
            DDC_1ST_ACK, DDC_2ND_ACK, DDC_3RD_ACK, DDC_BW_ACK :
                if (i2c_cycle && slave_ack && (~reg_ddc_no_ack))
                    ddc_no_ack <= #`FFD 1'b1;
            DDC_IDLE :
                ddc_no_ack <= #`FFD 1'b0;
        endcase
      end


endmodule
