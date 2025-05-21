library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity counter_top_tb is
--  Port ( );
end counter_top_tb;

architecture Behavioral of counter_top_tb is

        signal tb_clk : std_logic;
        signal tb_btn : std_logic_vector(3 downto 0);
        signal tb_sw : std_logic_vector(3 downto 0);
        signal tb_led : std_logic_vector(3 downto 0);

    component counter_top is
       port(
        clk : in std_logic;
        btn : in std_logic_vector(3 downto 0);
        sw : in std_logic_vector(3 downto 0);
        led : out std_logic_vector(3 downto 0)
       );
    end component;
    
begin

    clk_gen_proc: process
    begin
        wait for 4 ps;
        tb_clk <= '1';
        
        wait for 4ps;
        tb_clk <= '0';
        
    end process clk_gen_proc;
    
    
        btn_proc: process
    begin
        tb_sw <= "0101";
        tb_btn <= "1110"; 
        wait for 1000ns;
        
        tb_btn <= "0010";
        tb_sw(0) <= '1';
        tb_btn(2) <= '1';
        wait for 5000ns;
        
        wait for 1000ns;
    end process btn_proc;

    
    

-- port mapping

    du: counter_top 
    port map(
            clk => tb_clk,
            btn => tb_btn,
            sw => tb_sw,
            led => tb_led
    );        
    
    
end Behavioral;
