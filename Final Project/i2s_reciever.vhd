library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity i2s_receiver is
    Port ( ac_bclk     : in  std_logic;
           ac_pblrc    : in  std_logic;
           ac_pbdat    : in  std_logic;
           ac_recdat   : in  std_logic;
           ac_reclrc   : in  std_logic;
           sample   : out std_logic_vector(15 downto 0)
           );
end i2s_receiver;

architecture Behavioral of i2s_receiver is

    type state is (idle, bclk_edge, pblrc_edge, data_ready);
    signal NS : state;
    signal CS : state := idle;
    
    signal counter : std_logic_vector(3 downto 0) := (others => '0');
    signal data_reg : std_logic_vector(15 downto 0);
    
begin

    process (ac_bclk, ac_pblrc, ac_pbdat, ac_recdat, ac_reclrc)
    begin
        CS <= NS;

        case CS is
            when idle =>
                if ac_pblrc = '1' then
                    NS <= bclk_edge;
                    counter <= (others => '0');
                else
                    NS <= idle;
                end if;

            when bclk_edge =>
                if ac_bclk = '1' then
                    NS <= bclk_edge;
                else
                    NS <= pblrc_edge;
                end if;

            when pblrc_edge =>
                if ac_pblrc = '0' then
                    NS <= pblrc_edge;
                else
                    NS <= data_ready;
                    data_reg <= std_logic_vector(to_unsigned(0, 16));
                    counter <= (others => '0');
                end if;

            when data_ready =>
                if ac_pblrc = '0' then
                    NS <= bclk_edge;
                    sample <= std_logic_vector(data_reg);
                else
                    NS <= data_ready;
                    data_reg(to_integer(unsigned(counter))) <= ac_recdat;
                    counter <= std_logic_vector(unsigned(counter) + 1);
                end if;

        end case;
    end process;

end Behavioral;