------ This file describes the instruction decode operation -------------
LIBRARY ieee;
use ieee.std_logic_1164.all;
USE work.components.all;

entity instruction_decode is
	port(instr : in std_logic_vector(31 downto 0);
			MemRead, MemWrite, RegWrite, add_sub, RegDst, ALUSrc, Branch, MemtoReg : out std_logic;
			read_p1, read_p2, write_p, immediate : out std_logic_vector(3 downto 0);
			alu_op : out std_logic_vector(1 downto 0));
end instruction_decode;

architecture struc_behaviour of instruction_decode is
	signal opcode, funct : std_logic_vector(5 downto 0);
	signal shamt : std_logic_vector(4 downto 0);
	
	

begin

	opcode <= instr(31 downto 26);
	shamt <= instr(10 downto 6);
	funct <= instr(5 downto 0);

	read_p1 <= instr(24 downto 21); -- Arent the left numbers supposed to be 1 higher????
	read_p2 <= instr(19 downto 16);
	write_p <= instr(14 downto 11);
	immediate <= instr(3 downto 0);
	
	RegDst <= '1' when (opcode = "000000")
						else '0';
	ALUSrc <= '1' when (opcode = "100011" or opcode = "101011")
						else '0';
	MemtoReg <= '1' when (opcode = "100011")
						else '0';
	RegWrite <= '1' when (opcode = "000000" or opcode = "100011")
						else '0';
	MemRead <= '1' when (opcode = "100011")
						else '0';
	MemWrite <= '1' when (opcode = "101011")
						else '0';
	Branch <= '1' when (opcode = "000100")
						else '0';
-- alu_op <= "10" when (opcode = "000000") else
	alu_op <= "01" when (opcode = "100011" or opcode = "101011") else
				 "01" when (opcode = "000100") else
				 "01" when (funct = "100000") else      -- add funct code
				"01" when (funct = "100010") else		-- sub funct code
				"11" when (funct = "100101") else 	-- or funct
				"10" when (funct = "100100") else 	-- and funct
				"00" when (funct = "101010") else 	-- slt funct
				"00" when (opcode = "000010"); 	-- jump opcode
	
	add_sub <= '0' when (funct = "100000") else		-- add funct code is 100000
				  '1' when (funct = "100010") else 		-- sub funct code is 100010
				  '1' when (funct = "101010") else 	-- slt funct
				  '0' when (opcode = "100011") else -- lw opcode
				  '0' when (opcode = "101011") else -- sw opcode
				  '1' when (opcode = "000100") else -- beq funct
				  '0' when (opcode = "000010"); -- jump funct
				  
				  

--	alu_op <= "01" when (funct = "100000") else      -- add funct code
--				"01" when (funct = "100010") else		-- sub funct code
--				"11" when (funct = "100101") else 	-- or funct
--				"10" when (funct = "100100") else 	-- and funct
--				"00" when (funct = "101010") else  	-- slt funct
--				"01" when (opcode = "100011") else 	-- lw opcode
--				"01" when (opcode = "101011") else 	-- sw opcode
--				"01" when (opcode = "000100") else 	-- beq funct
--				"00" when (opcode = "000010"); 	-- jump opcode
				
end struc_behaviour;