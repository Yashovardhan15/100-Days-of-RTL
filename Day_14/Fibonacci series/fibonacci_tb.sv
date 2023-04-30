module fibonacci_tb();
  logic clk;
  logic rst;
  int out;
  int size;
  
  
  fibonacci fibonacci_inst(.*);
  
  always@(*) begin
    #1 clk <= ~clk;
  end
  
  initial begin
    clk=0; rst=1;
    @(posedge clk);
    @(posedge clk);
    $display("out is %0h ",out);
    rst=0;
    size=10;
    repeat(size) begin
      @(posedge clk);
      $display("out is %0h ",out); 
    end
    $finish();  
  end
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0);
  end
  
  
endmodule