module alarmSet(
    input clk,
    input switch,
    input clear,
    input [4:0]Button,
    input [23:0]AtTime, // hour[23:16] - min[15:8] - second[7:0]
    output reg[13:0]alramTime, // hour[13:8] - min[7:0] 
    output reg[1:0]LED,
    output reg assert
    );
    
    reg state,AlarmState;
    reg[7:0]alminITemp,alhrITemp,alminFTemp,alhrFTemp;
    
    initial
        begin
            alminITemp=8'h0;
            alhrITemp=8'h0;
            alminFTemp=8'h0;
            alhrFTemp=8'h5;
            AlarmState=1'b0;
        end
          
    always @( posedge  clk )
    begin
        if(alhrITemp == AtTime[23:16] && alminITemp == AtTime[15:8] )
          assert <= 1;
        else if(alhrFTemp == AtTime[23:16] && alminFTemp == AtTime[15:8] || clear)
          assert <=0;
        if(switch)
            begin
            if(Button[0]) // C
                AlarmState = !AlarmState;
            if(!AlarmState)
                begin
                if(Button[4] == 1'b1) // L 
                    state = 1'b1;
                else if(Button[3] == 1'b1) // R
                    state = 1'b0;
                if(state == 1'b1)
                    begin
                        if(Button[2] == 1'b1) // U 
                            if (alhrITemp > 8'h17)
                                alhrITemp = 8'h17;
                            else
                                alhrITemp = alhrITemp + 1'b1;
                        else if (Button[1] == 1'b1) // D
                            if (alhrITemp < 8'h0)
                                alhrITemp = 8'h0;
                            else
                                alhrITemp = alhrITemp - 1'b1;
                    end
                else if (state == 1'b0)
                    begin
                        if(Button[2] == 1'b1) // U 
                            if (alminITemp > 8'h3B)
                                alminITemp = 8'h3B;
                            else
                                alminITemp = alminITemp + 1'b1;
                        else if (Button[1] == 1'b1) // D
                            if (alminITemp < 8'h0)
                                alminITemp = 8'h0;
                            else
                                alminITemp = alminITemp - 1'b1;
                    end
                  alramTime <= {alhrITemp,alminITemp};
                  LED <= 2'b01;
               end
            else
                begin
                if(Button[4] == 1'b1) // L 
                    state = 1'b1;
                else if(Button[3] == 1'b1) // R
                    state = 1'b0;
                if(state == 1'b1)
                    begin
                        if(Button[2] == 1'b1) // U 
                            if (alhrFTemp > 8'h17)
                                alhrFTemp = 8'h17;
                            else
                                alhrFTemp = alhrFTemp + 1'b1;
                        else if (Button[1] == 1'b1) // D 
                            if (alhrFTemp < 8'h0)
                                alhrFTemp = 8'h0;
                            else
                                alhrFTemp = alhrFTemp - 1'b1;
                    end
                else if (state == 1'b0)
                    begin
                        if(Button[2] == 1'b1) // U 
                            if (alminFTemp > 8'h3B)
                                alminFTemp = 8'h3B;
                            else
                                alminFTemp = alminFTemp + 1'b1;
                        else if (Button[1] == 1'b1) // D
                            if (alminFTemp < 8'h0)
                                alminFTemp = 8'h0;
                            else
                                alminFTemp = alminFTemp - 1'b1;
                    end
                  alramTime <= {alhrFTemp,alminFTemp};
                  LED <= 2'b10;
               end
         end
    end
    
endmodule
