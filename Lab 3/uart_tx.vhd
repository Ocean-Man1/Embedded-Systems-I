library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity uart_tx is
Port ( 
        clk, en, send, rst : in std_logic;
        char               : in std_logic_vector(7 downto 0);
        ready, tx          : out std_logic
    );
end uart_tx;

architecture Behavioral of uart_tx is

type state_type is (idle, data);
signal state: state_type:= idle;
signal count: std_logic_vector(3 downto 0) := (others => '0');
signal shift: std_logic_vector(7 downto 0) := (others => '0');
signal lsb: std_logic := '0';    

begin

    proc: process(clk) begin
        if(rising_edge(clk)) then
            if(rst = '1') then
                state <= idle;
                count <= (others => '0');
                shift <= (others => '0');
            elsif(en = '1') then
                case state is
                    when idle => 
                        if(send = '0') then
                            state <= idle;
                        else
                            state <= data;
                            lsb <= '0';         -- "start bit"
                            shift <= char;
                        end if;
                    when data => 
                        if(count = "1000") then     --when all bits sent
                            lsb <= '1';             --lsb => 1 (stop bit)
                            count <= count + "1";
                        elsif(count = "1001") then
                            state <= idle;
                            count <= (others => '0');
                        else
                            count <= count + "1";
                            lsb <= shift(0);        --send lsb first       
                            shift <= std_logic_vector(shift_right(unsigned(shift),1));
                        end if;
                end case;
            end if;
        end if; 
    end process proc; 
    
    ready <= '1' when state=idle else '0';
    tx <= '1' when(state = idle) else lsb; 

end Behavioral;