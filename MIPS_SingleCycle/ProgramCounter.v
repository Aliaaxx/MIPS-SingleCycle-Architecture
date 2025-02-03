module ProgramCounter (
    input clk,
    input reset,
    input [31:0] pc_in, //data
    output reg [31:0] pc_out
);

    always @(posedge clk or posedge reset) begin
        if (reset == 1)begin
            pc_out <= 32'b0;
        end else begin
            pc_out <= pc_in;
        end
    end

endmodule
