Library IEEE;
USE IEEE.Std_logic_1164.all;
-- fpga4student.com 
-- FPGA projects, VHDL projects, Verilog projects 
-- VHDL code for full adder 
-- Testbench code of the structural code for full adder 
entity Testbench_structural_adder is
end Testbench_structural_adder;
 
architecture  behavioral of Testbench_structural_adder is
 component Full_Adder_Structural_VHDL 
   port( 
  X1, X2, Cin : in std_logic;  
  S, Cout : out std_logic
  );  
 end component; 
 signal A,B,Cin: std_logic:='0';
 signal S,Cout: std_logic;
begin   
 structural_adder: Full_Adder_Structural_VHDL port map 
   (
    X1 => A,
    X2 => B,
    Cin => Cin,
    S => S,
    Cout => Cout 
   );
  process
  begin
   A <= '0';
   B <= '0';
   Cin <= '0';
   wait for 100 ns;
   A <= '0';
   B <= '0';
   Cin <= '1';
   wait for 100 ns;   
   A <= '0';
   B <= '1';
   Cin <= '0';
   wait for 100 ns;
   A <= '0';
   B <= '1';
   Cin <= '1';
   wait for 100 ns;
   A <= '1';
   B <= '0';
   Cin <= '0';
   wait for 100 ns;
   A <= '1';
   B <= '0';
   Cin <= '1';
   wait for 100 ns;
   A <= '1';
   B <= '1';
   Cin <= '0';
   wait for 100 ns;   
   A <= '1';
   B <= '1';
   Cin <= '1';
   wait for 100 ns;   
  end process;
      
end behavioral; 
