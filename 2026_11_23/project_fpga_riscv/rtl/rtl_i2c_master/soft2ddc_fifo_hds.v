 /*
 * Copyright (c) 2026. All rights reserved.
 *
 * Unauthorized copying, modification, distribution, or use
 * of this code is strictly prohibited without prior
 * written permission from the copyright owner.
 *
 * Date: 2026-11-11
 */
 
//*****************************************************************************
//

`include "i2c_master_define.v"

module soft2ddc_fifo_hds (
  // Inputs
  i2c_clk                 ,
  resetn_reg              ,
  reg_ddc_acs_cmd         , // reg_ddc_cmd                 ,
  reg_ddc_acs_num         ,
  ddc_cmd_write           ,
  reg_fifo_re             ,
  reg_fifo_we             ,
  reg_fifo_data           ,
  ddc_reg_data_out        ,
  ddc_reg_data_rdy        ,
  ddc_reg_ack             ,
  ddc_reg_busy            ,
  ddc_reg_link_free       ,
  ddc_master_err          ,
  ddc_no_ack              ,
  i2c_10us_pulse          ,
  clr_intp_ddc_fifo_full  ,
  clr_intp_ddc_fifo_empty ,
  clr_intp_ddc_fifo_half  ,
  clr_intp_ddc_acc_done   ,
 
  // Outputs
  ddc_timeout             ,
  reg_ddc_data_in         ,
  reg_ddc_start           ,
  reg_ddc_stop            ,
  reg_ddc_not_rdy         ,
  reg_ddc_cmd             ,
  fifo_cnt                ,
  ddc_fifo_state          ,
  fifo_reg_data           ,
  fifo_reading            ,
  fifo_writing            ,
  ddc_cmd_progress        ,
  fifo_full               ,
  fifo_empty              ,
  intp_ddc_fifo_full      ,
  intp_ddc_fifo_empty     ,
  intp_ddc_fifo_half      ,
  intp_ddc_acc_done      
  );

input           i2c_clk; //registers clock
input           resetn_reg;  //register clock domain resetn_reg
input   [2:0]   reg_ddc_acs_cmd         ; // reg_ddc_cmd                 ,
input   [9:0]   reg_ddc_acs_num         ;
input           ddc_cmd_write           ;
input           i2c_10us_pulse          ;

output          ddc_timeout             ;
output  [4:0]   fifo_cnt;
output  [2:0]   ddc_fifo_state;     // Output to register for debug.

// Local I2C Read & Write Interface
input           reg_fifo_re;
input           reg_fifo_we;
input   [7:0]   reg_fifo_data;  //InfoFrame content input.
output  [7:0]   fifo_reg_data;  //InfoFrame content output.

// Local FIFO to DDC Master Interface
input   [7:0]   ddc_reg_data_out;
input           ddc_reg_data_rdy;
input           ddc_reg_ack;
input           ddc_reg_busy;
input           ddc_reg_link_free;
input           ddc_master_err;
input           ddc_no_ack;
output  [7:0]   reg_ddc_data_in;
output          reg_ddc_start;
output          reg_ddc_stop;
output          reg_ddc_not_rdy;
output  [2:0]   reg_ddc_cmd;
output          fifo_reading;
output          fifo_writing;
output          ddc_cmd_progress;
output          fifo_full;
output          fifo_empty;

// DDC FIFO Interrupt
input           clr_intp_ddc_fifo_full;
input           clr_intp_ddc_fifo_empty;
input           clr_intp_ddc_fifo_half;
input           clr_intp_ddc_acc_done;
output          intp_ddc_fifo_full;
output          intp_ddc_fifo_empty;
output          intp_ddc_fifo_half;
output          intp_ddc_acc_done;

reg             reg_ddc_start;
reg             reg_ddc_stop;
reg             reg_ddc_not_rdy;
wire    [7:0]   reg_ddc_data_in;

//reg             ddc_fifo_1st_rd;
reg             ddc_cmd_progress;
reg             ddc_cmd_progress_d;

// DDC FIFO Interrupt
reg             intp_ddc_fifo_full;
reg             intp_ddc_fifo_empty;
reg             intp_ddc_fifo_half;
reg             intp_ddc_acc_done;

reg [2:0]       reg_ddc_cmd;

wire            fifo_reading;
wire            fifo_writing;

//-----------------------------------------
// DDC command define
//-----------------------------------------
parameter BYTE_READ    = 3'b000;
parameter BYTE_WRITE   = 3'b001;
parameter MSG_READ     = 3'b010;
parameter E_DDC_READ   = 3'b011;
parameter I2C_RESET    = 3'b100;

//-----------------------------------------
// Local FIFO Control FSM define
//-----------------------------------------
//parameter   I2C_FIFO_IDLE    = 2'b00;
//parameter   I2C_FIFO_WRITE   = 2'b01;
//parameter   I2C_FIFO_READ    = 2'b10;

//reg     [1:0]   i2c_fifo_state;
//wire            i2c_fifo_reading;
//wire            i2c_fifo_writing;

//-----------------------------------------
// DDC Master Control FSM define
//-----------------------------------------
parameter   DDC_FIFO_IDLE   = 3'b000;
parameter   DDC_FIFO_WAIT   = 3'b001;
parameter   DDC_FIFO_START  = 3'b010;
parameter   DDC_FIFO_READ   = 3'b011;   // DDC operation: Write; FIFO operation: Read.
parameter   DDC_FIFO_WRITE  = 3'b100;   // DDC operation: Read; FIFO operation: Write.
parameter   DDC_FIFO_STOP   = 3'b101;

//-----------------------------------------
// DDC command Register Content define
//-----------------------------------------
parameter   DDC_REG_ABORT_OPT    = 3'b000;
parameter   DDC_REG_BYTE_READ    = 3'b001;
parameter   DDC_REG_BYTE_WRITE   = 3'b010;
parameter   DDC_REG_MSG_READ     = 3'b011;
parameter   DDC_REG_E_DDC_READ   = 3'b100;
parameter   DDC_REG_CLR_FIFO     = 3'b101;
parameter   DDC_REG_I2C_RESET    = 3'b110;


reg     [2:0]   ddc_fifo_state;
reg             ddc_cmd_start;
reg             reg_abort_ddc_acs ;
wire            ddc_cmd_write;
reg     [9:0]   ddc_cmd_cnt;
wire            ddc_fifo_reading;
wire            ddc_fifo_writing;

//-----------------------------------------
// FIFO signal define
//-----------------------------------------
parameter   FIFO_DEPTH = 16;

reg     [3:0]   w_addr;
reg     [3:0]   r_addr;
reg     [4:0]   fifo_cnt;
reg             fifo_full;
reg             fifo_empty;

reg             clear_ddc_fifo          ;

wire            fifo_wr_en;
wire            fifo_rd_en;
wire    [7:0]   fifo_input;
wire    [7:0]   fifo_output;

reg     [7:0]   q_data [FIFO_DEPTH-1:0];
reg     [11:0]  ddc_timeout_counter  ;

integer i;

  always @(resetn_reg or reg_ddc_acs_cmd)
    if (!resetn_reg)
        reg_ddc_cmd = 3'h0;
    else begin
        casez (reg_ddc_acs_cmd)
            DDC_REG_BYTE_WRITE :    reg_ddc_cmd = BYTE_WRITE;
            DDC_REG_MSG_READ   :    reg_ddc_cmd = MSG_READ;
            DDC_REG_E_DDC_READ :    reg_ddc_cmd = E_DDC_READ;
            DDC_REG_I2C_RESET  :    reg_ddc_cmd = I2C_RESET;
            default            :    reg_ddc_cmd = BYTE_READ;
        endcase
      end

  always @(posedge i2c_clk)
    if (!resetn_reg)
        ddc_cmd_start <= #`FFD 1'b0;
    else if (ddc_cmd_write) begin
        casez (reg_ddc_acs_cmd)
            DDC_REG_BYTE_READ  ,
            DDC_REG_BYTE_WRITE ,
            DDC_REG_MSG_READ   ,
            DDC_REG_E_DDC_READ ,
            DDC_REG_I2C_RESET  :
                ddc_cmd_start <= #`FFD 1'b1;
            default :
                ddc_cmd_start <= #`FFD 1'b0;
        endcase
      end
    else
        ddc_cmd_start <= #`FFD 1'b0;

  always @(posedge i2c_clk)
    if (!resetn_reg)
        reg_abort_ddc_acs <= #`FFD 1'b0;
    else if (ddc_cmd_write && (reg_ddc_acs_cmd == DDC_REG_ABORT_OPT) && ddc_cmd_progress)
        reg_abort_ddc_acs <= #`FFD 1'b1;
    else
        reg_abort_ddc_acs <= #`FFD 1'b0;

  always @(posedge i2c_clk)
    if (!resetn_reg)
        clear_ddc_fifo <= #`FFD 1'b0;
    else if (ddc_cmd_write && (reg_ddc_acs_cmd == DDC_REG_CLR_FIFO))
        clear_ddc_fifo <= #`FFD 1'b1;
    else
        clear_ddc_fifo <= #`FFD 1'b0;



