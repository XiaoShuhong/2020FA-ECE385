/************************************************************************
AES Decryption Core Logic

Dong Kai Wang, Fall 2017

For use with ECE 385 Experiment 9
University of Illinois ECE Department
************************************************************************/

module AES (
	input	 logic CLK,
	input  logic RESET,
	input  logic AES_START,
	output logic AES_DONE,
	input  logic [127:0] AES_KEY,
	input  logic [127:0] AES_MSG_ENC,
	output logic [127:0] AES_MSG_DEC
);

logic [1407:0] keyschedule;
logic [127:0] roundkey;
logic [1:0] state_sel;
logic[1:0] 		in_en;
logic [3:0] roundkey_sel;
logic [3:0] count,op_count;
logic [127:0] state;
logic [127:0] in;
logic [127:0] addroundkey_result, invshiftrow_result,subbyte_result,mixcolumn_result;
logic [127:0] function_result;
assign state=AES_MSG_DEC;
//////////////////////////////////
KeyExpansion mykeyexpansion(
	.clk(CLK),
	.Cipherkey(AES_KEY),
	.KeySchedule(keyschedule)
);

//////////////////////////////////

always_ff @(posedge CLK)begin
AES_MSG_DEC<=AES_MSG_DEC;
case(in_en)
2'b00: AES_MSG_DEC<=AES_MSG_ENC;
2'b01: AES_MSG_DEC<=function_result;
endcase
end


//////////////////////////////////

always_comb
begin
case(roundkey_sel)
4'b1010: roundkey=keyschedule[1407:1280];
4'b1001: roundkey=keyschedule[1279:1152];
4'b1000: roundkey=keyschedule[1151:1024];
4'b0111: roundkey=keyschedule[1023:896];
4'b0110: roundkey=keyschedule[895:768];
4'b0101: roundkey=keyschedule[767:640];
4'b0100: roundkey=keyschedule[639:512];
4'b0011: roundkey=keyschedule[511:384];
4'b0010: roundkey=keyschedule[383:256];
4'b0001: roundkey=keyschedule[255:128];
4'b0000: roundkey=keyschedule[127:0];
default: roundkey=128'b0;
endcase
end

/////////////////////////

InvAddRoundKey myinvaddroundkey(
	.state(state),
	.roundkey(roundkey),
	.result(addroundkey_result)
);

//////////////////////////


InvShiftRows myinvshiftrow(
					.data_in(state), 
					.data_out(invshiftrow_result)
);

//////////////////////////

InvSubBytes sub0( .clk(CLK), .in(state[7:0]), .out(subbyte_result[7:0]) );
InvSubBytes sub1( .clk(CLK), .in(state[15:8]), .out(subbyte_result[15:8]) );
InvSubBytes sub2( .clk(CLK), .in(state[23:16]), .out(subbyte_result[23:16]) );
InvSubBytes sub3( .clk(CLK), .in(state[31:24]), .out(subbyte_result[31:24]) );
InvSubBytes sub4( .clk(CLK), .in(state[39:32]), .out(subbyte_result[39:32]) );
InvSubBytes sub5( .clk(CLK), .in(state[47:40]), .out(subbyte_result[47:40]) );
InvSubBytes sub6( .clk(CLK), .in(state[55:48]), .out(subbyte_result[55:48]) );
InvSubBytes sub7( .clk(CLK), .in(state[63:56]), .out(subbyte_result[63:56]) );
InvSubBytes sub8( .clk(CLK), .in(state[71:64]), .out(subbyte_result[71:64]) );
InvSubBytes sub9( .clk(CLK), .in(state[79:72]), .out(subbyte_result[79:72]) );
InvSubBytes sub10( .clk(CLK), .in(state[87:80]), .out(subbyte_result[87:80]) );
InvSubBytes sub11( .clk(CLK), .in(state[95:88]), .out(subbyte_result[95:88]) );
InvSubBytes sub12( .clk(CLK), .in(state[103:96]), .out(subbyte_result[103:96]) );
InvSubBytes sub13( .clk(CLK), .in(state[111:104]), .out(subbyte_result[111:104]) );
InvSubBytes sub14( .clk(CLK), .in(state[119:112]), .out(subbyte_result[119:112]) );
InvSubBytes sub15( .clk(CLK), .in(state[127:120]), .out(subbyte_result[127:120]) );

