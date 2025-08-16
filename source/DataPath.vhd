library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity DataPath is
    Port (
        clk     : in STD_LOGIC;
        rst     : in STD_LOGIC;
        dataOut : in STD_LOGIC_VECTOR(15 downto 0);
        immed   : in STD_LOGIC_VECTOR(15 downto 0);
        RF_sel  : in STD_LOGIC_VECTOR(1 downto 0);
        Rd_wr   : in STD_LOGIC;
        Rd_sel  : in STD_LOGIC_VECTOR(2 downto 0);
        Rm_sel  : in STD_LOGIC_VECTOR(2 downto 0);
        Rn_sel  : in STD_LOGIC_VECTOR(2 downto 0);
        ALU_op  : in STD_LOGIC_VECTOR(3 downto 0);
        flags   : out STD_LOGIC_VECTOR(15 downto 0);
        Rm_out  : out STD_LOGIC_VECTOR(15 downto 0);
        Rn_out  : out STD_LOGIC_VECTOR(15 downto 0)
    );
end DataPath;

architecture Behavioral of DataPath is
    signal Rm : STD_LOGIC_VECTOR(15 downto 0);
    signal Rn : STD_LOGIC_VECTOR(15 downto 0);
    signal Alu_out : STD_LOGIC_VECTOR(15 downto 0);
    signal Mux_out : STD_LOGIC_VECTOR(15 downto 0);
    
begin
    Mux : entity work.Mux4 
        Port map (
            Mux_0   => Rm,
            Mux_1   => dataOut,
            Mux_2   => immed,
            Mux_3   => Alu_out,
            Mux_sel => RF_sel,
            Mux_out => Mux_out
        );
        
    RegisterFile : entity work.RegisterFile
        Port map (
            clk    => clk,
            rst    => rst,
            Rd_wr  => Rd_wr,
            Rd_sel => Rd_sel,
            Rm_sel => Rm_sel,
            Rn_sel => Rn_sel,
            Rd     => Mux_out,
            Rm     => Rm,
            Rn     => Rn
        );
        
    Rn_out <= Rn;
    Rm_out <= Rm;
    
    Alu : entity work.Alu
        Port map (
            Alu_in0 => Rm,
            Alu_in1 => Rn,
            Alu_op  => ALU_op,
            flags   => flags,
            Alu_out => Alu_out
        );

end Behavioral;
