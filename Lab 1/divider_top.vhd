library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity divider_top is
    Port (clk : in std_logic;
          led : out std_logic);
    
end divider_top;

architecture Behavioral of divider_top is

-- Clock_Div --------
    component clock_div is
        Port( clk : in std_logic;
              div : out std_logic);
    end component;

    signal CE : std_logic;
    signal Q : std_logic;
        
begin
    clk_div : clock_div
    port map (clk => clk, div => CE);
    
    process(clk)
        begin
            if (rising_edge(clk)) then
                if (CE = '1') then
                    Q <= NOT Q;
                end if;
            end if;
    end process;        

    led <= Q;

end Behavioral;
