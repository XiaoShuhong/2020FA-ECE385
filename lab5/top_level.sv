module top_level(

input logic[7:0] S,
input logic Clk,Reset,Run,ClearA_LoadB,


output logic[6:0] AhexU,AhexL,BhexU,BhexL,
output logic[7:0] Aval,Bval,
output logic X,
output logic add,
output logic sub,
output logic shift
);




//////////////////////////

//control's output
//logic add;
//logic sub;
//ogic shift;
logic clear_XA;
logic clr_ld;
logic reset_out;

/////////////////////////

//register's output


logic m;
logic[16:0]  all_data;

//register's input

logic Load_XA;
logic x;
logic A;
logic B;
/////////////////

//adder's output
logic[8:0] adder_result;



//adder's input
logic [7:0] s_adder;







register my_register ( 
							.Clk(Clk),
							.Reset_all(reset_out) ,
							.clear_XA(clear_XA), 
							.Load_B(clr_ld), 
							.Load_XA(Load_XA),
							.Shift_En(shift),
							.x(adder_result[8]),
							.A(adder_result[7:0]),
							.B(S),
							
							
							
							.M(m),
							.Data_Out(all_data)
				  
);





adder my_adder(



							.S(s_adder),
							.A(all_data[15:8]),
							.sub(sub),


							.result(adder_result)


);





control my_control(


							.run(~Run),
							.clearA_loadB(~ClearA_LoadB),
							.Clk(Clk),
							.reset(~Reset),



							.add(add),
							.sub(sub),
							.shift(shift),
							.clear_XA(clear_XA),
							.clr_ld(clr_ld),
							.reset_out(reset_out)

						
);











HexDriver  one(
						.In0(Aval[3:0]),
                  .Out0(AhexL)
						);






HexDriver two(
						.In0(Aval[7:4]),
                  .Out0(AhexU)
						);
						
HexDriver three(
						.In0(Bval[3:0]),
                  .Out0(BhexL)
						);

HexDriver four(
						.In0(Bval[7:4]),
                  .Out0(BhexU)
						);



















always_comb begin

if(m && add)
	s_adder=S;
else
	s_adder=8'b00000000;
	
Load_XA=1;
Aval=all_data[15:8];
Bval=all_data[7:0];
X=all_data[16];
	
end







endmodule