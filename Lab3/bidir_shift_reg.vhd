library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity bidir_shift_reg is port
	( 
		clk				:in std_logic := '0';
		reset				:in std_logic := '0';
		clk_en			:in std_logic := '0';
		left0_right1	:in std_logic := '0';
		reg_bits			:out std_logic_vector(7 downto 0)
	);
end entity;

architecture one of bidir_shift_reg is

-- Signals
signal sreg			: std_logic_vector(7 downto 0);
	
begin

process(clk) is

begin 
	if (rising_edge(clk)) then							
	
		if (RESET = '1') then
			sreg <= "00000000";
		
		elsif (clk_en = '1') then 
		
			if (left0_right1 = '1') then
				sreg(7 downto 0) <= '1' & sreg(7 downto 1); -- right-shift of bits
			
			else 
				sreg(7 downto 0) <= sreg(6 downto 0) & '0'; -- left-shift of bits
			
			end if;
		
		end if;
		
	end if;
	
	reg_bits <= sreg;
	
end process; 

end one;
