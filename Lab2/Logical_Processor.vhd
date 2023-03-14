-- Lab Section: 203
-- Team Members: Raiyan Samin, Justin Lau
-- Lab Number: 18

library ieee;
use ieee.std_logic_1164.all;

entity Logical_Processor is 
port (
	logic_in0, logic_in1 						: in std_logic_vector(3 downto 0); 	-- Logical Processor inputs
	logic_select 									: in std_logic_vector(1 downto 0);  -- Selector input
	logic_out  										: out std_logic_vector(3 downto 0) 	-- Logical Processor output
);

end Logical_Processor;

architecture logic_gates of Logical_Processor is 

-- Here the circuit begins to make a functional logical processor

begin 

	with logic_select(1 downto 0) select
	logic_out <= (logic_in0 and logic_in1) when"00", 
				  (logic_in0 or logic_in1) when"01",
				  (logic_in0 xor logic_in1) when"10",
				  (logic_in0 xnor logic_in1) when"11";

end logic_gates;