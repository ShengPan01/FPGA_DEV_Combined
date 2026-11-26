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


module i2c_m_fsm_hds(
    //input ports
    i2c_clk,
    resetn,
    scl_negedge,
    scl_posedge,
    i2c_link_start,
    i2c_link_stop,
    i2c_inter_start,
    sda_negedge,
    sda_posedge,
    ddc_tx_en,
    ddc_rx_en,
    ddc_rst_start,
    ddc_restart,
    ddc_stop,
    ddc_wait,
    i2c_mode,
    reg_ddc_speed,
    data_line,
    sda_in,
    reg_ddc_no_stop,

    //output ports
    i2c_cycle,
    rcv_data, //shift out data
    rcv_data_en, //shift out data enable
    sda_out,
    sda_out_en,
    scl_out,
    scl_out_en,
    link_free,
    bus_arbt_lose,
    sda_chg_err,
    // scl_chg_err,
    ddc_finish,
    crnt_tx_state,
    crnt_rc_state
    );

    //input ports
input           i2c_clk;
input           resetn;
input           scl_negedge;
input           scl_posedge;
input           i2c_link_start;
input           i2c_link_stop;
input           i2c_inter_start;
//input           i2c_inter_stop;
input           sda_negedge;
input           sda_posedge;
input           ddc_tx_en;
input           ddc_rx_en;
input           ddc_rst_start;
input           ddc_restart;
input           ddc_stop;
input           ddc_wait;
input           i2c_mode;
input   [1:0]   reg_ddc_speed;
input           data_line;
input           sda_in;
input           reg_ddc_no_stop;

//output ports
output          i2c_cycle;
output          rcv_data;
output          rcv_data_en;
output          sda_out;
output          sda_out_en;
output          scl_out;
output          scl_out_en;
output          ddc_finish;
output          link_free;
output          bus_arbt_lose;
output          sda_chg_err;
// output          scl_chg_err;
output  [4:0]   crnt_tx_state;  // current link transmit control state 
output  [2:0]   crnt_rc_state;  // current link receive control state 

reg             i2c_cycle;
reg             rcv_data;
reg             rcv_data_en;
reg             sda_out;
reg             sda_out_en;
reg             scl_out;
reg             scl_out_en;
reg             ddc_finish;

//list reg and signal
reg             bus_arbt_lose;
reg             link_free;
reg             link_fsm_start;
reg             scl_out_del;

reg    [11:0]   t_hd_sta;
reg    [11:0]   t_su_sta;
reg    [11:0]   t_high;
reg    [11:0]   t_low;
reg    [11:0]   t_hd_dat;
reg    [11:0]   t_su_dat;
reg    [11:0]   t_su_sto;
reg    [11:0]   t_buf;

wire    [7:0]   fast_t_hd_sta;
wire    [7:0]   fast_t_su_sta;
wire    [7:0]   fast_t_high;
wire    [7:0]   fast_t_low;
wire    [7:0]   fast_t_hd_dat;
wire    [7:0]   fast_t_su_dat;
wire    [7:0]   fast_t_su_sto;
wire    [7:0]   fast_t_buf;

wire    [7:0]   standard_t_hd_sta;
wire    [7:0]   standard_t_su_sta;
wire    [7:0]   standard_t_high;
wire    [7:0]   standard_t_low;
wire    [7:0]   standard_t_hd_dat;
wire    [7:0]   standard_t_su_dat;
wire    [7:0]   standard_t_su_sto;
wire    [7:0]   standard_t_buf;

reg     [4:0]   crnt_tx_state;  // current link transmit control state 
reg     [4:0]   next_tx_state;  // next link transmit control state
reg    [11:0]   bus_timing_cnt;  // SDA and SCL bus timing control counter  

reg     [2:0]   crnt_rc_state;  // current link receive control state 
reg     [2:0]   next_rc_state;  // next link receive control state

