library IEEE;
use IEEE.STD_LOGIC_1164.ALL;--use UNISIM.VComponents.all;

entity TestBanch is
--  Port ( );
end TestBanch;

architecture Behavioral of TestBanch is
    signal clk : STD_LOGIC;
    signal rst : STD_LOGIC;
    
    signal PC_out_signal : STD_LOGIC_VECTOR(15 downto 0);
    
    signal Rd_signal      : STD_LOGIC_VECTOR(15 downto 0);
    signal Rm_signal      : STD_LOGIC_VECTOR(15 downto 0);
    signal Rn_signal      : STD_LOGIC_VECTOR(15 downto 0);
    signal Alu_out_signal : STD_LOGIC_VECTOR(15 downto 0);
    
    signal IR_data_signal : STD_LOGIC_VECTOR(15 downto 0);
    signal flags_signal   : STD_LOGIC_VECTOR(15 downto 0);
    signal flag_ld_signal : STD_LOGIC;
    signal Jump_signal    : STD_LOGIC;
    signal IR_load_signal : STD_LOGIC;
    signal RAM_sel_signal : STD_LOGIC;
    signal RAM_we_signal  : STD_LOGIC;
    signal ROM_en_signal  : STD_LOGIC;
    signal PC_clr_signal  : STD_LOGIC;
    signal PC_inc_signal  : STD_LOGIC;
    signal RF_sel_signal  : STD_LOGIC_VECTOR(1 downto 0);
    signal Rd_wr_signal   : STD_LOGIC;
    signal Rd_sel_signal  : STD_LOGIC_VECTOR(2 downto 0);
    signal Rm_sel_signal  : STD_LOGIC_VECTOR(2 downto 0);
    signal Rn_sel_signal  : STD_LOGIC_VECTOR(2 downto 0);
    signal ALU_op_signal  : STD_LOGIC_VECTOR(3 downto 0);
    signal immed_signal   : STD_LOGIC_VECTOR(15 downto 0);
    
    signal SE_out_signal : STD_LOGIC_VECTOR(15 downto 0);
    signal New_PC_signal : STD_LOGIC_VECTOR(15 downto 0);
    signal JumpPC_signal : STD_LOGIC_VECTOR(15 downto 0);
    signal JumpAd_signal : STD_LOGIC_VECTOR(15 downto 0);
    
    signal New_flags_signal : STD_LOGIC_VECTOR(15 downto 0);
    signal Data_in_signal : STD_LOGIC_VECTOR(15 downto 0);
    signal Data_Out1_signal : STD_LOGIC_VECTOR(15 downto 0);
    signal Data_Out2_signal : STD_LOGIC_VECTOR(15 downto 0);
    
begin
    DUT_Processor : entity work.Processor
        Port map (
            clk => clk,
            rst => rst
        );
        
    DUT_ROM : entity work.MemoryRom
        Port map (
            address => PC_out_signal,
            En      => ROM_en_signal,
            clk     => clk,
            dataOut => Data_Out1_signal
        );
        
    DUT_RAM : entity work.MemoryRam
        Port map (
            address => Rm_signal,
            dataIn  => Data_in_signal,
            writeEn => RAM_we_signal,
            clk     => clk,
            dataOut => Data_Out2_signal
        );
        
    DUT_Mux_Proc : entity work.Mux2
        Port map (
            Mux_0   => Rn_signal,
            Mux_1   => Immed_signal,
            Mux_sel => RAM_sel_signal,
            Mux_out => Data_in_signal
        );
    
    DUT_Controller : entity work.Controller
        Port map (
            clk     => clk,
            rst     => rst,
            IR_data => IR_data_signal,
            flags   => flags_signal,
            flag_ld => flag_ld_signal,
            Jump    => Jump_signal,
            IR_load => IR_load_signal,
            RAM_sel => RAM_sel_signal,
            RAM_we  => RAM_we_signal,
            ROM_en  => ROM_en_signal,
            PC_clr  => PC_clr_signal,
            PC_inc  => PC_inc_signal,
            RF_sel  => RF_sel_signal,
            Rd_wr   => Rd_wr_signal,
            Rd_sel  => Rd_sel_signal,
            Rm_sel  => Rm_sel_signal,
            Rn_sel  => Rn_sel_signal,
            ALU_op  => ALU_op_signal,
            Immed   => Immed_signal
        );
        
    DUT_ProgramCounter : entity work.Registrador
        Port map (
            D   => JumpAd_signal,
            ld  => PC_inc_signal,
            clk => clk,
            rst => PC_clr_signal,
            Q   => PC_out_signal
        );
        
    DUT_Add_PC : entity work.Add_pc
        Port map (
            A => PC_out_signal,
            C => New_PC_signal
        );
    
    DUT_SingExtender : entity work.SignExtender
        Port map (
            A => Immed_signal,
            B => SE_out_signal
        );
        
    DUT_Add_Jump : entity work.Add
        Port map (
            A => SE_out_signal,
            B => PC_out_signal,
            C => JumpPC_signal
        );
        
    DUT_MuxJump : entity work.Mux2
        Port map (
            Mux_0   => New_PC_signal,
            Mux_1   => JumpPC_signal,
            Mux_sel => Jump_signal,
            Mux_out => JumpAd_signal
        );
        
    DUT_InstructionRegister : entity work.Registrador
        Port map (
            D   => Data_Out1_signal,
            ld  => IR_load_signal,
            clk => clk,
            rst => rst,
            Q   => IR_data_signal
        );
        
    DUT_FlagRegister : entity work.Registrador
        Port map (
            D   => New_flags_signal,
            ld  => flag_ld_signal,
            clk => clk,
            rst => rst,
            Q   => flags_signal
        );
    
    DUT_Mux : entity work.Mux4 
        Port map (
            Mux_0   => Rm_signal,
            Mux_1   => Data_Out2_signal,
            Mux_2   => Immed_signal,
            Mux_3   => Alu_out_signal,
            Mux_sel => RF_sel_signal,
            Mux_out => Rd_signal
        );
        
    DUT_RegisterFile : entity work.RegisterFile
        Port map (
            clk    => clk,
            rst    => rst,
            Rd_wr  => Rd_wr_signal,
            Rd_sel => Rd_sel_signal,
            Rm_sel => Rm_sel_signal,
            Rn_sel => Rn_sel_signal,
            Rd     => Rd_signal,
            Rm     => Rm_signal,
            Rn     => Rn_signal
        );
    
    DUT_Alu : entity work.Alu
        Port map (
            Alu_in0 => Rm_signal,
            Alu_in1 => Rn_signal,
            Alu_op  => ALU_op_signal,
            flags   => New_flags_signal,
            Alu_out => Alu_out_signal
        );
        
        teste : process begin
            wait for 5 ns;
            rst <= '1';
            PC_out_signal <= x"0000";
            loop
                clk <= '1';
                wait for 1 ns;
                clk <= '0';
                wait for 1 ns;
            end loop;
        end process;


end Behavioral;
