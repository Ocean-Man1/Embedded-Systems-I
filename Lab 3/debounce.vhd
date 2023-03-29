library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity debounce is
    Port ( 
          clk   : in std_logic;
          btn   : in std_logic;
          dbnc  : out std_logic
);
end debounce;

architecture Behavioral of debounce is

    constant max_val: integer:= 2000;
    signal cnt   : std_logic_vector(21 downto 0);
    --signal shift : std_logic_vector(1 downto 0);
    --signal temp : std_logic;

begin

process(clk)
    begin
        if (rising_edge(clk)) then
            if (btn = '1') then
                if(unsigned(cnt) < max_val) then
                    cnt <= std_logic_vector(unsigned(cnt) + 1);
                 else
                    dbnc <= '1';
                 end if;
            else
                cnt <= (others => '0');
                dbnc <= '0';
            end if;
        end if;
            
end process;
end Behavioral;