// I2C Master Link (SDA SCL) output transmit control state
parameter IDLE          = 5'b00000;
parameter START_pre     = 5'b00001;
parameter START_wait    = 5'b00010;
parameter START_hld     = 5'b00011;
parameter TX_DATA_pre   = 5'b00100;
parameter DATA_hold     = 5'b00101;
parameter RX_DATA_pre   = 5'b00110;
parameter SCL_NEG_wait  = 5'b00111;
parameter SCL_POS_wait  = 5'b01000;
parameter SCL_LOW       = 5'b01001;
parameter SCL_HIGH      = 5'b01010;
parameter RESTART_pre   = 5'b01011;
parameter RESTART_su    = 5'b01100;
parameter STOP_pre      = 5'b01101;
parameter STOP_su       = 5'b01110;
parameter STOP_hld      = 5'b01111;
parameter STOP_wait     = 5'b10000;
parameter RE_ACCESS     = 5'b10001;
parameter RESET_START   = 5'b10010;
//parameter   = 5'b10011;
//parameter TX_DATA_hld   = 5'b00101;
//parameter RX_DATA_hld   = 5'b00111;

// I2C Master Link (SDA SCL) Receive control state
parameter FREE          = 3'b000;
parameter BUSY          = 3'b001;
parameter START         = 3'b010;
parameter STOP          = 3'b011;
parameter ARBT_CHK      = 3'b100;
parameter RCV_SMPL      = 3'b101;
parameter BUS_MNTR      = 3'b110;
parameter ARBT_LOSE     = 3'b111;

// I2C Master Link (SDA SCL) output transmit control state machine
always @(/*AUTOSENSE*/bus_arbt_lose or bus_timing_cnt or crnt_tx_state
	 or ddc_restart or ddc_rst_start or ddc_rx_en or ddc_stop
	 or ddc_tx_en or ddc_wait or i2c_inter_start or i2c_link_stop
	 or link_free or scl_negedge or scl_posedge or sda_negedge
	 or t_buf or t_hd_dat or t_hd_sta or t_high or t_low
	 or t_su_dat or t_su_sta or t_su_sto) begin
    casez (crnt_tx_state)
        IDLE : begin    //IDLE state wait for start
            if (i2c_inter_start && ddc_rst_start)
                next_tx_state = RESET_START;
            else if (i2c_inter_start && link_free)
                next_tx_state = START_pre;
            else
                next_tx_state = IDLE;
          end
        START_pre : begin   //START state to generate the start flag
                next_tx_state = START_wait;
          end
        START_wait : begin   //START state to generate the start flag
            if (sda_negedge)
                next_tx_state = START_hld;
            else
                next_tx_state = START_wait;
          end
        START_hld : begin
            if (bus_timing_cnt == t_hd_sta)
                next_tx_state = SCL_NEG_wait;
            else
                next_tx_state = START_hld;
          end
        RESET_START : //I2C reset START state do NOT generate the start flag
                next_tx_state = SCL_NEG_wait;
        SCL_NEG_wait : begin
            if (scl_negedge)
                next_tx_state = DATA_hold;
            else
                next_tx_state = SCL_NEG_wait;
          end
        DATA_hold : begin
            if ((bus_timing_cnt == t_hd_dat) && ddc_restart)
                next_tx_state = RESTART_pre;
            else if ((bus_timing_cnt == t_hd_dat) && ddc_stop)
                next_tx_state = STOP_pre;
            else if ((bus_timing_cnt == t_hd_dat) && ddc_tx_en)
                next_tx_state = TX_DATA_pre;
            else if ((bus_timing_cnt == t_hd_dat) && ddc_rx_en)
                next_tx_state = RX_DATA_pre;
            else
                next_tx_state = DATA_hold;
          end
        TX_DATA_pre : begin
            if (bus_timing_cnt == t_su_dat)
                next_tx_state = SCL_LOW;
            else
                next_tx_state = TX_DATA_pre;
          end
        SCL_LOW : begin
            if ((bus_timing_cnt == t_low) && (!ddc_wait))
                next_tx_state = SCL_POS_wait;
            else
                next_tx_state = SCL_LOW;
          end
        SCL_POS_wait : begin
            if (scl_posedge && ddc_restart)
                next_tx_state = RESTART_su;
            else if (scl_posedge && ddc_stop)
                next_tx_state = STOP_su;
            else if (scl_posedge)
                next_tx_state = SCL_HIGH;
            else
                next_tx_state = SCL_POS_wait;
          end
        SCL_HIGH : begin
            if (bus_timing_cnt == t_high)
                next_tx_state = SCL_NEG_wait;
            else if (bus_arbt_lose)
                next_tx_state = RE_ACCESS;
            else
                next_tx_state = SCL_HIGH;
          end
        RX_DATA_pre : begin
            if (bus_timing_cnt == t_su_dat)
                next_tx_state = SCL_LOW;
            else
                next_tx_state = RX_DATA_pre;
          end
        RESTART_pre : begin
            if (bus_timing_cnt == t_su_dat)
                next_tx_state = SCL_LOW;
            else
                next_tx_state = RESTART_pre;
          end
        RESTART_su : begin
            if (bus_timing_cnt == t_su_sta)
                next_tx_state = START_wait;
            else
                next_tx_state = RESTART_su;
          end
        STOP_pre : begin
            if (bus_timing_cnt == t_su_dat)
                next_tx_state = SCL_LOW;
            else
                next_tx_state = STOP_pre;
          end
        STOP_su : begin
            if (bus_timing_cnt == t_su_sto)
                next_tx_state = STOP_hld;
            else
                next_tx_state = STOP_su;
          end
        STOP_hld : begin
            if (bus_timing_cnt == t_hd_dat)
                next_tx_state = STOP_wait;
            else
                next_tx_state = STOP_hld;
          end
        STOP_wait : begin
            if ((bus_timing_cnt == t_buf) && i2c_inter_start)
                next_tx_state = START_pre;
            else if (bus_timing_cnt == t_buf)
                next_tx_state = IDLE;
            else
                next_tx_state = STOP_wait;
          end
        RE_ACCESS : begin
            if (i2c_link_stop)
                next_tx_state = IDLE;
            else
                next_tx_state = RE_ACCESS;
          end
        default : next_tx_state = IDLE;
    endcase
  end

