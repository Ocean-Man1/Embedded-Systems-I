library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity tb_swells is
end tb_swells;

architecture Behavioral of tb_swells is
    component swells is
        port (
            clk: in std_logic;
            audio_input: in std_logic_vector(15 downto 0);
            btn: in std_logic;
            audio_out: out std_logic_vector(15 downto 0)
        );
    end component;

    signal clk : std_logic := '0';
    signal audio_input : std_logic_vector(15 downto 0) := (others => '0');
    signal btn : std_logic := '0';
    signal audio_out : std_logic_vector(15 downto 0);

   
begin
    dut: swells port map (
        clk => clk,
        audio_input => audio_input,
        btn => btn,
        audio_out => audio_out
    );

    clk_gen_proc: process
    begin
        clk <= '0';
        wait for 4 ns;
        clk <= '1';
        wait for 4 ns;
    end process clk_gen_proc;

    stimulus: process
    begin
        audio_input <= std_logic_vector(to_unsigned(256,16));
        wait for 100 us;
        btn <= '1';
        wait for 1.25 ms;
        btn <= '0';
        wait for 1.25 ms;
        btn <= '1';
        wait for 1.25 ms;
        btn <= '0';

    end process;

end Behavioral;
