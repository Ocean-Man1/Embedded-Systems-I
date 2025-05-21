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

    signal cnt   : std_logic_vector(21 downto 0);
    signal shift : std_logic_vector(1 downto 0);
    signal temp : std_logic;

begin

process(clk)
    begin
        if (rising_edge(clk)) then
            shift(1) <= shift(0); 
            shift(0) <= btn;
            if (shift(1) = '1') then
                cnt <= std_logic_vector(unsigned(cnt) + 1);
            else
                cnt <= (others => '0');
            end if;
            
            if(unsigned(cnt) > 2500000) then
                dbnc <= '1';
                cnt <= (others => '0');
            else
                dbnc <='0';
            end if;
        end if;
            
end process;
end Behavioral;
