module carry_select_adder
(
    input   logic[15:0]     A,
    input   logic[15:0]     B,
    output  logic[15:0]     Sum,
    output  logic           CO
);

    /* TODO
     *
     * Insert code here to implement a carry select.
     * Your code should be completly combinational (don't use always_ff or always_latch).
     * Feel free to create sub-modules or other files. */
	  
	  logic c1,c2,c3;
     four_bits_ripple_adder zero		( .A(A[3:0]),   .B(B[3:0]),   .c0(0),       .sum(Sum[3:0]), .c4(c1));
	  four_bits_CSA          one 		( .A(A[7:4]),   .B(B[7:4]),   .select(c1),  .c(c2),         .sum(Sum[7:4]));
	  four_bits_CSA          two 		( .A(A[11:8]),  .B(B[11:8]),  .select(c2),  .c(c3),         .sum(Sum[11:8]));
	  four_bits_CSA          three 	( .A(A[15:12]), .B(B[15:12]), .select(c3),  .c(CO),         .sum(Sum[15:12]));
														//select signal from mux accept the carry in from its right adder 
endmodule





module four_bits_CSA(
							input[3:0] A,
							input[3:0] B,
							input select,
							output logic c,
							output logic[3:0] sum
);

logic c_zero;
logic c_one;
logic[3:0] sum_zero;
logic[3:0] sum_one;
							


four_bits_ripple_adder zero( .A(A[3:0]), .B(B[3:0]), .c0(1'b0), .sum(sum_zero), .c4(c_zero));
four_bits_ripple_adder one(  .A(A[3:0]), .B(B[3:0]), .c0(1'b1), .sum(sum_one), .c4(c_one)); //two groups of 4-bit ripple adder are used, one accept carry in 0 and another 1

always_comb begin
case(select)
	1'b0 : begin
			c=c_zero;
			sum=sum_zero;  // construct the mux, select 1, choose four_bits_ripple_adder one above, other wise zero
			end
	default: begin
			c=c_one;
			sum=sum_one;
			end
endcase

end
endmodule







