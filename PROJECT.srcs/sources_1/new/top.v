module top(
    input [5:0]sw,
    input clk,btnC,btnU,btnL,btnR,btnD,
    output [7:0]led,
    output [2:0]JA,
    output [6:0]seg,
    output [3:0]Anode_Activate
    );
    
    wire [23:0]Clock,Alarm;
    wire [15:0]intiTime;
    wire [6:0]SEQ;
    wire [4:0]btnDe;
    wire [3:0]BCD,AA;
    wire [2:0]Alert;
    wire [1:0]LED;
    wire clk1s;
    
    reg temp;
           
    clocking_module couterOne(
        .clk(clk),
        .clk1s(clk1s)
    );
    
    always @(posedge clk1s)
        temp = !temp;
    
    ButtonDebouncingUnit ButtonDeboucing1(
        .clk(clk),
        .btnU(btnU),
        .btnL(btnL),
        .btnR(btnR),
        .btnD(btnD),
        .btnC(btnC),
        .btnDe(btnDe)
    );
    
    setTimer setTime1(
        .clk(clk),
        .switch(sw[1]),
        .Button(btnDe),
        .setTime(intiTime) // [7:0]Hour - [7:0]Min
    );
    
    ClockUnit Clock1(
        .clk(clk),
        .clk1s(clk1s),
        .switch(sw[1:0]),
        .initTime(intiTime),
        .clock(Clock)
    );
    
    AlarmUnit Alarm1(
        .clk(clk),
        .switch(sw[5:2]),
        .Button(btnDe),
        .AtTime(Clock),
        .AlamSet(Alarm),
        .LED(LED),
        .Alert(Alert)
    );
    
    DisplayUnit Disp1(
        .clk(clk),
        .reset(sw[0]),
        .Clock(Clock),
        .Alarm(Alarm),
        .switch(sw[4:2]),
        .BCD(BCD),
        .AA(AA)
     );
    
     bcdto7seg seq1(
        .BCD(BCD),
        .seq(SEQ)
     );
            
     assign seg = SEQ;
     assign Anode_Activate = AA;
     assign led[0] = temp;
     assign led[1] = (sw[5:0] == 6'b000010) ? 1'b1 : 1'b0;
     assign led[2] = (sw[5:0] == 6'b000100) ? 1'b1 : 1'b0;
     assign led[3] = (sw[5:0] == 6'b001000) ? 1'b1 : 1'b0;
     assign led[4] = (sw[5:0] == 6'b010000) ? 1'b1 : 1'b0;
     assign led[6:5] =(sw[4:2] == 3'b000) ? 2'b00 : LED;
     assign led[7] = Alert[0] || Alert[1] || Alert[2];
     assign JA[0] = Alert[0];
     assign JA[1] = Alert[1];
     assign JA[2] = Alert[2];
                       
endmodule
