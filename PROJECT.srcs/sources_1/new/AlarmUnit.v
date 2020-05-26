module AlarmUnit(
        input clk,
        input [3:0]switch,
        input [4:0]Button,
        input [23:0]AtTime,
        output reg [13:0]AlamSet,
        output reg [1:0]LED,
        output [2:0]Alert
    );
    
    wire [13:0]alramTime1,alramTime2,alramTime3;
    wire [1:0]LED1,LED2,LED3;
    wire assert1,assert2,assert3;
    
    alarmSet Alarm1(
        .clk(clk),
        .switch(switch[0]),
        .clear(switch[3]),
        .Button(Button),
        .AtTime(AtTime),
        .alramTime(alramTime1),
        .LED(LED1),
        .assert(assert1)
    );
    
    alarmSet Alarm2(
        .clk(clk),
        .switch(switch[1]),
        .clear(switch[3]),
        .Button(Button),
        .AtTime(AtTime),
        .alramTime(alramTime2),
        .LED(LED2),
        .assert(assert2)
    );
    
    alarmSet Alarm3(
        .clk(clk),
        .switch(switch[2]),
        .clear(switch[3]),
        .Button(Button),
        .AtTime(AtTime),
        .alramTime(alramTime3),
        .LED(LED3),
        .assert(assert3)
    );
    
    always @(posedge clk)
        begin
            case(switch[2:0])
                3'b001: 
                    begin
                        AlamSet <= alramTime1;
                        LED <= LED1;
                    end
                3'b010: 
                    begin
                        AlamSet <= alramTime2;
                        LED <= LED2;
                    end
                3'b100: 
                    begin
                        AlamSet <= alramTime3;
                        LED <= LED3;
                    end
                default : AlamSet <= AtTime;
            endcase
        end
       assign Alert = {assert3,assert2,assert1};
endmodule
