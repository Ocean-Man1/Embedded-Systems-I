library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity top_uart_tb is
--  Port ( );
end top_uart_tb;

architecture Behavioral of top_uart_tb is

    signal  clk  : std_logic := '0';
    signal  btn : std_logic_vector(1 downto 0) := "00";
    signal  txd, rxd, cts, rts : std_logic := '0';
   

component top_uart is
port(
        clk, TXD      : in std_logic;
        btn           : in std_logic_vector(1 downto 0);
        CTS, RTS, RXD : out std_logic 
);
end component;

begin
    txd <= rxd;
    clk_gen_proc: process
    begin
        wait for 4 ns;
        clk <= '1';
        wait for 4 ns;
        clk <= '0';
    end process clk_gen_proc;
    
    input_proc: process
    begin
        wait for 50 us;
        btn(1) <= '1';
        wait for 50 us;
        btn(1) <= '0';
    end process input_proc;
    
    reset_proc: process
    begin
        wait for 1700 us;
        btn(0) <= '1';
        wait for 300 us;
        btn(0) <= '0';
    end process reset_proc;
    
-- port mapping
    
    dut: top_uart
        port map(
            clk => clk,
            txd => txd,
            btn => btn,
            CTS => cts,
            RTS => rts,
            rxd => rxd
        );   

end Behavioral;
