library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

entity ripple_tb is

end ripple_tb;

architecture Behavioral of ripple_tb is
    
    signal a,b,sum: std_logic_vector (3 downto 0) := "0000";
    signal c0,c4: std_logic := '0';
    
    component ripple_adder is port(
        a: in std_logic_vector (3 downto 0);
        b: in std_logic_vector (3 downto 0);
        c0: in std_logic;
        sum: out std_logic_vector (3 downto 0);
        c4: out std_logic
     );end component;


begin

    input_proc: process begin
        a <= std_logic_vector(unsigned(a) + 1);
        wait for 10 ns ;
        b <= std_logic_vector(unsigned(b) + 1);
        wait for 10 ns ;
        b <= std_logic_vector(unsigned(b) + 1);
        wait for 10 ns ;
        b <= std_logic_vector(unsigned(b) + 1);
        wait for 10 ns ;
        b <= std_logic_vector(unsigned(b) + 1);
        wait for 10 ns ;
        b <= std_logic_vector(unsigned(b) + 1);
        wait for 10 ns ;
        b <= std_logic_vector(unsigned(b) + 1);
        wait for 10 ns ;
        b <= std_logic_vector(unsigned(b) + 1);
        wait for 10 ns ;
        b <= std_logic_vector(unsigned(b) + 1);
        wait for 10 ns ;
        b <= std_logic_vector(unsigned(b) + 1);
        wait for 10 ns ;
        b <= std_logic_vector(unsigned(b) + 1);
        wait for 10 ns ;
        b <= std_logic_vector(unsigned(b) + 1);
        wait for 10 ns ;
        b <= std_logic_vector(unsigned(b) + 1);
        wait for 10 ns ;
        b <= std_logic_vector(unsigned(b) + 1);
        wait for 10 ns ;
        b <= std_logic_vector(unsigned(b) + 1);
        wait for 10 ns ;
        b <= std_logic_vector(unsigned(b) + 1);
        wait for 10 ns ;
        b <= std_logic_vector(unsigned(b) + 1);
    end process input_proc;

    du: ripple_adder port map(
        a => a,
        b => b,
        c0 => c0,
        sum => sum,
        c4 => c4
     );

end Behavioral;
