library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;



entity fancy_counter is
    Port ( 
        clk : in std_logic;
        clk_en : in std_logic;
        dir : in std_logic;
        en : in std_logic;
        ld : in std_logic;
        rst : in std_logic;
        updn : in std_logic;
        val : in std_logic_vector(3 downto 0);
        cnt : out std_logic_vector(3 downto 0)
);
end fancy_counter;

architecture Behavioral of fancy_counter is

    signal value : std_logic_vector(3 downto 0) := (others => '0');
    signal count : std_logic_vector(3 downto 0) := (others => '0');
    signal direction: std_logic;

begin

process(clk)
    begin
    if(rising_edge(clk)) then
        if (en = '1') then
            if(clk_en = '1') then
                if(updn = '1') then
                    direction <= dir;
                 end if;
                 
                 if(ld = '1') then
                    value <= val;
                 end if;
                 
                 if(direction = '1') then
                    if(count = value) then
                        count <= (others => '0');
                    else
                        count <= std_logic_vector(unsigned(count) + 1);
                    end if;
                 else
                    if(unsigned(count) = 0) then
                        count <= value;
                    else
                        count <= std_logic_vector(unsigned(count) - 1);
                    end if;
                 end if;
            end if;
            
            if (rst = '1') then
                count <= (others => '0');
            end if;
            
        end if;
    end if;
end process;

cnt <= count;

end Behavioral;
