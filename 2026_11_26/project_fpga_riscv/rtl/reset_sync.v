
module reset_sync #(
    parameter ACTIVE_HIGH = 0,
    parameter SHIFT = 3
) (
    input clk,
    input reset_in,
    output reset_out
);

reg [SHIFT-1:0] reset_shift;

generate
if (ACTIVE_HIGH)
    always @(posedge clk or posedge reset_in)
        if (reset_in)
            reset_shift <= ~0;
        else
            reset_shift <= {1'b0, reset_shift[SHIFT-1:1]};
else
    always @(posedge clk or negedge reset_in)
        if (!reset_in)
            reset_shift <= 0;
        else
            reset_shift <= {1'b1, reset_shift[SHIFT-1:1]};
endgenerate

assign reset_out = reset_shift[0];

endmodule
