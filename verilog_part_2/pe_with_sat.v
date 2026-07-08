module pe_with_sat
    #( 
        parameter WIDTH = 16,
        parameter FRAC_BIT = 10
    )
    (
        input wire signed [WIDTH-1:0]  a_in,
        input wire signed [WIDTH-1:0]  y_in,
        input wire signed [WIDTH-1:0]  b,
        output wire signed [WIDTH-1:0] a_out,
        output wire signed [WIDTH-1:0] y_out
    );

    localparam signed [WIDTH-1:0]   MAX_VAL  = {1'b0, {WIDTH-1{1'b1}}};
    localparam signed [WIDTH-1:0]   MIN_VAL  = {1'b1, {WIDTH-1{1'b0}}};
    localparam signed [WIDTH*2-1:0] MAX_MULT = {{WIDTH-FRAC_BIT{1'b0}}, MAX_VAL, {FRAC_BIT{1'b0}}};
    localparam signed [WIDTH*2-1:0] MIN_MULT = {{WIDTH-FRAC_BIT{1'b1}}, MIN_VAL, {FRAC_BIT{1'b0}}};
    localparam signed [WIDTH:0]     MAX_ADD  = {1'b0, MAX_VAL};
    localparam signed [WIDTH:0]     MIN_ADD  = {1'b1, MIN_VAL};
  
    wire signed [WIDTH*2-1:0] mult_result;
    wire signed [WIDTH-1:0]   mult_scaled;  
    wire signed [WIDTH:0]     add_result;
    wire signed [WIDTH-1:0]   add_scaled;
    
    // Multiplication    
    assign mult_result = a_in * b;
    // Multiplication saturated and scaled
    assign mult_scaled = (mult_result > MAX_MULT) ? MAX_VAL :
                         (mult_result < MIN_MULT) ? MIN_VAL : mult_result[WIDTH+FRAC_BIT-1:FRAC_BIT];
    
    // Addition
    assign add_result = y_in + mult_scaled;
    // Addition saturated and scaled
    assign add_scaled = (add_result > MAX_ADD) ? MAX_VAL :
                        (add_result < MIN_ADD) ? MIN_VAL : add_result[WIDTH-1:0];
    
    // Bypass    
    assign a_out = a_in;
    // Output
    assign y_out = add_scaled;
    
endmodule
