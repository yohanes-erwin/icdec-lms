`timescale 1ns / 1ps

module lut_sigmoid_tb();
    localparam T = 10;
    
    reg en;
    reg [7:0] x;
    wire [15:0] sig;
    
    lut_sigmoid dut
    (
        .en(en),
        .x(x),
        .sig(sig)
    );
    
    initial
    begin
        en = 1;
        
        x = 8'b1_111_1110;
        #T;
        x = 8'b1_111_1111;
        #T;
        x = 8'b0_000_0000;
        #T;
        x = 8'b0_000_0001;
        #T;
        
        x = 0;
    end
    
endmodule
