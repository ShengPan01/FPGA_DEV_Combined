/*
 * Copyright (c) 2026. All rights reserved.
 *
 * Unauthorized copying, modification, distribution, or use
 * of this code is strictly prohibited without prior
 * written permission from the copyright owner.
 * 
 * Author : Sheng Pan
 * Date: 2026-11-24
 *
 * SHA-256 block compression for LMS SHA-256/192 and full SHA-256
 */

module sha256_accel (
    input             clk,
    input             reset_n,
    input             rd_en,
    input             wr_en,
    input      [3:0]  addr,
    input      [7:0]  wdata,
    output reg [7:0]  rdata
);

localparam [3:0] CONTROL = 4'h4, INDEX = 4'h5;
reg [4:0] word_index; // 0..7: H0..H7, 8..23: W0..W15
wire [3:0] block_index = word_index[3:0] - 4'd8;
wire data_port = addr[3:2] == 2'b10; // Offsets 8..B, least-significant byte first.
wire [4:0] byte_shift = {addr[1:0], 3'b000};

localparam IDLE = 2'd0, ROUNDS = 2'd1, FEED_FORWARD = 2'd2;
reg [1:0] phase;
reg done;
reg [5:0] round;
reg [31:0] state [0:7];
reg [31:0] schedule [0:15];
reg [31:0] a, b, c, d, e, f, g, h;

function [31:0] round_constant;
    input [5:0] index;
    begin
        case (index)
            6'd0: round_constant = 32'h428a2f98;
            6'd1: round_constant = 32'h71374491;
            6'd2: round_constant = 32'hb5c0fbcf;
            6'd3: round_constant = 32'he9b5dba5;
            6'd4: round_constant = 32'h3956c25b;
            6'd5: round_constant = 32'h59f111f1;
            6'd6: round_constant = 32'h923f82a4;
            6'd7: round_constant = 32'hab1c5ed5;
            6'd8: round_constant = 32'hd807aa98;
            6'd9: round_constant = 32'h12835b01;
            6'd10: round_constant = 32'h243185be;
            6'd11: round_constant = 32'h550c7dc3;
            6'd12: round_constant = 32'h72be5d74;
            6'd13: round_constant = 32'h80deb1fe;
            6'd14: round_constant = 32'h9bdc06a7;
            6'd15: round_constant = 32'hc19bf174;
            6'd16: round_constant = 32'he49b69c1;
            6'd17: round_constant = 32'hefbe4786;
            6'd18: round_constant = 32'h0fc19dc6;
            6'd19: round_constant = 32'h240ca1cc;
            6'd20: round_constant = 32'h2de92c6f;
            6'd21: round_constant = 32'h4a7484aa;
            6'd22: round_constant = 32'h5cb0a9dc;
            6'd23: round_constant = 32'h76f988da;
            6'd24: round_constant = 32'h983e5152;
            6'd25: round_constant = 32'ha831c66d;
            6'd26: round_constant = 32'hb00327c8;
            6'd27: round_constant = 32'hbf597fc7;
            6'd28: round_constant = 32'hc6e00bf3;
            6'd29: round_constant = 32'hd5a79147;
            6'd30: round_constant = 32'h06ca6351;
            6'd31: round_constant = 32'h14292967;
            6'd32: round_constant = 32'h27b70a85;
            6'd33: round_constant = 32'h2e1b2138;
            6'd34: round_constant = 32'h4d2c6dfc;
            6'd35: round_constant = 32'h53380d13;
            6'd36: round_constant = 32'h650a7354;
            6'd37: round_constant = 32'h766a0abb;
            6'd38: round_constant = 32'h81c2c92e;
            6'd39: round_constant = 32'h92722c85;
            6'd40: round_constant = 32'ha2bfe8a1;
            6'd41: round_constant = 32'ha81a664b;
            6'd42: round_constant = 32'hc24b8b70;
            6'd43: round_constant = 32'hc76c51a3;
            6'd44: round_constant = 32'hd192e819;
            6'd45: round_constant = 32'hd6990624;
            6'd46: round_constant = 32'hf40e3585;
            6'd47: round_constant = 32'h106aa070;
            6'd48: round_constant = 32'h19a4c116;
            6'd49: round_constant = 32'h1e376c08;
            6'd50: round_constant = 32'h2748774c;
            6'd51: round_constant = 32'h34b0bcb5;
            6'd52: round_constant = 32'h391c0cb3;
            6'd53: round_constant = 32'h4ed8aa4a;
            6'd54: round_constant = 32'h5b9cca4f;
            6'd55: round_constant = 32'h682e6ff3;
            6'd56: round_constant = 32'h748f82ee;
            6'd57: round_constant = 32'h78a5636f;
            6'd58: round_constant = 32'h84c87814;
            6'd59: round_constant = 32'h8cc70208;
            6'd60: round_constant = 32'h90befffa;
            6'd61: round_constant = 32'ha4506ceb;
            6'd62: round_constant = 32'hbef9a3f7;
            6'd63: round_constant = 32'hc67178f2;
            default: round_constant = 32'b0;
        endcase
    end
endfunction

wire [31:0] sigma_a = {a[1:0], a[31:2]} ^ {a[12:0], a[31:13]} ^ {a[21:0], a[31:22]};
wire [31:0] sigma_e = {e[5:0], e[31:6]} ^ {e[10:0], e[31:11]} ^ {e[24:0], e[31:25]};
wire [31:0] choice = (e & f) ^ (~e & g);
wire [31:0] majority = (a & b) ^ (a & c) ^ (b & c);
wire [31:0] t1 = h + sigma_e + choice + round_constant(round) + schedule[0];
wire [31:0] t2 = sigma_a + majority;

// During round t, schedule[0:15] contains W[t] through W[t+15].
wire [31:0] w1 = schedule[1];
wire [31:0] w14 = schedule[14];
wire [31:0] gamma0 = {w1[6:0], w1[31:7]} ^ {w1[17:0], w1[31:18]} ^ (w1 >> 3);
wire [31:0] gamma1 = {w14[16:0], w14[31:17]} ^ {w14[18:0], w14[31:19]} ^ (w14 >> 10);
wire [31:0] next_word = gamma1 + schedule[9] + gamma0 + schedule[0];

always @* begin
    rdata = 8'b0;
    if (rd_en) begin
        case (addr)
            4'h0: rdata = 8'h02; // SHA-256 accelerator interface v2
            4'h1: rdata = 8'h32;
            4'h2: rdata = 8'h48;
            4'h3: rdata = 8'h53;
            CONTROL: rdata = {6'b0, done, (phase != IDLE)};
            INDEX: rdata = {3'b0, word_index};
            default: if (data_port && word_index < 5'd8)
                rdata = state[word_index[2:0]][byte_shift +: 8];
        endcase
    end
end

integer i;
always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
        phase <= IDLE;
        done <= 1'b0;
        round <= 6'd0;
        word_index <= 5'd0;
        {a, b, c, d, e, f, g, h} <= 256'b0;
        for (i = 0; i < 8; i = i + 1)
            state[i] <= 32'b0;
        for (i = 0; i < 16; i = i + 1)
            schedule[i] <= 32'b0;
    end else begin
        case (phase)
            IDLE: if (wr_en) begin
                if (addr == INDEX)
                    word_index <= wdata[4:0];
                if (data_port && word_index < 5'd8)
                    state[word_index[2:0]][byte_shift +: 8] <= wdata;
                if (data_port && word_index >= 5'd8 && word_index < 5'd24)
                    schedule[block_index][byte_shift +: 8] <= wdata;
                if (addr == CONTROL && wdata[0]) begin
                    {a, b, c, d, e, f, g, h} <= {state[0], state[1], state[2], state[3],
                                                state[4], state[5], state[6], state[7]};
                    done <= 1'b0;
                    round <= 6'd0;
                    phase <= ROUNDS;
                end
            end
            ROUNDS: begin
                {a, b, c, d, e, f, g, h} <= {t1 + t2, a, b, c, d + t1, e, f, g};
                for (i = 0; i < 15; i = i + 1)
                    schedule[i] <= schedule[i + 1];
                schedule[15] <= next_word;
                round <= round + 6'd1;
                if (round == 6'd63)
                    phase <= FEED_FORWARD;
            end
            FEED_FORWARD: begin
                state[0] <= state[0] + a;
                state[1] <= state[1] + b;
                state[2] <= state[2] + c;
                state[3] <= state[3] + d;
                state[4] <= state[4] + e;
                state[5] <= state[5] + f;
                state[6] <= state[6] + g;
                state[7] <= state[7] + h;
                done <= 1'b1;
                phase <= IDLE;
            end
            default: phase <= IDLE;
        endcase
    end
end

endmodule
