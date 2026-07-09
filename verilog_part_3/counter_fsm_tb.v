`timescale 1ns / 1ps

module counter_fsm_tb();
    localparam T = 10;
    
    reg clk;
    reg rst_n;
    reg clr;
    reg start;
    wire en_rd;
    wire [3:0] addr_rd;
    wire en_pe;
    wire en_wr;
    wire [3:0] addr_wr;
    
    counter_fsm dut
    (
        .clk(clk),
        .rst_n(rst_n),
        .clr(clr),
        .start(start),
        .en_rd(en_rd),
        .addr_rd(addr_rd),
        .en_pe(en_pe),
        .en_wr(en_wr),
        .addr_wr(addr_wr)
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
