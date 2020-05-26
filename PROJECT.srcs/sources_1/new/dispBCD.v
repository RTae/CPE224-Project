module dispBCD(
    input clock_100Mhz,
    input reset,
    input [23:0]clock,
    output reg [3:0] LED_BCD,
    output reg [3:0] Anode_Activate
    );
    reg [19:0] counter;
    wire [1:0] LED_activating; 
     
    always @(posedge clock_100Mhz)
        begin 
            if(reset == 1)
                counter <= 20'b00000000000000000000;
            else
                counter <= counter + 1;
        end 
    
    assign LED_activating = counter[19:18];
    
    always @(*)
    begin
        case(LED_activating)
        2'b00: begin
            Anode_Activate = 4'b0111; 
            LED_BCD = clock[15:8] / 10;
              end
        2'b01: begin
            Anode_Activate = 4'b1011; 
            LED_BCD = clock[15:8] % 10;
              end
        2'b10: begin
            Anode_Activate = 4'b1101; 
            LED_BCD = clock[7:0] / 10;
                end
        2'b11: begin
            Anode_Activate = 4'b1110; 
            LED_BCD = clock[7:0] % 10;
               end
        endcase
    end 
 endmodule