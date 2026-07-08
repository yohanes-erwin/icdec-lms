`timescale 1ns / 1ps

module shifter_tb();
    localparam T = 10;
    
    reg [7:0] a;
    reg dir;
    reg [1:0] amt;
    wire [7:0] y;
    
    shifter dut
    (
        .a(a),
        .dir(dir),
        .amt(amt),
        .y(y)
    );
    
    initial
    begin
        dir = 0;
        
        a = 8'b10101100;
        amt = 0;
        #T;
        a = 8'b10101100;
        amt = 1;
        #T;
        a = 8'b10101100;
        amt = 2;
        #T;
        a = 8'b10101100;
        amt = 3;
        #T;
        
        dir = 1;
        
        a = 8'b10101100;
        amt = 0;
        #T;
        a = 8'b10101100;
        amt = 1;
        #T;
        a = 8'b10101100;
        amt = 2;
        #T;
        a = 8'b10101100;
        amt = 3;
        #T;
        
        a = 0;
        amt = 0;
    end
    
endmodule
