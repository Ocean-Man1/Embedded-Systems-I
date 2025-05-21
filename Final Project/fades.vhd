library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity fades is
    port (
        clk: in std_logic;
        audio_in: in std_logic_vector(15 downto 0);
        btn: in std_logic;
        audio_out: out std_logic_vector(15 downto 0)
    );
end entity;

architecture Behavioral of fades is
    signal cnt: unsigned(23 downto 0) := (others => '0');
    signal fade_in: std_logic_vector(15 downto 0) := (others => '0');
    signal fade_out: std_logic_vector(15 downto 0) := (others => '0');
    signal enable_fade_in: std_logic := '0';
    signal enable_fade_out: std_logic := '0';
begin
    process (clk)
    begin
        if rising_edge(clk) then
            if btn = '1' then
                enable_fade_in <= '1';
                enable_fade_out <= '0';
                cnt <= (others => '0');
                fade_out <= audio_in;
                if enable_fade_in = '1' then --if btn is held, start fade in
                    if  unsigned(cnt) < 32767 then
                        cnt <= cnt + 1;
                        fade_in <= std_logic_vector(resize(unsigned(audio_in) * cnt / 32768,16)); --gradually scale up from silence (when "cnt"=0) to full volume (when "cnt"=32767) over time
                        audio_out <= fade_in;
                    else
                        enable_fade_in <= '0';
                    end if;
                elsif enable_fade_out = '1' then    --now enable fade out
                    if unsigned(cnt) < 32767 then
                        cnt <= cnt + 1;
                        fade_out <= std_logic_vector(resize(unsigned(audio_in) * (to_unsigned(32767, 24) - cnt) / 32768,16));
                        audio_out <= fade_out;
                    else
                        enable_fade_out <= '0';
                    end if;
                end if;
              else    --btn = 0, normal audio
                    audio_out <= audio_in;
              end if;
        end if;
    end process;
end Behavioral;