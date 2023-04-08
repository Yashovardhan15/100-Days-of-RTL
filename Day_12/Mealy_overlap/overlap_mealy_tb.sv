module non_over_mealy; 
  logic clk;
  logic rst; 
  logic in;
  logic z;

  overlap_mealy over_mealy_inst(.*);
  
  always@(*) begin
    #5 clk <= ~clk;
  end
  
  initial begin
    clk=0; rst=1; in=0;
    @(posedge clk);
    repeat(1) begin
      @(posedge clk);
      rst=0;
      
      @(posedge clk) in = 1;
      @(posedge clk) in = 0;
      @(posedge clk) in = 1;
      @(posedge clk) in = 0;
      #1 $display("Z is %0h", z);
      @(posedge clk) in = 1;
      @(posedge clk) in = 1;
      @(posedge clk) in = 0;
      @(posedge clk) in = 1;
      @(posedge clk) in = 0;  
      #1 $display("Z is %0h", z);
      @(posedge clk) in = 1;
      @(posedge clk) in = 0;
      #1 $display("Z is %0h", z);
    end
    $finish();
  end
  
  
  
  initial begin
    $dumpvars;
    $dumpfile("dump.vcd");
  end
  
endmodule
 