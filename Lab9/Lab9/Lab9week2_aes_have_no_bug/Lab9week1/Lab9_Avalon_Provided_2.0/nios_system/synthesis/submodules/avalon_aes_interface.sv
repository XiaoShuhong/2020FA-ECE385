/************************************************************************
Avalon-MM Interface for AES Decryption IP Core

Dong Kai Wang, Fall 2017

For use with ECE 385 Experiment 9
University of Illinois ECE Department

Register Map:

 0-3 : 4x 32bit AES Key
 4-7 : 4x 32bit AES Encrypted Message
 8-11: 4x 32bit AES Decrypted Message
   12: Not Used
	13: Not Used
   14: 32bit Start Register
   15: 32bit Done Register

************************************************************************/

module avalon_aes_interface (
	// Avalon Clock Input
	input logic CLK,
	
	// Avalon Reset Input
	input logic RESET,
	
	// Avalon-MM Slave Signals
	input  logic AVL_READ,					// Avalon-MM Read
	input  logic AVL_WRITE,					// Avalon-MM Write
	input  logic AVL_CS,						// Avalon-MM Chip Select
	input  logic [3:0] AVL_BYTE_EN,		// Avalon-MM Byte Enable
	input  logic [3:0] AVL_ADDR,			// Avalon-MM Address
	input  logic [31:0] AVL_WRITEDATA,	// Avalon-MM Write Data
	output logic [31:0] AVL_READDATA,	// Avalon-MM Read Data
	
	// Exported Conduit
	output logic [31:0] EXPORT_DATA		// Exported Conduit Signal to LEDs
);


logic [31:0] rigister_file[16],de_msg[4],done;







always_ff @ (posedge CLK) begin

if(RESET) 
	for(int i=0;i<16;i++)
		rigister_file[i]<=32'b0;

else if (AVL_WRITE & AVL_CS) begin
	if(AVL_BYTE_EN[0]==1) 
		rigister_file[AVL_ADDR][7:0]<=AVL_WRITEDATA[7:0];
	if(AVL_BYTE_EN[1]==1) 
		rigister_file[AVL_ADDR][15:8]<=AVL_WRITEDATA[15:8];
	if(AVL_BYTE_EN[2]==1) 
		rigister_file[AVL_ADDR][23:16]<=AVL_WRITEDATA[23:16];
	if(AVL_BYTE_EN[3]==1) 
		rigister_file[AVL_ADDR][31:24]<=AVL_WRITEDATA[31:24];
end
else begin
	rigister_file[11]<=de_msg[0];
	rigister_file[10]<=de_msg[1];
	rigister_file[9]<=de_msg[2];
	rigister_file[8]<=de_msg[3];
	rigister_file[15]<=done;



end


end



always_comb begin

AVL_READDATA=32'b0;
if (AVL_READ & AVL_CS) begin
	AVL_READDATA=rigister_file[AVL_ADDR];


end

EXPORT_DATA={rigister_file[0][31:16],  rigister_file[3][15:0]     };

end	



AES my_aes (
	 .CLK(CLK),
	.RESET(RESET),
	.AES_START(rigister_file[14]),
	.AES_DONE(done),
	.AES_KEY({rigister_file[0],rigister_file[1],rigister_file[2],rigister_file[3]}),
	.AES_MSG_ENC({rigister_file[4],rigister_file[5],rigister_file[6],rigister_file[7]}),
	.AES_MSG_DEC({de_msg[3],de_msg[2],de_msg[1],de_msg[0]})
);

endmodule

















