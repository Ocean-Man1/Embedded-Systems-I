-- library declaration
library IEEE;
use IEEE.std_logic_1164.all;

-- entity
entity q2 is
    port (X,Y,Z          : in std_logic_vector(7 downto 0);
          CLK            : in std_logic;
          MS             : in std_logic_vector(1 downto 0);
          DS             : in std_logic;
          REG_A, REG_B   : inout std_logic_vector(7 downto 0));
end q2;

-- architecture
architecture rtl_behavioral of q2 is
-- intermediate signal declaration ---------------
    signal s_mux_result, ra_result, rb_result : std_logic_vector(7 downto 0);
    signal LD       :   std_logic;
begin
    
    with DS select
	   LD <= '1' when '1',
	         '0' when '0',
	         '0' when others;
	         
    ra: process(CLK) -- process         
	    begin
        if (falling_edge(CLK)) then
            if (LD = '0') then
                REG_A <= s_mux_result;
            end if;
        end if;
	end process;
	
	rb: process(CLK)
	   begin
	   if (falling_edge(CLK)) then
            if (LD = '1') then
                REG_B <= REG_A;
            end if;
        end if;
	
	end process;

    with MS select
    s_mux_result <= X     when "11",
                    Y     when "10",
                    Z     when "01",
                    REG_B when "00",
                    (others => '0') when others;
end rtl_behavioral;
	   begin
	   if (rising_edge(CLK)) then
            if (LD = "10") then
                REG_B <= REG_A;
            end if;
        end if;
	
	end process;

    with MS select
    s_mux_result <= X     when "11",
                    Y     when "10",
                    Z     when "01",
                    REG_B when "00",
                    (others => '0') when others;
end rtl_behavioral;
