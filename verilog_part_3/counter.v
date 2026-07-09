module counter
    (
        input wire        clk,
        input wire        rst_n,
        input wire        clr,
        input wire        start,
        output wire [3:0] q
    );
    
    reg [3:0] cnt_reg;

    always @(posedge clk)
    begin
        if (!rst_n || clr)
        begin
            cnt_reg <= 0;
        end
        else if (start)
        begin
            cnt_reg <= cnt_reg + 1;
        end
        else if (cnt_reg >= 1 && cnt_reg <= 4)
        begin
            cnt_reg <= cnt_reg + 1;
        end
        else if (cnt_reg >= 5)
        begin
            cnt_reg <= 0;
        end
    end
    
    assign q = cnt_reg;

endmodule
