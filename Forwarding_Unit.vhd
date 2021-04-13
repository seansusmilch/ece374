-------------- Forwarding Unit ---------------
LIBRARY ieee;
USE ieee.std_logic_1164.all;
use work.components.all;

ENTITY forwarding_unit is
--	port( ID_EX_Rs, ID_EX_Rt, EX_MEM_Rd, MEM_WB_Rd : in std_logic_vector(3 downto 0);
--		EX_MEM_MemtoReg, EX_MEM_RegWrite : in std_logic;
--		MEM_WB_MemtoReg, MEM_WB_RegWrite : in std_logic;
--		
--		Fwd_A, Fwd_B : out std_logic_vector(1 downto 0);
--		);
	port( ID_EX_Rs, ID_EX_Rt, EX_MEM_Rd, MEM_WB_Rd : in std_logic_vector(3 downto 0);
		EX_MEM_RegWrite : in std_logic;
		MEM_WB_RegWrite : in std_logic;
		
		Fwd_A, Fwd_B : out std_logic_vector(1 downto 0));
end forwarding_unit;

architecture forwarding_logic of forwarding_unit is begin
	

		
	Fwd_A <= "10" when ((EX_MEM_RegWrite = '1') and (EX_MEM_Rd /= "0000") and (EX_MEM_Rd = ID_EX_Rs)) else
				"01" when ((MEM_WB_RegWrite = '1') and (MEM_WB_Rd /= "0000") and (MEM_WB_Rd = ID_EX_Rs)) else 
				"00";
		
	Fwd_B <= "10" when ((EX_MEM_RegWrite = '1') and (EX_MEM_Rd /= "0000") and (EX_MEM_Rd = ID_EX_Rt)) else
				"01" when ((MEM_WB_RegWrite = '1') and (MEM_WB_Rd /= "0000") and (MEM_WB_Rd = ID_EX_Rt)) else 
				"00";
		

--	if (EX_MEM_RegWrite
--		and (EX_MEM_Rd /= "0000")
--		and (EX_MEM_Rd = ID_EX_Rs)) then Fwd_A = "10";
--		
--	if (EX_MEM_RegWrite
--		and (EX_MEM_Rd /= "0000")
--		and (EX_MEM_Rd = ID_EX_Rt)) then Fwd_B = "10";
--		
--	if (MEM_WB_RegWrite
--		and (MEM_WB_Rd /= "0000")
--		and (MEM_WB_Rd = ID_EX_Rs)) then Fwd_A = "01";
--	
--	if (MEM_WB_RegWrite
--		and (MEM_WB_Rd /= "0000")
--		and (MEM_WB_Rd = ID_EX_Rt)) then Fwd_B = "01";
	
end forwarding_logic;