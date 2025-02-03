library verilog;
use verilog.vl_types.all;
entity Mux4 is
    port(
        Branch_Address  : in     vl_logic_vector(31 downto 0);
        Next_PC         : in     vl_logic_vector(31 downto 0);
        AndGateOut      : in     vl_logic;
        pc_in           : out    vl_logic_vector(31 downto 0)
    );
end Mux4;
