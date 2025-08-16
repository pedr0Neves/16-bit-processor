library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Mux4 is
    Port ( 
        Mux_0 : in STD_LOGIC_VECTOR (15 downto 0);
        Mux_1 : in STD_LOGIC_VECTOR (15 downto 0);
        Mux_2 : in STD_LOGIC_VECTOR (15 downto 0);
        Mux_3 : in STD_LOGIC_VECTOR (15 downto 0);
        Mux_sel : in STD_LOGIC_VECTOR (1 downto 0);
        Mux_out : out STD_LOGIC_VECTOR (15 downto 0)
    );
end Mux4;

architecture Behavioral of Mux4 is

begin
    Mux_out <= Mux_0 when Mux_sel = "00" else
               Mux_1 when Mux_sel = "01" else
               Mux_2 when Mux_sel = "10" else
               Mux_3;

end Behavioral;
