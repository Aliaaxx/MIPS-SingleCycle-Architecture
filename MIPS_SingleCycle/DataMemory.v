/*
module DataMemoryy( 
    input wire clk,
    input wire write_enable,
    input wire [31:0] address,
    input wire [31:0] write_data,
    output reg [31:0] read_data
);
    parameter MEM_SIZE = 256;  // Declare parameter here

    reg [31:0] memory [0:MEM_SIZE-1];

    always @(posedge clk) begin
        if (write_enable) begin
            memory[address] <= write_data;  // Write data to memory
        end
    end

    always @(*) begin
        if (!write_enable) begin
            read_data = memory[address];  // Read data from memory when write_enable is low
        end
    end
endmodule
*/

/*   
module DataMemoryy_tb;
    reg clk;
    reg write_enable;
    reg [31:0] address;
    reg [31:0] write_data;
    wire [31:0] read_data;

    // Instantiate DataMemory with parameter MEM_SIZE=256
    DataMemory #(.MEM_SIZE(256)) uut (  // Use parameter override here
        .clk(clk),
        .write_enable(write_enable),
        .address(address),
        .write_data(write_data),
        .read_data(read_data)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk; 
    end

    initial begin
        write_enable = 1; 
        address = 32'h00000000; 
        write_data = 32'hDEADBEEF; 
        #20; 
        write_enable = 0; #10;

        write_enable = 1; 
        address = 32'h00000001;  
        write_data = 32'hCAFEBABE; 
        #20; 
        write_enable = 0; #10; 

        write_enable = 1; 
        address = 32'h000000FF; 
        write_data = 32'h12345678; 
        #20; 
        write_enable = 0; #10;  
        $finish;
    end
endmodule
*/

module DataMemory (clk, mem_write, mem_read, addr, write_data, read_data); 
    input clk;               // Clock signal
    input mem_write;         // Control signal: 1 for write, 0 for no write
    input mem_read;          // Control signal: 1 for read, 0 for no read
    input [31:0] addr;       // Memory address (from ALU result)
    input [31:0] write_data; // Data to write into memory (from register file)
    output reg [31:0] read_data;   // Data read from memory

    // Declare memory array
    reg [31:0] memory [0:1023]; // 256 words, each 32 bits wide
    //integer i;
    initial begin
        /*
        // Initialize all memory locations to zero
        for (i = 0; i < 256; i = i + 1) begin
            memory[i] = 32'h00000000;
        end
        */
        //$display("Data Memory Initialized:");
        //for (i = 0; i < 25; i = i + 1) begin
        //    $display("memory[%0d] = %h", i, memory[i]);
        //end
    
          memory[80] = 32'h00000005; // Value for `lw $2, 80($0)`
          memory[84] = 32'h00000000; // Placeholder for `sw $2, 84($0)`

        end
    // Memory write operation
    always @(posedge clk) begin
        if (mem_write) begin
            memory[addr[11:2]] <= write_data; // Word-aligned write
           // $display("WRITE: Addr=%0d, Data=%d", addr, write_data);
        end
    end

    // Memory read operation
     always @(*) begin
        //if (mem_read) begin
            read_data = memory[addr[11:2]]; // Word-aligned read
            //$display("READ: Addr=%0d, Data=%d", addr, memory[addr[31:2]]);
        //end else begin
          //  read_data <= 32'b0; // Default value when read is disabled
        //end
    end
endmodule

/*
module DataMemory_tb;

    // Testbench signals
    reg clk;
    reg mem_write;
    reg mem_read;
    reg [31:0] addr;
    reg [31:0] write_data;
    wire [31:0] read_data;

    // Instantiate DataMemory module
    DataMemory uut (
        .clk(clk),
        .mem_write(mem_write),
        .mem_read(mem_read),
        .addr(addr),
        .write_data(write_data),
        .read_data(read_data)
    );

    // Generate clock signal
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // Clock period of 10 units
    end

    // Test sequence
    initial begin
        // Initialize signals
        mem_write = 0;
        mem_read = 0;
        addr = 0;
        write_data = 0;

        // Write data to address 0x00000010
        #10;
        addr = 32'h00000010;
        write_data = 32'hDEADBEEF;
        mem_write = 1;
        #10;
        mem_write = 0; // Disable write

        // Write data to address 0x00000020
        #10;
        addr = 32'h00000020;
        write_data = 32'hCAFEBABE;
        mem_write = 1;
        #10;
        mem_write = 0; // Disable write

        // Read data from address 0x00000010
        #10;
        addr = 32'h00000010;
        mem_read = 1;
        #10;
        mem_read = 0; // Disable read

        // Read data from address 0x00000020
        #10;
        addr = 32'h00000020;
        mem_read = 1;
        #10;
        mem_read = 0; // Disable read

        // End simulation
        #20;
        $stop;
    end
endmodule

*/
