library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity alu_tester_tb is
--  Port ( );
end alu_tester_tb;

architecture Behavioral of alu_tester_tb is

    signal tb_clk : std_logic := '0';
    signal tb_btn : std_logic_vector(3 downto 0) := (others => '0');
    signal tb_sw : std_logic_vector(3 downto 0) := (others => '0');
    signal tb_led : std_logic_vector(3 downto 0) := (others => '0');
    
    component alu_tester is
    port(
            clk    : in std_logic;
            btn    : in std_logic_vector(3 downto 0);
            sw    : in std_logic_vector(3 downto 0);
            led    : out std_logic_vector(3 downto 0)
     );
     end component;
 

begin

    clk_gen_proc: process
    begin
        wait for 6 ps;
        tb_clk <= '1';
        
        wait for 6 ps;
        tb_clk <= '0';
    end process clk_gen_proc;

    set_btns: process
    begin
 -- set op A-B
        -- wait for 600 ms;
        tb_btn(1) <= '1';       --set A
        tb_sw <= "1001";        -- set A to 6
    wait for 1ms;         -- if using clock div set to 1ms & 15 ms sim time ; if using clk, set to 200 ns, and 5 ms sim time
    
        tb_btn <= "0000";
        tb_btn(0) <= '1';       --set B
        tb_sw <= "0010";       --set B to 2    
    wait for 1ms; 
    
        tb_btn <= "0000";
        tb_btn(2) <= '1';       --set opcode
        tb_sw <= "0001";            -- dp A-B
    wait for 1ms;


-- next op A-1

        tb_btn <= "0000";
        tb_btn(1) <= '1';       --set A
        tb_sw <= "1001";        -- set A to alu_tester
    wait for 1ms;        
    
        tb_btn <= "0000";
        tb_btn(2) <= '1';   -- set op
        tb_sw <= "0011";    -- A - 1
    wait for 1ms;             
        -- A is now 5
            
-- next op A + 1   
        
        tb_btn <= "0000";
        tb_btn(2) <= '1';   -- set op
        tb_sw <= "0001";    -- A + 1
    wait for 1ms;         

        tb_btn <= "0000";    
        tb_btn(1) <= '1';       --set A
        tb_sw <= "1001";        -- set A to alu_tester
    wait for 1ms;        
        -- A is now 6
        
        tb_btn <= "0000";           
      
    end process set_btns;
    
    du: alu_tester
    port map(
            clk => tb_clk,
            btn => tb_btn,
            sw => tb_sw,
            led => tb_led
    );

end Behavioral;
