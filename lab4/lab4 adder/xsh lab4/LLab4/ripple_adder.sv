module ripple_adder
(
    input   logic[15:0]     A,
    input   logic[15:0]     B,
    output  logic[15:0]     Sum,
    output  logic           CO
);

    /* TODO
     *
     * Insert code here to implement a ripple adder.
     * Your code should be completly combinational (don't use always_ff or always_latch).
     * Feel free to create sub-modules or other files. */
	  logic c1,c2,c3;
	  four_bits_ripple_adder one( .A(A[3:0]), .B(B[3:0]), .c0(0), .sum(Sum[3:0]), .c4(c1));
	  four_bits_ripple_adder two( .A(A[7:4]), .B(B[7:4]), .c0(c1), .sum(Sum[7:4]), .c4(c2));
	  four_bits_ripple_adder three( .A(A[11:8]), .B(B[11:8]), .c0(c2), .sum(Sum[11:8]), .c4(c3));
	  four_bits_ripple_adder four( .A(A[15:12]), .B(B[15:12]), .c0(c3), .sum(Sum[15:12]), .c4(CO));
	  
		
     
endmodule





module full_adder(input A,B,cin, output logic sum,co);

	always_comb begin
	sum= A^B^cin;						//define single adder here, accept A and B and carry in,
												// calculate sum and carry out as output
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
	full_adder four(.A(A[3]), .B(B[3]), .cin(c3), .sum(sum[3]), .co(c4) );//call single adder assign cin from co of last bit  
	


endmodule



