library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity vga_ctrl_tb is
--  Port ( );
end vga_ctrl_tb;

architecture Behavioral of vga_ctrl_tb is

    signal tb_clk, tb_en : std_logic;
    signal tb_hcount,tb_vcount : std_logic_vector(9 downto 0);
    signal tb_vid, tb_hs, tb_vs : std_logic;

component vga_ctrl is
port(
        clk, en : in std_logic;
        hcount,vcount   : out std_logic_vector(9 downto 0);
        vid, hs, vs     : out std_logic
);
end component;

begin

clk_gen_proc: process
begin
    wait for 4 ns;
    tb_clk <= '1';
    wait for 4 ns;
    tb_clk <= '0';
end process clk_gen_proc;

en_proc: process
begin
    tb_en <= '1';
    wait for 4 ms;
    tb_en <= '0';
    wait for 10 ns;
end process en_proc;    

-- port mapping
dut: vga_ctrl
port map(
    clk => tb_clk,
    en => tb_en,
    hcount => tb_hcount,
    vcount => tb_vcount,
    vid => tb_vid,
    hs => tb_hs,
    vs => tb_vs
);

end Behavioral;
