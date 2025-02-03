library verilog;
use verilog.vl_types.all;
entity Mux2 is
    port(
        ALUSrc          : in     vl_logic;
        ReadData2       : in     vl_logic_vector(31 downto 0);
        Extend32        : in     vl_logic_vector(31 downto 0);
        B               : out    vl_logic_vector(31 downto 0)
    );
end Mux2;