//state transfer
always @(posedge i2c_clk) begin
    if (~resetn)
        crnt_tx_state <= #`FFD IDLE;
    else
        crnt_tx_state <= #`FFD next_tx_state;
  end


// I2C Master Link (SDA SCL) Receive control state machine
always @(/*AUTOSENSE*/crnt_rc_state or crnt_tx_state or ddc_rx_en
	 or ddc_tx_en or i2c_link_start or i2c_link_stop
	 or link_fsm_start or scl_negedge or scl_posedge
	 or sda_chg_err or sda_in or sda_out) begin
    casez (crnt_rc_state)
        FREE : begin
            if (i2c_link_start && link_fsm_start)
                next_rc_state = START;
            else if (i2c_link_start || scl_negedge)
                next_rc_state = BUSY;
            else if (i2c_link_stop)
                next_rc_state = STOP;
            else
                next_rc_state = FREE;
          end
        BUSY : begin
            if (i2c_link_stop)
                next_rc_state = STOP;
            else
                next_rc_state = BUSY;
          end
        START : begin
            if (scl_negedge && link_fsm_start)
                next_rc_state = ARBT_LOSE;
            else if (scl_posedge)   // && ddc_tx_en
                next_rc_state = ARBT_CHK;
            else
                next_rc_state = START;
          end
        STOP : begin
            next_rc_state = FREE;
          end
        ARBT_CHK : begin
            if ((sda_in ^ sda_out))
                next_rc_state = ARBT_LOSE;
            else
                next_rc_state = BUS_MNTR;
          end
        RCV_SMPL : begin
            next_rc_state = BUS_MNTR;
          end
        BUS_MNTR : begin
            if (scl_negedge && link_fsm_start)   //  i2c_link_start replaced by link_fsm_start
                next_rc_state = ARBT_LOSE;  // Add one cycle SCL error detection on 2006.11.08
            else if (link_fsm_start)   //  i2c_link_start replaced by link_fsm_start
                next_rc_state = START;
            else if (i2c_link_stop)
                next_rc_state = STOP;
            else if (scl_negedge && (crnt_tx_state == SCL_HIGH) || sda_chg_err)
                next_rc_state = ARBT_LOSE;
            else if (scl_posedge && ddc_tx_en)
                next_rc_state = ARBT_CHK;
            else if (scl_posedge && ddc_rx_en)
                next_rc_state = RCV_SMPL;
            else
                next_rc_state = BUS_MNTR;
          end
        ARBT_LOSE : begin
            if (i2c_link_stop)
                next_rc_state = STOP;
            else
                next_rc_state = ARBT_LOSE;
          end
    endcase
  end

