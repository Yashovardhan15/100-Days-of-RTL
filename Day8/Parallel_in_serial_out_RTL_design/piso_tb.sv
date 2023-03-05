module piso_tb;
  logic clk;
  logic rst;
  logic [3:0] pi;
  logic load;
  logic so;
  
  logic so_e;
  logic [3:0] temp;
  
  piso piso_inst(.*);
  
  function void model(input logic clk, input logic rst, input logic [3:0] pi, input logic load, input logic so,  output logic [3:0] temp);    
    if(rst) begin
      so_e = 0;
      temp = 0;
    end else begin
      if(load) begin
        temp = pi;
      end else begin
        temp = temp<<1;
      end
    end
  endfunction
  
  function void compare(input logic clk, input logic rst, input logic [3:0] pi, input logic load, input logic so, input logic [3:0] temp);
    logic so_e;
    so_e = temp[3];
    
    if(so_e == so) begin
      $monitor("Time is %0t Pass : so is %0h ",$time, so);
    end else begin
      $monitor("Time is %0t Fail : so is %0h  and so_e is %0h ", $time, so, so_e);
    end   
  endfunction
  
  always@(*) begin
    #1 clk <= ~clk;
  end
    
  initial begin
    clk=0;rst=1;
    @(negedge clk);
    @(negedge clk);
    compare(clk, rst, pi,load, so, temp);
    rst=0;
      repeat(20) begin
        pi = $random();
        load = $random();
        compare(clk, rst, pi, load, so, temp);
        @(negedge clk);
      end
    $finish();
  end
  
  initial begin
    model(clk, rst, pi, load, so, temp);
    forever begin 
      @(posedge clk);
      model(clk, rst, pi, load, so, temp);
    end
  end
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
  end
  
endmodule