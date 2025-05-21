library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity comp_8bit is
  port( clk       : in    std_logic;
        in1,in2   : in    std_logic(7 downto 0);
        output    : out   std_logic);
end comp_8bit;

architecture Behavioral of comp_8bit is
begin

    process(clk)
        begin
            if (clk'event and clk ='1') then
                if ( in1 = in2 ) then
                    output <= '1';
                else
                    output <= '0';
                end if;
            end if;
    end process;

end Behavioral;
