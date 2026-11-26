
`include "i2c_master_define.v"
`define I2CM_FIFO_DATA               24'h000008


module i2c_master_top (
    input              i2c_clk                 ,
    input              reset_n                  , 
    input              i2c_10us_pulse          ,
    
    input              sda_in                  ,
    input              scl_in                  ,
    output             sda_out                 ,
    output             sda_out_en              ,
    output             scl_out                 ,
    output             scl_out_en              ,
    
    input        reg_clk                    ,
    input        reg_reset_n                 ,
    input        mcus_rd_en,   // Read strobe, active high
    input        mcus_wr_en,   // Write strobe, active high
    input [15:0] mcus_addr,   // Address
    input [7:0] mcus_wdata,   // Write data
    output [7:0] mcus_rdata   // Read data

);

reg reg_cmd_write;
wire reg_fifo_re = mcus_rd_en && ({8'h0, mcus_addr} == `I2CM_FIFO_DATA);
wire reg_fifo_we = mcus_wr_en && ({8'h0, mcus_addr} == `I2CM_FIFO_DATA);
wire [7:0] fifo_reg_data;
wire [7:0] mcus_rdata_reg;
assign mcus_rdata = reg_fifo_re ? fifo_reg_data[7:0] : mcus_rdata_reg[7:0];
wire clr_intp_fifo_full;
wire clr_intp_fifo_empty;
wire clr_intp_fifo_half;
wire clr_intp_acc_done;
wire [2:0] reg_i2cm_access_cmd;
wire [7:0] reg_i2cm_access_num1;
wire [7:0] reg_i2cm_access_num;
wire [7:0] reg_i2cm_dev_addr;
wire [7:0] reg_i2cm_offset;
wire [7:0] reg_i2cm_sgmt_addr;
wire [1:0] reg_i2cm_speed;
wire [4:0] fifo_cnt;

i2c_master_wrapper i2c_master_wrapper (
    .i2c_clk                 (i2c_clk),
    .resetn                  (reset_n), 
    .i2c_10us_pulse          (i2c_10us_pulse),

    .sda_in                  (sda_in    ),
    .scl_in                  (scl_in    ),
    .sda_out                 (sda_out   ),
    .sda_out_en              (sda_out_en),
    .scl_out                 (scl_out   ),
    .scl_out_en              (scl_out_en),

    .reg_acs_cmd             (reg_i2cm_access_cmd[2:0]),
    .reg_acs_num             ({reg_i2cm_access_num1[1:0], reg_i2cm_access_num[7:0]}),
    .reg_cmd_write           (reg_cmd_write),
    .reg_fifo_re             (reg_fifo_re),
    .reg_fifo_we             (reg_fifo_we),
    .reg_fifo_data           (mcus_wdata[7:0]),
    .fifo_reg_data           (fifo_reg_data[7:0]),


    .dev_addr                (reg_i2cm_dev_addr[7:0]),
    .offset_addr             (reg_i2cm_offset[7:0]),
    .segment_pointer         (reg_i2cm_sgmt_addr[7:0]),
    .i2c_glh_sel             (reg_i2cm_glitch_sel),
    .i2c_mode                (reg_i2cm_mode),
    .reg_no_stop             (reg_i2cm_no_stop),
    .reg_no_ack              (reg_i2cm_no_ack_ignore),
    .reg_e_no_ack            (reg_i2cm_eddc_no_ack),
    .reg_speed               (reg_i2cm_speed[1:0]),
    
    .cmd_progress            (cmd_progress),
    .timeout                 (timeout),
    .i2cm_no_ack             (i2cm_no_ack),
    .master_err              (master_err),
    .fifo_cnt                (fifo_cnt[4:0]),
    .fifo_full               (fifo_full),
    .fifo_empty              (fifo_empty),
    .ext_occupy              (ext_occupy),
    .clr_intp_fifo_full      (clr_intp_fifo_full),
    .clr_intp_fifo_empty     (clr_intp_fifo_empty),
    .clr_intp_fifo_half      (clr_intp_fifo_half),
    .clr_intp_acc_done       (clr_intp_acc_done),
    .intp_fifo_full          (intp_fifo_full),
    .intp_fifo_empty         (intp_fifo_empty),
    .intp_fifo_half          (intp_fifo_half),
    .intp_acc_done           (intp_acc_done),
    .crnt_state              (),
    .crnt_tx_state           (),
    .crnt_rc_state           (),
    .i2cm_fifo_state         ()
);

i2c_master_regs i2c_master_regs (
    //constant input
    .clk                    (reg_clk),
    .resetn                 (reg_reset_n),
    .mcus_rd_en(mcus_rd_en),   // Read strobe, active high
    .mcus_wr_en(mcus_wr_en),   // Write strobe, active high
    .mcus_addr(mcus_addr[15:0]),   // Address
    .mcus_wdata(mcus_wdata[7:0]),   // Write data
    // inputs reg
    .reg_i2cm_master_error(master_err),
    .reg_i2cm_occupy(ext_occupy),
    .reg_i2cm_fifo_full(fifo_full),
    .reg_i2cm_fifo_empt(fifo_empty),
    .reg_i2cm_no_ack(i2cm_no_ack),
    .reg_i2cm_timeout(timeout),
    .reg_i2cm_error(1'b0),
    .reg_i2cm_progress(cmd_progress),
    .reg_i2cm_fifo_cnt({3'h0, fifo_cnt[4:0]}),
    .reg_intp_fifo_full(intp_fifo_full),
    .reg_intp_fifo_empty(intp_fifo_empty),
    .reg_intp_fifo_half(intp_fifo_half),
    .reg_intp_acc_done(intp_acc_done),

    //add other inputs here

    //constant output
    .mcus_rdata(mcus_rdata_reg[7:0]),   // Read data
    .reg_i2cm_dev_addr(reg_i2cm_dev_addr[7:0]),
    .reg_i2cm_sgmt_addr(reg_i2cm_sgmt_addr[7:0]),
    .reg_i2cm_offset(reg_i2cm_offset[7:0]),
    .reg_i2cm_access_cmd(reg_i2cm_access_cmd[2:0]),
    .reg_i2cm_access_num(reg_i2cm_access_num[7:0]),
    .reg_i2cm_access_num1(reg_i2cm_access_num1[1:0]),
    .reg_intp_fifo_full_clr(reg_intp_fifo_full_clr),
    .reg_intp_fifo_empty_clr(reg_intp_fifo_empty_clr),
    .reg_intp_fifo_half_clr(reg_intp_fifo_half_clr),
    .reg_intp_acc_done_clr(reg_intp_acc_done_clr),
    .reg_i2cm_no_stop(reg_i2cm_no_stop),
    .reg_i2cm_no_ack_ignore(reg_i2cm_no_ack_ignore),
    .reg_i2cm_eddc_no_ack(reg_i2cm_eddc_no_ack),
    .reg_i2cm_glitch_sel(reg_i2cm_glitch_sel),
    .reg_i2cm_mode(reg_i2cm_mode),
    .reg_i2cm_speed(reg_i2cm_speed[1:0])
);

always @(posedge reg_clk)
    reg_cmd_write <= mcus_wr_en && ({8'h0, mcus_addr} == `I2CM_CMD);

reg reg_intp_fifo_full_clr_d;
reg reg_intp_fifo_empty_clr_d;
reg reg_intp_fifo_half_clr_d;
reg reg_intp_acc_done_clr_d;

always @(posedge reg_clk)
    if (!reg_reset_n)
    begin
        reg_intp_fifo_full_clr_d <= 1'b0;
        reg_intp_fifo_empty_clr_d <= 1'b0;
        reg_intp_fifo_half_clr_d <= 1'b0;
        reg_intp_acc_done_clr_d <= 1'b0;
    end else
    begin
        reg_intp_fifo_full_clr_d <= reg_intp_fifo_full_clr;
        reg_intp_fifo_empty_clr_d <= reg_intp_fifo_empty_clr;
        reg_intp_fifo_half_clr_d <= reg_intp_fifo_half_clr;
        reg_intp_acc_done_clr_d <= reg_intp_acc_done_clr;
    end

assign clr_intp_fifo_full = reg_intp_fifo_full_clr ^ reg_intp_fifo_full_clr_d;
assign clr_intp_fifo_empty = reg_intp_fifo_empty_clr ^ reg_intp_fifo_empty_clr_d;
assign clr_intp_fifo_half = reg_intp_fifo_half_clr ^ reg_intp_fifo_half_clr_d;
assign clr_intp_acc_done = reg_intp_acc_done_clr ^ reg_intp_acc_done_clr_d;

endmodule
