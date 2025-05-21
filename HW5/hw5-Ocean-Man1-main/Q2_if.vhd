library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity hw5_q2_if is
	port(
		A,B : in std_logic_vector(1 downto 0);
		D : in std_logic;
		E : out std_logic
	);
end hw5_q2_if;

architecture Behavioral of hw5_q2_if is
	
	signal and_1 : std_logic_vector(1 downto 0);
	signal and_2 : std_logic_vector(1 downto 0);
	signal or_1  : std_logic_vector(1 downto 0);
	signal or_2 : std_logic_vector(3 downto 0);
	
begin
and_1 <= A(1) & A(0);
or_1 <= B(1) & B(0);
and_2 <= not(D) & B(1);
or_2 <= and_1 or or_1 or and_2;
    
	proc_1: process(and_1,and_2,or_1,or_2) is
	
	begin
	
	if (or_2 = "111") then
	   E <= '1';
	elsif (or_2 = "110") then
	   E <= '1';
	elsif (or_2 = "101") then
	   E <= '1';
	elsif (or_2 = "100") then
	   E <= '1';
	elsif (or_2 = "011") then
	   E <= '1';
	elsif (or_2 = "010") then
	   E <= '1';
	elsif (or_2 = "001") then
	   E <= '1';
	else
	   E <= '0';
	end if;
	 
    end process proc_1;
end Behavioral;
