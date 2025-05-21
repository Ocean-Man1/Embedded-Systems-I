-- library declaration
library IEEE;
use IEEE.std_logic_1164.all;

-- entity
entity q5 is
    port (A,B,C          : in std_logic_vector(7 downto 0);
          CLK            : in std_logic;
          SL1,SL2        : in std_logic;
          RAX, RBX       : out std_logic_vector(7 downto 0));
end q5;

-- architecture
architecture rtl_behavioral of q5 is
-- intermediate signal declaration ---------------
    signal s_mux_result   : std_logic_vector(7 downto 0);
    signal LD             : std_logic;
begin
    
    with SL1 select
	   LD <= '1' when '1',
	         '0' when '0',
	         '0' when others;
	         
    ra: process(CLK) -- process         
	    begin
        if (rising_edge(CLK)) then
            if (LD = '1') then
                RAX <= A;
            end if;
        end if;
	end process;
	
	rb: process(CLK)
	   begin
	   if (rising_edge(CLK)) then
            if (LD = '0') then
                RBX <= s_mux_result;
            end if;
        end if;
	
	end process;

    with SL2 select
    s_mux_result <= B     when '1',
                    C     when '0',
                    (others => '0') when others;
end rtl_behavioral;
