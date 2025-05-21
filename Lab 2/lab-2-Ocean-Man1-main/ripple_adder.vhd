library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ripple_adder is port(
    a: in std_logic_vector (3 downto 0);
    b: in std_logic_vector (3 downto 0);
    c0: in std_logic;
    sum: out std_logic_vector (3 downto 0);
    c4: out std_logic
);end ripple_adder;



architecture Behavioral of ripple_adder is
    component adder is port(
        a :in std_logic;
        b :in std_logic;
        c :in std_logic;
        sum: out std_logic;
        co: out std_logic
    );end component;
    
    signal c1,c2,c3: std_logic;
    
    begin
        a1: adder port map(
            a=>a(0),
            b=>b(0),
            c=>c0,
            sum=>sum(0),
            co=>c1
        );
        
        a2: adder port map(
            a=>a(1),
            b=>b(1),
            c=>c1,
            sum=>sum(1),
            co=>c2
        );
        
        a3: adder port map(
            a=>a(2),
            b=>b(2),
            c=>c2,
            sum=>sum(2),
            co=>c3
        );
        
        a4: adder port map(
            a=>a(3),
            b=>b(3),
            c=>c3,
            sum=>sum(3),
            co=>c4
        );

end Behavioral;