assign  fifo_reading = ddc_fifo_reading;    // i2c_fifo_reading || 
assign  fifo_writing = ddc_fifo_writing;    // i2c_fifo_writing || 

//assign  i2c_fifo_reading = (i2c_fifo_state == I2C_FIFO_READ);
//assign  i2c_fifo_writing = (i2c_fifo_state == I2C_FIFO_WRITE);
assign  ddc_fifo_reading = (ddc_fifo_state == DDC_FIFO_READ);
assign  ddc_fifo_writing = (ddc_fifo_state == DDC_FIFO_WRITE);
assign  fifo_wr_en = ddc_fifo_writing ? ddc_reg_data_rdy : reg_fifo_we;    // (i2c_fifo_writing ?  : 1'b0)
assign  fifo_rd_en = ddc_fifo_reading ? ddc_reg_data_rdy : reg_fifo_re;    // (i2c_fifo_reading ?  : 1'b0)
assign  fifo_input = ddc_fifo_writing ? ddc_reg_data_out : reg_fifo_data;    // (i2c_fifo_writing ?  : 8'h0)
assign  reg_ddc_data_in = ddc_fifo_reading ? fifo_output : 8'h0;
assign  fifo_reg_data = fifo_output;   // i2c_fifo_reading ?  : 8'h0

