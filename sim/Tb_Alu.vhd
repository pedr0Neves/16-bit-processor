library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Tb_Alu is
--  Port ( );
end Tb_Alu;

architecture Behavioral of Tb_Alu is
    signal Alu_in0_signal : STD_LOGIC_VECTOR(15 downto 0);
    signal Alu_in1_signal : STD_LOGIC_VECTOR(15 downto 0);
    signal Alu_op_signal  : STD_LOGIC_VECTOR(3 downto 0);
    signal flags_signal   : STD_LOGIC_VECTOR(15 downto 0);
    signal Alu_out_signal : STD_LOGIC_VECTOR(15 downto 0);
begin
    DUT_Alu : entity work.Alu
        Port map (
            Alu_in0 => Alu_in0_signal,
            Alu_in1 => Alu_in1_signal,
            Alu_op  => Alu_op_signal,
            flags   => flags_signal,
            Alu_out => Alu_out_signal
        );
    
    process begin
        Alu_in0_signal <= x"0005";
        Alu_in1_signal <= x"0002";
        
        Alu_op_signal <= "0000";
        wait for 5 ns;
        
        Alu_op_signal <= "0001";
        wait for 5 ns;
        
        Alu_op_signal <= "0010";
        wait for 5 ns;
        
        Alu_op_signal <= "0011";
        wait for 5 ns;
        
        Alu_op_signal <= "0100";
        wait for 5 ns;
        
        Alu_op_signal <= "0101";
        wait for 5 ns;
        
        Alu_op_signal <= "1100";
        wait for 5 ns;
        
        Alu_in0_signal <= x"F00F";
        
        Alu_op_signal <= "1000";
        wait for 5 ns;
        
        Alu_op_signal <= "1001";
        wait for 5 ns;
        
        Alu_in0_signal <= x"C003";
        
        Alu_op_signal <= "1010";
        wait for 5 ns;
        
        Alu_op_signal <= "1011";
        wait for 5 ns;
        
        Alu_in0_signal <= x"000F";
        Alu_in1_signal <= x"000E";
        
        Alu_op_signal <= "0111";
        wait for 5 ns;
        
        Alu_in0_signal <= x"000E";
        Alu_in1_signal <= x"000E";
        
        Alu_op_signal <= "0111";
        wait for 5 ns;
        
        Alu_in0_signal <= x"FFFF";
        Alu_in1_signal <= x"0001";
        wait for 5 ns;
        
    end process;

end Behavioral;
