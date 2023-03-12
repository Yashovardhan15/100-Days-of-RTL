module d_ff(
  input logic clk,
  input logic rst,
  input logic d,
  output logic q,
  output logic qbar
);
  
  logic q1;
  
  always@(posedge clk) begin
    if(rst) begin
      q <= 0;
    end else begin
      q1 <= d;
      q <= q1;
    end
    
  end
  
  
  assign qbar = ~q;
  
endmodule