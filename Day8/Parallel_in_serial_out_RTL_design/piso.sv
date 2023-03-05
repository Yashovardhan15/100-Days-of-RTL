module piso(
  input logic clk,
  input logic rst,
  input logic [3:0] pi,
  input logic load,
  output logic so
);
  logic [3:0] temp;
  
  always@(posedge clk) begin
    if(rst) begin
      so <= 1'b0;
      temp <= 4'b0000;
    end else begin
      if(load) begin
        temp <= pi;
      end else begin
        temp <= temp<<1;
      end 
    end
  end
    
  always@(*) begin
    so = temp[3];
  end
  
endmodule



