library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity my_alu is
    Port ( 
            A : in std_logic_vector(15 downto 0);
            B : in std_logic_vector(15 downto 0);
            opcode: in std_logic_vector(3 downto 0);
            ALUout : out std_logic_vector(15 downto 0)
    );
end my_alu;

architecture Behavioral of my_alu is

begin
    opcode_proc: process(opcode)
    begin  
        case(opcode) is
            when "0000" => ALUout <= std_logic_vector(unsigned(A) + unsigned(B));
            when "0001" => ALUout <= std_logic_vector(unsigned(A) + unsigned(B));
            when "0010" => ALUout <= std_logic_vector(unsigned(A) + 1);
            when "0011" => ALUout <= std_logic_vector(unsigned(A) - 1);
            when "0100" => ALUout <= std_logic_vector(0 - unsigned(A));
            when "0101" => 
            if A > B then
                ALUout <= std_logic_vector(to_signed(1, 16));
            else
                ALUout <= std_logic_vector(to_signed(0, 16));
            end if;
            when "0110" => ALUout <=  std_logic_vector(shift_left(unsigned(A),1));
            when "1001" => ALUout <= NOT A;
            when "1010" => ALUout <= A AND B;
            when "1011" => ALUout <= A OR B;
            when "1100" => ALUout <= A XOR B;
            when "1101" => ALUout <= A XNOR B;
            when "1110" => ALUout <= A NAND B;
            when "1111" => ALUout <= A NOR B;
            when others => ALUout <= std_logic_vector(to_signed(0, 16));
        end case;
    end process opcode_proc;
end Behavioral;
