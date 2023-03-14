library ieee;
use ieee.std_logic_1164.all;

entity multiplexer is 
port (
	in0, in1 			: in std_logic_vector(3 downto 0);
	mux_select 			: in std_logic;
	mux_out  			: out std_logic_vector(3 downto 0)
);

end multiplexer;

architecture mux_logic of multiplexer is 

begin 

	with mux_select select
	mux_out <= in0 when'0',
				  in1 when'1';

end mux_logic;