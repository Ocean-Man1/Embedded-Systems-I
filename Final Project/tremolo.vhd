library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;
use IEEE.MATH_REAL.all;

entity tremolo is
    port (
        clk: in std_logic;
        audio_input: in std_logic_vector(15 downto 0);
        btn: in std_logic;
        audio_out: out std_logic_vector(15 downto 0)
    );
end entity; 

architecture Behavioral of tremolo is

    signal cnt : std_logic_vector(23 downto 0) := (others => '0');
    signal depth: std_logic_vector(3 downto 0) := "1000"; -- depth = 50%
    signal sine: std_logic_vector(15 downto 0);
    signal real_cnt : real := 0.0; 
    
begin
    process (clk)
    begin
        if rising_edge(clk) then
            if btn = '1' then
                cnt <= std_logic_vector(unsigned(cnt) + 1 + unsigned(depth));
                if unsigned(cnt) >= 65536 then
                    cnt <= (others => '0');
                end if;
                real_cnt <= real(to_integer(unsigned(cnt))) / 65536.0;  -- Convert cnt to real
                sine <= std_logic_vector(to_unsigned(integer(sin(real_cnt * 2.0 * 3.14159 * 32767.0)), 16));
                audio_out <= std_logic_vector((signed(audio_input) * signed(sine)) / 32768);
            else
                audio_out <= audio_input;
                cnt <= (others => '0');
            end if;

        end if;
    end process;
end Behavioral;

