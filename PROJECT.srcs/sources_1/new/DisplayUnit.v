module DisplayUnit(
        input clk,reset,
        inout [23:0]Clock,
        input [13:0]Alarm,
        input [2:0]switch,
        output reg [3:0]BCD,AA
    );
    
    wire [3:0]BCD_Clock,BCD_Alarm,AA_Clock,AA_Alarm;
    
    dispBCD dispClock(
        .clock_100Mhz(clk),
        .reset(reset),
        .clock(Clock[23:8]),
        .LED_BCD(BCD_Clock),
        .Anode_Activate(AA_Clock)
     );
     
    dispBCD dispAlarm(
        .clock_100Mhz(clk),
        .reset(reset),
        .clock(Alarm),
        .LED_BCD(BCD_Alarm),
        .Anode_Activate(AA_Alarm)
     );
     
     always @(posedge clk)
        begin
            if(switch == 3'b000)
                begin
                    BCD <= BCD_Clock;
                    AA <= AA_Clock;
                end
            else
                begin
                    BCD <= BCD_Alarm;
                    AA <= AA_Alarm;
                end
        end
     
endmodule
