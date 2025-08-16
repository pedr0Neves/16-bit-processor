library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Tb_MemoryRam is
--  Port ( );
end Tb_MemoryRam;

architecture Behavioral of Tb_MemoryRam is
    signal clk_signal     : STD_LOGIC;
    signal dataIn_signal  : STD_LOGIC_VECTOR (15 downto 0);
    signal address_signal : STD_LOGIC_VECTOR (15 downto 0);
    signal writeEn_signal : STD_LOGIC := '0';
    signal dataOut_signal : STD_LOGIC_VECTOR (15 downto 0);
    
begin
    DUT_MemoryRam : entity work.MemoryRam
        Port map (
            clk     => clk_signal,
            address => address_signal,
            dataIn  => dataIn_signal,
            writeEn => writeEn_signal,
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
    
        wait for 4 ns;
        
        writeEn_signal <= '1'; 
        dataIn_signal  <= x"0fa1";
        address_signal <= x"0000";
        wait for 2 ns;
        
        writeEn_signal <= '0'; 
        dataIn_signal  <= x"0fa1";
        address_signal <= x"0000";
        wait for 2 ns;
        
        writeEn_signal <= '1'; 
        dataIn_signal  <= x"0010";
        address_signal <= x"0002";
        wait for 2 ns;
        
        writeEn_signal <= '1'; 
        dataIn_signal  <= x"0001";
        address_signal <= x"0006";
        wait for 2 ns;
        
        writeEn_signal <= '0'; 
        dataIn_signal  <= x"0000";
        address_signal <= x"0006";
        wait for 2 ns;
        
        address_signal <= x"0000";
        wait for 2 ns;
        
        address_signal <= x"0002";
        wait for 2 ns;
    end process;


end Behavioral;
