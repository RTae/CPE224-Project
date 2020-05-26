module ClockUnit(
    input clk,clk1s,
    input [1:0]switch,
    input [15:0]initTime,
    output [23:0]clock
    );
    
    wire [7:0] second, minute, hour;
    wire tc_s, tc_m;
    
    reg [7:0]initSecond = 8'h0;
        
    counter60 sec(
            .switch(switch),
            .clkin(switch[1] ? (clk) :(clk1s)),
            .init(initSecond),
            .count(second),
            .tc(tc_s)
    );
    
    counter60 min(
            .switch(switch),
            .clkin(switch[1] ? (clk) :(tc_s)),
            .init(initTime[7:0]),
            .count(minute),
            .tc(tc_m)
    );
    
    counter24 hou(
            .switch(switch),
            .clkin(switch[1] ? (clk) :(tc_m)),
            .init(initTime[15:8]),
            .count(hour),
            .tc(tc_h)
     );
     
     assign clock = {hour,minute,second};
     
endmodule
