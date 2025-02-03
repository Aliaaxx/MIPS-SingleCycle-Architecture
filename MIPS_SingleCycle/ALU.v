module ALU (ALUControl, A, B, ALUResult, Zero);
	input [3:0] ALUControl; // Control Bits
	input [31:0] A;
	input signed [31:0] B;
	output reg signed [31:0] ALUResult;
	output reg Zero;
	
  always @(*)
  begin
	case (ALUControl)
		  4'b0000: // AND
			   ALUResult = A & B;
		  4'b0001: // OR
			   ALUResult = A | B;
		  4'b0010: // ADD
			   ALUResult = A + B;
		  4'b0110: // SUB
			   ALUResult = A - B;
		  4'b0111: // SLT
			   ALUResult = (A < B) ? 1 : 0; 
		  4'b1100: // NOR
			   ALUResult = ~(A | B);
				
      default: ALUResult = 32'b0;
    endcase
    Zero = (ALUResult ==  32'b0) ? 1'b1 : 1'b0;
  end
endmodule
/*
module ALU_tb();
    reg [3:0] ALUControl;
    reg [31:0] A, B;
    wire [31:0] ALUResult;
    wire Zero;
    ALU uut (.ALUControl(ALUControl), .A(A), .B(B), .ALUResult(ALUResult), .Zero(Zero));
    initial begin
      // AND
      ALUControl = 4'b0000; A = 32'h0A0A0A0A; B = 32'h00000003;
      #10;
      $display("AND: A=%d, B=%d, Result=%d, Zero=%b", A, B, ALUResult, Zero);

      // OR
      ALUControl = 4'b0001; A = 32'h01010101; B = 32'h01000005;
      #10;
      $display("OR: A=%d, B=%d, Result=%d, Zero=%b", A, B, ALUResult, Zero);

      // ADD
      ALUControl = 4'b0010; A = 32'h00000001; B = 32'h00000004;
      #10;
      $display("ADD: A=%h, B=%h, Result=%h, Zero=%b", A, B, ALUResult, Zero);

      // SUB
      ALUControl = 4'b0110; A = 32'hF0F0F0F0; B = 32'h0F0F0F0F;
      #10;
      $display("SUB: A=%h, B=%h, Result=%h, Zero=%b", A, B, ALUResult, Zero);

      // SLT
      ALUControl = 4'b0111; A = 32'h00000002; B = 32'h00000003;
      #10;
      $display("SLT: A=%d, B=%d, Result=%d, Zero=%b", A, B, ALUResult, Zero);
        
      // NOR 
      ALUControl = 4'b1100; A = 32'hAAAAAAAA; B = 32'h55555555; 
      #10;
      $display("NOR: A = %h, B = %h, ALUResult = %h, Zero = %b", A, B, ALUResult, Zero);
    
    end
endmodule
*/
