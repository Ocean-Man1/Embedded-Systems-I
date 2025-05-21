library IEEE;
use IEEE.STD_LOGIC_1164.ALL, IEEE.NUMERIC_STD.ALL;


entity de_4 is
  port( clk     : in    std_logic;
        reset   : in    std_logic;
        input   : in    std_logic_vector(1 downto 0);
        output  : out   unsigned(3 downto 0));
end de_4;            
        
architecture sys of de_4 is
begin 
    process(clk)
        begin
            if ( clk'event and clk ='1') then
                if ( reset = '1') then
                    output <= "0000";
            else
                case input is
                    when "00" => output <= "0001";
                    when "01" => output <= "0010";
                    when "10" => output <= "0100";
                    when "11" => output <= "1000";
                    when others => output <= "0000";
                end case;
                end if;
            end if;
    end process;
end sys;