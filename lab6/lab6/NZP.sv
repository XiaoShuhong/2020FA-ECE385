module NZP(input logic Clk,LD_BEN,LD_CC,
					input logic[15:0] IR,
					input logic [15:0]NZP_value_IN,
					input logic reset, unique_reset,
					output logic NZP_value_OUT);

logic n,z,p,b,N,Z,P;
logic BEN;			
always_comb
begin


if (NZP_value_IN==16'h000) begin
	n=0;
	z=1;
	p=0;

end
	

else if (NZP_value_IN[15]==0) begin 
	n=0;
	z=0;
	p=1;

end

else begin

	n=1;
	z=0;
	p=0;

end


b=(IR[11]&N)|(IR[10]&Z)|(IR[9]&P);
NZP_value_OUT=BEN;
end
	

always_ff@(posedge Clk)
begin


if(reset && unique_reset)
begin
N<=1'b0;
Z<=1'b0;
P<=1'b0;
end

else if (LD_CC)
begin
N<=n;
Z<=z;
P<=p;
end



if(LD_BEN)
BEN<=b;

end	

					
					
					
					
					
					
endmodule
