library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Tb_ControlUnit is
--  Port ( );
end Tb_ControlUnit;

architecture Behavioral of Tb_ControlUnit is
    
    -- in signals
    signal clk_signal     : STD_LOGIC;
    signal rst_signal     : STD_LOGIC := '1';
    signal WaitEnd_signal : STD_LOGIC := '0';
    signal dataOut_signal : STD_LOGIC_VECTOR(15 downto 0);
    signal flag_at_signal : STD_LOGIC_VECTOR(15 downto 0);
    
    -- out signals
    signal IO_sel_signal  : STD_LOGIC;
    signal IO_en_signal   : STD_LOGIC;
    signal IO_mode_signal : STD_LOGIC;
    signal Sp_en_signal   : STD_LOGIC;
    signal ROM_en_signal  : STD_LOGIC;
    signal RAM_sel_signal : STD_LOGIC;
    signal RAM_we_signal  : STD_LOGIC;
    signal RF_sel_signal  : STD_LOGIC_VECTOR(1 downto 0);
    signal Rd_wr_signal   : STD_LOGIC;
    signal Rd_sel_signal  : STD_LOGIC_VECTOR(2 downto 0);
    signal Rm_sel_signal  : STD_LOGIC_VECTOR(2 downto 0);
    signal Rn_sel_signal  : STD_LOGIC_VECTOR(2 downto 0);
    signal ALU_op_signal  : STD_LOGIC_VECTOR(3 downto 0);
    signal SP_out_signal  : STD_LOGIC_VECTOR(15 downto 0);
    signal address_signal : STD_LOGIC_VECTOR(15 downto 0);
    signal immed_signal   : STD_LOGIC_VECTOR(15 downto 0);
    
