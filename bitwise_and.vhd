---- This is a Bitwise AND circuit ----
LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY bitwise_and is
	PORT (
		a: IN std_logic_vector(3 downto 0);
		b: IN std_logic_vector(3 downto 0);
		q: OUT std_logic_vector(3 downto 0));
	end bitwise_and;
	
ARCHITECTURE LogicFunc of bitwise_and is
begin
	
	q <= a and b;
	
end LogicFunc;