	-- Lab Section: 203
-- Team Members: Raiyan Samin, Justin Lau
-- Lab Number: 18

library ieee;
use ieee.std_logic_1164.all;

entity full_adder_1bit is 
port (
	input_a, input_b, carry_in 	: in std_logic; -- The full adder inputs
	f_sum_out, f_carry_out  		: out std_logic -- The full adder ouputs
);

end full_adder_1bit;

architecture gates of full_adder_1bit is

-- Signal and temporary variables used

	signal sum_out				: std_logic;	-- Signal to store the sum of a 1-bit addition
	signal carry_out			: std_logic;	-- Signal to store the carry of a 1-bit addition

-- Here the circuit begins to make a functional 1 bit adder

begin 

	sum_out <= input_a xor input_b;	
	carry_out <= input_a and input_b;
	
	f_sum_out <= sum_out xor carry_in;
	f_carry_out <= carry_out or (carry_in and sum_out);
	

end gates;