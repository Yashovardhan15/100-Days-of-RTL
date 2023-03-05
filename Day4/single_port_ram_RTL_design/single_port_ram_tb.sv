module single_port_ram_tb;
  parameter DATA_WIDTH = 8;
  parameter ADDR_WIDTH = 6;
  logic clk;
  logic rst;
  logic [DATA_WIDTH-1 : 0] data;
  logic [ADDR_WIDTH-1 : 0] addr;
  logic enable;
  logic [DATA_WIDTH-1 : 0] q;
  
  logic [DATA_WIDTH-1 : 0] q_e;
  logic [DATA_WIDTH-1 : 0] q1[$];
  
  
  single_port_ram #(.DATA_WIDTH(DATA_WIDTH), .ADDR_WIDTH(ADDR_WIDTH)) single_port_ram_inst (.*);
  
  function void compare(input logic clk, input logic rst, input logic [DATA_WIDTH-1 : 0] data, input logic [ADDR_WIDTH-1 : 0] addr, input logic enable, input logic [DATA_WIDTH-1 : 0] q, input logic [DATA_WIDTH-1 : 0] q_e);
    
    logic [DATA_WIDTH-1 : 0] ram[0 : 2**(ADDR_WIDTH)-1];
    
    if(rst) begin
      q_e = 0;
    end else begin
      if (enable) begin
        ram[addr] = data;
      end else begin
        q_e = ram[addr];
      end 
    end 
      
    if (enable == 0) begin
      if(q == q_e) begin
        $display("Pass %0t: q is %0h", $time, q);
      end else begin
        $display("Fail %0t : q is %0h and q_e is %0h ", $time, q, q_e);
      end
    end  
      
  endfunction
      
  always@(*) begin
    #1 clk <= ~clk;
  end
  
  initial begin  
    clk = 0;rst = 1;
    @(posedge clk);
    @(posedge clk);
    compare(clk,rst, data, addr, enable, q, q_e);
    rst = 0;
    data = $random();
    addr = $random();
    enable = 1'b1;   
    q1.push_back(addr); 
    @(posedge clk);
    compare(clk,rst, data, addr, enable, q, q_e);
    repeat(20) begin
      data = $random();
      q1.shuffle();
      enable = $random();
      if(enable == 0) begin
        addr = q1[0];
      end else begin
        addr = $random();
      end
         
      if(enable) begin
        q1.push_back(addr); 
      end
      @(posedge clk);
      compare(clk,rst, data, addr, enable, q, q_e);
    end
    $finish();
  end
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
  end  
endmodule