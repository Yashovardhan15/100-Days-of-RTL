module palindrome_tb();
  string dialog;
  int cnt;
  int lptr;
  int rptr;
  
  initial begin
    dialog = "malayalam";
    lptr = 0;
    rptr = dialog.len()-1;
    do begin
      if(dialog[lptr] == dialog[rptr]) begin
        cnt = cnt + 1;
      end
      lptr = lptr + 1;
      rptr = rptr - 1;
      
    end
    while(lptr != dialog.len()/2); 
      
    if(cnt == dialog.len()/2) begin
      $display("Pass ");
    end else begin
      $display("Fail count is %d",cnt);
    end
    
  end
endmodule