library verilog;
use verilog.vl_types.all;
entity ShiftLeft2 is
    port(
        shiftIn         : in     vl_logic_vector(31 downto 0);
        shiftOut        : out    vl_logic_vector(31 downto 0)
    );
end ShiftLeft2;
