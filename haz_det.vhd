library ieee;
use ieee.std_logic_1164.all;
use work.components.all;

entity haz_det is
	port( 
			ID_EX_MemRead : in std_logic;
			ID_EX_Rt, IF_ID_Rs, IF_ID_Rt : in std_logic_vector(3 downto 0);
			
			stall : out std_logic);
end haz_det;

architecture det_logic of haz_det is begin

--	if (ID/EX.MemRead and ((ID/EX.RegisterRt=IF/ID.RegisterRs) or (ID/EX.RegisterRt=IF/ID.RegisterRt))) then
--		stall = 1;
--	else stall = 0;

	stall <= '1' when ((ID_EX_MemRead = '1') and ((ID_EX_Rt = IF_ID_Rs) or (ID_EX_Rt = IF_ID_Rt))) else
				'0';
	
end det_logic;