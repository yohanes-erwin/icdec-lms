`timescale 1ns / 1ps

module register_tb();
    localparam T = 10;
    
    reg clk;
    reg rst_n;
    reg en;
    reg clr;
    reg [7:0] d;
    wire [7:0] q;
    
    register
    #(8)
    dut
    (
        .clk(clk),
        .rst_n(rst_n),
        .en(en),
        .clr(clr),
        .d(d),
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
        en = 1;
        clr = 0;
        d = 0;
        
        rst_n = 0;
        #T;
        rst_n = 1;
        #T;
        
        d = 8'd8;
        #T;
        d = 8'd16;
        #T;
        
        clr = 1;
        #T;
    end
endmodule
