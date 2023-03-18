module sr_ff(
  input logic s,
  input logic r,
  input logic clk,
  output logic q,
  output logic qbar
);
  always@(posedge clk) begin
    case({s,r})
      2'b00 : q <= q;
      2'b01 : q <= 0;
      2'b10 : q <= 1;
      2'b11 : q <= 1'bz;
      default : q <= 1'bz;
    endcase   
  end
  
  assign qbar = ~q;   
  
endmodule