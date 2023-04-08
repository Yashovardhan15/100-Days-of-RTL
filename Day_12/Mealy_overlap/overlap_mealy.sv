//1010 detector
module overlap_mealy #( 
)( 
  input logic clk,
  input logic rst, 
  input logic in,
  output logic z
);
  
  typedef enum logic[1:0] {
    IDLE = 2'h0,
    A = 2'h1,
    B = 2'h2,
    C = 2'h3
  } states_t;
  
  states_t state, next_state;
  
  always @(posedge clk) begin
    if(rst) begin 
      state <= IDLE;
      next_state <= IDLE;
    end else begin
      state <= next_state;
    end
  end
  
  always @(state or in) begin
    case(state)
      IDLE: 
        if(in == 0) begin
          next_state = IDLE;
        end else begin
          next_state = A;
        end
      
      A: 
        if(in == 0) begin
          next_state = B;
        end else begin
           next_state = A;
        end
      
      B: 
        if(in == 0) begin 
          next_state = IDLE;
        end else begin
          next_state = C;
        end
      
      C: 
        if(in == 0) begin
          next_state = B; 
        end else begin
          next_state = A;
        end
      
      default: next_state = IDLE;
    endcase
  end
  
  assign z = (state == C) ? 1:0;
  
endmodule