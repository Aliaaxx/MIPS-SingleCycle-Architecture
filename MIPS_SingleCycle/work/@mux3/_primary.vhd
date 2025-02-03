library verilog;
use verilog.vl_types.all;
entity Mux3 is
    port(
        MemtoReg        : in     vl_logic;
        read_data       : in     vl_logic_vector(31 downto 0);
        ALUResult       : in     vl_logic_vector(31 downto 0);
        WriteData_Reg   : out    vl_logic_vector(31 downto 0)
    );
end Mux3;
