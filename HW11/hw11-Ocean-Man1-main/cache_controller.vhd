library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity cache_controller is
	port (
		clk : in std_logic;  		--Clock
		clk_en : in std_logic; 		--Clock enable
		rst : in std_logic;			--Reset. Will clear the entire cache.

		-- The address whose contents the processor wants to fetch
		target_address : in std_logic_vector(13 downto 0);
		
		-- The data the processor wants, at the target_address.
		-- This gets hooked up to an input of the processor.
		data_out : out std_logic_vector(15 downto 0);
		
		-- The address whose contents the processor wants to fetch,
		-- if the cache doesn't contain this. This gets hooked up to the
		-- address port of the BRAM (or whatever your memory entity is).
		main_memory_address: out std_logic_vector(13 downto 0);
		
		-- This will be '1' if we are currently busy reading from main memory
		busy_reading : out std_logic;
		
		-- This will be a '1' if the data requested by the processor 
		-- (present on data_out) is ready for reception.
		data_ready : out std_logic
	);
end cache_controller;

architecture Behavioral of cache_controller is
   
    constant num_blocks : integer := 32; -- # of blocks in cache
    constant block_size : integer := 16; -- Size of each block in bytes (1 word = 2 bytes)
    constant block_address_bits : integer := 5; -- # of bits for block index

    -- record data type to represent cache block to store data
    type cache_block is record
        valid : std_logic; 
        tag : std_logic_vector(13 downto block_address_bits + 1);
        data : std_logic_vector(block_size - 1 downto 0);
    end record;

    type cache_array is array(0 to num_blocks - 1) of cache_block;

    signal cache : cache_array;
    signal block_index : std_logic_vector(block_address_bits - 1 downto 0);
    signal tag : std_logic_vector(13 downto block_address_bits + 1);
    signal data : std_logic_vector(block_size - 1 downto 0);
    signal hit : std_logic;
    signal main_memory_data_ready : std_logic;
    signal main_memory_data : std_logic_vector(block_size - 1 downto 0);

begin
    process(clk, rst)
    begin
        if rst = '1' then -- reset cache
            for i in 0 to num_blocks - 1 loop
                cache(i).valid <= '0';
            end loop;
        elsif rising_edge(clk) and clk_en = '1' then
            -- determine block index and tag from target address
            block_index <= target_address(block_address_bits + 1 downto 16);
            tag <= target_address(13 downto block_address_bits + 1);

            -- check requested data is in cache
            if cache(to_integer(unsigned(block_index))).valid = '1' and cache(to_integer(unsigned(block_index))).tag = tag then
                hit <= '1';
                data <= cache(to_integer(unsigned(block_index))).data;
            else
                -- miss => request data from main 
                hit <= '0';
                main_memory_address <= target_address;
            end if;

            if hit = '1' then
                data_out <= data;
                data_ready <= '1';
            elsif main_memory_data_ready = '1' then
                cache(to_integer(unsigned(block_index))).valid <= '1';
                cache(to_integer(unsigned(block_index))).tag <= tag;
                cache(to_integer(unsigned(block_index))).data <= main_memory_data;
                data_out <= main_memory_data;
                data_ready <= '1';
            else
                data_out <= (others => '0');
                data_ready <= '0';
            end if;
        end if;
    end process;

    busy_reading <= not main_memory_data_ready;

end Behavioral;


