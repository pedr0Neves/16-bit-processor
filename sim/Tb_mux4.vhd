library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Tb_mux4 is
--  Port ( );
end Tb_mux4;

architecture Behavioral of Tb_mux4 is
    signal Mux_0_signal   : STD_LOGIC_VECTOR (15 downto 0);
    signal Mux_1_signal   : STD_LOGIC_VECTOR (15 downto 0);
    signal Mux_2_signal   : STD_LOGIC_VECTOR (15 downto 0);
    signal Mux_3_signal   : STD_LOGIC_VECTOR (15 downto 0);
    signal Mux_sel_signal : STD_LOGIC_VECTOR (1 downto 0);
    signal Mux_out_signal : STD_LOGIC_VECTOR (15 downto 0);
    
begin
    DUT_Mux4 : entity work.Mux4
        Port map (
            Mux_0   => Mux_0_signal,
            Mux_1   => Mux_1_signal,
            Mux_2   => Mux_2_signal,
            Mux_3   => Mux_3_signal,
            Mux_sel => Mux_sel_signal,
            Mux_out => Mux_out_signal
        );
        
    process begin
        Mux_0_signal <= x"0001";
        Mux_1_signal <= x"0010";
        Mux_2_signal <= x"0100";
        Mux_3_signal <= x"1000";
        
        wait for 5 ns;
        Mux_sel_signal <= "00";
        
        wait for 5 ns;
        Mux_sel_signal <= "01";
        
        wait for 5 ns;
        Mux_sel_signal <= "10";
        
        wait for 5 ns;
        Mux_sel_signal <= "11";
    end process;

end Behavioral;
