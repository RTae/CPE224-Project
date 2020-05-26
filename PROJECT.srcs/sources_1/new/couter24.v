module counter24(switch, clkin, init, count, tc);
  input clkin;
  input [1:0]switch;
  input [7:0]init;
  output reg [7:0]count;
  output reg tc;

  always @( posedge clkin)
  begin
    case(switch)
    2'b01 :
        begin
            count<=8'h0;
            tc <= 1'b1;
        end
    2'b10 :
        begin
            count<=init;
            tc <= 1'b1;
        end
    default :
        begin
            if(count == 8'h17)
                begin
                    count <= 8'h0;
                    tc <= 1'b1;
                end
            else
                begin
                    count[7:0] = count[7:0] + 1'b1;
                    tc <= 1'b0;
            end
        end
     endcase
  end
endmodule