//state transfer
always @(posedge i2c_clk) begin
    if (~resetn)
        crnt_rc_state <= #`FFD FREE;
    else
        crnt_rc_state <= #`FFD next_rc_state;
  end

/*******************************control signal gen***********************************/

// Send the Link Timing FSM finish signal to DDC inter control FSM
always @(posedge i2c_clk)
    if (~resetn)
        scl_out_del <= #`FFD 1'b1;
    else
        scl_out_del <= #`FFD scl_out;

always @(posedge i2c_clk)
    if (~resetn)
        i2c_cycle <= #`FFD 1'b0;
    else if ((~ scl_out) & scl_out_del)
        i2c_cycle <= #`FFD 1'b1;
    else
        i2c_cycle <= #`FFD 1'b0;

//TX process, send out the data and the ack to slave
always @(posedge i2c_clk) begin
    if (~resetn)
        sda_out_en <= #`FFD 1'b0;
    else begin
        casez (crnt_tx_state)
            START_pre, START_wait, START_hld, RESTART_pre, RESTART_su,
            STOP_pre, STOP_su, STOP_hld, TX_DATA_pre:
                sda_out_en <= #`FFD 1'b1;
            IDLE, STOP_wait, RX_DATA_pre, RE_ACCESS:
                sda_out_en <= #`FFD 1'b0;
            default:
                sda_out_en <= #`FFD sda_out_en;
        endcase
      end
  end

//TX process, send out the data and the ack to slave
always @(posedge i2c_clk) begin
    if (~resetn)
        sda_out <= #`FFD 1'b1;
    else begin
        casez (crnt_tx_state)
            IDLE, START_pre, RESTART_pre, RESTART_su, STOP_hld, STOP_wait :
                sda_out <= #`FFD 1'b1;
            START_wait, START_hld :
                sda_out <= #`FFD 1'b0;
            STOP_pre, STOP_su : begin
                if (reg_ddc_no_stop)
                    sda_out <= #`FFD 1'b1;
                else
                    sda_out <= #`FFD 1'b0;
              end
            TX_DATA_pre :
                sda_out <= #`FFD data_line;
            default:
                sda_out <= #`FFD sda_out;
        endcase
      end
  end

// Drive SCL line process
always @(posedge i2c_clk) begin
    if (~resetn)
        scl_out_en <= #`FFD 1'b0;
    else begin
        casez (crnt_tx_state)
            START_pre, RX_DATA_pre,
            START_wait, START_hld, TX_DATA_pre,
            DATA_hold, RESTART_pre, RESTART_su,
            SCL_NEG_wait, SCL_POS_wait, SCL_LOW, SCL_HIGH,
            STOP_pre, STOP_su, STOP_hld, STOP_wait,
            RESET_START :
                scl_out_en <= #`FFD 1'b1;
            default:
                scl_out_en <= #`FFD 1'b0;
        endcase
      end
  end

