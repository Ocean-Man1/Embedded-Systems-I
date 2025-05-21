library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tremolo_tb is
end tremolo_tb;

architecture Behavioral of tremolo_tb is

    -- Component Declaration for the Unit Under Test (UUT)
    component tremolo is
        port (
            clk : in std_logic;
            audio_input : in std_logic_vector(15 downto 0);
            btn : in std_logic;
            audio_out : out std_logic_vector(15 downto 0)
        );
    end component;

    -- Clock period definitions
    constant clk_period : time := 10 ns;

    -- Test case signals
    signal clk : std_logic := '0';
    signal audio_input : std_logic_vector(15 downto 0) := (others => '0');
    signal btn : std_logic := '0';
    signal audio_out : std_logic_vector(15 downto 0);

begin

    -- Instantiate the Unit Under Test (UUT)
    dut: tremolo port map (
        clk => clk,
        audio_input => audio_input,
        btn => btn,
        audio_out => audio_out
    );

    -- Clock process definitions
    clk_process :process
    begin
        wait for 4 ns;
        clk <= '0';
        wait for 4 ns;        
        clk <= '1';
    end process;

    -- Stimulus process
    stim_proc: process
    begin
        wait for 20 ns;


        audio_input <= "0110011101100001";
        btn <= '1'; -- Enable the effect
        wait for 2 ms;
        btn <= '0';

        wait for 1 ms;


        audio_input <= "0001001100110101"; 
        btn <= '1';
        wait for 2 ms;

    end process;

end Behavioral;
