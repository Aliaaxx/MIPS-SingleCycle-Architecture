module Add_PC (
	input [31:0] pc_out,
	output [31:0] Next_PC
);

assign Next_PC = pc_out + 4;

endmodule
