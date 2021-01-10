module carry_lookahead_adder
(
    input   logic[15:0]     A,
    input   logic[15:0]     B,
    output  logic[15:0]     Sum,
    output  logic           CO
);
 logic G_0,P_0,C_0,G_1,P_1,C_1,G_2, P_2,C_2,G_3,P_3,C_3;

 four_bits_carry_lookahead_adder one(.X(A[3:0]), .Y(B[3:0]), .Cin(0), .P(P_0), .G(G_0));
 four_bits_carry_lookahead_adder two(.X(A[7:4]), .Y(B[7:4]), .Cin(0), .P(P_1), .G(G_1));
 four_bits_carry_lookahead_adder three(.X(A[11:8]), .Y(B[11:8]), .Cin(0), .P(P_2), .G(G_2));
 four_bits_carry_lookahead_adder four(.X(A[15:12]), .Y(B[15:12]), .Cin(0), .P(P_3), .G(G_3));   // this above four 4-bit adder are used to 
																																//decide P and G parallely
 assign C_0=0;
 assign C_1=G_0;
 assign C_2=G_1|(G_0&P_1);
 assign C_3=G_2|(G_1&P_2)|(G_0&P_1&P_2);   // using P G to 
 
 assign CO=G_3|(P_3&G_2)|(G_1&P_2&P_3)|(G_0&P_1&P_2&P_3);
 four_bits_carry_lookahead_adder five(.X(A[3:0]), .Y(B[3:0]), .Cin(C_0), .S(Sum[3:0]));
 four_bits_carry_lookahead_adder six(.X(A[7:4]), .Y(B[7:4]), .Cin(C_1), .S(Sum[7:4]));
 four_bits_carry_lookahead_adder seven(.X(A[11:8]), .Y(B[11:8]), .Cin(C_2), .S(Sum[11:8]));
 four_bits_carry_lookahead_adder eight(.X(A[15:12]), .Y(B[15:12]), .Cin(C_3), .S(Sum[15:12]));   //use all C generate above to do 16 -bit adder
    /* TODO
     *
     * Insert code here to implement a CLA adder.
     * Your code should be completly combinational (don't use always_ff or always_latch).
     * Feel free to create sub-modules or other files. */
     
endmodule




module single_adder(input x1,y1,cin, output logic s1);

assign s1= x1^y1^cin;
 
endmodule 


module four_bits_carry_lookahead_adder(
 input  logic[3:0] X,
 input  logic[3:0] Y,
 input  logic   Cin,
 output logic[3:0] S,
 output  logic   G,
 output   logic       P,
 output   logic       C
 
);
 logic G0,P0,C0,G1,P1,C1,G2, P2,C2,G3,P3,C3;
 assign P0=X[0]^Y[0];
 assign P1=X[1]^Y[1];
 assign P2=X[2]^Y[2];
 assign P3=X[3]^Y[3];
 assign G0=X[0]&Y[0];
 assign G1=X[1]&Y[1];
 assign G2=X[2]&Y[2];
 assign G3=X[3]&Y[3];				//use input X and Y first decide G and P
 assign C0=Cin;
 assign C1=Cin&P0|G0;
 assign C2=(Cin&P0&P1)|(G0&P1)|G1;
 assign C3=(Cin&P0&P1&P2)|(G0&P1&P2)|(G1&P2)|G2; // represent c0-c3 using only Cin,G and P
 
 assign P=P0&P1&P2&P3;
 assign G=G3|(G2&P3)|(G1&P3&P2)|(G0&P3&P2&P1);
 assign C=P3&C3|G3;

 single_adder one(.x1(X[0]), .y1(Y[0]), .cin(C0), .s1(S[0]));
 single_adder two(.x1(X[1]), .y1(Y[1]), .cin(C1), .s1(S[1]));
 single_adder three(.x1(X[2]), .y1(Y[2]),.cin(C2), .s1(S[2]));
 single_adder four(.x1(X[3]), .y1(Y[3]),.cin(C3), .s1(S[3]));
 
 
endmodule 
 
 