library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
-- use IEEE.NUMERIC_STD.ALL;

entity Alu is
    Port (
        Alu_in0 : in STD_LOGIC_VECTOR(15 downto 0); 
        Alu_in1 : in STD_LOGIC_VECTOR(15 downto 0);
        Alu_op  : in STD_LOGIC_VECTOR(3 downto 0);
        flags   : out STD_LOGIC_VECTOR(15 downto 0);
        Alu_out : out STD_LOGIC_VECTOR(15 downto 0)
    );
end Alu;

architecture Behavioral of Alu is
    signal ResultX  : STD_LOGIC_VECTOR(15 downto 0) := x"0000";
    signal flag     : STD_LOGIC_VECTOR(15 downto 0) := x"0000";

begin
    process(Alu_op,Alu_in0,Alu_in1) begin
        case Alu_op is
            when "0000" => -- ADD operation
                ResultX <= unsigned(Alu_in0) + unsigned(Alu_in1);
                
            when "0001" => -- SUB operation
                ResultX <= unsigned(Alu_in0) - unsigned(Alu_in1);
                
            when "0010" => -- AND operation
                ResultX <= Alu_in0 and Alu_in1;
                
            when "0011" => -- OR operation
                ResultX <= Alu_in0 or Alu_in1;
                
            when "0100" => -- NOT operation
                ResultX <= not Alu_in0;
                
            when "0101" => -- XOR operation
                ResultX <= Alu_in0 xor Alu_in1;
                
            when "0110" => -- SLT operation
            when "0111" => -- CMP operation
                ResultX <= unsigned(Alu_in0) - unsigned(Alu_in1);
            
            when "1000" => -- SHR operation
                if (Alu_in1(15) /= '1') then
                    ResultX <= shr(Alu_in0, Alu_in1);
                end if;
                
            when "1001" => -- SHL operation
                if (Alu_in1(15) /= '1') then
                    ResultX <= shl(Alu_in0, Alu_in1);
                end if;
                
            when "1010" => -- ROR operation
                ResultX <= Alu_in0(0) & Alu_in0(15 downto 1);
                
            when "1011" => -- ROL operation
                ResultX <= Alu_in0(14 downto 0) & Alu_in0(15);
                
            when "1100" => -- MUL operation
                ResultX <=  unsigned(Alu_in0(7 downto 0)) * unsigned(Alu_in1(7 downto 0));
                
            when "1101" =>
            when "1110" =>
            when "1111" =>
            when others =>
                ResultX <= x"0000";
                
        end case;
    end process;
    
    -- flag numero negativo
    flag(7) <= '1' when ResultX(15) = '1' else
               '0';
    
    -- flag numero 0
    flag(6) <= '1' when ResultX = x"0000" else
               '0';
    
    -- flag de carry
    flag(0) <= '1' when (Alu_in0 < Alu_in1) else
               '0';
    
    Alu_out <= ResultX;
    flags   <= flag;
    
end Behavioral;