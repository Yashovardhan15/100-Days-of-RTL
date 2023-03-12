module d_ff_tb;
  logic clk;
  logic rst;
  logic d;
  logic q;
  logic qbar;
  
  d_ff d_ff_inst(.*);
  
  initial begin
    clk = 0; rst = 1;
    @(negedge clk);
    @(negedge clk);
    rst = 0;
    if(q == 0) begin
      $display("Pass ");
    end else begin
      $display("Fail");
    end
    repeat(20) begin
      d = $random();
      @(negedge clk);
      if(q == d) begin
        $display("Pass ");
      end else begin
        $display("Fail ");
      end
    end
    $finish();
  end
  
  always@(*) begin
   #1 clk <= ~clk;
  end
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
  end
  
endmodule
  
  