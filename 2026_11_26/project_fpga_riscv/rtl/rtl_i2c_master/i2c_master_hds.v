 /*
 * Copyright (c) 2026. All rights reserved.
 *
 * Unauthorized copying, modification, distribution, or use
 * of this code is strictly prohibited without prior
 * written permission from the copyright owner.
 *
 * Date: 2026-11-11
 */
 

module i2c_master_hds (/*AUTOARG*/
   // Outputs
   ddc_busy, ddc_inter_data, ddc_inter_rd, scl_out, scl_out_en, 
   sda_out, sda_out_en, link_free, bus_arbt_lose, i2c_err, 
   ddc_no_ack, crnt_ddc_state, crnt_tx_state, crnt_rc_state, 
   // Inputs
   dev_addr, segment_pointer, i2c_clk, i2c_glh_sel, i2c_inter_start, 
   i2c_inter_stop, i2c_mode, reg_ddc_speed, inter_ddc_cmd, 
   inter_ddc_data, offset_addr, inter_ddc_not_rdy, resetn, scl_in, 
   sda_in, reg_ddc_no_stop, reg_ddc_no_ack, reg_eddc_no_ack
   );

    input [7:0]     dev_addr;        // To u_ddc_inter_ctrl of ddc_inter_ctrl_hds.v
    input [7:0]     segment_pointer;        // To u_ddc_inter_ctrl of ddc_inter_ctrl_hds.v
    input           i2c_clk;        // To u_i2c_m_glitch of i2c_m_glitch_hds.v, ...
    input           i2c_glh_sel;        // To u_i2c_m_glitch of i2c_m_glitch_hds.v
    input           i2c_inter_start;    // To u_i2c_m_fsm of i2c_m_fsm_hds.v, ...
    input           i2c_inter_stop;        // To u_i2c_m_fsm of i2c_m_fsm_hds.v, ...
    input           i2c_mode;        // To u_i2c_m_fsm of i2c_m_fsm_hds.v
    input   [1:0]   reg_ddc_speed;
    input [2:0]     inter_ddc_cmd;        // To u_ddc_inter_ctrl of ddc_inter_ctrl_hds.v
    input [7:0]     inter_ddc_data;        // To u_ddc_inter_ctrl of ddc_inter_ctrl_hds.v
    input [7:0]     offset_addr;        // To u_ddc_inter_ctrl of ddc_inter_ctrl_hds.v
    input           inter_ddc_not_rdy;
    input           resetn;            // To u_i2c_m_glitch of i2c_m_glitch_hds.v, ...
    input           scl_in;            // To u_i2c_m_glitch of i2c_m_glitch_hds.v
    input           sda_in;            // To u_i2c_m_glitch of i2c_m_glitch_hds.v, ...
    //input           abort_ddc_acs;

    output          ddc_busy;        // From u_ddc_inter_ctrl of ddc_inter_ctrl_hds.v
    output [7:0]    ddc_inter_data;        // From u_ddc_inter_ctrl of ddc_inter_ctrl_hds.v
    output          ddc_inter_rd;        // From u_ddc_inter_ctrl of ddc_inter_ctrl_hds.v
    output          scl_out;        // From u_i2c_m_fsm of i2c_m_fsm_hds.v
    output          scl_out_en;        // From u_i2c_m_fsm of i2c_m_fsm_hds.v
    output          sda_out;        // From u_i2c_m_fsm of i2c_m_fsm_hds.v
    output          sda_out_en;        // From u_i2c_m_fsm of i2c_m_fsm_hds.v
    output          link_free;
    output          bus_arbt_lose;
    output          i2c_err; // Debug information
    output          ddc_no_ack;
    output  [4:0]   crnt_ddc_state;
    output  [4:0]   crnt_tx_state;  // current link transmit control state 
    output  [2:0]   crnt_rc_state;  // current link receive control state 

    // Debug Control Registers
    input           reg_ddc_no_stop;
    input           reg_ddc_no_ack;
    input           reg_eddc_no_ack;

    /*AUTOWIRE*/
    // Beginning of automatic wires (for undeclared instantiated-module outputs)
    wire		ddc_finish;		// From u_i2c_m_fsm of i2c_m_fsm_hds.v
    wire		ddc_rst_start;		// From u_ddc_inter_ctrl of ddc_inter_ctrl_hds.v
    wire		sda_chg_err;		// From u_i2c_m_fsm of i2c_m_fsm_hds.v
    // End of automatics
    wire            data_line;        // From u_ddc_inter_ctrl of ddc_inter_ctrl_hds.v
    wire            ddc_restart;        // From u_ddc_inter_ctrl of ddc_inter_ctrl_hds.v
    wire            ddc_rx_en;        // From u_ddc_inter_ctrl of ddc_inter_ctrl_hds.v
    wire            ddc_stop;        // From u_ddc_inter_ctrl of ddc_inter_ctrl_hds.v
    wire            ddc_wait;
    wire            ddc_tx_en;        // From u_ddc_inter_ctrl of ddc_inter_ctrl_hds.v
    wire            i2c_cycle;        // From u_i2c_m_fsm of i2c_m_fsm_hds.v
    wire            rcv_data;        // From u_i2c_m_fsm of i2c_m_fsm_hds.v
    wire            rcv_data_en;        // From u_i2c_m_fsm of i2c_m_fsm_hds.v
    wire            scl_linkin;        // From u_i2c_m_glitch of i2c_m_glitch_hds.v
    wire            sda_negedge;        // To u_i2c_m_fsm of i2c_m_fsm_hds.v
    wire            sda_posedge;        // To u_i2c_m_fsm of i2c_m_fsm_hds.v
    wire            scl_negedge;        // From u_i2c_m_bus_detect of i2c_m_bus_detect_hds.v
    wire            scl_posedge;        // From u_i2c_m_bus_detect of i2c_m_bus_detect_hds.v
    wire            sda_linkin;        // From u_i2c_m_glitch of i2c_m_glitch_hds.v
    wire            i2c_link_start;        // To u_i2c_m_fsm of i2c_m_fsm_hds.v
    wire            i2c_link_stop;        // To u_i2c_m_fsm of i2c_m_fsm_hds.v
    wire            link_free;
    wire            bus_arbt_lose;
    //wire            resetn_sync;


