module jk_ff(
  input logic j,
  input logic k,
  input logic clk,
  output logic q,
  output logic qbar
);
  always@(posedge clk) begin
    case({j,k}) 
      2'b00 : q <= q;
      2'b01 : q <= 0;
      2'b10 : q <= 1;
      2'b11 : q <= ~q;
      default : q <= q;
    endcase    
  end
  
  assign qbar = ~q; 
  
endmodule