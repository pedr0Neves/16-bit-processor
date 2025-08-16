library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Tb_Registrador is
--  Port ( );
end Tb_Registrador;

architecture Behavioral of Tb_Registrador is
    signal D_signal   : STD_LOGIC_VECTOR (15 downto 0);
    signal clk_signal : STD_LOGIC := '0';
    signal rst_signal : STD_LOGIC;
    signal ld_signal  : STD_LOGIC;
    signal Q_signal   : STD_LOGIC_VECTOR (15 downto 0);
begin
    DUT_Registrador : entity work.Registrador
        Port map (
            D   => D_signal,
            clk => clk_signal,
            rst => rst_signal,
            ld  => ld_signal,
            Q   => Q_signal
        );
        
    Clock_signal:
    process begin
        wait for 1 ns;
        clk_signal <= '1';
        wait for 1 ns;
        clk_signal <= '0';
    end process;
    
    Stimulus:
    process begin
        rst_signal <= '1'; 
        wait for 5 ns;
        D_signal <= x"1420";
        
        rst_signal <= '0'; 
        wait for 5 ns;
        D_signal <= x"1420";
        
        wait for 5 ns;
        ld_signal <= '1';
        wait for 5 ns;
        ld_signal <= '0';
        D_signal <= x"1111";
        wait for 5 ns;
        ld_signal <= '1';
        wait for 5 ns;
    end process;

end Behavioral;
