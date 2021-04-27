---- LAB 4 ----
-----Uses data memory and implements lw and sw instructions--------
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE work.components.all;

ENTITY isa_pipeline IS 
                port( clock, reset : in std_logic;
                current_pc, result : out std_logic_vector(3 downto 0));
end isa_pipeline;
                
architecture behaviour of isa_pipeline is
					constant initial_pc : std_logic_vector(3 downto 0) := (others => '0');
					signal update_pc, rs_addr, rt_addr, write_port, rd_addr, w_value, src1, src2, sum, rout, mout, reg_write_data, mem_read_data, reg_write_src, alu_in_2, immediate : std_logic_vector(3 downto 0);
					signal instr_from_im : std_logic_vector(31 downto 0);
					signal MemRead, MemWrite, RegWrite, add_sub, zero2, MemtoReg, RegDst, ALUSrc, Branch: std_logic;
					signal alu_op : std_logic_vector(1 downto 0);

					-- IF/ID Pipeline Signals
					signal IF_ID_instr : std_logic_vector(31 downto 0);
					-- ID/EX Pipeline Signals
					signal ID_EX_RegWrite, ID_EX_MemtoReg, ID_EX_MemRead, ID_EX_MemWrite, ID_EX_RegDst, ID_EX_ALUSrc, ID_EX_add_sub : std_logic;
					signal ID_EX_alu_op : std_logic_vector(1 downto 0);
					signal ID_EX_src1, ID_EX_src2, ID_EX_immediate, ID_EX_rs_addr, ID_EX_rt_addr, ID_EX_rd_addr : std_logic_vector(3 downto 0);
					-- EX/MEM Pipeline Signals
					signal EX_MEM_RegWrite, EX_MEM_MemtoReg, EX_MEM_MemRead, EX_MEM_MemWrite, EX_MEM_zero2 : std_logic;
					signal EX_MEM_sum, EX_MEM_src2, EX_MEM_write_port : std_logic_vector(3 downto 0);
					-- MEM/WB Pipeline Signals
					signal MEM_WB_RegWrite, MEM_WB_MemtoReg : std_logic;
					signal MEM_WB_mem_read_data, MEM_WB_sum, MEM_WB_write_port : std_logic_vector(3 downto 0);
					-- For WB
					signal WB_reg_write_data : std_logic_vector(3 downto 0);
					-- Forwarding
					signal Fwd_data_A, Fwd_data_B : std_logic_vector(3 downto 0);
					signal Fwd_A, Fwd_B : std_logic_vector(1 downto 0);
--					signal EX_MEM_rd_addr, MEM_WB_rd_addr : std_logic_vector(3 downto 0);
					
