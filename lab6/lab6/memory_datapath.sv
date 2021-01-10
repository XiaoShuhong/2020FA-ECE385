

module memory_datapath( 
								input logic GateMDR,LD_MDR,MIO_EN,LD_MAR,Clk,
								input logic[15:0] Data_to_CPU,
								output logic[15:0] Data_from_CPU,
								output logic[15:0] MAR_line,
								input logic[15:0] BUS
								);

logic [15:0] MDR,MAR;

always_ff @(posedge Clk)
	begin
	if(LD_MAR)
		MAR<=BUS;
	end
	
always_ff @(posedge Clk)
	begin
	if(LD_MDR & MIO_EN)
		MDR<=Data_to_CPU;
	else if(LD_MDR & ~MIO_EN)
		MDR<=BUS;
	
	end
	
assign  Data_from_CPU=MDR;
assign MAR_line=MAR;
endmodule 