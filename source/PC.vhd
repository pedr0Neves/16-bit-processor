library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity PC is
    Port (
        Jump_ctl : in STD_LOGIC;
        immed    : in STD_LOGIC_VECTOR(15 downto 0);
        address  : in STD_LOGIC_VECTOR(15 downto 0);
        new_address : out STD_LOGIC_VECTOR(15 downto 0)
    );
end PC;

architecture Behavioral of PC is
    signal immed_ext   : STD_LOGIC_VECTOR(15 downto 0);
    signal Add1_signal : STD_LOGIC_VECTOR(15 downto 0);
    signal Add2_signal : STD_LOGIC_VECTOR(15 downto 0);
    
begin      
    SingExtender : entity work.SignExtender
        Port map (
            A => immed,
            B => immed_ext
        );
          
    Add_PC : entity work.Add_pc
        Port map (
            A => address,
            C => Add1_signal
        );
        
    Add_Jump : entity work.Add
        Port map (
            A => address,
            B => immed_ext,
            C => Add2_signal
        );
        
    MuxJump : entity work.Mux2
        Port map (
            Mux_0   => Add1_signal,
            Mux_1   => Add2_signal,
            Mux_sel => Jump_ctl,
            Mux_out => new_address
        );
        


end Behavioral;
