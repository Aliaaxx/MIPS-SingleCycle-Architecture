library verilog;
use verilog.vl_types.all;
entity MIPS is
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        writedata       : out    vl_logic_vector(31 downto 0);
        dataaddr        : out    vl_logic_vector(31 downto 0);
        memwrite        : out    vl_logic
    );
end MIPS;
