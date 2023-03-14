-- Lab Section: 203
-- Team Members: Raiyan Samin, Justin Lau
-- Lab Number: 18

library ieee;
use ieee.std_logic_1164.all;

entity hex_mux is 
port (
	hex_num1, hex_num0 : in std_logic_vector(3 downto 0);								-- The multiplexer inputs
	mux_select 										: in std_logic;							-- Multiplexer select input
	hex_out  										: out std_logic_vector(3 downto 0) 	-- The multiplexer output
);

end hex_mux;

architecture mux_logic of hex_mux is 

-- Here the circuit begins to make a functional 2-to-1 Multiplexer

begin 

	with mux_select select
	hex_out <= hex_num0 when'0',
				  hex_num1 when'1';

end mux_logic;