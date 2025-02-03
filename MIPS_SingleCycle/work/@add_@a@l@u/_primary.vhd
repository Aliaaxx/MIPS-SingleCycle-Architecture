library verilog;
use verilog.vl_types.all;
entity Add_ALU is
    port(
        Next_PC         : in     vl_logic_vector(31 downto 0);
        shiftOut        : in     vl_logic_vector(31 downto 0);
        Branch_Address  : out    vl_logic_vector(31 downto 0)
    );
end Add_ALU;
