module counter_tb;
  logic clk;
  logic rst;
  logic [3:0] count;
  
  logic [3:0] count_e;       
  
  counter counter_inst(.*);
  
  always@(clk) begin
    #1 clk <= ~clk;
  end 
  
  function void compare(input logic [3:0]count, input logic [3:0]count_e);
    if(count == count_e) begin
      $display("Pass : count is %0h", count);
    end else begin
      $display("Fail : count is %0h count_e is %0h", count, count_e);
    end 
  endfunction
    
  initial begin
    clk=0;rst=1; count_e = 0;
    @(posedge clk);
    @(posedge clk);
    rst=0;
    repeat(3) begin
      repeat(20) begin
        count_e <= count_e + 1;
        compare(count,count_e);
        @(posedge clk);
      end 
      rst=1; count_e = 0;
      @(posedge clk);
      rst=0;
    end
    $finish();
  end
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
  end
  
endmodule