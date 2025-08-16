library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity RegisterFile is
    Port (
        clk    : in STD_LOGIC;
        rst    : in STD_LOGIC;
        Rd_wr  : in STD_LOGIC;
        Rd_sel : in STD_LOGIC_VECTOR(2 downto 0);
        Rm_sel : in STD_LOGIC_VECTOR(2 downto 0);
        Rn_sel : in STD_LOGIC_VECTOR(2 downto 0);
        Rd     : in STD_LOGIC_VECTOR(15 downto 0);
        Rm     : out STD_LOGIC_VECTOR(15 downto 0);
        Rn     : out STD_LOGIC_VECTOR(15 downto 0)
    );
end RegisterFile;

architecture Behavioral of RegisterFile is
    type RegFile is array(0 to 7) of STD_LOGIC_VECTOR(15 downto 0);
    signal Reg    : RegFile;
    signal RegCtr : STD_LOGIC_VECTOR(7 downto 0);

begin
    g1 : for i in 0 to 7 generate
        RegCtr(i) <= '1' when Rd_wr = '1' and Rd_sel = i else '0';
        
        Rp : entity work.Registrador(Behavioral)
            port map (
                D   => Rd,
                clk => clk,
                rst => rst,
                ld  => RegCtr(i),
                Q   => Reg(i)
            );
        
    end generate;
    
    Rm <= Reg(conv_integer(unsigned(Rm_sel)));
    Rn <= Reg(conv_integer(unsigned(Rn_sel)));
    
end Behavioral;
