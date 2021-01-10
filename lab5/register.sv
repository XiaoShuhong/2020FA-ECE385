module register ( input  logic Clk, Reset_all ,clear_XA, Load_B, Load_XA,Shift_En,
							input  logic   x,
							input  logic[7:0]   A,
							input  logic[7:0]   B,
							
							
							
							output logic M,
							output logic [16:0]  Data_Out
				  
);

    always_ff @ (posedge Clk)
    begin
	 	 if (Reset_all) 
			  Data_Out <= 17'b00000000000000000;
			  
		 else if (Load_B) begin
			  Data_Out[7:0] <=B ;
			  Data_Out[15:8]<=8'b00000000;
			  end
		 else if (clear_XA) 
			  Data_Out[16:8] <= 9'b000000000;
		 
			  
		
			  

			  
			  
			  
		 else if (Shift_En)
		 begin
			  
			  Data_Out <= { x, Data_Out[16:1] }; 
	    end
		 
		 else if (Load_XA)
			  Data_Out[16:8] <= {x,A};
			  	 
		 
		 
    end
	
    assign M = Data_Out[0];

endmodule
