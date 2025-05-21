library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity hw1_1a is
	port (A,B  : in std_logic;
		  F    : out std_logic);
end hw1_1a;

architecture func of hw1_1a is

begin
    F <= ((NOT A) AND B) OR A OR (A AND (NOT B));

end func;
