module dual_port_ram_tb;
  parameter DATA_WIDTH = 8;
  parameter ADDR_WIDTH = 6;
  logic clk;
  logic rst;
  logic [DATA_WIDTH-1 : 0] data1;
  logic [ADDR_WIDTH-1 : 0] addr1;
  logic enable1;
  logic [DATA_WIDTH-1 : 0] q1;
  logic [DATA_WIDTH-1 : 0] data2;
  logic [ADDR_WIDTH-1 : 0] addr2;
  logic enable2;
  logic [DATA_WIDTH-1 : 0] q2;
  
  logic [DATA_WIDTH-1 : 0] q_e1;
  logic [DATA_WIDTH-1 : 0] q_e2;
  logic [DATA_WIDTH-1 : 0] queue1[$];
  
  
  dual_port_ram dual_port_ram_inst(.*);
  
  function void compare(input logic clk, input logic rst, input logic [DATA_WIDTH-1 : 0] data1, input logic [DATA_WIDTH-1 : 0] data2, input logic [ADDR_WIDTH-1 : 0] addr1, input logic [ADDR_WIDTH-1 : 0] addr2, input logic enable1, input logic enable2, input logic [DATA_WIDTH-1 : 0] q1, input logic [DATA_WIDTH-1 : 0] q2, input logic [DATA_WIDTH-1 : 0] q_e1, input logic [DATA_WIDTH-1 : 0] q_e2);
    
    logic [DATA_WIDTH-1 : 0] ram[0 : 2**(ADDR_WIDTH)-1];
    
    if(rst) begin
      q_e1 = 0;
      q_e2 = 0;
    end else begin
      if (enable1) begin
        ram[addr1] = data1;
      end else begin
        q_e1 = ram[addr1];
      end 
      if (enable2) begin
        ram[addr2] = data2;
      end else begin
        q_e2 = ram[addr2];
      end 
    end 
      
    if (enable1 == 0) begin
      if(q1 == q_e1) begin
        $display("Pass %0t: q1 is %0h", $time, q1);
      end else begin
        $display("Fail %0t : q1 is %0h and q_e1 is %0h ", $time, q1, q_e1);
      end
    end
    if (enable2 == 0) begin
      if(q2 == q_e2) begin
        $display("Pass %0t: q2 is %0h", $time, q2);
      end else begin
        $display("Fail %0t : q2 is %0h and q_e2 is %0h ", $time, q2, q_e2);
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
    compare(clk,rst, data1, data2, addr1, addr2, enable1, enable2, q1, q2, q_e1, q_e2);
    rst = 0;
    data1 = $random();
    addr1 = $random();
    enable1 = 1'b1;   
    queue1.push_back(addr1);
    data2 = $random();
    addr2 = $random();
    enable2 = 1'b1;   
    queue1.push_back(addr2);
    @(posedge clk);
    compare(clk,rst, data1, data2, addr1, addr2, enable1, enable2, q1, q2, q_e1, q_e2);
    repeat(20) begin
      data1 = $random();
      data2 = $random();
      queue1.shuffle();
      enable1 = $random();
      enable2 = $random();
      if(enable1 == 0) begin
        queue1.shuffle();
        addr1 = queue1[0];
      end else begin
        addr1 = $random();
      end
      if(enable2 == 0) begin
        queue1.shuffle();
        addr2 = queue1[0];
      end else begin
        addr2 = $random();
      end
         
      if(enable1) begin
        queue1.push_back(addr1); 
      end
      if(enable2) begin
        queue1.push_back(addr2); 
      end
      @(posedge clk);
      compare(clk,rst, data1, data2, addr1, addr2, enable1, enable2, q1, q2, q_e1, q_e2);
    end
    $finish();
  end
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
  end
  
endmodule
