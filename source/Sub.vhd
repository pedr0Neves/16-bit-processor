library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Sub is
    Port (
        A : in STD_LOGIC_VECTOR (15 downto 0);
        C : out STD_LOGIC_VECTOR (15 downto 0)
    );
end Sub;

architecture Behavioral of Sub is

begin
    C <= A - 2;

end Behavioral;
