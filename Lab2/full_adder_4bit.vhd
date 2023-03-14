-- Lab Section: 203
-- Team Members: Raiyan Samin, Justin Lau
-- Lab Number: 18

library ieee;
use ieee.std_logic_1164.all;

entity full_adder_4bit is 
port (
	BUS0 								: in std_logic_vector(3 downto 0);  -- Inputs for bits
	BUS1 								: in std_logic_vector(3 downto 0);
	carry_in 						: in std_logic; 						   -- Carry input
	sum								: out std_logic_vector(3 downto 0); -- The sum output
	carry_out3  					: out std_logic 							-- The carry output
);

end full_adder_4bit;


architecture gates of full_adder_4bit is

-- Signal and temporary variables used

	signal Carry_out2				: std_logic;	-- Intermediate carry signal 2 in the daisy chain of 4-bit adder
	signal Carry_out1				: std_logic;	-- Intermediate carry signal 1 in the daisy chain of 4-bit adder
	signal Carry_out0				: std_logic;	-- Intermediate carry signal 0 in the daisy chain of 4-bit adder
	
-- Using full_adder_1bit inputs and outputs
	
	component full_adder_1bit port (
		input_a					:	in std_logic;
		input_b					:	in std_logic;
		carry_in 				:  in std_logic;
		f_sum_out 			: out std_logic; 		-- The final sum output
		f_carry_out  		: out std_logic 		-- The final carry output
		); 
   end component;

-- Here the circuit begins to make a functional 4 bit adder 

begin 



	INST1: full_adder_1bit port map (BUS0(0), BUS1(0), carry_in, sum(0), Carry_out0); 	-- Instance of a 1-bit full adder with its carry output to the second instance and sum output to the 4-bit full adder
	INST2: full_adder_1bit port map (BUS0(1), BUS1(1), Carry_out0, sum(1), carry_out1); -- Instance of a 1-bit full adder with its carry output to the third instance and sum output to the 4-bit full adder
	INST3: full_adder_1bit port map (BUS0(2), BUS1(2), Carry_out1, sum(2), carry_out2); -- Instance of a 1-bit full adder with its carry output to the fourth instance and sum output to the 4-bit full adder
	INST4: full_adder_1bit port map (BUS0(3), BUS1(3), Carry_out2, sum(3), carry_out3); -- Fourth instance of a 1-bit full adder with its carry output to the 4-bit full adder carry out and sum output to the 4-bit full adder
	

end gates;