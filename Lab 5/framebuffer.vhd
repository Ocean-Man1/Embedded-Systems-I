library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity framebuffer is
  port (
    clk1, en1, en2, ld : in std_logic;
    addr1, addr2 : in std_logic_vector(11 downto 0);
    wr_en1 : in std_logic;
    din1 : in std_logic_vector(15 downto 0);
    dout1, dout2 : out std_logic_vector(15 downto 0)
  );
end framebuffer;

architecture behavioral of framebuffer is
  type mem_array is array (0 to 4095) of std_logic_vector(15 downto 0);
  signal memory : mem_array;
begin
  process(clk1)
  begin
    if rising_edge(clk1) then
      if ld = '1' then
        -- Load memory with data on rising edge of ld signal
        for i in 0 to 4095 loop
          memory(i) <= din1;
        end loop;
      elsif en1 = '1' then
        -- Read from memory port 1
        dout1 <= memory(to_integer(unsigned(addr1)));
      elsif en2 = '1' then
        -- Read from memory port 2
        dout2 <= memory(to_integer(unsigned(addr2)));
      end if;
      if wr_en1 = '1' then
        -- Write to memory port 1
        memory(to_integer(unsigned(addr1))) <= din1;
      end if;
    end if;
  end process;
end behavioral;
