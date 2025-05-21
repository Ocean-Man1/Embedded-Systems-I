library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity hw6_q2 is
    Port ( X1,X2,clk    : in std_logic;
            Y       : out std_logic_vector(1 downto 0);
            Z       : out std_logic
    );
end hw6_q2;

architecture Behavioral of hw6_q2 is

type state_type is (ST0,ST1,ST2);
attribute ENUM_ENCODING: STRING;
attribute ENUM_ENCODING of state_type: type is "01 10 11";
signal PS,NS : state_type;

begin
    sync: process(clk,NS)
    begin
        if(rising_edge(clk)) then
            PS <= NS;
        end if;
    end process sync;
   
    comb: process(clk,X1,X2)
    begin
        Z <= '0';
        case PS is
            when ST0 =>
                if X2 = '1' then
                    NS <= ST2;
                    Z <= '0';
                else 
                    NS <= ST1;
                    Z <= '1';
                end if;
            when ST1 => 
                if X1 = '1' then
                    NS <= ST0;
                    Z <= '0';
                else
                    NS <= ST1;
                    Z <= '0';
                end if;
            when ST2 =>
                if X2 = '1' then
                    NS <= ST2;
                    Z <= '0';
                else 
                    NS <= ST1;
                    Z <= '1';
                end if;  
            when others =>
                NS <= ST0;
                Z <= '1';                      
            end case;
      end process comb;
      
      with PS select
        Y <= "01" when ST0,
             "10" when ST1,
             "11" when ST2,
             "00" when others;        

end Behavioral;