//-----------------------------------------
// DDC Master Control FSM
//-----------------------------------------
always @(posedge i2c_clk) begin
    if (!resetn_reg)
        ddc_fifo_state <= #`FFD DDC_FIFO_IDLE;
    else if (reg_abort_ddc_acs)
        ddc_fifo_state <= #`FFD DDC_FIFO_STOP;
    else begin
        casez (ddc_fifo_state)
            DDC_FIFO_IDLE:
                if (ddc_cmd_start && (reg_ddc_cmd == I2C_RESET))
                    ddc_fifo_state <= #`FFD DDC_FIFO_START;
                else if (ddc_cmd_start && (ddc_reg_busy || (~ddc_reg_link_free) || ((reg_ddc_cmd == BYTE_WRITE) &&
                        fifo_empty) || ((reg_ddc_cmd != BYTE_WRITE) && fifo_full)))
                    ddc_fifo_state <= #`FFD DDC_FIFO_WAIT;
                else if (ddc_cmd_start)
                    ddc_fifo_state <= #`FFD DDC_FIFO_START;
            DDC_FIFO_WAIT:
                if ((!ddc_reg_busy) && ddc_reg_link_free && (((reg_ddc_cmd == BYTE_WRITE) &&
                        !fifo_empty) || ((reg_ddc_cmd != BYTE_WRITE) && !fifo_full)))
                    ddc_fifo_state <= #`FFD DDC_FIFO_START;
            DDC_FIFO_START:
                if (ddc_reg_ack && ddc_reg_busy && (reg_ddc_cmd == BYTE_WRITE))
                    ddc_fifo_state <= #`FFD DDC_FIFO_READ;   // DDC operation: Write; FIFO operation: Read.
                else if (ddc_reg_ack && ddc_reg_busy)
                    ddc_fifo_state <= #`FFD DDC_FIFO_WRITE;  // DDC operation: Read; FIFO operation: Write.
            DDC_FIFO_READ:   // DDC operation: Write; FIFO operation: Read.
                if (ddc_reg_data_rdy && (ddc_cmd_cnt == reg_ddc_acs_num) || ddc_master_err || ddc_no_ack || ddc_timeout)
                    ddc_fifo_state <= #`FFD DDC_FIFO_STOP;
            DDC_FIFO_WRITE:   // DDC operation: Read; FIFO operation: Write.
                if (ddc_reg_data_rdy && ((ddc_cmd_cnt == reg_ddc_acs_num) || (reg_ddc_cmd == I2C_RESET)) || ddc_master_err || ddc_no_ack || ddc_timeout)
                    ddc_fifo_state <= #`FFD DDC_FIFO_STOP;
            DDC_FIFO_STOP:
                if (~ddc_reg_busy)
                    ddc_fifo_state <= #`FFD DDC_FIFO_IDLE;
            default:
                ddc_fifo_state <= #`FFD DDC_FIFO_IDLE;
        endcase
      end
  end

  always @(posedge i2c_clk)
    if (!resetn_reg)
        ddc_timeout_counter <= #`FFD 12'h00;
    else if( ddc_fifo_state == DDC_FIFO_IDLE )
        ddc_timeout_counter <= #`FFD 12'h00;
    else if(i2c_10us_pulse) begin
        if(ddc_timeout_counter == 12'hfff)
            ddc_timeout_counter <= #`FFD 12'hfff;
        else if(( ddc_fifo_state  == DDC_FIFO_WRITE ) || (ddc_fifo_state == DDC_FIFO_READ))
            ddc_timeout_counter <= #`FFD ddc_timeout_counter + 1'b1;
    end

  assign ddc_timeout = (ddc_timeout_counter == 12'h960);

  always @(posedge i2c_clk)
    if (!resetn_reg)
        ddc_cmd_cnt <= #`FFD 10'h1;
    else begin
        casez (ddc_fifo_state)
            DDC_FIFO_READ, DDC_FIFO_WRITE :
                if (ddc_reg_data_rdy)
                    ddc_cmd_cnt <= #`FFD ddc_cmd_cnt + 10'b1;
            default:
                ddc_cmd_cnt <= #`FFD 10'h1;
        endcase
      end

  always @(posedge i2c_clk)
    if (!resetn_reg)
        ddc_cmd_progress <= #`FFD 1'b0;
    else begin
      if ( ddc_fifo_state == DDC_FIFO_IDLE )
        ddc_cmd_progress <= #`FFD 1'b0;
      else
        ddc_cmd_progress <= #`FFD 1'b1;
        // casez (ddc_fifo_state)
        //     DDC_FIFO_WAIT, DDC_FIFO_START, DDC_FIFO_READ, DDC_FIFO_WRITE, DDC_FIFO_STOP :
        //         ddc_cmd_progress <= #`FFD 1'b1;
        //     default:
        //         ddc_cmd_progress <= #`FFD 1'b0;
        // endcase
    end

always @(posedge i2c_clk)
    if (!resetn_reg)
        reg_ddc_start <= #`FFD 1'b0;
    else begin
        casez (ddc_fifo_state)
            DDC_FIFO_START :
                reg_ddc_start <= #`FFD 1'b1;
            default:
                reg_ddc_start <= #`FFD 1'b0;
        endcase
      end

always @(posedge i2c_clk)
    if (!resetn_reg)
        reg_ddc_stop <= #`FFD 1'b0;
    else begin
        casez (ddc_fifo_state)
            DDC_FIFO_STOP :
                reg_ddc_stop <= #`FFD 1'b1;
            default:
                reg_ddc_stop <= #`FFD 1'b0;
        endcase
      end

//always @(posedge i2c_clk)
//    if (!resetn_reg)
//        ddc_fifo_1st_rd <= #`FFD 1'b0;
//    else begin
//        casez (ddc_fifo_state)
//            DDC_FIFO_START :
//                if (ddc_reg_busy && (reg_ddc_cmd == BYTE_WRITE))
//                    ddc_fifo_1st_rd <= #`FFD 1'b1;
//            default:
//                ddc_fifo_1st_rd <= #`FFD 1'b0;
//        endcase
//      end
//

always @(posedge i2c_clk)
    if (!resetn_reg)
        reg_ddc_not_rdy <= #`FFD 1'b0;
    else begin
        casez (ddc_fifo_state)
            DDC_FIFO_READ :
                if (fifo_empty)
                    reg_ddc_not_rdy <= #`FFD 1'b1;
                else
                    reg_ddc_not_rdy <= #`FFD 1'b0;
            DDC_FIFO_WRITE :
                if (fifo_full)
                    reg_ddc_not_rdy <= #`FFD 1'b1;
                else
                    reg_ddc_not_rdy <= #`FFD 1'b0;
            default:
                reg_ddc_not_rdy <= #`FFD 1'b0;
        endcase
      end

//-----------------------------------------
// DDC Master Access FIFO from Software
//-----------------------------------------
always @(posedge i2c_clk)
    if ((!resetn_reg) || clear_ddc_fifo)
        for (i = 0; i < FIFO_DEPTH; i = i + 1) begin
            q_data[i] <= #`FFD 8'h0;
          end
    else if (fifo_wr_en) begin
        q_data[w_addr] <= #`FFD fifo_input;
      end

assign fifo_output = q_data[r_addr];

// FSM for w_addr
always @(posedge i2c_clk) begin
    if ((!resetn_reg) || clear_ddc_fifo)
        w_addr[3:0] <= #`FFD 4'h0;
    else if (fifo_wr_en && (!fifo_full))   // Don't need Gray code
        w_addr[3:0] <= #`FFD w_addr[3:0] + 4'b1;
  end

// FSM for r_addr
always @(posedge i2c_clk) begin
    if ((!resetn_reg) || clear_ddc_fifo)
        r_addr[3:0] <= #`FFD 4'h0;
    else if (fifo_rd_en && (!fifo_empty))    // Don't need Gray code
        r_addr[3:0] <= #`FFD r_addr[3:0] + 4'b1;
  end

//***************************************
// FIFO status
//***************************************
always @(posedge i2c_clk)
    if ((!resetn_reg) || clear_ddc_fifo)
        fifo_cnt <= #`FFD 5'b0;
    else if ((fifo_wr_en && (!fifo_full)) && (fifo_rd_en && (!fifo_empty)))
        fifo_cnt <= #`FFD fifo_cnt;
    else if (fifo_wr_en && (!fifo_full))
        fifo_cnt <= #`FFD fifo_cnt + 5'b1;
    else if (fifo_rd_en && (!fifo_empty))
        fifo_cnt <= #`FFD fifo_cnt - 5'b1;
    else
        fifo_cnt <= #`FFD fifo_cnt;

always @(posedge i2c_clk) begin
    if ((!resetn_reg) || clear_ddc_fifo)
        fifo_empty <= #`FFD 1'b1;
    else if (fifo_cnt == 5'b0)
        fifo_empty <= #`FFD 1'b1;
    else
        fifo_empty <= #`FFD 1'b0;
  end

always @(posedge i2c_clk) begin
    if ((!resetn_reg) || clear_ddc_fifo)
        fifo_full <= #`FFD 1'b0;
    else if (fifo_cnt == 5'h10)
        fifo_full <= #`FFD 1'b1;
    else
        fifo_full <= #`FFD 1'b0;
  end

//-----------------------------------------
// DDC Master Access FIFO from Software
//-----------------------------------------
always @(posedge i2c_clk) begin
    if (!resetn_reg)
        intp_ddc_fifo_full <= #`FFD 1'b0;
    else if (fifo_full)
        intp_ddc_fifo_full <= #`FFD 1'b1;
    else if (clr_intp_ddc_fifo_full)
        intp_ddc_fifo_full <= #`FFD 1'b0;
  end

always @(posedge i2c_clk) begin
    if (!resetn_reg)
        intp_ddc_fifo_empty <= #`FFD 1'b0;
    else if (fifo_empty)
        intp_ddc_fifo_empty <= #`FFD 1'b1;
    else if (clr_intp_ddc_fifo_empty)
        intp_ddc_fifo_empty <= #`FFD 1'b0;
  end

always @(posedge i2c_clk) begin
    if (!resetn_reg)
        intp_ddc_fifo_half <= #`FFD 1'b0;
    else if (fifo_cnt == 5'h08)
        intp_ddc_fifo_half <= #`FFD 1'b1;
    else if (clr_intp_ddc_fifo_half)
        intp_ddc_fifo_half <= #`FFD 1'b0;
  end

always @(posedge i2c_clk)
    if (!resetn_reg)
        ddc_cmd_progress_d <= #`FFD 1'b0;
    else
        ddc_cmd_progress_d <= #`FFD ddc_cmd_progress;

always @(posedge i2c_clk) begin
    if (!resetn_reg)
        intp_ddc_acc_done <= #`FFD 1'b0;
    else if (ddc_cmd_progress_d && (~ ddc_cmd_progress))
        intp_ddc_acc_done <= #`FFD 1'b1;
    else if (clr_intp_ddc_acc_done)
        intp_ddc_acc_done <= #`FFD 1'b0;
  end


endmodule
