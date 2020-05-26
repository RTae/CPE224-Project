  
module Alarm(clk,alminI,alhrI,alminF,alhrF,min,hr,assert);
  input clk;
  input [7:0] alminI,alhrI,alminF,alhrF,min,hr;
//  input [1:0]mode;
  output reg assert;
  always@(posedge clk)
  begin
      if(alhrI == hr)
          assert <= 1;
      else
        assert <=0;
  end
endmodule