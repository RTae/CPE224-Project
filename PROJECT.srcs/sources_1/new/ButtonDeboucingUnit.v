module ButtonDebouncingUnit(
    input clk,btnU,btnL,btnR,btnD,btnC,
    output [4:0]btnDe
    );
    
    wire btnLDe,btnRDe,btnUDe,btnDDe,btnCDe;
    
    debouncing LeftButtDe(
            .clk(clk),
            .i_btn(btnL),
            .o_ondn(btnLDe)
    );
        
    debouncing RightButtDe(
            .clk(clk),
            .i_btn(btnR),
            .o_ondn(btnRDe)
    );
        
    debouncing UpButtDe(
            .clk(clk),
            .i_btn(btnU),
            .o_ondn(btnUDe)
    );
        
    debouncing DownButtDe(
            .clk(clk),
            .i_btn(btnD),
            .o_ondn(btnDDe)
    );
        
    debouncing CenterButtDe(
            .clk(clk),
            .i_btn(btnC),
            .o_ondn(btnCDe)
    );
      
    assign btnDe = {btnLDe,btnRDe,btnUDe,btnDDe,btnCDe}; // L , R , U , D , C
endmodule
