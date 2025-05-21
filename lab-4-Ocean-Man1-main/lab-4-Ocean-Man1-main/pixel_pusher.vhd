library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity pixel_pusher is
Port ( 
        clk, en, vs, vid    : in std_logic;
        pixel           : in std_logic_vector(7 downto 0);
        hcount          : in std_logic_vector(9 downto 0);
        r, b            : out std_logic_vector(4 downto 0);
        g               : out std_logic_vector(5 downto 0);
        addr            : out std_logic_vector(17 downto 0)
);
end pixel_pusher;

architecture Behavioral of pixel_pusher is

    signal temp_addr : std_logic_vector(17 downto 0);

begin

addr <= temp_addr;

addr_proc: process(clk,en,vs)
begin
    if (rising_edge(clk)) then
        if(vs = '0') then
            temp_addr <= (others => '0');
        end if;
        
          -- should en be in this conditional???
        if (vid = '1' and unsigned(hcount) < 480 and en = '1') then
            temp_addr <= temp_addr + 1;
            r <= pixel(7 downto 5) & "00";
            g <= pixel(4 downto 2) & "000";
            b <= pixel(1 downto 0) & "000";
        else
            r <= (others => '0');
            g <= (others => '0');
            b <= (others => '0'); 
        end if;
    end if;
    
end process addr_proc;

end Behavioral;
