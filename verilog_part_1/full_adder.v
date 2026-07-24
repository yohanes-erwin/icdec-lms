module full_adder
    (
        input wire  a,
        input wire  b,
        input wire  c,
        output wire sum,
        output wire carry 
    );
    
    // Signal declaration
    wire sum_0, carry_0, carry_1;
    
    // Module body
    half_adder half_adder_0 // Module instantiation
    (
        .a(a),
        .b(b),
        .sum(sum_0),
        .carry(carry_0)
    );
    half_adder half_adder_1
    (
        .a(sum_0),
        .b(c),
        .sum(sum),
        .carry(carry_1)
    );
    assign carry = carry_0 | carry_1; // Continuous assignment

endmodule
