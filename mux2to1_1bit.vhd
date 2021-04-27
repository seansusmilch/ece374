LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY mux2to1_1bit IS
	PORT ( s : IN std_logic;
			a, b : in std_logic;
			f : OUT std_logic);
END mux2to1_1bit;

ARCHITECTURE Logic OF mux2to1_1bit IS
	signal s_vec : std_logic;
BEGIN
	process(s)
		begin
			if (s='0') then
				s_vec <= a;
			else
				s_vec <= b;
			end if;
	end process;
		
	f <= ((not s_vec) and a) OR (b and s_vec);	
END Logic;