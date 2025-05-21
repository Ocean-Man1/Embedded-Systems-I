-- library declaration
library IEEE;
use IEEE.std_logic_1164.all;
-- entity
entity q4 is
    port (X,Y          : in std_logic_vector(7 downto 0);
          CLK          : in std_logic;
          LDA,LDB      : in std_logic;
          S0,S1        : in std_logic;
          RD           : in std_logic;
          REG_A        : out std_logic_vector(7 downto 0);
          REG_B        : inout std_logic_vector(7 downto 0));
end q4;

-- architecture
architecture rtl_behavioral of q4 is
-- intermediate signal declaration ---------------
    signal s_mux_result1, s_mux_result2 : std_logic_vector(7 downto 0);
    signal and_out1, and_out2           : std_logic;
begin
    
    and_out1 <= LDB AND (NOT RD);
    and_out2 <= LDA AND RD;

    ra: process(CLK) -- process
    begin
        if (rising_edge(CLK)) then
            if (and_out2 = '1') then
                REG_A <= s_mux_result2;
            end if;
        end if;
    end process;
    
    rb: process(CLK)
	begin
	   if (rising_edge(CLK)) then
            if (and_out1 = '1') then
                REG_B <= s_mux_result1;
            end if;
        end if;
	end process;
    
    with S1 select
    s_mux_result1 <= X when '1',
                     Y when '0',
                     (others => '0') when others;
                     
    with S0 select
    s_mux_result2 <= REG_B when '1',
                     Y     when '0',
                     (others => '0') when others;                    
                     
                    
end rtl_behavioral;