begin
    DUT_ControlUnit : entity work.ControlUnit
        Port map (
            clk     => clk_signal,
            rst     => rst_signal,
            WaitEnd => WaitEnd_signal,
            dataOut => dataOut_signal,
            flag_at => flag_at_signal,
            IO_sel  => IO_sel_signal,
            IO_en   => IO_en_signal,
            IO_mode => IO_mode_signal,
            Sp_en   => Sp_en_signal,
            ROM_en  => ROM_en_signal,
            RAM_sel => RAM_sel_signal,
            RAM_we  => RAM_we_signal,
            RF_sel  => RF_sel_signal,
            Rd_wr   => Rd_wr_signal,
            Rd_sel  => Rd_sel_signal,
            Rm_sel  => Rm_sel_signal,
            Rn_sel  => Rn_sel_signal,
            ALU_op  => ALU_op_signal,
            Sp_out  => SP_out_signal,
            address => address_signal,
            immed   => immed_signal
        );
    
    Clock_signal:
    process begin
        clk_signal <= '1';
        wait for 50 ps;
        clk_signal <= '0';
        wait for 50 ps;
    end process;
    
    Stimulus:
    process begin
        wait for 200 ps;
        rst_signal <= '0';
        flag_at_signal   <= x"0000";
        
        -- in r0		  -> 0xF001
        dataOut_signal <= x"F001";
        wait for 100 ps;
        
        -- mov r1, r0	  -> 0x1100
        dataOut_signal <= x"1100";
        wait for 100 ps;
        
        -- Mov r2, #2     -> 0x1A02
        dataOut_signal <= x"1A02";
        wait for 100 ps;
        
        -- Mov r1, #32    -> 0x1920
        dataOut_signal <= x"1920";
        wait for 100 ps;
        
        -- Mov r2, r1     -> 0x1220
        dataOut_signal <= x"1220";
        wait for 100 ps;
        
        -- Nop            -> 0x0000
        dataOut_signal <= x"0000";
        wait for 100 ps;
        
        -- Str [r2], #20  -> 0x2854
        dataOut_signal <= x"2854";
        wait for 100 ps;
        
        -- Ldr r3 , [r2]  -> 0x3340
        dataOut_signal <= x"3340";
        wait for 100 ps;
        
        -- Str [r2], r1   -> 0x2044
        dataOut_signal <= x"2044";
        wait for 100 ps;
        
        -- Add r4, r3, r2 -> 0x4468
        dataOut_signal <= x"4468";
        wait for 100 ps;
        
        -- Sub r4, r3, r2 -> 0x5C6A
        dataOut_signal <= x"5C6A";
        wait for 100 ps;
        
        -- Mul r4, r3, r2 -> 0x6469
        dataOut_signal <= x"6469";
        wait for 100 ps;
        
        -- And r4, r3, r2 -> 0x7C68
        dataOut_signal <= x"7C68";
        wait for 100 ps;
        
        -- Or r4, r3, r2  -> 0x8468
        dataOut_signal <= x"8468";
        wait for 100 ps;
        
        -- Not r4, r3     -> 0x9C68
        dataOut_signal <= x"9C68";
        wait for 100 ps;
        
        -- Xor r4, r3, r2 -> 0xA468
        dataOut_signal <= x"A468";
        wait for 100 ps;
        
        -- Shr r4, r3, #5 -> 0xB465
        dataOut_signal <= x"B465";
        wait for 100 ps;
        
        -- Shl r4, r3, #5 -> 0xC465
        dataOut_signal <= x"C465";
        wait for 100 ps;
        
        -- Ror r4, r3     -> 0xD460
        dataOut_signal <= x"D460";
        wait for 100 ps;
        
        -- Rol r4, r3     -> 0xE460
        dataOut_signal <= x"E460";
        wait for 100 ps;
        
        -- push r2	       -> 0x0009
        dataOut_signal <= x"0009";
        WaitEnd_signal <= '1';
        wait for 100 ps;
        WaitEnd_signal <= '0';
        wait for 100 ps;
        
        -- push r3	       -> 0x000D
        dataOut_signal <= x"000D";
        WaitEnd_signal <= '1';
        wait for 100 ps;
        WaitEnd_signal <= '0';
        wait for 100 ps;
        
        -- pop r5 	       -> 0x0502
        dataOut_signal <= x"0502";
        wait for 100 ps;
        
        -- pop r6 	       -> 0x0602
        dataOut_signal <= x"0602";
        wait for 100 ps;
        
        -- mov r0, r5     -> 0x10A0
        dataOut_signal <= x"10A0";
        wait for 100 ps;
        
        -- mov r0, r6     -> 0x10C0
        dataOut_signal <= x"10C0";
        wait for 100 ps;
        
        -- mov r1, #10    -> 0x190A
        dataOut_signal <= x"190A";
        wait for 100 ps;
        
        -- mov r2, #11    -> 0x1A0B
        dataOut_signal <= x"1A0B";
        wait for 100 ps;
        
        -- jmp #0002      -> 0x0802
        dataOut_signal <= x"0808";
        wait for 100 ps;
        
        -- nop            -> 0x0000
        dataOut_signal <= x"0000";
        wait for 100 ps;
        
        -- cmp r2, r1     -> 0x0047
        dataOut_signal <= x"0047";
        flag_at_signal   <= x"0000";
        wait for 100 ps;
        
        -- jeq #0006   	-> 0x0819
        dataOut_signal <= x"0819";
        wait for 100 ps;
        
        -- jgt #0004      -> 0x0812
        dataOut_signal <= x"0812";
        wait for 100 ps;
        
        -- jlt #0002   	-> 0x080B
        dataOut_signal <= x"080B";
        wait for 100 ps;
        
        -- nop            -> 0x0000
        dataOut_signal <= x"0000";
        wait for 100 ps;
        
        -- mov r2, #9     -> 0x1A09
        dataOut_signal <= x"1A09";
        wait for 100 ps;
        
        -- cmp r2, r1     -> 0x0047
        dataOut_signal <= x"0047";
        flag_at_signal   <= x"0040";
        wait for 100 ps;
        
        -- jeq #0006   	-> 0x0819
        dataOut_signal <= x"0819";
        wait for 100 ps;
        
        -- jgt #0004      -> 0x0812
        dataOut_signal <= x"0812";
        wait for 100 ps;
        
        -- jlt #0002   	-> 0x080B
        dataOut_signal <= x"080B";
        wait for 100 ps;
        
        -- nop            -> 0x0000
        dataOut_signal <= x"0000";
        wait for 100 ps;
        
        -- mov r2, #10 	-> 0x1A0A
        dataOut_signal <= x"1A0A";
        wait for 100 ps;
        
        -- cmp r2, r1  	-> 0x0047
        dataOut_signal <= x"0047";
        flag_at_signal   <= x"0001";
        wait for 100 ps;
        
        -- jeq #0006   	-> 0x0819
        dataOut_signal <= x"0819";
        wait for 100 ps;
        
        -- jgt #0004      -> 0x0812
        dataOut_signal <= x"0812";
        wait for 100 ps;
        
        -- jlt #0002   	-> 0x080B
        dataOut_signal <= x"080B";
        wait for 100 ps;
        
        -- nop          -> 0x0000
        dataOut_signal <= x"0000";
        wait for 100 ps;
        
        -- mov r1, #3	-> 0x1903
        dataOut_signal <= x"1903";
        wait for 100 ps;
        
        -- mov r2, #4	-> 0x1A04
        dataOut_signal <= x"1A04";
        wait for 100 ps;
        
        -- push r1		-> 0x0005
        dataOut_signal <= x"0005";
        wait for 100 ps;
        
        -- push r2		-> 0x0009
        dataOut_signal <= x"0009";
        wait for 100 ps;
        
        -- pop r3		-> 0x0302
        dataOut_signal <= x"0302";
        wait for 100 ps;
        
        -- pop r4		-> 0x0402
        dataOut_signal <= x"0402";
        wait for 100 ps;
        
        -- mov r5, r3	-> 0x1560
        dataOut_signal <= x"1560";
        wait for 100 ps;
        
        -- mov r6, r4	-> 0x1680
        dataOut_signal <= x"1680";
        wait for 100 ps;
                
        -- out r5 		 -> 0xF0A2
        dataOut_signal <= x"F0A2";
        wait for 100 ps;
        
        -- out r6		 -> 0xF0C2
        dataOut_signal <= x"F0C2";
        wait for 100 ps;
        
        -- out #5F		 -> 0xFA1F
        dataOut_signal <= x"FA1F";
        wait for 100 ps;
        
        -- in r7		 -> 0xF701
        dataOut_signal <= x"F701";
        wait for 100 ps;
        
        -- nop 		     -> 0x0000
        dataOut_signal <= x"0000";
        wait for 100 ps;
        
        -- nop		     -> 0x0000
        dataOut_signal <= x"0000";
        wait for 100 ps;
        
        -- in r7		 -> 0xF701
        dataOut_signal <= x"F701";
        wait for 100 ps;
        
        -- halt		   -> 0xFFFF
        dataOut_signal <= x"FFFF";
        wait for 100 ps;
        
    end process;

end Behavioral;