always @(posedge i2c_clk) begin
    if (~resetn)
        scl_out <= #`FFD 1'b1;
    else if ((crnt_tx_state == START_hld) && (bus_timing_cnt == t_hd_sta) || (crnt_tx_state == RESET_START))
        scl_out <= #`FFD 1'b0;
    else if ((crnt_tx_state == SCL_LOW) && (bus_timing_cnt == t_low) && (!ddc_wait))
        scl_out <= #`FFD 1'b1;
    else if ((crnt_tx_state == SCL_HIGH) && (bus_timing_cnt == t_high))
        scl_out <= #`FFD 1'b0;
  end

//RD process, read pulse and read ack pulse
always @(posedge i2c_clk) begin
    if (~resetn)
        rcv_data <= #`FFD 1'b0;
    else if (crnt_rc_state == RCV_SMPL)
        rcv_data <= #`FFD sda_in;
  end

always @(posedge i2c_clk) begin
    if (~resetn)
        rcv_data_en <= #`FFD 1'b0;
    else if (crnt_rc_state == RCV_SMPL)
        rcv_data_en <= #`FFD 1'b1;
    else
        rcv_data_en <= #`FFD 1'b0;
  end

// ARBITOR check process
always @(/*AUTOSENSE*/crnt_rc_state or resetn) begin
    if (~resetn)
        bus_arbt_lose = 1'b0;
    else if ((crnt_rc_state == ARBT_LOSE))
        bus_arbt_lose = 1'b1;
    else
        bus_arbt_lose = 1'b0;
  end

// DDC Link status flag
always @(/*AUTOSENSE*/crnt_rc_state or resetn) begin
    if (~resetn)
        link_free = 1'b0;
    else if ((crnt_rc_state == FREE))
        link_free = 1'b1;
    else
        link_free = 1'b0;
  end

// DDC Link Timing FSM start flag
always @(/*AUTOSENSE*/crnt_tx_state or resetn) begin
    if (~resetn)
        link_fsm_start = 1'b0;
    else begin
        casez (crnt_tx_state)
            START_pre, START_wait, START_hld, RESTART_su :
                link_fsm_start = 1'b1;
            default:
                link_fsm_start = 1'b0;
        endcase
      end
  end

// DDC Link Timing FSM finish flag
always @(posedge i2c_clk) begin
    if (~resetn)
        ddc_finish <= #`FFD 1'b0;
    else if ((crnt_tx_state == STOP_wait) && (bus_timing_cnt == t_buf))
        ddc_finish <= #`FFD 1'b1;
    else
        ddc_finish <= #`FFD 1'b0;
  end

// Link Error Check
assign  sda_chg_err = (crnt_tx_state == SCL_HIGH) && (sda_negedge || sda_posedge);

