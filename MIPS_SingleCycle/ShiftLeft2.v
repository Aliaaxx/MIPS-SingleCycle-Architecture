module ShiftLeft2 (
    input [31:0] shiftIn,
    output [31:0] shiftOut
);

    assign shiftOut = shiftIn << 2;

endmodule
