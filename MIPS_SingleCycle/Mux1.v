module Mux1(inst20_16, inst15_11, RegDst, WriteReg);

	input [4:0] inst20_16;
	input [4:0] inst15_11;
	input RegDst;
	
	output reg [4:0] WriteReg;

	always @(*) begin
        if (RegDst)
            WriteReg = inst15_11;
        else
            WriteReg = inst20_16;
    end
endmodule

