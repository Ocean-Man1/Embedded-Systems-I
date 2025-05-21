library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity dff_SAHR is
  port (
        R, D, CLK   : in  std_logic;
        Q               : out std_logic);
end dff_SAHR;

architecture Behavioral of dff_SAHR is

begin

process (CLK)
begin
   if (rising_edge(CLK)) then
      if R='1' then
         Q <= '0';
      else
         Q <= D;
      end if;
   end if;
end process;


end Behavioral;
