--------- This is 1-bit register circuit -----------
library ieee;
use ieee.std_logic_1164.all;

entity reg1 is
port (clock : in std_logic;
		reset : in std_logic;	-- resets when 1
		D 		: in std_logic;
		Q 		: out std_logic);
end reg1;

architecture behavior of reg1 is
begin
	process (clock)
	begin
		if clock'event and clock = '1' then
				Q <= D and not reset;
		end if;
	end process;
end behavior;