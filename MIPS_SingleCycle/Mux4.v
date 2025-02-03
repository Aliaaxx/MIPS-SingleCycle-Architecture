module Mux4 (Branch_Address, Next_PC, AndGateOut, pc_in);

	input [31:0] Branch_Address;
	input [31:0] Next_PC;
	input AndGateOut;	
	output reg [31:0] pc_in;
	
	always @(*) begin
        if (AndGateOut)
            pc_in = Branch_Address;
        else
            pc_in = Next_PC;
    end
endmodule

