library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity swells is
    port (
        clk: in std_logic;
        audio_input: in std_logic_vector(15 downto 0);
        btn: in std_logic;
        audio_out: out std_logic_vector(15 downto 0)
    );
end entity;

architecture Behavioral of swells is

    signal cnt : std_logic_vector(23 downto 0) := (others => '0');
    signal swell_en : std_logic := '1';
    signal vol : std_logic_vector(15 downto 0) := (others => '0');
    signal inc : std_logic_vector(15 downto 0) := std_logic_vector(to_unsigned(10,16)); --set inc to 100
    
begin
    process (clk)
    begin
        if rising_edge(clk) then
            if btn = '1' then
                if swell_en = '1' then
                    cnt <= std_logic_vector(unsigned(cnt) + 1);
                    if unsigned(cnt) >= 64 then   --2^17 clock cycles to reach max volume of audio signal 
                        vol <= std_logic_vector(to_unsigned(32767, 16));
                        swell_en <= '0';
                    end if;
                else                   
                    cnt <= (others => '0');
                    swell_en <= '1';
                end if;
                if unsigned(vol) <= unsigned(audio_input) and swell_en = '1' then
                    vol <= std_logic_vector(unsigned(vol) + unsigned(inc));
                elsif unsigned(vol) > unsigned(audio_input) and swell_en = '0' then
                    vol <= std_logic_vector(unsigned(vol) - unsigned(inc));
                end if;
                audio_out <= std_logic_vector(vol(15 downto 0));
            else
                cnt <= (others => '0');
                vol <= (others => '0');
                swell_en <= '0';
                audio_out <= audio_input;
            end if;           
        end if;
    end process;
end Behavioral;