//double latch the resetn
//sync_reg_hds u_sync_resetn(.clk(i2c_clk), .din(resetn), .dout(resetn_sync));

i2c_m_glitch_hds u_i2c_m_glitch(/*AUTOINST*/
			    // Outputs
			    .scl_linkin	(scl_linkin),
			    .sda_linkin	(sda_linkin),
			    // Inputs
			    .scl_in	(scl_in),
			    .sda_in	(sda_in),
			    .i2c_clk	(i2c_clk),
			    .resetn	(resetn),
			    .i2c_glh_sel(i2c_glh_sel));

i2c_m_bus_detect_hds u_i2c_m_bus_detect(/*AUTOINST*/
				    // Outputs
				    .sda_negedge(sda_negedge),
				    .sda_posedge(sda_posedge),
				    .scl_negedge(scl_negedge),
				    .scl_posedge(scl_posedge),
				    .i2c_start(i2c_link_start),	 // Templated
				    .i2c_stop(i2c_link_stop),	 // Templated
				    // Inputs
				    .i2c_clk(i2c_clk),
				    .resetn(resetn),
				    .scl_linkin(scl_linkin),
				    .sda_linkin(sda_linkin));

i2c_m_fsm_hds u_i2c_m_fsm(/*AUTOINST*/
		      // Outputs
		      .i2c_cycle	(i2c_cycle),
		      .rcv_data		(rcv_data),
		      .rcv_data_en	(rcv_data_en),
		      .sda_out		(sda_out),
		      .sda_out_en	(sda_out_en),
		      .scl_out		(scl_out),
		      .scl_out_en	(scl_out_en),
		      .ddc_finish	(ddc_finish),
		      .link_free	(link_free),
		      .bus_arbt_lose	(bus_arbt_lose),
		      .sda_chg_err	(sda_chg_err),
		      .crnt_tx_state	(crnt_tx_state[4:0]),
		      .crnt_rc_state	(crnt_rc_state[2:0]),
		      // Inputs
		      .i2c_clk		(i2c_clk),
		      .resetn		(resetn),
		      .scl_negedge	(scl_negedge),
		      .scl_posedge	(scl_posedge),
		      .i2c_link_start	(i2c_link_start),
		      .i2c_link_stop	(i2c_link_stop),
		      .i2c_inter_start	(i2c_inter_start),
		      .sda_negedge	(sda_negedge),
		      .sda_posedge	(sda_posedge),
		      .ddc_tx_en	(ddc_tx_en),
		      .ddc_rx_en	(ddc_rx_en),
		      .ddc_rst_start	(ddc_rst_start),
		      .ddc_restart	(ddc_restart),
		      .ddc_stop		(ddc_stop),
		      .ddc_wait		(ddc_wait),
		      .i2c_mode		(i2c_mode),
		      .reg_ddc_speed	(reg_ddc_speed[1:0]),
		      .data_line	(data_line),
		      .sda_in		(sda_linkin),		 // Templated
		      .reg_ddc_no_stop	(reg_ddc_no_stop));

