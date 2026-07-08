`timescale 1ns / 1ps

module pe_tb();
    localparam T = 10;
    
    localparam WIDTH = 16;
    localparam FRAC_BIT = 8;
    
    reg signed [WIDTH-1:0]  a_in;
    reg signed [WIDTH-1:0]  y_in;
    reg signed [WIDTH-1:0]  b;
    wire signed [WIDTH-1:0] a_out;
    wire signed [WIDTH-1:0] y_out;
    wire signed [WIDTH-1:0] a_out_with_sat;
    wire signed [WIDTH-1:0] y_out_with_sat;
    
    pe
    #(
        .WIDTH(WIDTH),
        .FRAC_BIT(FRAC_BIT)
    )
    dut
    (
        .a_in(a_in),
        .y_in(y_in),
        .b(b),
        .a_out(a_out),
        .y_out(y_out)
    );
    
    pe_with_sat
    #(
        .WIDTH(WIDTH),
        .FRAC_BIT(FRAC_BIT)
    )
    dut_with_sat
    (
        .a_in(a_in),
        .y_in(y_in),
        .b(b),
        .a_out(a_out_with_sat),
        .y_out(y_out_with_sat)
    );
    
    initial
    begin
        a_in = 0; y_in = 0; b = 0;
        #T;
        a_in = 16'b0000_0000_1000_0000; y_in = 16'b0000_0000_1100_0000; b = 16'b0000_0000_1000_0000;
        #T;
        a_in = 16'b0000_0001_1000_0000; y_in = 16'b0000_0011_1100_0000; b = 16'b0000_0100_1000_0000;
        #T;
        a_in = 16'b1111_1111_1000_0000; y_in = 16'b1111_1111_1100_0000; b = 16'b1111_0100_1000_0000;
        #T;
        a_in = 16'b0000_1111_1000_0000; y_in = 16'b1111_0011_1100_0000; b = 16'b0000_1110_1000_0000;
        #T;
        a_in = 16'b0000_1111_1000_0000; y_in = 16'b0111_0011_1100_0000; b = 16'b0000_1110_1000_0000;
        #T;
        a_in = 16'b1111_0100_1000_0000; y_in = 16'b1111_0100_1000_0000; b = 16'b0000_1110_1000_0000;
        #T;
        a_in = 0; y_in = 0; b = 0;
        #T;
    end
    
endmodule
