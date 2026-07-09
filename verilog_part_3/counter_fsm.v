module counter_fsm
    (
        input wire        clk,
        input wire        rst_n,
        input wire        clr,
        input wire        start,
        output wire       done_tick,
        output wire       ready,
        output wire       en_rd,
        output wire [3:0] addr_rd,
        output wire       en_pe,
        output wire       en_wr,
        output wire [3:0] addr_wr
    );
    
    reg [3:0] cnt_fsm_reg;
    reg [3:0] cnt_addr_rd_reg;
    reg [3:0] cnt_addr_wr_reg;
    wire start_cnt_addr_rd;
    wire start_cnt_addr_wr;
    
    // Main counter as FSM
    always @(posedge clk)
    begin
        if (!rst_n || clr)
        begin
            cnt_fsm_reg <= 0;
        end
        else if (start)
        begin
            cnt_fsm_reg <= cnt_fsm_reg + 1;
        end
        else if (cnt_fsm_reg >= 1 && cnt_fsm_reg <= 6)
        begin
            cnt_fsm_reg <= cnt_fsm_reg + 1;
        end
        else if (cnt_fsm_reg >= 7)
        begin
            cnt_fsm_reg <= 0;
        end
    end
    
    // Control to start address read counter
    assign start_cnt_addr_rd = (cnt_fsm_reg == 1) ? 1 : 0;
    // Control to enable read
    assign en_rd = ((cnt_fsm_reg >= 1) & (cnt_fsm_reg <= 4)) ? 1 : 0;
    // Control to enable pe
    assign en_pe = ((cnt_fsm_reg >= 2) & (cnt_fsm_reg <= 5)) ? 1 : 0;
    // Control to start address write counter
    assign start_cnt_addr_wr = (cnt_fsm_reg == 3) ? 1 : 0;
    // Control to enable write
    assign en_wr = ((cnt_fsm_reg >= 3) & (cnt_fsm_reg <= 6)) ? 1 : 0;
    // Status done
    assign done_tick = (cnt_fsm_reg == 7) ? 1 : 0;
    // Status ready
    assign ready = (cnt_fsm_reg == 0) ? 1 : 0;
        
    // Additional counter for address read
    always @(posedge clk)
    begin
        if (!rst_n)
        begin
            cnt_addr_rd_reg <= 0;
        end
        else if (start_cnt_addr_rd)
        begin
            cnt_addr_rd_reg <= cnt_addr_rd_reg + 1;
        end
        else if (cnt_addr_rd_reg >= 1 && cnt_addr_rd_reg <= 2)
        begin
            cnt_addr_rd_reg <= cnt_addr_rd_reg + 1;
        end
        else if (cnt_addr_rd_reg >= 3)
        begin
            cnt_addr_rd_reg <= 0;
        end
    end
    // Address read output
    assign addr_rd = cnt_addr_rd_reg;
        
    // Additional counter for address write
    always @(posedge clk)
    begin
        if (!rst_n)
        begin
            cnt_addr_wr_reg <= 0;
        end
        else if (start_cnt_addr_wr)
        begin
            cnt_addr_wr_reg <= cnt_addr_wr_reg + 1;
        end
        else if (cnt_addr_wr_reg >= 1 && cnt_addr_wr_reg <= 2)
        begin
            cnt_addr_wr_reg <= cnt_addr_wr_reg + 1;
        end
        else if (cnt_addr_wr_reg >= 3)
        begin
            cnt_addr_wr_reg <= 0;
        end
    end
    // Address write output
    assign addr_wr = cnt_addr_wr_reg;
    
endmodule
