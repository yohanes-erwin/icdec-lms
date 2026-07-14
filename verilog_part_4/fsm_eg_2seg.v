module fsm_eg_2seg
    (
        input wire       clk,
        input wire       rst_n,
        input wire       a,
        input wire       b,
        output reg [7:0] x,
        output reg [7:0] y
    );
    
    // Symbolic state declaration
    localparam [1:0] S0 = 2'b00,
                     S1 = 2'b01,
                     S2 = 2'b10;
    
    // Signal declaration
    reg [1:0] state_reg, state_next;

    // State register
    always @(posedge clk)
    begin
        if (!rst_n)
            state_reg <= S0;
        else
            state_reg <= state_next;
    end
    
    // Next state logic
    always @(*)
    begin
        state_next = state_reg;
        x = 8'd0;
        y = 8'd0;
        case (state_reg)
            S0:
            begin
                if (a == 1'b1)
                    if (b == 1'b1)
                    begin
                        x = 8'd168;
                        state_next = S2;
                    end
                    else
                        state_next = S1;
                else
                    state_next = S0;
            end
            S1:
            begin
                y = 8'd168;
                if (a == 1'b1)
                    state_next = S0;
                else
                    state_next = S1;
            end
            S2:
            begin
                if (a && b)
                    x = 8'd168;
                state_next = S0;
            end
        endcase
    end
    
endmodule
