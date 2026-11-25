module time_pulse #(
    parameter CNT_WIDTH = 5,
    parameter TIME_TH = 27
) (
    input clk,
    input reset_n,
    output pulse_out
);

reg [CNT_WIDTH-1:0] pulse_cnt;
reg pulse;

always @(posedge clk or negedge reset_n)
    if (!reset_n)
        pulse <= 1'b0;
    else
        pulse <= (pulse_cnt == TIME_TH);

always @(posedge clk or negedge reset_n)
    if (!reset_n)
        pulse_cnt <= 'b0;
    else if (pulse_cnt == TIME_TH)
        pulse_cnt <= 'b1;
    else
        pulse_cnt <= pulse_cnt + 'b1;

assign pulse_out = pulse;

endmodule
