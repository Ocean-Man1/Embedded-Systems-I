library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity counter_top is
  Port ( 
        clk : in std_logic;
        btn : in std_logic_vector(3 downto 0);
        sw : in std_logic_vector(3 downto 0);
        led : out std_logic_vector(3 downto 0)
);
end counter_top;


architecture Behavioral of counter_top is

    component clock_div is
        Port( clk : in std_logic;
              div : out std_logic
        );
    end component;

    component debounce is
        Port ( 
          clk   : in std_logic;
          btn   : in std_logic;
          dbnc  : out std_logic
    );
    end component;
    
    component fancy_counter is
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
    end component;
    
    signal temp_en : std_logic;
    signal temp_ld : std_logic;
    signal temp_rst : std_logic;
    signal temp_updn : std_logic;
    signal temp_clk_en : std_logic;
    
  --  signal shit: std_logic_vector(3 downto 0);
    

begin

-- Port Mapping

    u1: debounce port map (
                 clk => clk, 
                 btn => btn(0), 
                 dbnc => temp_rst);
    
    u2: debounce port map (
                 clk => clk, 
                 btn => btn(1), 
                 dbnc => temp_en);
    
    u3: debounce port map (
                 clk => clk, 
                 btn => btn(2), 
                 dbnc => temp_updn);
    
    u4: debounce port map (
                 clk => clk, 
                 btn => btn(3), 
                 dbnc => temp_ld);
    
    u5: clock_div port map (
                 clk => clk, 
                 div => temp_clk_en);
    
    u6: fancy_counter port map (
                 clk => clk, 
                 clk_en => temp_clk_en,
                 dir => sw(0),
                 en => temp_en,
                 ld => temp_ld,
                 rst => temp_rst,
                 updn => temp_updn,
                 val => sw,
                 cnt => led);
                    
end Behavioral;
