---- This is a bitwise OR circuit ----
LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY bitwise_or IS
	PORT (
		a : IN std_logic_vector(3 downto 0);
		b : IN std_logic_vector(3 downto 0);
		q : OUT std_logic_vector(3 downto 0));
	end bitwise_or;

ARCHITECTURE LogicFunc OF bitwise_or is
begin

	q <= a or b;
	
end LogicFunc;