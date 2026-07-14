module gcd
	(
		input wire         clk,
		input wire         rst_n,
		input wire         start,
		input wire [31:0]  a,
		input wire [31:0]  b,
		output wire        ready,
		output wire        done,
		output wire [31:0] r
	);
	
	localparam S_IDLE = 2'h0,
			   S_OP = 2'h1;
	
	reg [1:0] state_reg, state_next;
	reg [31:0] a_reg, a_next;
	reg [31:0] b_reg, b_next;
	reg [4:0] n_reg, n_next;
	reg done_reg, done_next;

	always @(posedge clk)
	begin
		if (!rst_n)
		begin
			state_reg <= S_IDLE;
			a_reg <= 0;
			b_reg <= 0;
			n_reg <= 0;
			done_reg <= 0;
		end
		else
		begin
			state_reg <= state_next;
			a_reg <= a_next;
			b_reg <= b_next;
			n_reg <= n_next;
			done_reg <= done_next;
		end
	end
	
	always @(*)
	begin
		state_next = state_reg;
		a_next = a_reg;
		b_next = b_reg;
		n_next = n_reg;
		done_next = 0;
		case(state_reg)
			S_IDLE:
			begin
				if (start)
				begin
					a_next = a;
					b_next = b;
					n_next = 0;
					state_next = S_OP;
				end
			end
			S_OP:
			begin
				if (a_reg == b_reg)
				begin
					a_next = a_reg << n_reg;
					done_next = 1;
					state_next = S_IDLE;
				end
				else
				begin
					if (!a_reg[0])       // a even
					begin
						a_next = {1'b0, a_reg[31:1]};
						if (!b_reg[0])   // a and b even
						begin
							b_next = {1'b0, b_reg[31:1]};
							n_next = n_reg + 1;
						end
					end
					else                // a odd
					begin
						if (!b_reg[0])  // b even
						begin
							b_next = {1'b0, b_reg[31:1]};
						end
						else            // a and b odd
						begin
							if (a_reg > b_reg)
								a_next = a_reg - b_reg;
							else
								b_next = b_reg - a_reg;
						end
					end
				end
			end
		endcase
	end
 
	assign ready = (state_reg == S_IDLE) ? 1 : 0;
	assign done = done_reg; 
	assign r = a_reg;
	
endmodule
