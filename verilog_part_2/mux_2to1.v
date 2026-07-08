module mux_2to1
    #( 
        parameter WIDTH = 8
    )
    (
        input wire [WIDTH-1:0]  a,
        input wire [WIDTH-1:0]  b,
        input wire [0:0]        sel,
        output wire [WIDTH-1:0] y
    );

    assign y = (sel == 1'b0) ? a : b;  

endmodule
