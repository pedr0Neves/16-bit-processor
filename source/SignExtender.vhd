library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity SignExtender is
    Port ( 
        A : in STD_LOGIC_VECTOR (15 downto 0);   
        B : out STD_LOGIC_VECTOR (15 downto 0)
    );
end SignExtender;

architecture Behavioral of SignExtender is

begin
    B <= "0000000" & A(8 downto 0) when A(8) = '0' else
         "1111111" & A(8 downto 0);

end Behavioral;
