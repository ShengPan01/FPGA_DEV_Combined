 /*
 * Copyright (c) 2026. All rights reserved.
 *
 * Unauthorized copying, modification, distribution, or use
 * of this code is strictly prohibited without prior
 * written permission from the copyright owner.
 *
 * Date: 2026-11-11
 */
 
//
//- ----------------------------------------------------------------------- -//
//- ----------------------------------------------------------------------- -//
`include "i2c_master_define.v"
//- ----------------------------------------------------------------------- -//
//- ----------------------------------------------------------------------- -//
module i2c_master_wrapper (
    input              i2c_clk                 ,
    input              resetn                  , 
    input              i2c_10us_pulse          ,

    input              sda_in                  ,
    input              scl_in                  ,
    output             sda_out                 ,
    output             sda_out_en              ,
    output             scl_out                 ,
    output             scl_out_en              ,

    input      [2:0]   reg_acs_cmd             ,
    input      [9:0]   reg_acs_num             ,
    input              reg_cmd_write           ,
    input              reg_fifo_re             ,
    input              reg_fifo_we             ,
    input      [7:0]   reg_fifo_data           ,
    output     [7:0]   fifo_reg_data           ,


    input      [7:0]   dev_addr                ,
    input      [7:0]   offset_addr             ,
    input      [7:0]   segment_pointer         ,
    input              i2c_glh_sel             ,
    input              i2c_mode                ,
    input              reg_no_stop             ,
    input              reg_no_ack              ,
    input              reg_e_no_ack            ,
    input      [1:0]   reg_speed               ,
    
    output             cmd_progress            ,
    output             timeout                 ,
    output reg         i2cm_no_ack ,
    output             master_err,
    output     [4:0]   fifo_cnt                ,
    output             fifo_full,
    output             fifo_empty,
    output             ext_occupy,
    input              clr_intp_fifo_full      ,
    input              clr_intp_fifo_empty     ,
    input              clr_intp_fifo_half      ,
    input              clr_intp_acc_done       ,
    output             intp_fifo_full          ,
    output             intp_fifo_empty         ,
    output             intp_fifo_half          ,
    output             intp_acc_done           ,
    output     [4:0]   crnt_state              ,
    output     [4:0]   crnt_tx_state           ,
    output     [2:0]   crnt_rc_state           ,
    output     [2:0]   i2cm_fifo_state
);
//- ----------------------------------------------------------------------- -//
//- ----------------------------------------------------------------------- -//
wire [7:0] reg_data_out;
wire [7:0] reg_data_in ;
wire [2:0] reg_cmd     ;

soft2ddc_fifo_hds soft2ddc_fifo_hds(
    // Inputs
    .i2c_clk                 (i2c_clk),
    .resetn_reg              (resetn),
    .i2c_10us_pulse          (i2c_10us_pulse),
    
    .reg_ddc_acs_cmd         (reg_acs_cmd[2:0]), // reg_ddc_cmd                 ,
    .reg_ddc_acs_num         (reg_acs_num[9:0]),
    .ddc_cmd_write           (reg_cmd_write),
    .reg_fifo_re             (reg_fifo_re),
    .reg_fifo_we             (reg_fifo_we),
    .reg_fifo_data           (reg_fifo_data[7:0]),
    .fifo_reg_data           (fifo_reg_data[7:0]),
    
    .ddc_reg_data_out        (reg_data_out[7:0]),
    .ddc_reg_data_rdy        (reg_data_rdy),
    .ddc_reg_ack             (1'b1),
    .ddc_reg_busy            (reg_busy),
    .ddc_reg_link_free       (reg_link_free),
    .ddc_master_err          (master_err),
    .ddc_no_ack              (no_ack),
    
    
    // Outputs
    .ddc_timeout             (timeout),
    .reg_ddc_data_in         (reg_data_in[7:0]),
    .reg_ddc_start           (reg_start),
    .reg_ddc_stop            (reg_stop),
    .reg_ddc_not_rdy         (reg_not_rdy),
    .reg_ddc_cmd             (reg_cmd[2:0]),
    .fifo_cnt                (fifo_cnt[4:0]),
    .ddc_fifo_state          (i2cm_fifo_state[2:0]),
    .fifo_reading            (),
    .fifo_writing            (),
    .ddc_cmd_progress        (cmd_progress),
    .fifo_full               (fifo_full),
    .fifo_empty              (fifo_empty),

    .clr_intp_ddc_fifo_full  (clr_intp_fifo_full),
    .clr_intp_ddc_fifo_empty (clr_intp_fifo_empty),
    .clr_intp_ddc_fifo_half  (clr_intp_fifo_half),
    .clr_intp_ddc_acc_done   (clr_intp_acc_done),
    .intp_ddc_fifo_full      (intp_fifo_full),
    .intp_ddc_fifo_empty     (intp_fifo_empty),
    .intp_ddc_fifo_half      (intp_fifo_half),
    .intp_ddc_acc_done       (intp_acc_done)
);

assign ext_occupy = reg_busy | ~reg_link_free;

//- ----------------------------------------------------------------------- -//
//- ----------------------------------------------------------------------- -//
i2c_master_hds i2c_master_fra (
   
    .i2c_clk                            ( i2c_clk                            ),
    .resetn                             ( resetn                             ),
    
    .sda_in                             ( sda_in                             ),
    .scl_in                             ( scl_in                             ),
    .sda_out                            ( sda_out                            ),
    .sda_out_en                         ( sda_out_en                         ),
    .scl_out                            ( scl_out                            ),
    .scl_out_en                         ( scl_out_en                         ),
    
    .inter_ddc_data                     ( reg_data_in                        ),
    .ddc_inter_data                     ( reg_data_out                       ),
    .ddc_inter_rd                       ( reg_data_rdy                       ),
    .ddc_busy                           ( reg_busy                           ),
    .ddc_no_ack                         ( no_ack                             ),
    .i2c_inter_start                    ( reg_start                          ),
    .i2c_inter_stop                     ( reg_stop                           ),
    .inter_ddc_cmd                      ( reg_cmd                            ),
    .inter_ddc_not_rdy                  ( reg_not_rdy                        ),
    .link_free                          ( reg_link_free                      ),
    .i2c_err                            ( master_err                         ),
    .bus_arbt_lose                      (                                    ),
    
    .segment_pointer                    ( segment_pointer                    ),
    .dev_addr                           ( dev_addr                           ),
    .offset_addr                        ( offset_addr                        ),
    .i2c_glh_sel                        ( i2c_glh_sel                        ),
    .reg_ddc_no_stop                    ( reg_no_stop                        ),
    .reg_ddc_no_ack                     ( reg_no_ack                         ),
    .reg_eddc_no_ack                    ( reg_e_no_ack                       ),
    .reg_ddc_speed                      ( reg_speed                          ),
    .i2c_mode                           ( i2c_mode                           ),
    
    .crnt_ddc_state                     ( crnt_state                         ),
    .crnt_tx_state                      ( crnt_tx_state                      ),
    .crnt_rc_state                      ( crnt_rc_state                      ));
//- ----------------------------------------------------------------------- -//
//- ----------------------------------------------------------------------- -//

always @(posedge i2c_clk)
    if (!resetn)
        i2cm_no_ack <= 1'b0;
    else if (reg_start)
        i2cm_no_ack <= 1'b0;
    else if (no_ack)
        i2cm_no_ack <= 1'b1;

endmodule
