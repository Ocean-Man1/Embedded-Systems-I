library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity hw6_q13 is    
    Port ( 
            X1, X2, clk : in std_logic;
            Y           : out std_logic_vector(2 downto 0);
            CS, RD      : out std_logic
    );
end hw6_q13;

architecture Behavioral of hw6_q13 is

type state_type is (ST0,ST1,ST2);
attribute ENUM_ENCODING: STRING;
attribute ENUM_ENCODING of state_type: type is "001 010 100";
signal PS,NS : state_type;

begin
    sync: process(CLK,NS)
    begin
        if(rising_edge(clk)) then
            PS <= NS;
        end if;
    end process sync;
    
    comb : process(clk, X1, X2)
    begin
        CS <= '0';
        RD <= '0';
        case PS is
            when ST0 =>
                if X1 = '1' then
                    NS <= ST2;
                    CS <= '1';
                    RD <= '0';
                else
                    NS <= ST1;
                    CS <= '0';
                    RD <= '1';
                end if;
            when ST1 =>
                NS <= ST2;
                CS <= '1';
                RD <= '1';
            when ST2 =>
                if X2 = '1' then
                    NS <= ST2;
                    CS <= '0';
                    RD <= '1';
                else
                    NS <= ST0;
                    CS <= '0';
                    RD <= '0';
                end if;
            when others =>
                NS <= ST0;
                CS <= '0';
                RD <= '0';
            end case;
    end process comb;
    
    with PS select
        Y <= "001" when ST0,
             "010" when ST1,
             "100" when ST2,
             "000" when others;
    
end Behavioral;
