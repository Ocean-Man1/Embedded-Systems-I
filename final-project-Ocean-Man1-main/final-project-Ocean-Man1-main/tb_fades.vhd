library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity tb_fades is
end entity;

architecture Behavioral of tb_fades is

    signal clk: std_logic := '0';
    signal audio_in: std_logic_vector(15 downto 0) := (others => '0');
    signal btn: std_logic := '0';
    signal audio_out: std_logic_vector(15 downto 0) := (others => '0');
    
    component fades is
    port(
        clk: in std_logic;
        audio_in : in std_logic_vector(15 downto 0);
        btn: in std_logic;
        audio_out: out std_logic_vector(15 downto 0)
    );
    end component;

begin

    uut: fades port map (
            clk => clk,
            audio_in => audio_in,
            btn => btn,
            audio_out => audio_out
        );

    clk_process: process
    begin
        clk <= '0';
        wait for 4 ns;
        clk <= '1';
        wait for 4 ns;
    end process;

    stimulus_process: process
    begin
        wait for 10 ns;
        audio_in <= x"0100";
        wait for 200 ns;
        btn <= '1';
        
        wait for 2 ms;
        btn <= '0';
        wait for 1000 ps;

--        btn <= '1';
--        assert audio_out = x"FFFF"
--            report "Output should be xFFFF"
--            severity error;
--        wait for 1000 ns;
--        btn <= '0';
    end process;

end Behavioral;

