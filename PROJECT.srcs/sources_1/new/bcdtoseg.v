module bcdto7seg(
    input [3:0]BCD,
    output reg [6:0]seq
);

    always @(BCD)
    begin
        case(BCD)
        4'b0000: seq = 7'b0000001; // "0"     
        4'b0001: seq = 7'b1001111; // "1" 
        4'b0010: seq = 7'b0010010; // "2" 
        4'b0011: seq = 7'b0000110; // "3" 
        4'b0100: seq = 7'b1001100; // "4" 
        4'b0101: seq = 7'b0100100; // "5" 
        4'b0110: seq = 7'b0100000; // "6" 
        4'b0111: seq = 7'b0001111; // "7" 
        4'b1000: seq = 7'b0000000; // "8"     
        4'b1001: seq = 7'b0000100; // "9" 
        default: seq = 7'b0000001; // "0"
        endcase
    end
 endmodule