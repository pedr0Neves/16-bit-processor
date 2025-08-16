library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Mux2 is
    Port ( 
        Mux_0 : in STD_LOGIC_VECTOR (15 downto 0);
        Mux_1 : in STD_LOGIC_VECTOR (15 downto 0);
        Mux_sel : in STD_LOGIC;
        Mux_out : out STD_LOGIC_VECTOR (15 downto 0)
 );
end Mux2;

architecture Behavioral of Mux2 is

begin
    Mux_out <= Mux_0 when Mux_sel = '0' else
               Mux_1;

end Behavioral;
