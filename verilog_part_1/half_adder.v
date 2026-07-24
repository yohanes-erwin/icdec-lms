module half_adder // Port declaration
    (
        input wire  a,
        input wire  b,
        output wire sum,
        output wire carry    
    );
    
    // Module body
    assign sum = a ^ b; // Continuous assignment
    assign carry = a & b;
    
endmodule
