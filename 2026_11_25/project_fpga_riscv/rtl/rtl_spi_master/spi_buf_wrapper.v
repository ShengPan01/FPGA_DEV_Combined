
module spi_buf_wrapper(
    input clk_a,
    input [10:0] addr_a,
    input [7:0] data_in_a,
    input we_a,
    output [7:0] data_out_a,
    input clk_b,
    input [10:0] addr_b,
    input [7:0] data_in_b,
    input we_b,
    output [7:0] data_out_b
);

dpsram_1280x8 dpsram_1280x8(
  .clka(clk_a),
  .wea(we_a),
  .addra(addr_a[10:0]),
  .dina(data_in_a[7:0]),
  .douta(data_out_a[7:0]),
  .clkb(clk_b),
  .web(we_b),
  .addrb(addr_b[10:0]),
  .dinb(data_in_b[7:0]),
  .doutb(data_out_b[7:0])
);

endmodule
