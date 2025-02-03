module AndGate (
    input Branch,
    input Zero,
    output AndGateOut
);
    assign AndGateOut = Branch & Zero;
endmodule
