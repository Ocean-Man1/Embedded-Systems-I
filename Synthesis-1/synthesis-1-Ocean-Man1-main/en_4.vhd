library IEEE;
use IEEE.STD_LOGIC_1164.ALL, IEEE.NUMERIC_STD.ALL;


entity en_4 is
  port( clk     : in    std_logic;
        reset   : in    std_logic;
        input   : in    std_logic_vector(3 downto 0);
        output  : out   unsigned(1 downto 0));
end en_4; 

architecture sys of en_4 is
begin 
    process(clk)
        begin
            if ( clk'event and clk ='1') then
                if (reset = '1') then
                    output <= "00";
                else
                    case input is
                        when "0001" => output <= "00";
                        when "0010" => output <= "01";
                        when "0100" => output <= "10";
                        when "1000" => output <= "11";
                        when others => output <= "00";
                    end case;
                end if;
            end if;
    end process;
end sys;