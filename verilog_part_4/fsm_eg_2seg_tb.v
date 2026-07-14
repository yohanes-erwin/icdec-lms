`timescale 1ns / 1ps

module fsm_eg_2seg_tb();
    localparam T = 10;
    
    reg clk;
    reg rst_n;
    reg a, b;
    wire [7:0] x, y;

    fsm_eg_2seg dut
    (
        .clk(clk),
        .rst_n(rst_n),
        .a(a),
        .b(b),
        .x(x),
        .y(y)
    );
    
    always
    begin
        clk = 0;
        #(T/2);
        clk = 1;
        #(T/2);
    end
    
    initial
    begin
        a = 0;
        b = 0;
    
        rst_n = 0;
        #T;
        rst_n = 1;
        #T;
        
        a = 1; b = 0; // Go to state S1
        #T;
        a = 1; b = 0; // Go back to state S0
        #T;    
        a = 1; b = 1; // Go to state S2
        #T;           
        a = 0; b = 0;        
    end
    
endmodule
