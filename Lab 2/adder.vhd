library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity adder is port(
    a :in std_logic; --std_logic_vector
    b :in std_logic;
    c :in std_logic;
    sum: out std_logic;
    co: out std_logic
);end adder;

architecture Behavioral of adder is
    signal sig: std_logic;
    begin
       sig <= a xor b;
       sum <= sig xor c;
       co <= (b and a) or (c and sig); 
    
end Behavioral;