begin
			
			--------------------- Lab 6 and 7 Mapping -----------------------------------
					
					pc_mux : mux2to1 generic map (n=>4) port map (reset, update_pc, initial_pc, mout);
					pc    : regN generic map (n=>4) port map (clock, mout, rout);
               
					---------- pc = pc +1 ------------------------------------------
					addpc : ripple_carry port map ('0', rout, "0001", update_pc);

					----------- IM -------------------------------------------------
					im : instruction_memory port map (clock, reset, rout, instr_from_im);
					
			----------------------- IF/ID Pipeline Stage ----------------------------------
					IF_ID_r1 : regN generic map (n=>32) port map (clock, instr_from_im, IF_ID_instr);
			
					------------------------ ID -----------------------------
					
					id : instruction_decode port map (IF_ID_instr, MemRead, MemWrite, RegWrite, add_sub, RegDst, ALUSrc, Branch, MemtoReg,
														rs_addr, rt_addr, rd_addr, immediate, 
														alu_op);

					rf : register_file port map (clock, reset, MEM_WB_RegWrite, rs_addr, rt_addr, MEM_WB_write_port, WB_reg_write_data, src1, src2);

			----------------------- ID/EX Pipeline Stage ----------------------------------
					-- WB
					ID_EX_r1 : reg1 port map (clock, reset, RegWrite, ID_EX_RegWrite);
					ID_EX_r2 : reg1 port map (clock, reset, MemtoReg, ID_EX_MemtoReg);
					-- MEM
					ID_EX_r3 : reg1 port map (clock, reset, MemRead, ID_EX_MemRead);
					ID_EX_r4 : reg1 port map (clock, reset, MemWrite, ID_EX_MemWrite);
					-- EX
					ID_EX_r5 : reg1 port map (clock, reset, RegDst, ID_EX_RegDst);
					ID_EX_r6 : regN generic map (n=>2) port map (clock, alu_op, ID_EX_alu_op);
					ID_EX_r7 : reg1 port map (clock, reset, ALUSrc, ID_EX_ALUSrc);
					ID_EX_r8 : reg1 port map (clock, reset, add_sub, ID_EX_add_sub);
					-- The rest for ID_EX
					ID_EX_r9 : regN generic map (n=>4) port map (clock, src1, ID_EX_src1);
					ID_EX_r10 : regN generic map (n=>4) port map (clock, src2, ID_EX_src2);
					ID_EX_r11 : regN generic map (n=>4) port map (clock, immediate, ID_EX_immediate);
					ID_EX_r12 : regN generic map (n=>4) port map (clock, rs_addr, ID_EX_rs_addr);
					ID_EX_r13 : regN generic map (n=>4) port map (clock, rt_addr, ID_EX_rt_addr);
					ID_EX_r14 : regN generic map (n=>4) port map (clock, rd_addr, ID_EX_rd_addr);
					
					
					------------------------ EX -----------------------------
					fwd_muxA : mux4to1 port map (ID_EX_src1, WB_reg_write_data, EX_MEM_sum, "0000", Fwd_A, Fwd_data_A);																				-- fwd muxes
					fwd_muxB : mux4to1 port map (ID_EX_src2, WB_reg_write_data, EX_MEM_sum, "0000", Fwd_B, Fwd_data_B);
					
					f_u : forwarding_unit port map (ID_EX_rs_addr, ID_EX_rt_addr, EX_MEM_write_port, MEM_WB_write_port,
																EX_MEM_RegWrite, MEM_WB_RegWrite, Fwd_A, Fwd_B);
					
					alusrc_mux : mux2to1 port map (ID_EX_ALUSrc, Fwd_data_B, ID_EX_immediate, alu_in_2);
					alu_stuff : alu port map (Fwd_data_A, alu_in_2, ID_EX_add_sub, ID_EX_alu_op, zero2, sum);
					
					regwrite_mux : mux2to1 port map (ID_EX_RegDst, ID_EX_rt_addr, ID_EX_rd_addr, write_port);
					
			----------------------- EX/MEM Pipeline Stage ----------------------------------
					-- WB
					EX_MEM_r1 : reg1 port map (clock, reset, ID_EX_RegWrite, EX_MEM_RegWrite);
					EX_MEM_r2 : reg1 port map (clock, reset, ID_EX_MemtoReg, EX_MEM_MemtoReg);
					-- MEM
					EX_MEM_r3 : reg1 port map (clock, reset, ID_EX_MemRead, EX_MEM_MemRead);
					EX_MEM_r4 : reg1 port map (clock, reset, ID_EX_MemWrite, EX_MEM_MemWrite);
					-- The rest for EX_MEM
					EX_MEM_r5 : reg1 port map (clock, reset, zero2, EX_MEM_zero2);
					EX_MEM_r6 : regN generic map (n=>4) port map (clock, sum, EX_MEM_sum);
					EX_MEM_r7 : regN generic map (n=>4) port map (clock, ID_EX_src2, EX_MEM_src2);
					EX_MEM_r8 : regN generic map (n=>4) port map (clock, write_port, EX_MEM_write_port);
					
					------------------------ MEM -----------------------------
					
					mem : data_memory port map (clock, reset, EX_MEM_MemWrite, EX_MEM_sum, EX_MEM_src2, mem_read_data);
					
			----------------------- MEM/WB Pipeline Stage ----------------------------------
					-- WB
					MEM_WB_r1 : reg1 port map (clock, reset, EX_MEM_RegWrite, MEM_WB_RegWrite);
					MEM_WB_r2 : reg1 port map (clock, reset, EX_MEM_MemtoReg, MEM_WB_MemtoReg);
					-- The rest of MEM_WB
					MEM_WB_r3 : regN generic map (n=>4) port map (clock, mem_read_data, MEM_WB_mem_read_data);
					MEM_WB_r4 : regN generic map (n=>4) port map (clock, EX_MEM_sum, MEM_WB_sum);
					MEM_WB_r5 : regN generic map (n=>4) port map (clock, EX_MEM_write_port, MEM_WB_write_port);
					
					------------------------ WB -----------------------------
					wb : mux2to1 port map (MEM_WB_MemtoReg, MEM_WB_sum, MEM_WB_mem_read_data, WB_reg_write_data);
					
					current_pc <= rout;

					result <= EX_MEM_src2 when (EX_MEM_MemWrite = '1') else
								WB_reg_write_data;
					
end behaviour;

