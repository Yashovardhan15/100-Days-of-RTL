module sipo_tb;
  logic clk;
  logic rst;
  logic si;
  logic [3:0] po;
  
  logic [3:0] po_e;
  
  sipo sipo_inst(.*);
  
  function void compare(input logic clk, input logic rst, input logic si, input logic [3:0] po, input logic [3:0] po_e); 
    if(po_e == po) begin
      $monitor("Pass : po is %0h ", po);
    end else begin
      $monitor("Fail : po is %0h  and po_e is %0h ", po, po_e);
    end   
  endfunction
  
  function void model(input logic clk, input logic rst, input logic si, input logic [3:0] po, output logic [3:0] po_e);
    if(rst) begin
      po_e = 'h0;
    end else begin
      po_e = po_e << 1;
      po_e[0] = si;
    end
  endfunction
  
  always@(*) begin
    #1 clk <= ~clk;
  end
    
  initial begin
    clk=0;rst=1;
    model(clk, rst, si, po, po_e);
    @(posedge clk);
    model(clk, rst, si, po, po_e);
    @(posedge clk);
    compare(clk, rst, si, po, po_e);
    rst=0;
      repeat(20) begin
        si = $random();
        model(clk, rst, si, po, po_e);
        @(posedge clk);
        compare(clk, rst, si, po, po_e);
      end
    $finish();
  end
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
  end
endmodule