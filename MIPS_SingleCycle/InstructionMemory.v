module InstructionMemory (address, instruction);
    input [31:0] address;
    output reg [31:0] instruction;

    reg [31:0] mem [0:255];  // Memory array to hold instructions
    integer i;
    initial begin
        $readmemh("test_asm", mem); // Load instructions from "test.asm" in hexadecimal format
        for (i = 0; i < 16; i = i + 1) begin
            $display("mem[%0d] = %h", i, mem[i]);
        end
    end
    
    always @(*) begin
		    instruction <= mem[address[31:2]];
	  end

endmodule

/*
module InstructionMemory_tb;

    reg [31:0] address;
    wire [31:0] instruction;

    // Instantiate the module
    InstructionMemory im (
        .address(address),
        .instruction(instruction)
    );

    initial begin
        // Test different addresses
        address = 32'h00000000; #10;
        $display("Instruction at %h: %h", address, instruction);

        address = 32'h00000004; #10;
        $display("Instruction at %h: %h", address, instruction);

        address = 32'h000003C; #10;
        $display("Instruction at %h: %h", address, instruction);

        // End simulation
        $finish;
    end

endmodule
*/
