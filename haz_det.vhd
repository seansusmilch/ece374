library ieee;
use ieee.std_logic_1164.all;
use work.components.all;

entity haz_det is
	port( 
			ID_EX_MemRead  : in std_logic;
			ID_EX_rt_addr : in std_logic_vector(3 downto 0);
			instr_from_im, IF_ID_instr : in std_logic_vector(31 downto 0);
			
			stall : out std_logic;
end haz_det;

architecture det_logic of haz_det is 

	if (ID/EX.MemRead and ((ID/EX.RegisterRt=IF/ID.RegisterRs) or (ID/EX.RegisterRt=IF/ID.RegisterRt))) then
		stall = 1;
		
	else stall = 0;
	
end det_logic
	
			