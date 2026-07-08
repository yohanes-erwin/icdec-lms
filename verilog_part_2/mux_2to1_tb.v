`timescale 1ns / 1ps

module mux_2to1_tb();
    localparam T = 10;
    
    reg [7:0] a;
    reg [7:0] b;
    reg [0:0] sel;
    wire [7:0] y;
    
    mux_2to1
    #(
        .WIDTH(8)
    )
    dut
    (
        .a(a),
        .b(b),
        .sel(sel),
        .y(y)
    );
    
    initial
    begin
        a = 8;
        b = 16;
        
        sel = 0;
        #T;
        sel = 1;
        #T;
        
        a = 0;
        b = 0;
    end
    
endmodule
