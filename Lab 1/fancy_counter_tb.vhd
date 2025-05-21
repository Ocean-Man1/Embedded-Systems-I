library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity fancy_counter_tb is
--  Port ( );
end fancy_counter_tb;

architecture fancy_counter of fancy_counter_tb is

    signal tb_clk   :   std_logic := '0';
    signal tb_clk_en   :   std_logic := '0';
    signal sw  :   std_logic_vector(3 downto 0) := (others =>'0');
    signal temp_en  :   std_logic := '0';
    signal temp_ld  :   std_logic := '0';
    signal temp_rst :  std_logic := '0';
    signal temp_updn :   std_logic := '0';
    signal led :   std_logic_vector(3 downto 0) := (others => '0');
    
   component fancy_counter is
        port(
        clk : in std_logic;
        clk_en : in std_logic;
        dir : in std_logic;
        en : in std_logic;
        ld : in std_logic;
        rst : in std_logic;
        updn : in std_logic;
        val : in std_logic_vector(3 downto 0);
        cnt : out std_logic_vector(3 downto 0)
        );
    end component;
    
begin
    
    temp_en_proc: process
    begin
        temp_en <= '1';
        wait for 300 ns;
           -- temp_en <= '0';
    end process temp_en_proc;   
    
    clk_gen_proc: process
    begin
        wait for 4 ns;
        tb_clk <= '1';
        
        wait for 4ns;
        tb_clk <= '0';
        
    end process clk_gen_proc;
    
    clk_en_proc: process
    begin
    
       wait for 100 ns;
       tb_clk_en <= '1';
       
       wait for 100 ns;
       tb_clk_en <= '0';
       
    end process clk_en_proc;
    
    sw_proc: process
    begin
       sw(0) <= '1';
       temp_updn <= '1';
   
       wait for 10 ns;
       sw(0) <= '1';
       sw(1) <= '0';
       sw(2) <= '1';
       sw(3) <= '0';
       temp_ld <= '1';
 
  
       wait for 20ns;
       temp_ld <= '0';
       sw(0) <= '0';
       temp_updn <= '1';

       
       --sw(0) <= '0';
       --sw(1) <= '0';
       --sw(2) <= '0';
       --sw(3) <= '1';
       --temp_ld <= '1';
       --temp_updn <= '0';
       
       wait for 10 ns;

       temp_ld <= '1';
       sw(0) <= '1';
       temp_updn <= '0';
       
    end process sw_proc;
    
--    updn_proc: process
--    begin
    
--       wait for 50 ns;
--       temp_updn <= '1';
       
--       wait for 50 ns;
--       temp_updn <= '0';
    
--    end process updn_proc;
    
    rst_proc: process
    begin
    
       wait for 200 ns;
       temp_rst <= '1';
       
       wait for 200 ns;
       temp_rst <= '0';   
    
    end process rst_proc;
--------------------------------------------------------------------------------
-- port mapping
--------------------------------------------------------------------------------
 
    dut : fancy_counter    
    port map(
        clk => tb_clk, 
        clk_en => tb_clk_en,
        dir => sw(0),
        en => temp_en,
        ld => temp_ld,
        rst => temp_rst,
        updn => temp_updn,
        val => sw,
        cnt => led
    );


end fancy_counter;
