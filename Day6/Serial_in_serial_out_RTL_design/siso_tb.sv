module siso_tb;
  logic clk;
  logic rst;
  logic si;
  logic so;
  
  logic so_e;
  
  logic[3:0] temp;
  
  siso siso_inst(.*);
  
  function void compare(input logic clk, input logic rst, input logic si, input logic so, input logic so_e);
    if(rst) begin
      so_e = 0;
      temp = 0;
    end else begin
      so_e = temp[3];
      temp = temp << 1;
      temp[0] = si;
    end
    
    if(so_e == so) begin
      $display("Pass : so is %0h ", so);
    end else begin
      $display("Fail : so is %0h  and so_e is %0h ", so, so_e);
    end   
  endfunction
  
  always@(*) begin
    #1 clk <= ~clk;
  end
    
  initial begin
    clk=0;rst=1;
    @(posedge clk);
    @(posedge clk);
    compare(clk, rst, si, so, so_e);
    rst=0;
      repeat(20) begin
        si = $random();
        @(posedge clk);
        compare(clk, rst, si, so, so_e);
      end
    $finish();
  end
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
  end
  
endmodule