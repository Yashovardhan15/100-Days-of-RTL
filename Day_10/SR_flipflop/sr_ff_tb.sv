module sr_ff_tb;
  logic s;
  logic r;
  logic clk;
  logic q;
  logic qbar;
  
  logic q_e;

  sr_ff sr_ff_inst(.*);
  
  always@(*) begin
    #1 clk <= ~clk;
  end
  
  function void compare(input logic q, input logic q_e);
    if(q === q_e) begin
      $display(" Time is %0t, Pass ", $time);
    end else begin
      $display("Time is %0t, Fail  q is %0h and q_e is %0h s is %0h and r is %0h ", $time, q, q_e,s, r);
    end
    
  endfunction
  
  function void model(input logic s, input logic r, input logic clk, output logic q_e);
    
    q_e = (s && r) ? 'hz : s ? 1 : r ? 0 : q_e;
    
  endfunction
  
  initial begin
    clk=0;s=0;r=1;
    @(negedge clk);
    model(s, r, clk,q_e);
    @(negedge clk);
    compare(q, q_e);
    r=0;
    repeat(20) begin
      s = $random();
      r = $random();
      model(s, r, clk, q_e);
      @(posedge clk);
      compare(q, q_e);
    end
    $finish();
  end
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
  end
  
endmodule