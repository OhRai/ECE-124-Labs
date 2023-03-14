library ieee;
use ieee.std_logic_1164.all;

entity Compx1 is port (
	
	input_A, input_B 		: in std_logic;
	out_G, out_L, out_E  : out std_logic
	
	);
	
end Compx1;

architecture CompOp1 of Compx1 is

begin 

	out_G <= input_A and not(input_B);
	out_L <= not(input_A) and input_B;
	out_E <= input_A xnor input_B;

end CompOp1;
	