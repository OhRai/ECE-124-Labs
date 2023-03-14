-- Lab Section: 203
-- Team Members: Raiyan Samin, Justin Lau
-- Lab Number: 18S

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity LogicalStep_Lab2_top is port (
   clkin_50			: in	std_logic;
	pb_n				: in	std_logic_vector(3 downto 0);
 	sw   				: in  std_logic_vector(7 downto 0); -- The switch inputs
   leds				: out std_logic_vector(7 downto 0); -- for displaying the switch content
   seg7_data 		: out std_logic_vector(6 downto 0); -- 7-bit outputs to a 7-segment
	seg7_char1  	: out	std_logic;				    		-- seg7 digit1 selector
	seg7_char2  	: out	std_logic				    		-- seg7 digit2 selector
	
); 
end LogicalStep_Lab2_top;

architecture SimpleCircuit of LogicalStep_Lab2_top is
--
-- Components Used ---
------------------------------------------------------------------- 
  component SevenSegment port (
   hex   		:  in  std_logic_vector(3 downto 0);   -- The 4 bit data to be displayed
   sevenseg 	:  out std_logic_vector(6 downto 0)    -- 7-bit outputs to a 7-segment
   ); 
   end component;
	
	component hex_mux port (
   hex_num0				: in std_logic_vector(3 downto 0); -- The multiplexer input
	hex_num1 			: in std_logic_vector(3 downto 0); -- The multiplexer input
	mux_select 			: in std_logic;						  -- Multiplexer select input
	hex_out  			: out std_logic_vector(3 downto 0) -- The multiplexer output
   ); 
   end component;
	
	component segment7_mux port (
		clk 							: in std_logic := '0';
		DIN2							: in std_logic_vector(6 downto 0);
		DIN1							: in std_logic_vector(6 downto 0);
		DOUT							: out std_logic_vector(6 downto 0);
		DIG2							: out std_logic;
		DIG1							: out std_logic
	);
	end component;
	
	component PB_Inverters port(
		pb_n 							: IN std_logic_vector(3 downto 0); -- PB inverters input
		pb 							: OUT std_logic_vector(3 downto 0) -- PB inverters output
	
	);
	end component;
	
	component logical_processor port(
		logic_in0					: in std_logic_vector(3 downto 0); -- Logical Processor input
		logic_in1 					: in std_logic_vector(3 downto 0); -- Logical Processor input
		logic_select 				: in std_logic_vector(1 downto 0); -- Selector input
		logic_out  					: out std_logic_vector(3 downto 0) -- Logical Processor output
	);
	end component;
	
	component full_adder_4bit port (
	BUS0 								: in std_logic_vector(3 downto 0);  -- Full adder input
	BUS1 								: in std_logic_vector(3 downto 0);  -- Full adder input
	carry_in 						: in std_logic; 						   -- Full adder carry input
	sum								: out std_logic_vector(3 downto 0); -- Full adder sum output
	carry_out3  					: out std_logic 							-- Full adder carry output
	);
	end component;
	
	
--  Signals and temporary variables to be used
--
--  std_logic_vector is a signal which can be used for logic operations such as OR, AND, NOT, XOR
--
	signal seg7_A			: std_logic_vector(6 downto 0);	-- Signal to store the 7-segment display value based on the 4-bit inputs from switches
	signal hex_A		 	: std_logic_vector(3 downto 0);  -- Signal to store the hexadecimal value based on the switch inputs
	
	signal seg7_B		 	: std_logic_vector(6 downto 0);	-- Signal to store the 7-segment display value based on the 4-bit inputs from switches
	signal hex_B			: std_logic_vector(3 downto 0);	-- Signal to store the hexadecimal value based on the switch inputs
	
	signal pb 				: std_logic_vector(3 downto 0);	-- Signal to store the inverted output of the pb_inverters
	
	signal hex_sum		 	: std_logic_vector(3 downto 0);	-- Signal to store the sum output of the 4-bit full adder
	signal hex_carry	 	: std_logic;							-- Signal to store the carry output of the hexadecimal multiplexer
 	
	signal signal_C    	: std_logic_vector(3 downto 0);	-- Signal to store the concatenated 4-bit full adder carry out signal with 000 to make it 4 bits	
	
	signal hex_sum_out 	: std_logic_vector(3 downto 0);	-- Signal to store output of the multiplexer representing the sum
	signal hex_carry_out : std_logic_vector(3 downto 0);  -- Signal to store output of the multiplexer representing the carry
	
	
	
	
-- Here the circuit begins

begin

	hex_A <= sw(3 downto 0);
	hex_B <= sw(7 downto 4);
	signal_C <= "000" & hex_carry;
	
	INST1: full_adder_4bit port map(hex_A, hex_B, '0', hex_sum, hex_carry); 						 -- 4 Bit Full Adder
	INST2: hex_mux port map(hex_A, hex_sum, pb(2), hex_sum_out);										 -- 2-to-1 Multiplexer for hex_A and sum output
	INST3: hex_mux port map (hex_B, signal_C, pb(2), hex_carry_out);									 -- 2-to-1 Multiplexer for hex_B and carry output (concatenated) 
	INST4: SevenSegment port map(hex_sum_out, seg7_A);														 -- Seven Segment Decoder for seg7_A
	INST5: SevenSegment port map(hex_carry_out, seg7_B);	 												 -- Seven Segment Decoder for seg7_B
	INST6: segment7_mux port map(clkin_50, seg7_A, seg7_B, seg7_data, seg7_char2, seg7_char1); -- Seven Segment Multiplexer
	
	INST7: pb_inverters port map(pb_n(3 downto 0), pb(3 downto 0));									 -- PB Inverters
	
	INST8: logical_processor port map(hex_A, hex_B, pb(1 downto 0), leds(3 downto 0));			 -- Logical Processor
 
end SimpleCircuit;

