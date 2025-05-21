library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity debounce_tb is
end debounce_tb;

architecture testbench of debounce_tb is

    signal tb_clk   :   std_logic := '0';
    signal tb_btn   :   std_logic := '0';
    signal tb_dbnc  :   std_logic := '0';
    
    component debounce is
        port( 
            clk :   in std_logic;
            btn :   in std_logic;
            dbnc:   out std_logic
        );
    end component;
    
begin 

--------------------------------------------------------------------------------
-- procs
--------------------------------------------------------------------------------
  
    clk_gen_proc: process
    begin
        wait for 4 ns;
        tb_clk <= '1';
        
        wait for 4ns;
        tb_clk <= '0';
        
    end process clk_gen_proc;
    
    btn_proc: process
    begin
        wait for 5 ms;
        tb_btn <= '1';
        
    -- set to 25 ms to see if debounce becomes true
        wait for 25 ms;
        tb_btn <= '0';
        
    end process btn_proc;

--------------------------------------------------------------------------------
-- port mapping
--------------------------------------------------------------------------------
 
    dut : debounce
    port map(
        clk => tb_clk,
        btn => tb_btn,
        dbnc => tb_dbnc
    );
    
end testbench;