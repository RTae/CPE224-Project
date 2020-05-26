module clocking_module(
	input clk,
	output clk1s
);         
 reg elapsed;//elapsed time 1 second          
 reg [27:0] state;          
 always @(posedge clk)          
 if (state == 100000000) 
    state <= 0;          
 else 
    state <= state + 1;          
 always @(state)          
 if (state == 100000000) 
    elapsed = 1;          
 else  
    elapsed = 0;          
 assign clk1s = elapsed;  
endmodule