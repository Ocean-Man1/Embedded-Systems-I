library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity image_top_tb is
--  Port ( );
end image_top_tb;

architecture Behavioral of image_top_tb is

signal tb_clk, vga_hs, vga_vs : std_logic;
signal vga_r,vga_b : std_logic_vector(4 downto 0);
signal vga_g : std_logic_vector(5 downto 0);

component image_top is
port (
        clk             : in std_logic;
        vga_r,vga_b     : out std_logic_vector(4 downto 0);
        vga_g           : out std_logic_vector(5 downto 0);
        vga_hs, vga_vs  : out std_logic    
);
end component;

begin

clk_gen_proc: process
begin
    wait for 4ns;
    tb_clk <= '1';
    wait for 4ns;
    tb_clk <= '0';
end process clk_gen_proc;

-- port mapping
du: image_top
port map(
    clk => tb_clk,
    vga_hs => vga_hs,
    vga_vs => vga_vs,
    vga_r => vga_r,
    vga_b => vga_b,
    vga_g => vga_g
);

end Behavioral;
