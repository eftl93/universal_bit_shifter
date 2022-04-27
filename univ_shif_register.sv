module univ_shift_register #(	parameter N=8)
								(	input 	logic i_clk,
									input		logic i_nrst,
									input		logic	[1:0]	i_ctrl,
									input		logic	[N-1:0] d,
									output	logic	[N-1:0] q);

//signal declarations
logic [N-1:0]	r_reg, r_next;

//body
always_ff @(posedge i_clk, negedge i_nrst)
begin
	if(!i_nrst)
		r_reg <= N-1'b0;
	else
		r_reg <= r_next;
end

//next state logic
always_comb
	case(i_ctrl)
		2'b00:	r_next = r_reg; 						//no operation
		2'b01:	r_next = {r_reg[N-2:0], d[0]};	//shift left
		2'b10:	r_next = {d[N-1], r_reg[N-1:1]};	//shift right
		default: r_next = d;								//load
	endcase
	
//output logic
assign q = r_reg;

endmodule
