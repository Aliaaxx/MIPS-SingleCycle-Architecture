library verilog;
use verilog.vl_types.all;
entity AndGate is
    port(
        Branch          : in     vl_logic;
        Zero            : in     vl_logic;
        AndGateOut      : out    vl_logic
    );
end AndGate;
