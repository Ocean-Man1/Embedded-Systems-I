library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux_2to1 is
  port( D1,D0       : in std_logic;
		  SEL       : in std_logic_vector(1 downto 0);
		  MX_OUT    : out std_logic);

end mux_2to1;

architecture Behavioral of mux_2to1 is

begin
MX_OUT <= D1 when SEL = "01" else
          D0;

end Behavioral;
