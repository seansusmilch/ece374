library ieee;
use ieee.std_logic_1164.all;
use work.components.all;

entity haz_det is
	port( 
			ID_EX_MemRead : in std_logic;
			
			pc_write, IF_ID_write, mux_en : out std_logic;
end haz_det;

architecture det_logic of haz_det is 

	if (ID/EX.MemRead and ((ID/EX.RegisterRt=IF/ID.RegisterRs) or (ID/EX.RegisterRt=IF/ID.RegisterRt)))
		
		--then stall
		
end det_logic
	
			