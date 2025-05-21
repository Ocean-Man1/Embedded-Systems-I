library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity i2s_transmit is
    Port (  clk : in std_logic;
            reset : in std_logic;
            audio_in : in std_logic_vector(15 downto 0);            
            LRCLK : out std_logic;
            SCLK : out std_logic;
            SD : out std_logic
            );
end i2s_transmit;

architecture Behavioral of i2s_transmit is

    type state is (reset_state, load_word, transmit);
    signal CS : state := reset_state;

    signal temp_audio : std_logic_vector(15 downto 0) := (others => '0');
    signal temp_lrclk : std_logic := '1';
    signal temp_sd : std_logic := '0';
    signal enable : std_logic := '0';
    signal counter : std_logic_vector(6 downto 0) := (others => '0');

begin

    process(clk)

    begin
        if(reset = '0') then
            CS <= reset_state;        
        elsif rising_edge(clk) then
            case CS is
                when reset_state =>
                    temp_lrclk <= '1';
                    enable <= '1';
                    temp_sd <= '0';
                    temp_audio <= (others => '0');
                    CS <= load_word;
                when load_word =>
                    counter <= (others => '0');
                    temp_audio <= audio_in;
                    temp_lrclk <= '0';
                    CS <= transmit;
                when transmit=>
                    counter <= std_logic_vector(unsigned(counter) + 1);
                    if(unsigned(counter) > 15) then
                        temp_lrclk <= '1';
                    end if;
                    if(unsigned(counter) < 31) then    
                        CS <= transmit;
                    else
    
                        CS <= load_word;
                    end if;
                    temp_audio <= temp_audio(14 downto 0) & "0";
                    temp_sd <= temp_audio(15 - 1);
            end case;
        end if;
    end process;
    SCLK <= clk and enable;
    LRCLK <= temp_lrclk;
    SD <= temp_sd;
end Behavioral;