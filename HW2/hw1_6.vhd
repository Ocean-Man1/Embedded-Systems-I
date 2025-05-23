-- Question 6 answered using selected signal assignment
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity hw1_6 is
	port (D_IN     : in std_logic_vector(2 downto 0);
	      SZ_OUT   : out std_logic_vector(7 downto 0));
end hw1_6;

architecture func of hw1_6 is

begin
-- using selected signal assignment
  with D_IN select
	   SZ_OUT <= "00000001" when "000",
		     "00000010" when "001",
		     "00000100" when "010",
		     "00001000" when "011",
		     "00010000" when "100",
		     "00100000" when "101",
	     	     "01000000" when "110",
	             "10000000" when "111",
	             "00000000" when others;	

end func;
