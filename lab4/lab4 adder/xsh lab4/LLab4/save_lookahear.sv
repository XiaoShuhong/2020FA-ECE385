module fk        (input a,b,cin, 
                  output logic s);
						assign s = a^b^cin;
						
endmodule

module four_bit
(
  input logic[3:0] A,
  input logic[3:0] B,
  input logic Cin,
  output logic[3:0] Sum,
  output logic Cout
 );
   logic[3:0] p,g,c;
	assign p[0] = A[0] ^ B[0];
	assign p[1] = A[1] ^ B[1];
	assign p[2] = A[2] ^ B[2];
	assign p[3] = A[3] ^ B[3];
	assign g[0] = A[0] & B[0];
	assign g[1] = A[1] & B[1];
	assign g[2] = A[2] & B[2];
	assign g[3] = A[3] & B[3];
	assign c[0] = Cin;
	assign c[1] = Cin & p[0] | g[0];
	assign c[2] = (Cin & p[0] & p[1]) | (g[0] & p[1]) | g[1];
	assign c[3] = (Cin & p[0] & p[1] & p[2]) | (g[0] & p[1] & p[2]) | (g[1] & p[2]) | g[2];
	assign Cout = p[3] & c[3] | g[3];
	
	fk F0(.a(A[0]),.b(B[0]),.cin(c[0]),.s(Sum[0]));
	fk F1(.a(A[1]),.b(B[1]),.cin(c[1]),.s(Sum[1]));
	fk F2(.a(A[2]),.b(B[2]),.cin(c[2]),.s(Sum[2]));
	fk F3(.a(A[3]),.b(B[3]),.cin(c[3]),.s(Sum[3]));
	
	
endmodule
	
 



module carry_lookahead_adder
(
    input   logic[15:0]     A,
    input   logic[15:0]     B,
    output  logic[15:0]     Sum,
    output  logic      CO
);
   logic [3:0] c;
	
	four_bit F4(.A(A[3:0]), .B(B[3:0]), .Cin(0), .Sum(Sum[3:0]), .Cout(c[1]));
	four_bit F5(.A(A[7:4]), .B(B[7:4]), .Cin(c[1]), .Sum(Sum[7:4]), .Cout(c[2]));
	four_bit F6(.A(A[11:8]), .B(B[11:8]), .Cin(c[2]), .Sum(Sum[11:8]), .Cout(c[3]));
	four_bit F7(.A(A[15:12]), .B(B[15:12]), .Cin(c[3]), .Sum(Sum[15:12]), .Cout(CO));
     
endmodule