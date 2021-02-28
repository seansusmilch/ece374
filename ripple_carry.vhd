
---- this is a 4-bit ripple_carry adder circuit -----------

LIBRARY ieee;
USE ieee.std_logic_1164.all ;
USE work.components.all;

ENTITY ripple_carry IS
	PORT ( Cin: IN STD_LOGIC;
			x,y : IN STD_LOGIC_VECTOR(3 downto 0);
			s : OUT STD_LOGIC_VECTOR(3 downto 0);
			Cout : OUT STD_LOGIC );
END ripple_carry ;

ARCHITECTURE struc_behaviour OF ripple_carry IS
	signal carry : std_logic_vector(3 downto 1);
	signal y0,y1,y2,y3 : std_logic;

BEGIN

	y0 <= y(0) XOR Cin;
	y1 <= y(1) XOR Cin;
	y2 <= y(2) XOR Cin;
	y3 <= y(3) XOR Cin;
	
	stage1 : fulladd PORT MAP (Cin, x(0), y0, s(0), carry(1));
	stage2 : fulladd PORT MAP (carry(1), x(1), y1, s(1), carry(2));
	stage3 : fulladd PORT MAP (carry(2), x(2), y2, s(2), carry(3));
	stage4 : fulladd PORT MAP (carry(3), x(3), y3, s(3), Cout);

END struc_behaviour;