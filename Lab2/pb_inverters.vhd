-- Lab Section: 203
-- Team Members: Raiyan Samin, Justin Lau
-- Lab Number: 18

library ieee;
use ieee.std_logic_1164.all;

entity pb_inverters is
port (
	pb_n 		: in std_logic_vector(3 downto 0); -- inverter input
	pb 		: out std_logic_vector(3 downto 0) -- inverter output
	);
end pb_inverters;

architecture gates of pb_inverters is

-- The inputs are inverted with a not gate

begin

pb <= not(pb_n);

end gates;

