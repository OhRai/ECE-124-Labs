library ieee;
use ieee.std_logic_1164.all;

entity Compx4 is port (
	
	A, B						: in std_logic_vector (3 downto 0);
	AGTB, AEQB, ALTB   	: out std_logic
	
	);
	
end Compx4;

architecture CompOp4 of Compx4 is

-- Single Bit comparator
component Compx1 port (
		
	input_A, input_B 		: in std_logic;
	out_G, out_L, out_E  : out std_logic
	
	);
	
end component Compx1;

-- Signals

-- A > B
signal A0GTB0	: std_logic;
signal A1GTB1	: std_logic;
signal A2GTB2	: std_logic;
signal A3GTB3	: std_logic;

-- A < B
signal A0LTB0	: std_logic;
signal A1LTB1	: std_logic;
signal A2LTB2	: std_logic;
signal A3LTB3	: std_logic;

-- A = B
signal A0EQB0	: std_logic;
signal A1EQB1	: std_logic;
signal A2EQB2	: std_logic;
signal A3EQB3	: std_logic;

begin 

inst1: Compx1 port map (A(0), B(0), A0GTB0, A0LTB0, A0EQB0);
inst2: Compx1 port map (A(1), B(1), A1GTB1, A1LTB1, A1EQB1);
inst3: Compx1 port map (A(2), B(2), A2GTB2, A2LTB2, A2EQB2);
inst4: Compx1 port map (A(3), B(3), A3GTB3, A3LTB3, A3EQB3);

AGTB <= A3GTB3 or ((A3EQB3 and A2GTB2) or (A3EQB3 and A2EQB2 and A1GTB1) or (A3EQB3 and A2EQB2 and A1EQB1 and A0GTB0));
AEQB <= A3EQB3 and (A2EQB2 and A1EQB1 and A0EQB0);
ALTB <= A3LTB3 or ((A3EQB3 and A2LTB2) or (A3EQB3 and A2EQB2 and A1LTB1) or (A3EQB3 and A2EQB2 and A1EQB1 and A0LTB0));


end CompOp4;

