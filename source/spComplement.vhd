library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity spComplement is
    Port (
        sp_op          : in STD_LOGIC;
        sp_address     : in STD_LOGIC_VECTOR(15 downto 0);
        new_sp_address : out STD_LOGIC_VECTOR(15 downto 0)
    );
end spComplement;

architecture Behavioral of spComplement is
    signal add_out_signal : STD_LOGIC_VECTOR(15 downto 0);
    signal sub_out_signal : STD_LOGIC_VECTOR(15 downto 0);

begin
    add_sp : entity work.Add_pc
        Port map (
            A => sp_address,
            C => add_out_signal
        );
        
    sub_sp : entity work.Sub
        Port map (
            A => sp_address,
            C => sub_out_signal
        );
        
    mux_sp : entity work.Mux2
        Port map (
            Mux_0   => add_out_signal,
            Mux_1   => sub_out_signal,
            Mux_sel => sp_op,
            Mux_out => new_sp_address
        );
        

end Behavioral;
