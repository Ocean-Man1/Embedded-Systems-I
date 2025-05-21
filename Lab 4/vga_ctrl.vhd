library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity vga_ctrl is
    Port ( 
        clk, en : in std_logic;
        hcount,vcount   : out std_logic_vector(9 downto 0) := (others => '0');
        vid, hs, vs     : out std_logic := '0'
);
end vga_ctrl;

architecture Behavioral of vga_ctrl is

    signal h_iter, v_iter : std_logic_vector(9 downto 0);

begin

proc: process(clk) 
begin

    if (rising_edge(clk)) then 
        if (en = '1') then
            if(unsigned(h_iter) < 799) then
                h_iter <= h_iter + 1;
            else
                h_iter <= (others => '0');
                if(unsigned(v_iter) < 524) then
                    v_iter <= v_iter + 1;    
                else
                    v_iter <= (others => '0');
                end if;
            end if;
    
            if ((unsigned(h_iter) < 640) and (unsigned(v_iter) < 480)) then
                vid <= '1';
            else
                vid <= '0';
            end if;
    
            if((unsigned(h_iter) >= 656) and (unsigned(h_iter) < 752)) then
                hs <= '0';
            else
                hs <= '1';
            end if;
            
            if(unsigned(v_iter) >= 490 and unsigned(v_iter) < 492) then
                vs <= '0';
            else 
                vs <= '1';
            end if;
            
            vcount <= v_iter;
            hcount <= h_iter;
        end if;
    end if;        
end process proc;

end Behavioral;
