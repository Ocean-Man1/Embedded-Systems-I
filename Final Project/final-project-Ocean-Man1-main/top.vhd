library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;



entity top is 
Port ( 
        clk : in std_logic;        
        btn : in std_logic_vector(3 downto 0);
        
        --Audio Codec
        ac_bclk : in  std_logic;
        ac_pblrc : in  std_logic;
        ac_pbdat : in  std_logic;
        ac_recdat : in  std_logic;
        ac_reclrc : in  std_logic;

        --PMOD Outputs
        jb_p : in std_logic_vector(3 downto 0); -- ENC PMOD
        ja_p : out std_logic_vector(3 downto 0) --I2S PMOD
);
end top;

architecture Behavioral of top is

component i2s_receiver is
    Port ( ac_bclk     : in  std_logic;
           ac_pblrc    : in  std_logic;
           ac_pbdat    : in  std_logic;
           ac_recdat   : in  std_logic;
           ac_reclrc   : in  std_logic;
           sample   : out std_logic_vector(15 downto 0)
           );
end component;

component debounce is
port ( 
      clk   : in std_logic;
      btn   : in std_logic;
      dbnc  : out std_logic
);
end component;

--component tremolo is
--    port (
--        clk: in std_logic;
--        audio_input: in std_logic_vector(15 downto 0);
--        btn: in std_logic;
--        audio_out: out std_logic_vector(15 downto 0)
--    );
--end component; 

component fades is
    port (
        clk: in std_logic;
        audio_in: in std_logic_vector(15 downto 0);
        btn: in std_logic;
        audio_out: out std_logic_vector(15 downto 0)
    );
end component;

component swells is
    port (
        clk: in std_logic;
        audio_input: in std_logic_vector(15 downto 0);
        btn: in std_logic;
        audio_out: out std_logic_vector(15 downto 0)
    );
end component;

component pitch_shifter is
    Port (
        clk   : in  std_logic;
        reset : in  std_logic;
        swt : in std_logic;
        enc_a : in  std_logic;
        enc_b : in  std_logic;
        audio_input : in std_logic_vector(15 downto 0);
        audio_out : out std_logic_vector(15 downto 0)
    );
end component;

component i2s_transmit is
    Port (  clk : in std_logic;
            reset : in std_logic;
            audio_in : in std_logic_vector(15 downto 0);            
            LRCLK   : out std_logic;
            SCLK    : out std_logic;
            SD      : out std_logic
            );
end component;

-- END COMPONENTS 

    signal temp_dbnc : std_logic_vector(3 downto 0);
    signal temp_audio : std_logic_vector(15 downto 0);
    signal temp_out : std_logic_vector(15 downto 0);
    signal i2s_tx_in : std_logic_vector(15 downto 0);
    signal enc_btn : std_logic;

begin
             
    ja_p(0) <= clk;
    
-- PORT MAPPING

    i2s_receive: i2s_receiver port map(
           ac_bclk => ac_bclk,  
           ac_pblrc => ac_pblrc,
           ac_pbdat => ac_pbdat,
           ac_recdat => ac_recdat,
           ac_reclrc => ac_reclrc,
           sample => temp_audio
    );


    --TREMELO
--    u1: debounce port map(
--                clk => clk,
--                btn => btn(0),
--                dbnc => temp_dbnc(0)
--    );
    
--    d_tremolo: tremolo port map(
--                clk => clk,
--                audio_input => temp_audio,
--                btn => temp_dbnc(0),
--                audio_out => temp_out
--    );
    
    
    --FADES
    u2: debounce port map(
                clk => clk,
                btn => btn(1),
                dbnc => temp_dbnc(1)
    );
    
    d_fades: fades port map(
                clk => clk,
                audio_in => temp_audio,
                btn => temp_dbnc(1),
                audio_out => temp_out
    );


    --SWELLS
    u3: debounce port map(
                clk => clk,
                btn => btn(2),
                dbnc => temp_dbnc(2)
    );
    
    d_swells: swells port map(
                clk => clk,
                audio_input => temp_audio,
                btn => temp_dbnc(2),
                audio_out => temp_out
    );            
    
    --PITCH SHIFTER
    pitch_shift: pitch_shifter port map(
                clk => clk,
                reset => temp_dbnc(3),
                swt => jb_p(3),
                enc_a => jb_p(0),
                enc_b => jb_p(1),
                audio_input => temp_out,
                audio_out => i2s_tx_in
    );
   
    
    --RESET
    u4: debounce port map(
                clk => clk,
                btn => btn(3),
                dbnc => temp_dbnc(3)
    );    


    output: i2s_transmit port map(
                clk => clk,
                reset => temp_dbnc(3),
                audio_in => i2s_tx_in,            
                LRCLK => ja_p(1),
                SCLK => ja_p(2),
                SD => ja_p(3)
    );

end Behavioral;
