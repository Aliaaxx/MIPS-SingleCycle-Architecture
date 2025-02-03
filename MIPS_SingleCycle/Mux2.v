module Mux2 (ALUSrc, ReadData2, Extend32, B);

	input ALUSrc;
	input [31:0] ReadData2;	
	input [31:0] Extend32;
	output reg [31:0] B;
	
	always @(*) begin
        if (ALUSrc)
            B = Extend32;
        else
            B = ReadData2;
    end
endmodule

