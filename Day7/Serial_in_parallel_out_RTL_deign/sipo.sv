module sipo(
  input logic clk,
  input logic rst,
  input logic si,
  output logic [3:0] po
);
  
  always@(posedge clk) begin
    if(rst) begin
      po <= 4'b0;
    end else begin
      po <= po << 1;
      po[0] <= si;
    end
  end
    
endmodule