module counter(
  input logic clk,
  input logic rst,
  output logic [3:0] count
);
  
  always@(posedge clk) begin  
    if(rst) begin
      count <= 4'b0000;
    end else begin
      count <= count + 1;
    end
  end
  
endmodule