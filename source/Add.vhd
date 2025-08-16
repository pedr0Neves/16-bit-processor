library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Add is
    Port ( 
        A : in STD_LOGIC_VECTOR (15 downto 0);
        B : in STD_LOGIC_VECTOR (15 downto 0);
        C : out STD_LOGIC_VECTOR (15 downto 0)
    );
end Add;

architecture Behavioral of Add is

begin
    C <= A + B;

end Behavioral;
