library ieee;
use ieee.std_logic_1164.all;

entity energy_monitor is port
	(
		GT, EQ, LT	:in std_logic;
		v_mode		:in std_logic;
		mc_mode		:in std_logic;
		w_open		:in std_logic;
		d_open		:in std_logic;		
		furnace, at_temp, AC, window, door, vacation	:out std_logic;
		blower		:buffer std_logic;
		increase		:out std_logic;
		decrease		:out std_logic;
		run			:out std_logic
	);
	
end energy_monitor;


architecture one of energy_monitor is
begin
process (GT, EQ, LT, v_mode, mc_mode, w_open, d_open) is
begin 


	 
        if ((not (w_open = '1')) and (not (d_open = '1'))) then
            -- Activate run signal only if mc_mode is not ON
            if (not (mc_mode = '1')) then
                -- Activate run signal if the desired temperature is different than the current temperature
                if (((GT = '1') or (LT = '1'))) then
                    run <= '1';
                    -- Increase or decrease the temperature depending on the output of the comparator
                    if (GT = '1') then
                        increase <= '1';
                        decrease <= '0';
                    elsif (LT = '1') then
                        increase <= '0';
                        decrease <= '1';
                    end if;
                -- Deactivate run signal if the desired temperature is equal to the current temperature
                elsif (EQ = '1') then
                    run <= '0';
                    increase <= '0';
                    decrease <= '0';
                end if;
            -- Deactivate run signal if mc_mode is ON
            else
                run <= '0';
                increase <= '0';
                decrease <= '0';
            end if;
        -- Deactivate run signal if the window or door sensors are open
        else
            run <= '0';
            increase <= '0';
            decrease <= '0';
        end if;

end process;	  
		  
    -- LED indicators
    furnace <= '1' when (GT = '1') else '0';
    AC <= '1' when (LT = '1') else '0';
    at_temp <= '1' when ((EQ = '1') and (blower = '0')) else '0';
	 blower <= '1' when ((GT = '1' or LT = '1') and (not mc_mode = '1') and (not w_open = '1') and (not d_open = '1')) else '0';
    door <= d_open;
    vacation <= v_mode;
	 window <= w_open;
    
	
end architecture one;