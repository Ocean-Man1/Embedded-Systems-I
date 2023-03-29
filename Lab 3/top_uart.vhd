library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity top_uart is
Port ( 
        clk, TXD      : in std_logic;
        btn           : in std_logic_vector(1 downto 0);
        CTS, RTS, RXD : out std_logic 
);
end top_uart;

architecture Behavioral of top_uart is

signal div                     : std_logic := '0';
signal temp_dbnc               : std_logic_vector(1 downto 0) := (others => '0');
signal temp_rdy, temp_send     : std_logic := '0';
signal temp_char               : std_logic_vector(7 downto 0) := (others => '0');
signal fake_sig1               : std_logic := '0';
signal fake_sig2               : std_logic_vector(7 downto 0) := (others => '0');

component debounce is
port ( 
      clk   : in std_logic;
      btn   : in std_logic;
      dbnc  : out std_logic
);
end component;

component clock_div is
port(
          clk  : in std_logic;       -- 125 Mhz clock
          div : out std_logic        -- led, '1' = on
    );
end component;  

component uart is
port(
        clk, en, send, rx, rst      : in std_logic;
        charSend                    : in std_logic_vector (7 downto 0);
        ready, tx, newChar          : out std_logic;
        charRec                     : out std_logic_vector (7 downto 0)
);
end component;

component sender is
port( 
        clk, rst, en, btn   : in std_Logic;
        ready               : in std_logic;
        send                : out std_logic;
        char                : out std_logic_vector(7 downto 0)
);
end component;


begin

CTS <= '0';
RTS <= '0';

-- port mapping

    clk_div: clock_div port map(
                clk => clk,
                div => div
    );

    u1: debounce port map(
                clk => clk,
                btn => btn(0),
                dbnc => temp_dbnc(0)
    );
    
    u2: debounce port map(
                clk => clk,
                btn => btn(1),
                dbnc => temp_dbnc(1)
    );
    
    u3: sender port map(
                clk => clk,
                rst => temp_dbnc(0),
                en => div,
                btn => temp_dbnc(1),   
                ready => temp_rdy,               
                send => temp_send,              
                char => temp_char              
    );
    
    u4: uart port map(
                clk => clk,
                en => div,
                send => temp_send,
                rx => TXD,
                rst => temp_dbnc(0),
                charSend => temp_char,                  
                ready => temp_rdy,
                tx => RXD,
                newChar => fake_sig1,         
                charRec => fake_sig2                   
    );
    
end Behavioral;
