module lut_sigmoid
    (
        input wire         en,
        input wire [7:0]   x,  // Fixed-point: 1 sign, 3 integer, 4 fraction
        output wire [15:0] sig // Fixed-point: 1 sign, 5 integer, 10 fraction
    );
    
    reg [15:0] sig_mem;
    
    // Module body using "always block"
    always @(x)
    begin
        case (x)
            // Add more ...
            8'b1_111_1110: sig_mem = 16'b0_00000_0111100000; // sig(-0.1250) = 0.4687500000
            8'b1_111_1111: sig_mem = 16'b0_00000_0111110000; // sig(-0.0625) = 0.4843750000
            8'b0_000_0000: sig_mem = 16'b0_00000_1000000000; // sig(+0.0000) = 0.5000000000
            8'b0_000_0001: sig_mem = 16'b0_00000_1000001111; // sig(+0.0625) = 0.5146484375
            // Add more ...
            default: sig_mem <= 16'h0000;
        endcase
    end
    
    // Module body using continuous assignment
    assign sig = (en == 1'b1) ? sig_mem : 16'h0000;
    // Module body using module instantiation
//    mux_2to1 #(16) mux_2to1_0(16'h0000, sig_mem, en, sig); // Produce the same result
    
endmodule
