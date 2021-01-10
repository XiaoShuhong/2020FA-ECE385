module adder(



input logic[7:0] S,
input logic[7:0] A,
input logic sub,


output logic[8:0] result


);

logic[8:0] ex_S;
logic[8:0] ex_A;
logic c4,c8,c12;
logic[8:0]  ex_S_T;


assign ex_S={S[7],S[7:0]};
assign ex_A={A[7],A[7:0]};




always_comb begin


ex_S_T=ex_S;
if (sub)
	ex_S_T=~ex_S;
	

end
four_bits_ripple_adder   one_sub( .A(ex_A[3:0]), .B(ex_S_T[3:0]),  .c0(sub), .sum(result[3:0]), .c4(c4));
four_bits_ripple_adder   two_sub( .A(ex_A[7:4]), .B(ex_S_T[7:4]),  .c0(c4),  .sum(result[7:4]), .c4(c8));																								
full_adder               the_sub( .A(ex_A[8]),   .B(ex_S_T[8]),    .cin(c8), .sum(result[8])  , .co(c12) );




endmodule









module full_adder(input A,B,cin, output logic sum,co);

	always_comb begin
	sum= A^B^cin;
	co= (A&B) | (B&cin)  | (A&cin);
	end


endmodule




module four_bits_ripple_adder(input [3:0] A,
										input [3:0] B, 
										input     c0, 
										output logic [3:0] sum,
										output logic c4);
	
	logic c1,c2,c3;
	
	full_adder one(.A(A[0]), .B(B[0]), .cin(c0), .sum(sum[0]), .co(c1) );
	full_adder two(.A(A[1]), .B(B[1]), .cin(c1), .sum(sum[1]), .co(c2) );
	full_adder three(.A(A[2]), .B(B[2]), .cin(c2), .sum(sum[2]), .co(c3) );
	full_adder four(.A(A[3]), .B(B[3]), .cin(c3), .sum(sum[3]), .co(c4) );
	


endmodule