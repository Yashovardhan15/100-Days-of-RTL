module fibonacci (
  input logic clk,
  input logic rst,
  input int size,
  output int out
);
  int ptr;
  int q[$];
  
  always@(posedge clk) begin
    if(rst) begin
      out <= 0;
      ptr <= 0;
    end else begin
      
      if(ptr == 0) begin
        out <= 0;
        ptr <= ptr + 1;
        q.push_back(0);
      end else if(ptr == 1) begin
        out <= 1;
        ptr <= ptr + 1;
        q.push_back(1);
      end else begin
        out <= q[ptr-1] + q[ptr-2];        
        q.push_back(q[ptr-1]+q[ptr-2]);
        ptr <= ptr + 1;
      end     
    end
  end
  
endmodule  