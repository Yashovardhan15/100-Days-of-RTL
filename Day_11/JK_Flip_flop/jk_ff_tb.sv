module jk_ff_tb;
  logic j;
  logic k;
  logic clk;
  logic q;
  logic qbar;
   
  logic q_e;

  jk_ff jk_ff_inst(.*);
  
  always@(*) begin
    #1 clk <= ~clk;
  end
  
  function void compare(input logic q, input logic q_e);
    if(q === q_e) begin
      $display("Pass");
    end else begin
      $display(" Time is %0t , j is %0h and k is %0h ,Fail q is %0h and q_e is %0h",$time,j,k, q, q_e);
    end
  endfunction
  

  function void model(input logic j, input logic k, input logic q, output logic q_e);
    
    q_e = (j && k) ? ~q : j ? 1 : k ? 0 : q_e;
    
  endfunction 
                            
  initial begin
    clk=0;j=0;k=1;
    @(negedge clk);
    model(j,k,q,q_e);
    @(negedge clk);
    compare(q,q_e);
    k=0;
    repeat(20) begin
      j = $random();
      k = $random();
      model(j,k,q,q_e);
      @(posedge clk);
      compare(q,q_e);
    end
    $finish();
  end
               
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
  end
  
endmodule             