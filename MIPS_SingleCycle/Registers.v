module Registers ( 
    // Write -> positive Edge
    input clk, 
    input RegWrite, 
    input [4:0] ReadReg1,          
    input [4:0] ReadReg2, 
    input [4:0] WriteReg, 
    input [31:0] WriteData,        
    output [31:0] ReadData1, 
    output [31:0] ReadData2  
);

    reg [31:0] reg_mem [0:31]; // A memory array representing 32 registers, each 32 bits wide
    integer i;
    // Initialize registers
    initial begin
        for (i = 0; i < 32; i = i + 1) begin
            reg_mem[i] = 32'b0;
        end
    end
    
    // Read -> don't wait for clk
    /*
    always @(*) begin 
        ReadData1 = (ReadReg1 != 5'b0) ? register[ReadReg1] : 32'b0;
        ReadData2 = (ReadReg2 != 5'b0) ? register[ReadReg2] : 32'b0;
    end
     */
    assign ReadData1 = reg_mem[ReadReg1];
    assign ReadData2 = reg_mem[ReadReg2];

    // Write
    always @(posedge clk) begin
        /*if (RegWrite == 1 && WriteReg != 5'b0) begin
            register[WriteReg] = WriteData; // Write data to the specified register
        end*/
        if (RegWrite && WriteReg != 5'b0) begin
          reg_mem[WriteReg] = WriteData;
        end
    end
endmodule


module Registers_tb;
    reg clk;
    reg RegWrite;
    reg [4:0] ReadReg1;
    reg [4:0] ReadReg2;
    reg [4:0] WriteReg;
    reg [31:0] WriteData;
    wire [31:0] ReadData1;
    wire [31:0] ReadData2;

    Registers uut (
        .clk(clk),
        .RegWrite(RegWrite),
        .ReadReg1(ReadReg1),
        .ReadReg2(ReadReg2),
        .WriteReg(WriteReg),
        .WriteData(WriteData),
        .ReadData1(ReadData1),
        .ReadData2(ReadData2)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 10 ns clock period
    end

    initial begin
        RegWrite = 0;
        ReadReg1 = 5'b0;
        ReadReg2 = 5'b0;
        WriteReg = 5'b0;
        WriteData = 32'b0;

        // Test Case 1: Write to register 5 and read it
        #10; 
        WriteReg = 5'b00101; 
        WriteData = 32'hAAAABBBB; 
        RegWrite = 1; 
        #10; 
        RegWrite = 0; 
        ReadReg1 = 5'b00101; // Read register 5
        #5;
        $display("Test Case 1 - ReadData1: %H (Expected: AAAABBBB)", ReadData1);

        // Test Case 2: Write to register 10 and read from two registers
        WriteReg = 5'b01010; 
        WriteData = 32'h12345678; 
        RegWrite = 1; // Enable write
        #10;
        RegWrite = 0; // Disable write
        // Read register 5 and 10 simultaneously
        ReadReg1 = 5'b00101; // Read register 5
        ReadReg2 = 5'b01010; // Read register 10
        #5; 
        $display("Test Case 2 - ReadData1: %h (Expected: AAAABBBB), ReadData2: %h (Expected: 12345678)", ReadData1, ReadData2);
        ReadReg1 = 5'b00000; 
        #5; // Wait for read delay
        $display("Test Case 3 - ReadData1: %h (Expected: 0)", ReadData1);
        #10;
        $stop;
    end
endmodule
