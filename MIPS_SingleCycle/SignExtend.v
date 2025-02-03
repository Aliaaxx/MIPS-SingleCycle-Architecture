/*
module SignExtend (
    input [15:0] in,           // Immediate value
    output reg [31:0] out      // Extended value (declare as 'reg' because it's assigned in 'always')
);

    always @(in) begin
        //if (in[15] == 1'b1)    // Check MSB for sign
        //    out = {16'b1111111111111111, in};  // Sign-extend for negative
        //else
        //    out = {16'b0000000000000000, in};  // Zero-extend for positive
        out[31:0] <= in[15:0];
    end

endmodule
*/

module SignExtend (
    input [15:0] in,
    output [31:0] out
);
    assign out = {{16{in[15]}}, in};
endmodule

