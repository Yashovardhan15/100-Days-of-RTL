module mux_tb;
  parameter WIDTH = 32; 
  parameter SEL_WIDTH = 1;
  logic [WIDTH-1 : 0] a;
  logic [WIDTH-1 : 0] b;
  logic [SEL_WIDTH-1 : 0] sel;
  logic [WIDTH-1 : 0] muxout;
  
  logic [WIDTH-1 : 0] muxout_e;
  
  mux mux_inst(.*);
  
  always@(*) begin
    case(sel)
      0: begin
           muxout_e = b;
         end
      1: begin
           muxout_e = a;
         end
      default: begin
                 muxout_e = 'hx;
               end
    endcase
  end
 
  //assign muxout_e = sel ? a : b;
  
  function void compare(input logic [WIDTH-1 : 0] a, input logic [WIDTH-1 : 0] b, input logic [SEL_WIDTH-1 : 0] sel, input logic [WIDTH-1 : 0] muxout, input logic [WIDTH-1 : 0] muxout_e);
    if(muxout == muxout_e) begin
      $display("Pass : a is %0h b is %0h sel is %0h muxout is %0h", a, b, sel, muxout);
    end else begin
      $display("Fail : a is %0h b is %0h sel is %0h muxout is %0h muxout_e is %0h", a, b, sel, muxout, muxout_e);
    end
  endfunction
  
  initial begin
    a = 0;b = 0;sel = 0;
    #1;
    compare(a, b, sel, muxout, muxout_e);
    repeat(40) begin
      a = $random();
      b = $random();
      sel = $random();
      #1;
      compare(a, b, sel, muxout, muxout_e);
    end
  end
    
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
  end
endmodule