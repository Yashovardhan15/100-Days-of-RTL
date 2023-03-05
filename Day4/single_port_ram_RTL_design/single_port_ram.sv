module single_port_ram #(
  parameter DATA_WIDTH = 8,
  parameter ADDR_WIDTH = 6
)(
  input logic clk,
  input logic rst,
  input logic [DATA_WIDTH-1 : 0] data,
  input logic [ADDR_WIDTH-1 : 0] addr,
  input logic enable,
  output logic [DATA_WIDTH-1 : 0] q
);
  logic [DATA_WIDTH-1 : 0] ram[0 : 2**(ADDR_WIDTH)-1];
  
  always@(posedge clk) begin
    if(rst) begin
      q <= 0;
    end else begin
      if (enable) begin
        ram[addr] <= data;
      end else begin
        q <= ram[addr];
      end 
    end 
  end
endmodule