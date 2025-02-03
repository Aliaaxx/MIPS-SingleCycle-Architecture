module MIPS (
    input clk,             // Clock signal
    input reset,           // Reset signal
    output wire [31:0] writedata,
    output wire [31:0] dataaddr,
    output wire memwrite
);
    wire [31:0] pc_in, pc_out; // pc
    wire [31:0] instr; // im
    wire RegDst, Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite; // control
	  wire [1:0] ALUOp; // control
	  wire [4:0]  WriteReg; // mux1
	  wire [31:0] ReadData1, ReadData2; // registers
	  wire [31:0] Extend32; // sign_ext
	  wire [31:0] B; // mux2
	  wire [3:0] ALUCntrl; // alu_control
	  wire Zero; // alu
	  wire [31:0] ALUResult; // alu
	  wire [31:0] read_data; // data_memory
	  wire [31:0] WriteData_Reg; // mux3
	  wire [31:0] shiftOut; // shift_left
	  wire [31:0] Next_PC; // add_pc
	  wire [31:0] Branch_Address; // add_alu
	  wire AndGateOut; // and_gate
	  
	  // assign writedata = B;   // Write data to memory
    // assign dataaddr = ALUResult;   // Address calculated by ALU
    // assign memwrite = MemWrite;    // Control signal for memory write
    /*always @(posedge clk or posedge reset) begin
        if (reset) begin
            writedata = 0;
            dataaddr = 0;
            memwrite = 0;
        end else begin
            writedata = ReadData2;           // Write data to memory
            dataaddr = ALUResult;    // Address calculated by ALU
            memwrite = MemWrite;     // Control signal for memory write
        end
    end*/
    
    
            
    // Instantiate PC (Program Counter)
    ProgramCounter pc (
        .clk(clk),
        .reset(reset),
        .pc_in(pc_in),
        .pc_out(pc_out)
    );
    
    // Instantiate Instruction Memory
    InstructionMemory im (
        .address(pc_out),
        .instruction(instr)
    );
    
    // Control Unit
    Control control (
        .OpCode(instr[31:26]),
        .RegDst(RegDst),
        .Branch(Branch),
        .MemRead(MemRead),
        .MemtoReg(MemtoReg),
        .ALUOp(ALUOp),
        .MemWrite(MemWrite),
        .ALUSrc(ALUSrc),
        .RegWrite(RegWrite)
    );
    
	  Mux1 mux1(
		   //inputs
		   .inst20_16(instr[20:16]),
		   .inst15_11(instr[15:11]),
		   .RegDst(RegDst),
		   //outputs
		   .WriteReg(WriteReg)	
	  );
    
    // Register File
    Registers registers (
        .clk(clk),
        .RegWrite(RegWrite),
        .ReadReg1(instr[25:21]),
        .ReadReg2(instr[20:16]),
        .WriteReg(WriteReg),
        .WriteData(WriteData_Reg), // output of memory mux
        .ReadData1(ReadData1),
        .ReadData2(ReadData2)
    );
    
    // Sign Extend
	  SignExtend sign_ext(
		    .in(instr[15:0]),
		    .out(Extend32)
	  );
	  
	  Mux2 mux2(
		    //inputs
		    .ALUSrc(ALUSrc),
		    .ReadData2(ReadData2),
		    .Extend32(Extend32),
		    //outputs
		    .B(B)	
	  );
	  
	  // ALU Control
    ALUControl alu_control (
        .ALUOp(ALUOp),
        .Funct(instr[5:0]),
        .ALUCntrl(ALUCntrl) // output
    );
    
    // ALU
    ALU alu (
        .A(ReadData1),
        .B(B),
        .ALUControl(ALUCntrl),
        .Zero(Zero),
        .ALUResult(ALUResult)
    );


    // Data Memory
    DataMemory data_memory (
        .clk(clk),
        .mem_write(MemWrite),
        .addr(ALUResult),
        .write_data(ReadData2),
        .mem_read(MemRead),
        .read_data(read_data)
    );
    
	  Mux3 mux3(
		    //inputs
		    .MemtoReg(MemtoReg),
		    .read_data(read_data),
		    .ALUResult(ALUResult),
		    //outputs
		    .WriteData_Reg(WriteData_Reg)	
	  );
	  
	  // Shift Left by 2
    ShiftLeft2 shift_left (
        .shiftIn(Extend32),
        .shiftOut(shiftOut)
    );
    
    Add_PC add_pc (
      .pc_out(pc_out),
      .Next_PC(Next_PC)
    );
    
    Add_ALU add_alu(
      .Next_PC(Next_PC),
      .shiftOut(shiftOut),
      .Branch_Address(Branch_Address)
    );
    
    AndGate and_gate(
      .Branch(Branch),
      .Zero(Zero),
      .AndGateOut(AndGateOut)
    );
	  
	  Mux4 mux4(
		    //inputs
		    .Branch_Address(Branch_Address),
		    .Next_PC(Next_PC),
		    .AndGateOut(AndGateOut),
		    //outputs
		    .pc_in(pc_in)
	  );
	  assign writedata = $signed(ReadData2);           // Write data to memory
    assign dataaddr = $signed(ALUResult);    // Address calculated by ALU
    assign memwrite = MemWrite;  
	  
endmodule


module testbench();
reg clk;
reg reset;
wire [31:0] writedata;
wire [31:0] dataaddr;
wire memwrite;
// instantiate device to be tested
MIPS dut(clk, reset, writedata, dataaddr, memwrite);
// initialize test
initial begin
  reset <= 1; #22;
  reset <= 0;
  $display("\t\t time \tdataaddr\t\twritedata");
  $monitor("%d\t%d\t%d", $time, $signed(dataaddr), $signed(writedata));
end
// generate clock to sequence tests
always begin
  clk <= 1; #5;
  clk <= 0; #5;
end
// If successful, it should write the value -5 to address 84

always @(negedge clk) begin
  if(memwrite) begin
    if(dataaddr === 84 & writedata === -5) begin
      $display("Simulation succeeded");
      $stop;
    end
  end
end
endmodule

/*
module testbench();
    reg clk;
    reg reset;
    wire [31:0] writedata;
    wire [31:0] dataaddr;
    wire memwrite;
    
    // Instantiate the MIPS module
    MIPS dut (
        .clk(clk),
        .reset(reset),
        .writedata(writedata),
        .dataaddr(dataaddr),
        .memwrite(memwrite)
    );

    // Clock generation
    always begin
        clk = 1; #5;
        clk = 0; #5;
    end

    // Initialize and drive test inputs
    initial begin
        reset = 1; #22;
        reset = 0; 
        #500; // Allow sufficient time for simulation
        $display("Simulation timed out");
        $stop;
    end

    // Monitor outputs and internal signals
    initial begin
        $display("\t\tTime\tDataAddr\tWriteData");
        $monitor("%d\t%d\t%d", $time, $signed(dataaddr), $signed(writedata));
    end

    // Verify simulation success
    always @(posedge clk) begin
        if (memwrite) begin
            if (dataaddr === 84 && writedata === -5) begin
                $display("Simulation succeeded at time %d: Wrote %d to address %d", $time, writedata, dataaddr);
                $stop;
            end else begin
            $display("wrong time %d: Wrote %d to address %d", $time, writedata, dataaddr);      
            end
        end
    end
endmodule

*/