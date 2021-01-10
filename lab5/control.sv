module control(


input logic run,
input logic clearA_loadB,
input logic Clk,
input logic reset,



output logic add,
output logic sub,
output logic shift,
output logic clear_XA,
output logic clr_ld,
output logic reset_out,

output logic[3:0] count
);

assign clr_ld=clearA_loadB;
assign reset_out=reset;



enum logic [2:0] {A, B, C, D, E, F,hold}   curr_state, next_state; 



//logic[3:0] count;
logic[3:0] addition;
logic[3:0] sum;
logic[3:0] sum_out;
four_bits_ripple_adder own_adder( .A(count), .B(addition), .c0(0), .sum(sum));

					





 always_ff @ (posedge Clk)  
 begin
	if (reset || clearA_loadB ) begin
		curr_state <= A;
		count<=0;
		end
   else begin
		curr_state <= next_state;
		count<=sum_out;
		end
	
 end
	
 always_comb begin 
 
			next_state  = curr_state;
         unique case (curr_state) 

            A :    if (run)
                       next_state = B;
            B :    next_state = C;			
            C :   begin  
						 if(count==4'b0110)
								next_state = D;
						 else
							next_state = B;
						 end
				
            D :    next_state = E;
            E :    next_state = hold;
				
				hold:   if (~run)
                       next_state =F;
							  
			   F :	if(run)		
							next_state = A;
        endcase
 
 
 
 case (curr_state) 
	A: begin
	
		add=0;
		sub=0;
		shift=0;
		clear_XA=1;
		addition=0;
		sum_out=sum;
		end
	
		
	B: begin
	
		add=1;
		sub=0;
		shift=0;
		clear_XA=0;
		addition=0;
		sum_out=sum;
		end 
		
	C: begin
	
		add=0;
		sub=0;
		shift=1;
		clear_XA=0;
		addition=1;
		sum_out=sum;
		end 
 
 
 
 
 	D: begin
	
		add=1;
		sub=1;
		shift=0;
		clear_XA=0;
		addition=0;
		sum_out=sum;
		end 
 
 
  	E: begin
	
		add=0;
		sub=0;
		shift=1;
		clear_XA=0;
		addition=0;
		sum_out=sum;
		end 
 
 
 
 	
	F: begin
	
		add=0;
		sub=0;
		shift=0;
		clear_XA=0;
		addition=0;
		sum_out=0;
		end 
		
	hold: begin
	
		add=0;
		sub=0;
		shift=0;
		clear_XA=0;
		addition=0;
		sum_out=sum;
		end	
 endcase
 
 
 
 end
 endmodule