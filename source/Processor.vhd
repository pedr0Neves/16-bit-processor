library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Processor is
    Port ( 
        clk     : in STD_LOGIC;
        rst     : in STD_LOGIC;
        read    : in STD_LOGIC_VECTOR (15 downto 0);
        write   : out STD_LOGIC_VECTOR (15 downto 0)
    );
end Processor;

architecture Behavioral of Processor is
    signal IO_signal        : STD_LOGIC_VECTOR (15 downto 0);
    signal IO_in_signal     : STD_LOGIC_VECTOR (15 downto 0);
    signal IO_out_signal    : STD_LOGIC_VECTOR (15 downto 0);
    
    -- Control Unit signal
    -- inSignals
    signal dataOut_signal_1 : STD_LOGIC_VECTOR(15 downto 0);
    signal flag_at_signal   : STD_LOGIC_VECTOR(15 downto 0);
    -- outSignals
    signal IO_sel_signal    : STD_LOGIC;
    signal IO_en_signal     : STD_LOGIC;
    signal IO_mode_signal   : STD_LOGIC;
    signal WaitEnd_signal   : STD_LOGIC;
    signal Sp_en_signal     : STD_LOGIC;
    signal ROM_en_signal    : STD_LOGIC;
    signal RAM_sel_signal   : STD_LOGIC;
    signal RAM_we_signal    : STD_LOGIC;
    signal RF_sel_signal    : STD_LOGIC_VECTOR(1 downto 0);
    signal Rd_wr_signal     : STD_LOGIC;
    signal Rd_sel_signal    : STD_LOGIC_VECTOR(2 downto 0);
    signal Rm_sel_signal    : STD_LOGIC_VECTOR(2 downto 0);
    signal Rn_sel_signal    : STD_LOGIC_VECTOR(2 downto 0);
    signal ALU_op_signal    : STD_LOGIC_VECTOR(3 downto 0);
    signal address_signal_1 : STD_LOGIC_VECTOR(15 downto 0);
    signal SP_out_signal    : STD_LOGIC_VECTOR(15 downto 0);
    signal immed_signal     : STD_LOGIC_VECTOR(15 downto 0);
    
    -- DataPath signal
    -- inSignals
    signal dataOut_signal_2 : STD_LOGIC_VECTOR(15 downto 0);
    -- outSignals
    signal Rm_out_signal    : STD_LOGIC_VECTOR(15 downto 0);
    signal Rn_out_signal    : STD_LOGIC_VECTOR(15 downto 0);
    
    -- RAM signal 
    -- inSignals
    signal address_signal_2 : STD_LOGIC_VECTOR(15 downto 0);
    signal dataIn_signal    : STD_LOGIC_VECTOR(15 downto 0);
    
begin
    IO_unit : entity work.InOut_Unit
        Port map (
            clk     => clk,
            rst     => rst,
            IO_mode => IO_mode_signal,
            IO_en   => IO_en_signal,
            read    => read,
            write   => write,
            IO_in   => Rm_out_signal,
            IO_out  => IO_out_signal
        );
        
    Mux_IO : entity work.Mux2
        Port map (
            Mux_0   => immed_signal,
            Mux_1   => IO_out_signal,
            Mux_sel => IO_sel_signal,
            Mux_out => IO_signal
        );
        
    ROM : entity work.MemoryRom
        Port map (
            address => address_signal_1,
            En      => ROM_en_signal,
            clk     => clk,
            dataOut => dataOut_signal_1
        );
        
    RAM : entity work.MemoryRam
        Port map (
            address => address_signal_2,
            dataIn  => dataIn_signal,
            writeEn => RAM_we_signal,
            clk     => clk,
            WriEnd  => WaitEnd_signal,
            dataOut => dataOut_signal_2
        );
        
    Mux_data_in : entity work.Mux2
        Port map (
            Mux_0   => Rn_out_signal,
            Mux_1   => immed_signal,
            Mux_sel => RAM_sel_signal,
            Mux_out => dataIn_signal
        );
    
    ControlUnit : entity work.ControlUnit
        Port map (
            clk     => clk,
            rst     => rst,
            WaitEnd => WaitEnd_signal,
            dataOut => dataOut_signal_1,
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
            address => address_signal_1,
            SP_out  => SP_out_signal,
            immed   => immed_signal
        );
        
    Mux_stack : entity work.Mux2
        Port map (
            Mux_0   => Rm_out_signal,
            Mux_1   => SP_out_signal,
            Mux_sel => Sp_en_signal,
            Mux_out => address_signal_2
        );
    
    DataPath : entity work.DataPath
        Port map (
            clk     => clk,
            rst     => rst,
            dataOut => dataOut_signal_2,
            immed   => IO_signal,
            RF_sel  => RF_sel_signal,
            Rd_wr   => Rd_wr_signal,
            Rd_sel  => Rd_sel_signal,
            Rm_sel  => Rm_sel_signal,
            Rn_sel  => Rn_sel_signal,
            ALU_op  => ALU_op_signal,
            flags   => flag_at_signal,
            Rm_out  => Rm_out_signal,
            Rn_out  => Rn_out_signal 
        );

end Behavioral;
