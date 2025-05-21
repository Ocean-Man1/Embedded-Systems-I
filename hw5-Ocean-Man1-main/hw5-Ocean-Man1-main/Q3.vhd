library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity hw5_3 is
	port(
		A,B : in std_logic_vector(1 downto 0);
		D : in std_logic;
		E : out std_logic
	);
end hw5_3;

architecture Behavioral of hw5_3 is

	signal and_1 : std_logic_vector(1 downto 0);
	signal and_2 : std_logic_vector(1 downto 0);
	signal or_1  : std_logic_vector(1 downto 0);
	signal or_2 : std_logic_vector(3 downto 0);

begin
and_1 <= A(1) & A(0);
or_1 <= B(1) & B(0);
and_2 <= not(D) & B(1);
or_2 <= and_1 or or_1 or and_2;

-- using conditional statements
E <= '1' when (or_2 = "111") else
     '1' when (or_2 = "110") else
     '1' when (or_2 = "101") else
     '1' when (or_2 = "100") else
     '1' when (or_2 = "011") else
     '1' when (or_2 = "010") else
     '1' when (or_2 = "001") else
     '0' when (or_2 = "000") else
     '0';

end Behavioral;
