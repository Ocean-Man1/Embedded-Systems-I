--QUESTION 2 answered using selected conditional assignment
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity hw1_2a_C is
	port (A,B,C,D 	: in std_logic;
		   F    	: out std_logic);
end hw1_2a_C;

architecture func of hw1_2a_C is

begin
-- create conditions for each possible outcome
-- using conditional assignment
	F <= '1' when (A = '0' AND C = '1' AND D = '0') else
	     '1' when (C = '1' AND B = '0') else
	     '1' when (B = '1' AND C = '1' AND D = '0') else
	     '0';	

end func;
