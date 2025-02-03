module Control(
    input [5:0] OpCode,
    output reg RegDst,
    output reg Branch,
    output reg MemRead,
    output reg MemtoReg,
    output reg [1:0] ALUOp, // ALU Contol
    output reg MemWrite,
    output reg ALUSrc,
    output reg RegWrite
    );

always @(*) begin
    RegDst = 0;
    Branch = 0;
    MemRead = 0;
    MemtoReg = 0;
    ALUOp = 2'b00;
    MemWrite = 0;
    ALUSrc = 0;
    RegWrite = 0;
    case (OpCode)
        6'b000000: // R-type
          begin 
              RegDst = 1;
              RegWrite = 1;
              ALUOp = 2'b10;
          end
          
        6'b100011: // lw 
          begin 
              ALUSrc = 1;
              MemtoReg = 1;
              RegWrite = 1;
              MemRead = 1;
              ALUOp = 2'b00;
          end
          
        6'b101011: // sw 
          begin  
              ALUSrc = 1;
              MemWrite = 1;
              ALUOp = 2'b00;
          end
        
        6'b000100: // beq 
          begin  
              Branch = 1;
              ALUOp = 2'b01;
          end
          
        6'b001000: // addi
          begin 
              ALUSrc = 1;
              RegWrite = 1;
              ALUOp = 2'b00;
          end
        
          /*
          6'b001100: // andi 
          begin  
              ALUSrc = 1;
              RegWrite = 1;
              ALUOp = 2'b11;
          end
          */
        default: begin
        end
    endcase
end
endmodule

/*
module Control_tb;
    reg [5:0] OpCode;
    wire RegDst, Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite;
    wire [1:0] ALUOp;
    Control uut (
        .OpCode(OpCode),
        .RegDst(RegDst),
        .Branch(Branch),
        .MemRead(MemRead),
        .MemtoReg(MemtoReg),
        .ALUOp(ALUOp),
        .MemWrite(MemWrite),
        .ALUSrc(ALUSrc),
        .RegWrite(RegWrite)
    );
    
    initial begin
        $monitor("OpCode=%b | RegDst=%b | Branch=%b | MemRead=%b | MemtoReg=%b | ALUOp=%b | MemWrite=%b | ALUSrc=%b | RegWrite=%b", OpCode, RegDst, Branch, MemRead, MemtoReg, ALUOp, MemWrite, ALUSrc, RegWrite);
     
        OpCode = 6'b000000; 
        #10;        
     
        OpCode = 6'b100011; 
        #10;       
       
        OpCode = 6'b101011; 
        #10;        
   
        OpCode = 6'b000100; 
        #10;  
             
        OpCode = 6'b001000; 
        #10;
     
        OpCode = 6'b001100; 
        #10;
        
        OpCode = 6'b111111; 
        #10;
        
        $finish;
    end
endmodule

*/
