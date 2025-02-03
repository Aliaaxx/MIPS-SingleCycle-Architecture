library verilog;
use verilog.vl_types.all;
entity Mux1 is
    port(
        inst20_16       : in     vl_logic_vector(4 downto 0);
        inst15_11       : in     vl_logic_vector(4 downto 0);
        RegDst          : in     vl_logic;
        WriteReg        : out    vl_logic_vector(4 downto 0)
    );
end Mux1;
