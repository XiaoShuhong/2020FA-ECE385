module IR_datapath(input logic GATEMARMUX,GATEPC,LD_PC,ADDR1MUX,LD_IR,reset,Clk,unique_reset,
						 input logic[1:0]PCMUX,ADDR2MUX,
						 input logic[15:0]SR1OUT,
						 output logic[15:0]IR_line,
						 output logic [15:0]sum,
						 output logic [15:0]PC_line,
						 
						 input logic[15:0] BUS);
logic [15:0]DR1_result,DR2_result,PC_result;

logic [15:0] IR,PC;
always_ff @(posedge Clk)
	begin
		if(reset && unique_reset)
			begin
			PC<=16'b0000000000000000;
			IR<=16'b0000000000000000;
			end
		if(LD_IR)
			IR<=BUS;
		
		
		if(LD_PC)
			PC<=PC_result;
		
	
	
	end
	
always_comb
	begin
	
		case(ADDR2MUX)
		
			
		2'b00: 
			DR2_result=2'b0000000000000000;
		2'b01:
			DR2_result= { IR[5],IR[5],IR[5],IR[5],IR[5],IR[5],IR[5],IR[5],IR[5],IR[5], IR[5:0] };
		2'b10:
			DR2_result= { IR[8],IR[8],IR[8],IR[8],IR[8],IR[8],IR[8], IR[8:0] };
		2'b11:
			DR2_result= { IR[10],IR[10],IR[10],IR[10],IR[10], IR[10:0] };
		endcase
	
	
		case(ADDR1MUX)
			
				
				1'b0:
					DR1_result=PC;
				1'b1:
					DR1_result=SR1OUT;
		endcase
		sum=DR1_result+DR2_result;
	
		
	
	
		case(PCMUX)
				default:
					PC_result=PC+16'h0001;

			
				2'b00:
					PC_result=PC+16'h0001;
				2'b01:
					PC_result=BUS;
				2'b10:
					PC_result=sum;
				
		endcase	
			

		
	end

assign IR_line=IR;
assign PC_line=PC;

endmodule
