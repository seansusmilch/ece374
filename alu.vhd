-- 4-bit ALU--

library ieee;
use ieee.std_logic_1164.all;
use work.components.all;

entity alu is
	port(
		x,y :			in std_logic_vector(3 downto 0);
		add_sub :	in std_logic;
		alu_op :		in std_logic_vector(1 downto 0);
		
		zero2 :		out std_logic;
		s :			out std_logic_vector(3 downto 0));
end alu;


architecture struct of alu is

	signal bw_or, bw_and, rca, is_negative: std_logic_vector(3 downto 0);
	
begin
	
		alu_and : bitwise_and port map (x,y, bw_and);
		
		alu_or : bitwise_or port map (x,y, bw_or);
		
		alu_rca : ripple_carry port map (add_sub, x, y, rca);
		
		neg : mux2to1 port map (rca(3), "0000", "0001", is_negative);
		
		
		zero2 <= '1' when (rca = "0000") else '0';
		
		s_out : mux4to1 port map (is_negative, rca, bw_and, bw_or, alu_op, s);
end struct;