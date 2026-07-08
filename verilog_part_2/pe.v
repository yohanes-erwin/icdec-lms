module pe
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
    
    wire signed [WIDTH*2-1:0] mult;
    wire signed [WIDTH-1:0]   mult_scaled;
    
    assign a_out = a_in;
    assign mult = a_in * b;
	assign mult_scaled = mult[WIDTH+FRAC_BIT-1:FRAC_BIT];
    assign y_out = y_in + mult_scaled;

endmodule
