library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.MATH_REAL.ALL;

entity tb_pitch_shifter is
end tb_pitch_shifter;

architecture Behavioral of tb_pitch_shifter is

    -- component declaration for the unit under test (UUT)
    component pitch_shifter is
        Port (
            clk : in  std_logic;
            reset : in  std_logic;
            swt : in std_logic;
            enc_a : in  std_logic;
            enc_b : in  std_logic;
            audio_input : in  std_logic_vector(15 downto 0);
            audio_out : out std_logic_vector(15 downto 0)
        );
    end component;

    -- clock signal
    signal clk : std_logic := '0';

    -- signals for rotary encoder input
    signal swt : std_logic := '0';
    signal enc_a : std_logic := '0';
    signal enc_b : std_logic := '0';

    -- signals for audio input and output
    signal audio_input : std_logic_vector(15 downto 0) := (others => '0');
    signal audio_out : std_logic_vector(15 downto 0);

begin

    -- unit under test
    uut : pitch_shifter port map (
        clk => clk,
        reset => '0',
        swt => swt,
        enc_a => enc_a,
        enc_b => enc_b,
        audio_input => audio_input,
        audio_out => audio_out
    );

    -- clock generator
    clk_gen_proc: process
    begin
        clk <= '0';
        wait for 4 ns;
        clk <= '1';
        wait for 4 ns;
    end process clk_gen_proc;

    -- stimulus process
    process
    begin
        wait for 20 ns;
        swt <= '1';

        audio_input <= "0111111111111111";
        wait for 0.30 ms;

        -- Change Pitch
        enc_a <= '1';
        wait for 1 ms;
        enc_a <= '0';

 
        enc_b <= '1';
        wait for 1 ms;
        enc_b <= '0';

    end process;

end Behavioral;