ddc_inter_ctrl_hds u_ddc_inter_ctrl (/*AUTOINST*/
				 // Outputs
				 .ddc_busy(ddc_busy),
				 .ddc_inter_rd(ddc_inter_rd),
				 .ddc_inter_data(ddc_inter_data[7:0]),
				 .data_line(data_line),
				 .ddc_tx_en(ddc_tx_en),
				 .ddc_rx_en(ddc_rx_en),
				 .ddc_rst_start(ddc_rst_start),
				 .ddc_restart(ddc_restart),
				 .ddc_stop(ddc_stop),
				 .ddc_wait(ddc_wait),
				 .ddc_master_err(i2c_err),	 // Templated
				 .ddc_no_ack(ddc_no_ack),
				 .crnt_ddc_state(crnt_ddc_state[4:0]),
				 // Inputs
				 .i2c_clk(i2c_clk),
				 .resetn(resetn),
				 .i2c_inter_start(i2c_inter_start),
				 .i2c_inter_stop(i2c_inter_stop),
				 .inter_ddc_cmd(inter_ddc_cmd[2:0]),
				 .dev_addr(dev_addr[7:0]),
				 .segment_pointer(segment_pointer[7:0]),
				 .offset_addr(offset_addr[7:0]),
				 .inter_ddc_data(inter_ddc_data[7:0]),
				 .inter_ddc_not_rdy(inter_ddc_not_rdy),
				 .i2c_cycle(i2c_cycle),
				 .rcv_data(rcv_data),
				 .rcv_data_en(rcv_data_en),
				 .ddc_finish(ddc_finish),
				 .i2c_link_stop(i2c_link_stop),
				 .bus_arbt_lose(bus_arbt_lose),
				 .sda_chg_err(sda_chg_err),
				 .reg_ddc_no_ack(reg_ddc_no_ack),
				 .reg_eddc_no_ack(reg_eddc_no_ack),
				 .link_free(link_free));

endmodule

/*
i2c_m_bus_detect_hds AUTO_TEMPLATE (
                    // Outputs
                    .i2c_start(i2c_link_start),
                    .i2c_stop(i2c_link_stop),
                    // Inputs
                    );

i2c_m_fsm_hds AUTO_TEMPLATE (
              // Outputs
              // Inputs
              .sda_in        (sda_linkin));

ddc_inter_ctrl_hds AUTO_TEMPLATE (
                 // Outputs
                 .ddc_master_err (i2c_err),
                 // Inputs
                 );

*/
