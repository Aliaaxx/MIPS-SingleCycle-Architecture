library verilog;
use verilog.vl_types.all;
entity Add_PC is
    port(
        pc_out          : in     vl_logic_vector(31 downto 0);
        Next_PC         : out    vl_logic_vector(31 downto 0)
    );
end Add_PC;
