module shifter
    (
        input wire [7:0]  a,
        input wire        dir, // 0: left, 1: right
        input wire [1:0]  amt,
        output wire [7:0] y
    );

    reg [7:0] y_tmp;
    
    // Module body using "always block"
    always @(a or dir or amt) // or
//    always @(*) // Wildcard, produce the same result
    begin
        case ({dir, amt})
            3'b000: y_tmp = {a[6:0], 1'b0};
            3'b001: y_tmp = {a[5:0], 2'b00};
            3'b010: y_tmp = {a[4:0], {3{1'b0}}}; // Replicate bit
            3'b011: y_tmp = {a[3:0], 4'b0000};
            3'b100: y_tmp = {1'b0, a[7:1]};
            3'b101: y_tmp = {2'b00, a[7:2]};
            3'b110: y_tmp = {3'b000, a[7:3]};
            3'b111: y_tmp = {4'b0000, a[7:4]};
            default: y_tmp = 8'h00;
        endcase
    end
    
    // Module body using continuous assignment
    assign y = y_tmp;  

endmodule
