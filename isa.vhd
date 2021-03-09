---- LAB 4 ----
-----Uses data memory and implements lw and sw instructions--------
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE work.components.all;

ENTITY isa IS 
                port( clock, reset : in std_logic;
                current_pc, result : out std_logic_vector(3 downto 0));
                end isa;
                
architecture behaviour of isa is
                constant initial_pc : std_logic_vector(3 downto 0) := (others => '0');
                signal next_pc, jump_pc, branch_pc, branch_mux_pc, jump_mux_pc, read_port1, read_port2, write_port, rd_addr, w_value, src1, src2, sum, rout, mout, reg_write_data, mem_read_data, reg_write_src, alu_in_2, immediate : std_logic_vector(3 downto 0);
                signal instr_from_im : std_logic_vector(31 downto 0);
                signal MemRead, MemWrite, RegWrite, add_sub, zero2, MemtoReg, RegDst, ALUSrc, Branch, Jump, branch_ms: std_logic;
                signal alu_op : std_logic_vector(1 downto 0);
                
begin
					 pc_mux : mux2to1 generic map (n=>4) port map (reset, jump_mux_pc, initial_pc, mout);
					 pc           : regN generic map (n=>4) port map (clock, mout, rout);
					 ---------- pc = pc +1 ------------------------------------------
					 addpc : ripple_carry port map ('0', rout, "0001", next_pc);

					 ----------- IM -------------------------------------------------
					 im : instruction_memory port map (clock, reset, rout, instr_from_im);
					 
					 ------------- ID ------------------------------------------------
					 id : instruction_decode port map (instr_from_im, 
														MemRead, MemWrite, RegWrite, add_sub, RegDst, ALUSrc, Branch, Jump, MemtoReg,
														read_port1, read_port2, rd_addr, immediate, 
														alu_op);
					 
					 ------------- RF --------------------------------------------------
					 regwrite_mux : mux2to1 port map (RegDst, read_port2, rd_addr, write_port);
					 rf : register_file port map (clock, reset, RegWrite, read_port1, read_port2, write_port, reg_write_data, src1, src2);
					 
					 ------------- ALU -------------------------------------------------
					 alusrc_mux : mux2to1 port map (ALUSrc, src2, immediate, alu_in_2);
					 alu_stuff : alu port map (src1, alu_in_2, add_sub, alu_op, zero2, sum);
					 
					 ------------- MEM -------------------------------------------------
					 mem : data_memory port map (clock, reset, MemWrite, sum, src2, mem_read_data);
					 
					 ---------- WB ----------------------------------------
					 wb : mux2to1 port map (MemtoReg, sum, mem_read_data, reg_write_data);
					 
					 
					 ---------- BRANCH & JUMP ----------------------------------------
					 branch_mux : mux2to1 port map(branch_ms, next_pc, branch_pc, branch_mux_pc);
					 branch_add_pc : ripple_carry port map('0', next_pc, immediate, branch_pc);
					 branch_ms <= zero2 and Branch;
					 
					 jump_mux : mux2to1 port map(Jump, branch_mux_pc, immediate, jump_mux_pc);
					 
					 
					 current_pc <= rout;
					 
					 result <= 	immediate when(Jump = '1') else
									branch_pc when(Branch = '1') else
									src2 when (MemWrite = '1') else
									reg_write_data;
				
end behaviour;

