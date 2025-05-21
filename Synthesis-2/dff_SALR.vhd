library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity dff_SALR is
  port (
        R, D, CLK       : in  std_logic;
        Q               : out std_logic);
end dff_SALR;

architecture Behavioral of dff_SALR is

begin

process (CLK)
begin
   if CLK'event and CLK='1' then
      if R ='0' then
         Q <= '0';
      else
         Q <= D;
      end if;
   end if;
end process;

end Behavioral;