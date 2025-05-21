library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity pitch_shifter is
    Port (
        clk   : in  std_logic;
        reset : in  std_logic;
        swt : in std_logic;
        enc_a : in  std_logic;
        enc_b : in  std_logic;
        audio_input : in  std_logic_vector(15 downto 0);
        audio_out : out std_logic_vector(15 downto 0)
    );
end pitch_shifter;

architecture Behavioral of pitch_shifter is

    signal speed_factor : std_logic_vector(31 downto 0) := x"00000001";
    signal enc_a_last : std_logic := '0';
    signal enc_b_last : std_logic := '0';
    signal pitch_factor : std_logic_vector(31 downto 0) := x"00000000";

begin

    process(clk, reset)
    begin
        if reset = '1' then
            speed_factor <= x"00000001";
            enc_a_last <= '0';
            enc_b_last <= '0';
            pitch_factor <= x"00000000";
            audio_out <= audio_input;
        elsif rising_edge(clk) then
            -- read rotary encoder input
            if swt = '1' then
                if enc_a = '1' and enc_a_last = '0' then
                    if enc_b = '1' then
                        speed_factor <= std_logic_vector(unsigned(speed_factor) + 1);
                    else
                        speed_factor <= std_logic_vector(unsigned(speed_factor) - 1);
                    end if;
                end if;
                enc_a_last <= enc_a;
                enc_b_last <= enc_b;
    
                -- calculate pitch factor based on speed factor
                pitch_factor <= std_logic_vector(shift_left(resize(signed(speed_factor), 32), 15));
    
                -- apply pitch shifting to audio samples
                audio_out <= std_logic_vector(resize(unsigned(audio_input) * unsigned(pitch_factor),16));
           else
                audio_out <= audio_input;
           end if;
        end if;
    end process;

end Behavioral;
