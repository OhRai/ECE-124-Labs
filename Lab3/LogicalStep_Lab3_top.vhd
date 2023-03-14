library ieee;
use ieee.std_logic_1164.all;


entity LogicalStep_Lab3_top is port (
	clkin_50		: in 	std_logic;
	pb_n			: in	std_logic_vector(3 downto 0);
 	sw   			: in  std_logic_vector(7 downto 0); 	
	
	----------------------------------------------------
	--HVAC_temp : out std_logic_vector(3 downto 0); -- used for simulations only. Comment out for FPGA download compiles.
	----------------------------------------------------
	
   leds			: out std_logic_vector(7 downto 0);
   seg7_data 	: out std_logic_vector(6 downto 0); -- 7-bit outputs to a 7-segment
	seg7_char1  : out	std_logic;				    		-- seg7 digit1 selector
	seg7_char2  : out	std_logic				    		-- seg7 digit2 selector
	
); 
end LogicalStep_Lab3_top;

architecture design of LogicalStep_Lab3_top is
--
-- Provided Project Components Used
------------------------------------------------------------------- 

component SevenSegment  port (
   hex	   :  in  std_logic_vector(3 downto 0);   -- The 4 bit data to be displayed
   sevenseg :  out std_logic_vector(6 downto 0)    -- 7-bit outputs to a 7-segment
); 
end component SevenSegment;



component segment7_mux port (
          clk        : in  std_logic := '0';
			 DIN2 		: in  std_logic_vector(6 downto 0);	
			 DIN1 		: in  std_logic_vector(6 downto 0);
			 DOUT			: out	std_logic_vector(6 downto 0);
			 DIG2			: out	std_logic;
			 DIG1			: out	std_logic
        );
end component segment7_mux;
	
component Tester port (
	MC_TESTMODE				: in  std_logic;
	I1EQI2,I1GTI2,I1LTI2	: in	std_logic;
	input1					: in  std_logic_vector(3 downto 0);
	input2					: in  std_logic_vector(3 downto 0);
	TEST_PASS  				: out	std_logic							 
	); 
	end component;
----	
component HVAC 	port (
	HVAC_SIM					: in boolean;
	clk						: in std_logic; 
	run		   			: in std_logic;
	increase, decrease	: in std_logic;
	temp						: out std_logic_vector (3 downto 0)
	);
end component;
----------------------------------------------------------------
-- Add any Other Components here
------------------------------------------------------------------
component Compx4 is port (
	A, B					: in std_logic_vector (3 downto 0);
	AGTB, AEQB, ALTB	: out std_logic
	);
end component Compx4;

component bidir_shift_reg is port (
	clk				:in std_logic := '0';
	reset				:in std_logic := '0';
	clk_en			:in std_logic := '0';
	left0_right1	:in std_logic := '0';
	reg_bits			:out std_logic_vector(7 downto 0)
	);
end component Bidir_shift_reg;

component U_D_Bin_counter8bit is port
(
    clk         : in std_logic;
    reset       : in std_logic;
    clk_en      : in std_logic;
    up1_down0   : in std_logic;
    counter_bits: out std_logic_vector(7 downto 0)
);
end component;

component pb_inverters is port (
	pb_n 		: in std_logic_vector(3 downto 0); -- inverter input
	pb 		: out std_logic_vector(3 downto 0) -- inverter output
	);
end component;

component multiplexer is port (
	in0, in1 			: in std_logic_vector(3 downto 0);
	mux_select 			: in std_logic;
	mux_out  			: out std_logic_vector(3 downto 0)
);
end component;

component energy_monitor is port
	(
		GT, EQ, LT  :in std_logic;
		v_mode		:in std_logic;
		mc_mode		:in std_logic;
		w_open		:in std_logic;
		d_open		:in std_logic;		
		furnace :out std_logic;
		at_temp :out std_logic;
		AC :out std_logic;
		blower :out std_logic;
		window :out std_logic;
		door :out std_logic;
		vacation	:out std_logic;
		increase		:out std_logic;
		decrease		:out std_logic;
		run			:out std_logic
	);
end component;

------------------------------------------------------------------	
-- Create any additional internal signals to be used
------------------------------------------------------------------	
constant HVAC_SIM : boolean := FALSE; -- set to FALSE when compiling for FPGA download to LogicalStep board 
                                      -- or TRUE for doing simulations with the HVAC Component
------------------------------------------------------------------	

-- global clock
signal clk_in					: std_logic;
signal hex_A, hex_B 			: std_logic_vector(3 downto 0);
signal hexA_7seg, hexB_7seg: std_logic_vector(6 downto 0);

signal mux_temp : std_logic_vector(3 downto 0);

signal vacation_mode :std_logic;

signal desired_temp	: std_logic_vector(3 downto 0);
signal vacation_temp	: std_logic_vector(3 downto 0);

signal pb : std_logic_vector(3 downto 0);

signal current_temp : std_logic_vector(3 downto 0);

signal EQ : std_logic;
signal GT : std_logic;
signal LT : std_logic;
signal increase : std_logic;
signal decrease : std_logic;
signal run : std_logic;

------------------------------------------------------------------- 
begin -- Here the circuit begins

clk_in <= clkin_50;	--hook up the clock input

-- temp inputs hook-up to internal busses.
desired_temp <= sw(3 downto 0);
vacation_temp <= sw(7 downto 4);

vacation_mode <= pb(3);

inst1: sevensegment port map (mux_temp, hexA_7seg);
inst2: sevensegment port map (current_temp, hexB_7seg);
inst3: segment7_mux port map (clk_in, hexA_7seg, hexB_7seg, seg7_data, seg7_char2, seg7_char1);

inst4: multiplexer port map (desired_temp, vacation_temp, vacation_mode, mux_temp); 
inst5: pb_inverters port map (pb_n, pb);

inst6: HVAC port map (HVAC_SIM, clk_in, run, increase, decrease, current_temp);
inst7: Compx4 port map (mux_temp, current_temp, GT, EQ ,LT);

inst8: TESTER port map (pb(2), EQ, GT, LT, desired_temp, current_temp, leds(6)); 

inst9: energy_monitor port map (GT, EQ, LT, pb(3), pb(2), pb(1), pb(0), leds(0), leds(1), leds(2), leds(3), leds(4), leds(5), leds(7), increase, decrease, run);

--inst4: Compx4 port map (hex_A, hex_B, leds(2), leds(1), leds(0)); -- 4-bit Comparator
--inst5: bidir_shift_reg port map (clk_in, not(pb_n(0)), sw(0), sw(1), leds(7 downto 0)); -- 8 Bit Shift Register
--inst6: U_D_Bin_counter8bit port map (clk_in, not(pb_n(0)), sw(0), sw(1), leds(7 downto 0)); -- Counter
		
end design;

