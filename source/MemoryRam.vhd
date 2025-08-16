library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity MemoryRam is
    Port ( 
        clk     : in STD_LOGIC;
        writeEn : in STD_LOGIC;
        dataIn  : in STD_LOGIC_VECTOR (15 downto 0);
        address : in STD_LOGIC_VECTOR (15 downto 0);
        WriEnd  : out STD_LOGIC;
        dataOut : out STD_LOGIC_VECTOR (15 downto 0)
    );
end MemoryRam;

architecture Behavioral of MemoryRam is
    type RAM is array(0 to 255) of STD_LOGIC_VECTOR(7 downto 0);
    signal RAM_data : RAM := (
        x"00", x"00",x"00", x"00", x"00", x"00",x"00", x"00", -- 0
        x"00", x"00",x"00", x"00", x"00", x"00",x"00", x"00",
        x"00", x"00",x"00", x"00", x"00", x"00",x"00", x"00",
        x"00", x"00",x"00", x"00", x"00", x"00",x"00", x"00",
        x"00", x"00",x"00", x"00", x"00", x"00",x"00", x"00",
        x"00", x"00",x"00", x"00", x"00", x"00",x"00", x"00",
        x"00", x"00",x"00", x"00", x"00", x"00",x"00", x"00",
        x"00", x"00",x"00", x"00", x"00", x"00",x"00", x"00",
        x"00", x"00",x"00", x"00", x"00", x"00",x"00", x"00",
        x"00", x"00",x"00", x"00", x"00", x"00",x"00", x"00",
        x"00", x"00",x"00", x"00", x"00", x"00",x"00", x"00", -- 10
        x"00", x"00",x"00", x"00", x"00", x"00",x"00", x"00",
        x"00", x"00",x"00", x"00", x"00", x"00",x"00", x"00",
        x"00", x"00",x"00", x"00", x"00", x"00",x"00", x"00",
        x"00", x"00",x"00", x"00", x"00", x"00",x"00", x"00",
        x"00", x"00",x"00", x"00", x"00", x"00",x"00", x"00",
        x"00", x"00",x"00", x"00", x"00", x"00",x"00", x"00",
        x"00", x"00",x"00", x"00", x"00", x"00",x"00", x"00",
        x"00", x"00",x"00", x"00", x"00", x"00",x"00", x"00",
        x"00", x"00",x"00", x"00", x"00", x"00",x"00", x"00",
        x"00", x"00",x"00", x"00", x"00", x"00",x"00", x"00", -- 20
        x"00", x"00",x"00", x"00", x"00", x"00",x"00", x"00",
        x"00", x"00",x"00", x"00", x"00", x"00",x"00", x"00",
        x"00", x"00",x"00", x"00", x"00", x"00",x"00", x"00",
        x"00", x"00",x"00", x"00", x"00", x"00",x"00", x"00",
        x"00", x"00",x"00", x"00", x"00", x"00",x"00", x"00",
        x"00", x"00",x"00", x"00", x"00", x"00",x"00", x"00",
        x"00", x"00",x"00", x"00", x"00", x"00",x"00", x"00",
        x"00", x"00",x"00", x"00", x"00", x"00",x"00", x"00",
        x"00", x"00",x"00", x"00", x"00", x"00",x"00", x"00",
        x"00", x"00",x"00", x"00", x"00", x"00",x"00", x"00", -- 30
        x"00", x"00",x"00", x"00", x"00", x"00",x"00", x"00"
    );
    
begin
    -- addressSig <= '0' & address(15 downto 1);
    
    WriteProcess:
    process(clk,address) begin
        if(rising_edge(clk)) then
            WriEnd <= '0';
            if(writeEn = '1') then
                RAM_data(to_integer(unsigned(address))) <= dataIn(7 downto 0);
                RAM_data(to_integer(unsigned(address + 1))) <= dataIn(15 downto 8);
                WriEnd <= '1';
            end if;
        end if;
    end process;
    
    ReadProcess:
    process(clk, address) begin
        if(rising_edge(clk)) then
            dataOut(7 downto 0) <= RAM_data(to_integer(unsigned(address)));
            dataOut(15 downto 8) <= RAM_data(to_integer(unsigned(address + 1)));
        end if;
    end process;

end Behavioral;
