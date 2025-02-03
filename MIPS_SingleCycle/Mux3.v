module Mux3 (MemtoReg, read_data, ALUResult, WriteData_Reg);

	input MemtoReg;	
	input [31:0] read_data;
	input [31:0] ALUResult;
	output reg [31:0] WriteData_Reg;
	
	always @(*) begin
        if (MemtoReg)
            WriteData_Reg = read_data;
        else
            WriteData_Reg = ALUResult;
    end
endmodule

