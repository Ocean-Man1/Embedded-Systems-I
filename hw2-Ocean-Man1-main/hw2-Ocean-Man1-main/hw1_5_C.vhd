-- Question 5 answered using conditional signal assignment
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity h1_5_C is
    port (D7,D6,D5,D4,D3,D2,D1,D0 : in std_logic;
		  SEL             : in std_logic_vector(2 downto 0);
		  MX_OUT          : out std_logic);
end h1_5_C;

architecture Behavioral of h1_5_C is

begin
-- this is a conditional signal assignment
	   MX_OUT <= D7 when (SEL = "111") else
		     D6 when (SEL = "110") else
		     D5 when (SEL = "101") else
		     D4 when (SEL = "100") else
		     D3 when (SEL = "011") else
		     D2 when (SEL = "010") else
	     	     D1 when (SEL = "001") else
	             D0 when (SEL = "000") else
	             '0';	

end Behavioral;
