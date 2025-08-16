library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Tb_MemoryRom is
end Tb_MemoryRom;

architecture Behavioral of Tb_MemoryRom is
    signal clk_signal     : STD_LOGIC;
    signal address_signal : STD_LOGIC_VECTOR (15 downto 0);
    signal En_signal      : STD_LOGIC := '0';
    signal dataOut_signal : STD_LOGIC_VECTOR (15 downto 0);
    
begin
    DUT_MemoryRom : entity work.MemoryRom
        Port map (
            address => address_signal,
            En      => En_signal,
            clk     => clk_signal,
            dataOut => dataOut_signal
        );
    
    Clock_signal:
    process begin
        clk_signal <= '1';
        wait for 1 ns;
        clk_signal <= '0';
        wait for 1 ns;
    end process;
    
    Stimulus:
    process begin
        
        address_signal <= x"0000";
        wait for 2 ns;
        
        En_signal <= '1';
        wait for 2 ns;
        
        address_signal <= x"0002";
        wait for 2 ns;
        
        En_signal <= '0';
        wait for 2 ns;
        
        En_signal <= '1';
        address_signal <= x"0004";
        wait for 2 ns;
        
        En_signal <= '0';
        wait for 2 ns;
        
        En_signal <= '1';
        address_signal <= x"0006";
        wait for 2 ns;
        
        En_signal <= '0';
        wait for 2 ns;
        
        En_signal <= '1';
        address_signal <= x"0008";
        wait for 2 ns;
        
        En_signal <= '0';
        wait for 2 ns;
        
        En_signal <= '1';
        address_signal <= x"0010";
        wait for 2 ns;
    end process;

end Behavioral;
