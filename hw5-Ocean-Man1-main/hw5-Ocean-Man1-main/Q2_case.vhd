library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity hw_2_case is
	port(
		A,B : in std_logic_vector(1 downto 0);
		D : in std_logic;
		E : out std_logic
	);
end hw_2_case;

architecture Behavioral of hw_2_case is

	signal and_1 : std_logic_vector(1 downto 0);
	signal and_2 : std_logic_vector(1 downto 0);
	signal or_1  : std_logic_vector(1 downto 0);
	signal or_2 : std_logic_vector(2 downto 0);
begin
and_1 <= A(1) & A(0);
or_2 <= B(1) & B(0);
and_2 <= not(D) & B(1);
    
    
	proc_1: process(and_1,and_2,or_1,or_2) is
	
    begin
        case(and_1) is
        when "11" => or_2(2) <= '1';
        when others => or_2(2) <= '0';
        end case;
        
        case(or_1) is
        when "11" => or_2(1) <= '1';
        when "10" => or_2(1) <= '1';
        when "01" => or_2(1) <= '1';
        when others => or_2(1) <= '0';
        end case;

        case(and_2) is
        when "11" => or_2(2) <= '1';
        when others => or_2(2) <= '0';
        end case; 
    
        case(or_2) is
        when "111" => E <= '1';
        when "110" => E <= '1';
        when "101" => E <= '1';
        when "100" => E <= '1';
        when "011" => E <= '1';
        when "010" => E <= '1';
        when "001" => E <= '1';
        when others => E <= '0';
        end case;
        
    end process proc_1;
end Behavioral;
