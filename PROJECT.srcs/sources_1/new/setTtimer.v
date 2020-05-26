module setTimer(
    input clk,
    input switch,
    input [4:0]Button,
    output [15:0]setTime
    );
    
    reg [7:0]initMin,initHour;
    reg state;
    
    initial
        begin
            initMin=8'h0;
            initHour=8'h0;
        end
        
    always @( posedge  clk )
    begin
        if(switch)
            begin
                if(Button[4] == 1'b1) // L
                    state = 1'b1;
                else if(Button[3] == 1'b1) // R
                    state = 1'b0;
                if(state == 1'b1)
                    begin
                        if(Button[2] == 1'b1) // U
                            if (initHour > 8'h17)
                                initHour = 8'h17;
                            else
                                initHour = initHour + 1'b1;
                        else if (Button[1] == 1'b1) // D
                            if (initHour < 8'h0)
                                initHour = 8'h0;
                            else
                                initHour = initHour - 1'b1;
                    end
                else if (state == 1'b0)
                    begin
                        if(Button[2] == 1'b1)
                            if (initMin > 8'h3B)
                                initMin = 8'h3B;
                            else
                                initMin = initMin + 1'b1;
                        else if (Button[1] == 1'b1)
                            if (initMin < 8'h0)
                                initMin = 8'h0;
                            else
                                initMin = initMin - 1'b1;
                    end
            end
    end
    
    assign setTime = {initHour,initMin};
endmodule
