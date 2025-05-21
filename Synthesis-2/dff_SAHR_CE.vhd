library IEEE;
use IEEE.std_logic_1164.all;

entity dff_SAHR_CE is
  port (
    R, CE, D, CLK   : in  std_logic;
    Q               : out std_logic);
end entity dff_SAHR_CE;

architecture Behavioral of dff_SAHR_CE is
begin
  process (CLK) is
  begin
    if rising_edge(CLK) then
      if R = '1' then
        Q <= '0';
      elsif (CE = '1') then
        Q <= D;
      end if;
    end if;
  end process;
end architecture Behavioral;