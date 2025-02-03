module ALUControl(ALUOp, Funct, ALUCntrl);
    input [1:0] ALUOp;  
    input [5:0] Funct; // instruction
    output reg [3:0] ALUCntrl;


always @(*) begin
    case (ALUOp)
        2'b00: ALUCntrl = 4'b0010; 
        2'b01: ALUCntrl = 4'b0110; 
        2'b10: 
            case (Funct)
                6'b100000: ALUCntrl = 4'b0010; // Add
                6'b100010: ALUCntrl = 4'b0110; // Sub
                6'b100100: ALUCntrl = 4'b0000; // And
                6'b100101: ALUCntrl = 4'b0001; // Or
                6'b100111: ALUCntrl = 4'b1100; // nor
                6'b101010: ALUCntrl = 4'b0111; // slt
                default:   ALUCntrl = 4'b0000;// old : 4'b1111; 
            endcase
        default: ALUCntrl = 4'b0000; // old : 4'b1111; 
    endcase
  end
endmodule
/*
module ALUControl_tb;
    reg [1:0] ALUOp;       
    reg [5:0] Funct;
    wire [3:0] ALUCntrl;
    ALUControl uut (
        .ALUOp(ALUOp),
        .Funct(Funct),
        .ALUCntrl(ALUCntrl)
    );

    initial begin
        $display("ALUOp=%b | Funct=%b -> ALUCntrl=%b", ALUOp, Funct, ALUCntl);

        // Test LW/SW (Add operation)
        ALUOp = 2'b00; 
        Funct = 6'bXXXXXX; 
        #10;
        
        // Test branch (Subtract operation)
        ALUOp = 2'b01;
        Funct = 6'bXXXXXX; 
        #10;
        
        // Test R-type ADD
        ALUOp = 2'b10; 
        Funct = 6'b100000; 
        #10;
        
        // Test R-type SUB
        ALUOp = 2'b10; 
        Funct = 6'b100010; 
        #10;
        
        // Test R-type AND
        ALUOp = 2'b10; 
        Funct = 6'b100100; 
        #10;
        
        // Test R-type OR
        ALUOp = 2'b10; 
        Funct = 6'b100101; 
        #10;
        
        // Test R-type SLT
        ALUOp = 2'b10; 
        Funct = 6'b101010; 
        #10;
        
        // Test default case
        ALUOp = 2'b11; 
        Funct = 6'bXXXXXX; 
        #10;
        
        $finish;
    end
endmodule
*/
