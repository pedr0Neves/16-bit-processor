library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Add_pc is
    Port ( 
        A : in STD_LOGIC_VECTOR (15 downto 0);
        C : out STD_LOGIC_VECTOR (15 downto 0)
    );
end Add_pc;

architecture Behavioral of Add_pc is

begin
    C <= A + 2;

end Behavioral;
