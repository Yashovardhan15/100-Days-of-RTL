module single_port_ram #(
  parameter DATA_WIDTH = 8,
  parameter ADDR_WIDTH = 6
)(
  input logic clk,
  input logic rst,
  input logic [DATA_WIDTH-1 : 0] data1,
  input logic [ADDR_WIDTH-1 : 0] addr1,
  input logic enable1,
  input logic [DATA_WIDTH-1 : 0] data2,
  input logic [ADDR_WIDTH-1 : 0] addr2,
  input logic enable2,
  output logic [DATA_WIDTH-1 : 0] q1,
  output logic [DATA_WIDTH-1 : 0] q2
  
);
  logic [DATA_WIDTH-1 : 0] ram[0 : 2**(ADDR_WIDTH)-1];
  
  always@(posedge clk) begin
    if(rst) begin
      q1 <= 0;
      q2 <= 0;
    end else begin
      if (enable1) begin
        ram[addr1] <= data1;
      end else begin
        q1 <= ram[addr1];
      end 
      if (enable2) begin
        ram[addr2] <= data2;
      end else begin
        q2 <= ram[addr2];
      end 
    end 
  end
endmodule