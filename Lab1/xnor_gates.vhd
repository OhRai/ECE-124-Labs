LIBRARY ieee;
USE ieee.std_logic_1164.all;
LIBRARY work;
ENTITY VHDL_POL IS
	PORT(
			POLARITY_CNTRL, IN_1, IN_2, IN_3, IN_4:IN STD_LOGIC;
			OUT_1, OUT_2, OUT_3, OUT_4:OUT STD_LOGIC
			);
END VHDL_POL;

ARCHITECTURE xnor_gates OF VHDL_POL IS
BEGIN

OUT_1 <= IN_1 XNOR POLARITY_CNTRL;
OUT_2 <= IN_2 XNOR POLARITY_CNTRL;
OUT_3 <= IN_3 XNOR POLARITY_CNTRL;
OUT_4 <= IN_4 XNOR POLARITY_CNTRL;

END xnor_gates;