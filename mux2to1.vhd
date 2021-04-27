-------- This is a n-bit 2_to_1 MUX ------------------
--						s=0	f<=a
--						s=1	f<=b

LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY mux2to1 IS
	generic(n : integer := 4);
	PORT ( s : IN std_logic;
			a, b : in std_logic_vector((n-1) downto 0);
			f : OUT std_logic_vector((n-1) downto 0));
END mux2to1;

ARCHITECTURE LogicFunc OF mux2to1 IS
	signal s_vec : std_logic_vector ((n-1) downto 0);
BEGIN
	process(s)
		begin
			if (s='0') then
				s_vec <= (others => '0');
			else
				s_vec <= (others => '1');
			end if;
	end process;
		
	f <= ((not s_vec) and a) OR (b and s_vec);	
END LogicFunc;


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