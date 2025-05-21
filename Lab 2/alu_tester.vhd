library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity alu_tester is
    Port ( 
            clk    : in std_logic;
            btn    : in std_logic_vector(3 downto 0);
            sw    : in std_logic_vector(3 downto 0);
            led    : out std_logic_vector(3 downto 0)
    );
end alu_tester;

architecture Behavioral of alu_tester is

    signal tempA,tempB  : std_logic_vector(3 downto 0);
    signal temp_opcode  : std_logic_vector(3 downto 0);
    signal temp_ALUout  : std_logic_vector(3 downto 0);
    signal temp_dbnc : std_logic_vector(3 downto 0);
    signal div  : std_logic;
    
    
    component debounce is
        Port ( 
          clk   : in std_logic;
          btn   : in std_logic;
          dbnc  : out std_logic
    );
    end component;

    component my_alu is
        Port(
            A : in std_logic_vector(3 downto 0);
            B : in std_logic_vector(3 downto 0);
            opcode: in std_logic_vector(3 downto 0);
            ALUout : out std_logic_vector(3 downto 0)
        );
    end component;
    
    component clock_div is
        Port(
              clk  : in std_logic;       -- 125 Mhz clock
              div : out std_logic        -- led, '1' = on
        );
    end component;        
    
    
begin

led <= temp_ALUout;

process(div)
begin
    
    if (rising_edge(div)) then
        if (temp_dbnc(2) = '1') then
            temp_opcode <= sw;
        elsif (temp_dbnc(1) = '1') then
            tempA <= sw;
        elsif (temp_dbnc(0) = '1') then
            tempB <= sw;
        elsif (temp_dbnc(3) = '1') then
            tempA <= (others => '0');
            tempB <= (others => '0');
            temp_opcode <= (others => '0');
        --elsif ((temp_dbnc(2) = '1') xor (temp_dbnc(1) = '1') xor (temp_dbnc(3) = '1')
        end if;
    end if;
end process;

-- port mapping

    clk_div: clock_div port map(
                clk => clk,
                div => div
    );

    u1: debounce port map(
                clk => clk,
                btn => btn(0),
                dbnc => temp_dbnc(0)
    );
    
    u2: debounce port map(
                clk => clk,
                btn => btn(1),
                dbnc => temp_dbnc(1)
    );
    
    u3: debounce port map(
                clk => clk,
                btn => btn(2),
                dbnc => temp_dbnc(2)
    );

    u4: debounce port map(
                clk => clk,
                btn => btn(3),
                dbnc => temp_dbnc(3)
    );

    ALU: my_alu port map(
                A => tempA,
                B => tempB,
                opcode => temp_opcode,
                ALUout => temp_ALUout
     );
                
                

end Behavioral;
