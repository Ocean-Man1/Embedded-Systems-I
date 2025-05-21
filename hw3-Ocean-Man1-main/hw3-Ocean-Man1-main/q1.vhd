-- library declaration
library IEEE;
use IEEE.std_logic_1164.all;
-- entity
entity q1 is
    port (A,B         : in std_logic_vector(7 downto 0);
          CLK,SEL     : in std_logic;
          LDA         : in std_logic;
          REG_A       : out std_logic_vector(7 downto 0));
end q1;

-- architecture
architecture rtl_behavioral of q1 is
-- intermediate signal declaration ---------------
    signal s_mux_result : std_logic_vector(7 downto 0);
begin
    ra: process(CLK) -- process
    begin
        if (rising_edge(CLK)) then
            if (LDA = '1') then
                REG_A <= s_mux_result;
            end if;
        end if;
    end process;
    
    with SEL select
    s_mux_result <= A when '1',
                    B when '0',
                    (others => '0') when others;
end rtl_behavioral;