//Link line Timing control counter
always @(posedge i2c_clk) begin
    if (~resetn)
        bus_timing_cnt <= #`FFD 10'h0;
    else begin
        casez (crnt_tx_state)
            START_hld : begin
                if (bus_timing_cnt == t_hd_sta)
                    bus_timing_cnt <= #`FFD 10'h0;
                else
                    bus_timing_cnt <= #`FFD bus_timing_cnt + 1'b1;
              end
            SCL_NEG_wait, SCL_POS_wait : begin
                if (scl_negedge || scl_posedge)
                    bus_timing_cnt <= #`FFD 10'h0;
              end
            DATA_hold : begin
                if (bus_timing_cnt == t_hd_dat)
                    bus_timing_cnt <= #`FFD 10'h0;
                else
                    bus_timing_cnt <= #`FFD bus_timing_cnt + 1'b1;
              end
            TX_DATA_pre, RX_DATA_pre, RESTART_pre, STOP_pre : begin
                if (bus_timing_cnt == t_su_dat)
                    bus_timing_cnt <= #`FFD 10'h0;
                else
                    bus_timing_cnt <= #`FFD bus_timing_cnt + 1'b1;
              end
            SCL_LOW : begin
                if ((bus_timing_cnt == t_low) && (!ddc_wait))
                    bus_timing_cnt <= #`FFD 10'h0;
                else if (bus_timing_cnt != t_low)
                    bus_timing_cnt <= #`FFD bus_timing_cnt + 1'b1;
              end
            SCL_HIGH : begin
                if (bus_timing_cnt == t_high)
                    bus_timing_cnt <= #`FFD 10'h0;
                else
                    bus_timing_cnt <= #`FFD bus_timing_cnt + 1'b1;
              end
            RESTART_su : begin
                if (bus_timing_cnt == t_su_sta)
                    bus_timing_cnt <= #`FFD 10'h0;
                else
                    bus_timing_cnt <= #`FFD bus_timing_cnt + 1'b1;
              end
            STOP_su : begin
                if (bus_timing_cnt == t_su_sto)
                    bus_timing_cnt <= #`FFD 10'h0;
                else
                    bus_timing_cnt <= #`FFD bus_timing_cnt + 1'b1;
              end
            STOP_hld : begin
                if (bus_timing_cnt == t_hd_dat)
                    bus_timing_cnt <= #`FFD 10'h0;
                else
                    bus_timing_cnt <= #`FFD bus_timing_cnt + 1'b1;
              end
            STOP_wait : begin
                if (bus_timing_cnt == t_buf)
                    bus_timing_cnt <= #`FFD 10'h0;
                else
                    bus_timing_cnt <= #`FFD bus_timing_cnt + 1'b1;
              end
            default :
                bus_timing_cnt <= #`FFD 10'h0;
        endcase
      end
  end

