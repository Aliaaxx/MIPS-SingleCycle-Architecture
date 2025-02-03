module Add_ALU (
	input [31:0] Next_PC,
	input [31:0] shiftOut,
	output [31:0] Branch_Address
);
assign Branch_Address = Next_PC + shiftOut;
endmodule
