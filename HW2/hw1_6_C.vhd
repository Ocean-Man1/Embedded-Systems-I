-- Question 6 answered using conditional signal assignment
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity hw1_6_C is
	port (D_IN     : in std_logic_vector(2 downto 0);
	      SZ_OUT   : out std_logic_vector(7 downto 0));
end hw1_6_C;

architecture Behavioral of hw1_6_C is

begin
-- using conditional signal assignment
	   SZ_OUT <= "00000001" when (D_IN = "000") else
		     "00000010" when (D_IN = "001") else
		     "00000100" when (D_IN = "010") else
		     "00001000" when (D_IN = "011") else
		     "00010000" when (D_IN = "100") else
		     "00100000" when (D_IN = "101") else
	     	     "01000000" when (D_IN = "110") else
	             "10000000" when (D_IN = "111") else
	             "00000000";	


end Behavioral;