// ddc speed    i2c_mode, reg_ddc_speed
//  400kbps        1'b1    2'b11
//  200kbps        1'b1    2'b10
//  100kbps        1'b0    2'b11
//   50kbps        1'b1    2'b01
//   25kbps        1'b1    2'b00
//   12kbps        1'b0    2'b10
//    6kbps        1'b0    2'b01
//    3kbps        1'b0    2'b00
always @ (/*AUTOSENSE*/fast_t_buf or fast_t_hd_dat or fast_t_hd_sta
	  or fast_t_high or fast_t_low or fast_t_su_dat
	  or fast_t_su_sta or fast_t_su_sto or i2c_mode
	  or reg_ddc_speed or standard_t_buf or standard_t_hd_dat
	  or standard_t_hd_sta or standard_t_high or standard_t_low
	  or standard_t_su_dat or standard_t_su_sta
	  or standard_t_su_sto) begin
    casez ({i2c_mode, reg_ddc_speed})
        3'b111 : begin
               t_hd_sta = {4'h0, fast_t_hd_sta};
               t_su_sta = {4'h0, fast_t_su_sta};
               t_high   = {4'h0, fast_t_high  };
               t_low    = {4'h0, fast_t_low   };
               t_hd_dat = {4'h0, fast_t_hd_dat};
               t_su_dat = {4'h0, fast_t_su_dat};
               t_su_sto = {4'h0, fast_t_su_sto};
               t_buf    = {4'h0, fast_t_buf   };
            end
        3'b110 : begin
               t_hd_sta = {3'h0, fast_t_hd_sta, 1'b0};
               t_su_sta = {3'h0, fast_t_su_sta, 1'b0};
               t_high   = {3'h0, fast_t_high  , 1'b0};
               t_low    = {3'h0, fast_t_low   , 1'b0};
               t_hd_dat = {3'h0, fast_t_hd_dat, 1'b0};
               t_su_dat = {3'h0, fast_t_su_dat, 1'b0};
               t_su_sto = {3'h0, fast_t_su_sto, 1'b0};
               t_buf    = {3'h0, fast_t_buf   , 1'b0};
            end
        3'b011 : begin
               t_hd_sta = {4'h0, standard_t_hd_sta};
               t_su_sta = {4'h0, standard_t_su_sta};
               t_high   = {4'h0, standard_t_high  };
               t_low    = {4'h0, standard_t_low   };
               t_hd_dat = {4'h0, standard_t_hd_dat};
               t_su_dat = {4'h0, standard_t_su_dat};
               t_su_sto = {4'h0, standard_t_su_sto};
               t_buf    = {4'h0, standard_t_buf   };
            end
        3'b101 : begin
               t_hd_sta = {3'h0, standard_t_hd_sta, 1'b0};
               t_su_sta = {3'h0, standard_t_su_sta, 1'b0};
               t_high   = {3'h0, standard_t_high  , 1'b0};
               t_low    = {3'h0, standard_t_low   , 1'b0};
               t_hd_dat = {3'h0, standard_t_hd_dat, 1'b0};
               t_su_dat = {3'h0, standard_t_su_dat, 1'b0};
               t_su_sto = {3'h0, standard_t_su_sto, 1'b0};
               t_buf    = {3'h0, standard_t_buf   , 1'b0};
            end
        3'b100 : begin
               t_hd_sta = {2'h0, standard_t_hd_sta, 2'b0};
               t_su_sta = {2'h0, standard_t_su_sta, 2'b0};
               t_high   = {2'h0, standard_t_high  , 2'b0};
               t_low    = {2'h0, standard_t_low   , 2'b0};
               t_hd_dat = {2'h0, standard_t_hd_dat, 2'b0};
               t_su_dat = {2'h0, standard_t_su_dat, 2'b0};
               t_su_sto = {2'h0, standard_t_su_sto, 2'b0};
               t_buf    = {2'h0, standard_t_buf   , 2'b0};
            end
        3'b010 : begin
               t_hd_sta = {1'h0, standard_t_hd_sta, 3'b0};
               t_su_sta = {1'h0, standard_t_su_sta, 3'b0};
               t_high   = {1'h0, standard_t_high  , 3'b0};
               t_low    = {1'h0, standard_t_low   , 3'b0};
               t_hd_dat = {1'h0, standard_t_hd_dat, 3'b0};
               t_su_dat = {1'h0, standard_t_su_dat, 3'b0};
               t_su_sto = {1'h0, standard_t_su_sto, 3'b0};
               t_buf    = {1'h0, standard_t_buf   , 3'b0};
            end
        3'b001, 3'b000 : begin
               t_hd_sta = {standard_t_hd_sta, 4'b0};
               t_su_sta = {standard_t_su_sta, 4'b0};
               t_high   = {standard_t_high  , 4'b0};
               t_low    = {standard_t_low   , 4'b0};
               t_hd_dat = {standard_t_hd_dat, 4'b0};
               t_su_dat = {standard_t_su_dat, 4'b0};
               t_su_sto = {standard_t_su_sto, 4'b0};
               t_buf    = {standard_t_buf   , 4'b0};
            end
    endcase
  end

`ifdef HDS_I2C_CLOCK_HALF
    // The I2C clock period is 71.4 ns (Max I2C frequency: 14 MHz)
    assign   fast_t_hd_sta = 8'd9;  // 0.6 us
    assign   fast_t_su_sta = 8'd9;  // 0.6 us
    assign   fast_t_high   = 8'd9;  // 0.6 us
    assign   fast_t_low    = 8'd19;  // 1.3 us
    assign   fast_t_hd_dat = 8'd5;   // 0.3 us
    assign   fast_t_su_dat = 8'd2;   // 100 ns
    assign   fast_t_su_sto = 8'd9;  // 0.6 us
    assign   fast_t_buf    = 8'd19;  // 1.3 us
    
    // The I2C clock period is 71.4 ns (Max I2C frequency: 14 MHz)
    assign   standard_t_hd_sta = 8'd56;  // 4.0 us
    assign   standard_t_su_sta = 8'd66;  // 4.7 us
    assign   standard_t_high   = 8'd56;  // 4.0 us
    assign   standard_t_low    = 8'd66;  // 4.7 us
    assign   standard_t_hd_dat = 8'd13;   // 0.9 us
    assign   standard_t_su_dat = 8'd4;    // 250 ns
    assign   standard_t_su_sto = 8'd56;  // 4.0 us
    assign   standard_t_buf    = 8'd66;  // 4.7 us
`else
/*    // The I2C clock period is 41.667 ns (Max I2C frequency: 24 MHz)
    assign   fast_t_hd_sta = 8'd12;  // 0.6 us
    assign   fast_t_su_sta = 8'd12;  // 0.6 us
    assign   fast_t_high   = 8'd12;  // 0.6 us
    assign   fast_t_low    = 8'd23;  // 1.3 us
    assign   fast_t_hd_dat = 8'd6;   // 0.3 us
    assign   fast_t_su_dat = 8'd2;   // 100 ns
    assign   fast_t_su_sto = 8'd12;  // 0.6 us
    assign   fast_t_buf    = 8'd37;  // 1.3 us
    
    // The I2C clock period is 41.667 ns (Max I2C frequency: 24 MHz)
    assign   standard_t_hd_sta = 8'd96;  // 4.0 us
    assign   standard_t_su_sta = 8'd113;  // 4.7 us
    assign   standard_t_high   = 8'd96;  // 4.0 us
    assign   standard_t_low    = 8'd113;  // 4.7 us
    assign   standard_t_hd_dat = 8'd22;   // 0.9 us
    assign   standard_t_su_dat = 8'd7;    // 250 ns
    assign   standard_t_su_sto = 8'd96;  // 4.0 us
    assign   standard_t_buf    = 8'd113;  // 4.7 us*/
    // The I2C clock period is 37.037 ns (Max I2C frequency: 27 MHz)
    assign   fast_t_hd_sta = 8'd14;  // 0.6 us
    assign   fast_t_su_sta = 8'd14;  // 0.6 us
    assign   fast_t_high   = 8'd14;  // 0.6 us
    assign   fast_t_low    = 8'd26;  // 1.3 us
    assign   fast_t_hd_dat = 8'd7;   // 0.3 us
    assign   fast_t_su_dat = 8'd2;   // 100 ns
    assign   fast_t_su_sto = 8'd14;  // 0.6 us
    assign   fast_t_buf    = 8'd26;  // 1.3 us
    
    // The I2C clock period is 37.037 ns (Max I2C frequency: 27 MHz)
    assign   standard_t_hd_sta = 8'd96;  // 4.0 us
    assign   standard_t_su_sta = 8'd113;  // 4.7 us
    assign   standard_t_high   = 8'd96;  // 4.0 us
    assign   standard_t_low    = 8'd113;  // 4.7 us
    assign   standard_t_hd_dat = 8'd22;   // 0.9 us
    assign   standard_t_su_dat = 8'd7;    // 250 ns
    assign   standard_t_su_sto = 8'd96;  // 4.0 us
    assign   standard_t_buf    = 8'd113;  // 4.7 us
`endif

//assign   t_hd_sta = i2c_mode ? 8'd20 : 8'd135;  // 0.6 us   4.0 us
//assign   t_su_sta = i2c_mode ? 8'd20 : 8'd159;  // 0.6 us   4.7 us
//assign   t_high = i2c_mode ? 8'd20 : 8'd135;    // 0.6 us   4.0 us
//assign   t_low = i2c_mode ? 8'd44 : 8'd159;     // 1.3 us   4.7 us
//assign   t_hd_dat = i2c_mode ? 8'd10 : 8'd10;   // 0.3 us   0.9 us
//assign   t_su_dat = i2c_mode ? 8'd4 : 8'd9;     // 100 ns   250 ns
//assign   t_su_sto = i2c_mode ? 8'd20 : 8'd135;  // 0.6 us   4.0 us
//assign   t_buf = i2c_mode ? 8'd44 : 8'd159;     // 1.3 us   4.7 us


endmodule
