module Register_ALU(input logic Clk,
						input logic[15:0] value_IN,
						input logic DR,
						input logic SR1,
						input logic LD_REG,
						input logic [2:0]SR2,
						input logic[1:0]ALUK,
						input logic [15:0]IR,
						input logic SR2MUX,
						input logic reset, unique_reset,
						output logic [15:0]value_OUT,
						output logic[15:0]SR1_OUT);

logic [15:0]R0,R1,R2,R3,R4,R5,R6,R7;
logic [4:0]imm5;
assign imm5=IR[4:0];
logic [2:0]SR1_chosen,DR_chosen;
logic[15:0]SR2_OUT;
logic[15:0]A_IN,B_IN;
assign A_IN=SR1_OUT;
always_comb
begin
case(SR1)
1'b1:SR1_chosen=IR[8:6];
1'b0:SR1_chosen=IR[11:9];
endcase

case(DR)
1'b1:DR_chosen=3'b111;
1'b0:DR_chosen=IR[11:9];
endcase

case(SR1_chosen)
3'b000: SR1_OUT=R0;
3'b001: SR1_OUT=R1;
3'b010: SR1_OUT=R2;						
3'b011: SR1_OUT=R3;
3'b100: SR1_OUT=R4;
3'b101: SR1_OUT=R5;						
3'b110: SR1_OUT=R6;			
3'b111: SR1_OUT=R7;
endcase
case(SR2)
3'b000:SR2_OUT=R0;
3'b001: SR2_OUT=R1;
3'b010: SR2_OUT=R2;						
3'b011: SR2_OUT=R3;
3'b100: SR2_OUT=R4;
3'b101: SR2_OUT=R5;						
3'b110: SR2_OUT=R6;			
3'b111: SR2_OUT=R7;
endcase

case(SR2MUX)
1'b0:B_IN=SR2_OUT;
1'b1:B_IN={imm5[4],imm5[4],imm5[4],imm5[4],imm5[4],imm5[4],imm5[4],imm5[4],imm5[4],imm5[4],imm5[4],imm5};
endcase

case(ALUK)
2'b00: value_OUT=A_IN+B_IN;
2'b01: value_OUT=A_IN & B_IN;
2'b10: value_OUT=~A_IN;
2'b11: value_OUT=A_IN;
endcase




end
always_ff@(posedge Clk)
begin

if(reset && unique_reset)
begin	
R0<=16'b0000000000000000;
R1<=16'b0000000000000000;
R2<=16'b0000000000000000;					
R3<=16'b0000000000000000;
R4<=16'b0000000000000000;
R5<=16'b0000000000000000;					
R6<=16'b0000000000000000;			
R7<=16'b0000000000000000;					
end




else if (LD_REG)
begin
case(DR_chosen)
3'b000: R0<=value_IN;
3'b001: R1<=value_IN;
3'b010: R2<=value_IN;						
3'b011: R3<=value_IN;
3'b100: R4<=value_IN;
3'b101: R5<=value_IN;						
3'b110: R6<=value_IN;			
3'b111: R7<=value_IN;
endcase
end
end

						
endmodule