/////////////////////////

InvMixColumns mc0( .in(state[31:0]), .out(mixcolumn_result[31:0]) );
InvMixColumns mc1( .in(state[63:32]), .out(mixcolumn_result[63:32]) );
InvMixColumns mc2( .in(state[95:64]), .out(mixcolumn_result[95:64]) );
InvMixColumns mc3( .in(state[127:96]), .out(mixcolumn_result[127:96]) );

/////////////////////////

always_comb begin
case(state_sel)
2'b00:function_result=addroundkey_result;
2'b01:function_result=invshiftrow_result;
2'b10:function_result=subbyte_result;
2'b11:function_result=mixcolumn_result;
endcase
end

/////////////////////////

enum logic[3:0]{WAIT,KEYEXPANSION,ADDROUNDKEY0,INVSHIFTROWS0,INVSUBBYTES0,ADDROUNDKEY1,INVNIXCOLUMNS,INVSHIFTROWS1,INVSUBBYTES1,ADDROUNDKEY2,DONE}State, Next_state;
always_ff @ (posedge CLK)
	begin
		if (RESET) 
			State <= WAIT;
		else 
			State <= Next_state;
	end
always_comb begin
	Next_state = State;
	unique case(State)
		WAIT: begin
			if(AES_START==1)
				Next_state=KEYEXPANSION;
		end
		
		KEYEXPANSION: begin
		if(count==4'b1011)
			Next_state=ADDROUNDKEY0;
		end
		
		ADDROUNDKEY0:begin
			Next_state=INVSHIFTROWS0;
		end
		
		INVSHIFTROWS0:begin
			Next_state=INVSUBBYTES0;
		end
		
		INVSUBBYTES0:begin
			Next_state=ADDROUNDKEY1;
		end
		
		ADDROUNDKEY1:begin
			Next_state=INVNIXCOLUMNS;
		end
		
		INVNIXCOLUMNS:begin
			if(op_count==4'b1001)
				Next_state=INVSHIFTROWS1;
			else
				Next_state=INVSHIFTROWS0;
		end
		
		INVSHIFTROWS1:begin
			Next_state=INVSUBBYTES1;
		end
		
		INVSUBBYTES1:begin
				Next_state=ADDROUNDKEY2;
		end
		
		ADDROUNDKEY2:begin
			Next_state=DONE;
		end
		
		DONE:begin
			if(AES_START==0)
				Next_state=WAIT;
		end
	
	
	endcase
end

always_ff @(posedge CLK) begin
	if(State==KEYEXPANSION)
		count<=count+1;
	else
		count<=4'b0000;
		
	if(State==ADDROUNDKEY1)
		op_count<=op_count+1;
		
	else if(State==KEYEXPANSION)
		op_count<=4'b0000;
	else if(State==ADDROUNDKEY2)
		op_count<=4'b0000;
	else
		op_count<=op_count;
end


always_comb begin
		state_sel=2'b00;
		in_en=2'b00;
		roundkey_sel=4'b0000;
		AES_DONE=1'b0;
		case(State) 
			ADDROUNDKEY0: in_en=2'b01;
			
			INVSHIFTROWS0: begin
				state_sel=2'b01;
				in_en=2'b01;
			end
			
			INVSUBBYTES0:begin
				state_sel=2'b10;
				in_en=2'b01;
			end
			
			ADDROUNDKEY1:begin
				in_en=2'b01;
				roundkey_sel=op_count+1;
			end
			
			INVNIXCOLUMNS: begin
				state_sel=2'b11;
				in_en=2'b01;
			end
			
			INVSHIFTROWS1: begin
				state_sel=2'b01;
				in_en=2'b01;
			end
			
			INVSUBBYTES1:begin
				state_sel=2'b10;
				in_en=2'b01;
			end
			
			ADDROUNDKEY2:begin
				in_en=2'b01;
				roundkey_sel=4'b1010;
			end
			
			DONE: begin
			AES_DONE=1'b1;	
			in_en=2'b10;
			end
	endcase
end

endmodule
















