module mux #(
  parameter WIDTH = 32, 
  parameter SEL_WIDTH = 1
)(
  input logic [WIDTH-1 : 0] a,
  input logic [WIDTH-1 : 0] b,
  input logic [SEL_WIDTH-1 : 0] sel,
  output logic [WIDTH-1 : 0] muxout
);
  assign muxout = sel ? a : b;
endmodule