module InvAddRoundKey (
	input  logic [127:0] state,
	input logic [127:0] roundkey,
	output logic [127:0] result
);
assign result=state ^ roundkey;

endmodule
