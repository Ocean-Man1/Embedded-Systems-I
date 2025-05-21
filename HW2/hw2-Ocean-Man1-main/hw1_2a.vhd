--QUESTION 2 answered using selected signal assignment
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity hw1_2a is
	port (A,B,C,D 	: in std_logic;
		  F    	    : out std_logic);
end hw1_2a;

architecture func of hw1_2a is

begin
-- using selected signal assignment
  with ((A = '0' AND C = '1' AND D = '0') OR (B = '0' AND C = '1') OR (B = '1' AND C = '1' AND D = '0')) select
        F <= '1' when true,
             '0' when false,
             '0' when others;

end func;
