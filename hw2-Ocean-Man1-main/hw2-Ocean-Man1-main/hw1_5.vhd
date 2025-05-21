--QUESTION 5 answered using selected signal assignment
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity hw1_5 is
    port (D7,D6,D5,D4,D3,D2,D1,D0 : in std_logic;
		  SEL                     : in std_logic_vector(3 downto 0);
		  MX_OUT                  : out std_logic);
end hw1_5;

architecture mx_code of hw1_5 is

begin
-- this is a selected signal assignment
  with SEL select
	   MX_OUT <= D7 when "0111",
		         D6 when "0110",
		         D5 when "0101",
		         D4 when "0100",
		         D3 when "0011",
		         D2 when "0010",
			 D1 when "0001",
	                 D0 when "0000",
	                 '0' when others;	

end mx_code;
