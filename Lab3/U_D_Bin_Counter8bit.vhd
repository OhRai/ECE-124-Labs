library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity U_D_Bin_counter8bit is port
(
    clk         : in std_logic;
    reset       : in std_logic;
    clk_en      : in std_logic;
    up1_down0   : in std_logic;
    counter_bits: out std_logic_vector(7 downto 0)
);
end entity;

architecture one of U_D_Bin_Counter8bit is
    signal ud_bin_counter: unsigned(7 downto 0);
begin

process (clk) is
begin
    if (rising_edge(clk)) then
	 
        if (reset = '1') then
            ud_bin_counter <= "00000000";
				
        elsif (clk_en = '1') then 
		  
            if (up1_down0 = '1') then
                ud_bin_counter <= ud_bin_counter + 1;
					 
            else 
                ud_bin_counter <= ud_bin_counter - 1;
					 
            end if;
				
        end if;
		  
    end if;
	 
    counter_bits <= std_logic_vector(ud_bin_counter);
	 
end process;

end architecture;