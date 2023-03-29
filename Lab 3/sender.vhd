library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity sender is
port ( 
        clk, rst, en, btn   : in std_Logic;
        ready               : in std_logic;
        send                : out std_logic;
        char                : out std_logic_vector(7 downto 0)
);
end sender;

architecture Behavioral of sender is

type state_type is (idle, BusyA, BusyB, BusyC);
signal state : state_type := idle;

type ascii_vector is array (4 downto 0) of std_logic_vector(7 downto 0); -- is n-bit array of ASCII values
signal NETID : ascii_vector := ("00110011", "00110100", "01110000","01110110", "01101110");

signal i : std_logic_vector(2 downto 0) := (others => '0');

begin

proc: process(clk,rst)
begin
    if (rst = '1') then
        state <= idle;
        send <= '0';
        char <= (others => '0');
        i <= (others => '0');
    elsif (rising_edge(clk) and en = '1') then
        case state is
            when idle =>
                if (ready = '1' and btn = '1') then
                    if (unsigned(i) < 5) then
                        state <= BusyA;
                        send <= '1';
                        char <= NETID(TO_INTEGER(unsigned(i)));
                    else
                        i <= (others => '0');
                        state <= idle;
                    end if;    
                end if;
                
             when BusyA =>
                state <= BusyB;
                       
             when BusyB =>
                send <= '0';
                state <= BusyC;
             
             when BusyC =>
                if (ready = '1' and btn = '0') then
                    state <= idle;
                    i <= i + 1;
                end if;             
             end case;     
    end if;
end process proc;
end Behavioral;
