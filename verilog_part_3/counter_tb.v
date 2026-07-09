`timescale 1ns / 1ps

module counter_tb();
    localparam T = 10;
    
    reg clk;
    reg rst_n;
    reg clr;
    reg start;
    wire [7:0] q;
    
    counter dut
    (
        .clk(clk),
        .rst_n(rst_n),
        .clr(clr),
        .start(start),
        .q(q)
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
        clr = 0;
        start = 0;
        
        rst_n = 0;
        #T;
        rst_n = 1;
        #T;
        
        start = 1;
        #T;
        start = 0;
    end
endmodule
