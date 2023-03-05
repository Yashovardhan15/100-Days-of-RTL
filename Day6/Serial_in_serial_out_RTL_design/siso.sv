module siso(
  input logic clk,
  input logic rst,
  input logic si,
  output logic so
);
  
  logic [3:0] temp;
  
  always@(posedge clk) begin
    if(rst) begin
      temp <= 4'b0000;
      so <= 1'b0;
    end else begin
      temp <= temp << 1;
      temp[0] <= si;
      so <= temp[3];
    end
  end
    
endmodule