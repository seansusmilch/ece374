-------- This is the Data Memory Circuit for MIPS -----------------
library ieee;
use ieee.std_logic_1164.all;
USE work.components.all;

entity data_memory is
	port(clock, reset, MemWrite : in std_logic;
			address, write_value : in std_logic_vector(3 downto 0);
			value1: out std_logic_vector(3 downto 0));
end data_memory;

architecture struc_behaviour of data_memory is

	constant zero_value : std_logic_vector(3 downto 0) := (others => '0');
	constant data0 : std_logic_vector(3 downto 0) := "0100";
	constant data1 : std_logic_vector(3 downto 0) := "0110";
	constant data2 : std_logic_vector(3 downto 0) := "0111";
	constant data3 : std_logic_vector(3 downto 0) := "1000";
	constant data4 : std_logic_vector(3 downto 0) := "0011";
	constant data5 : std_logic_vector(3 downto 0) := "1010";
	constant data6 : std_logic_vector(3 downto 0) := "1110";
	constant data7 : std_logic_vector(3 downto 0) := zero_value;
	constant data8 : std_logic_vector(3 downto 0) := "0101";
	constant data9 : std_logic_vector(3 downto 0) := "1001";
	constant data10 : std_logic_vector(3 downto 0) := "0001";
	constant data11 : std_logic_vector(3 downto 0) := "0010";
	constant data12 : std_logic_vector(3 downto 0) := zero_value;
	constant data13 : std_logic_vector(3 downto 0) := zero_value;
	constant data14 : std_logic_vector(3 downto 0) := zero_value;
	constant data15 : std_logic_vector(3 downto 0) := zero_value;
	
	signal decoder_port1, decoder_port2, decoder_write_enable : std_logic_vector(15 downto 0);
	
	------- signals for register output -----------------------
	signal rout0, rout1, rout2, rout3, rout4, rout5, rout6, rout7, rout8, rout9, rout10, rout11, rout12, rout13, rout14, rout15 : std_logic_vector(3 downto 0);
	------- signals for multiplexer output ---------------------
	signal mout0, mout1, mout2, mout3, mout4, mout5, mout6, mout7, mout8, mout9, mout10, mout11, mout12, mout13, mout14, mout15 : std_logic_vector(3 downto 0);
 	---------- signals for multiplexer select --------------------
	signal ssel0, ssel1, ssel2, ssel3, ssel4, ssel5, ssel6, ssel7, ssel8, ssel9, ssel10, ssel11, ssel12, ssel13, ssel14, ssel15 : std_logic_vector(1 downto 0);

begin

	------------ decoder 4 x 16 to enable the tri-state buffer connected at the end of register -------------
	stage_dec1 : dec4to16 port map (address, '1', decoder_port1);
--	stage_dec2 : dec4to16 port map (temp0, '1', decoder_port2);

	------------ decoder 4 x 16 to find which register to write to -------------
	stage_dec_write : dec4to16 port map (address, MemWrite, decoder_write_enable);
	
	------------- location 0 -----------------------
	ssel0 <= reset & decoder_write_enable(0);
	m0 : mux4to1 generic map (n=>4) port map (rout0, write_value, data0, data0, ssel0, mout0);	--- multiplexer
	r0	: regN generic map (n=>4) port map (clock, mout0, rout0);										--- register
	tri0 : trin generic map (n=>4) port map (rout0, decoder_port1(0), value1);						--- tri-state buffer
--	tri0_2 : trin generic map (n=>4) port map (rout0, decoder_port2(0), temp2);					--- tri-state buffer
	
	------------- location 1 -----------------------
	ssel1 <= reset & decoder_write_enable(1);
	m1 : mux4to1 generic map (n=>4) port map (rout1, write_value, data1, data1, ssel1, mout1);	--- multiplexer
	r1	: regN generic map (n=>4) port map (clock, mout1, rout1);										--- register
	tri1 : trin generic map (n=>4) port map (rout1, decoder_port1(1), value1);						--- tri-state buffer
--	tri1_2 : trin generic map (n=>4) port map (rout1, decoder_port2(1), temp2);					--- tri-state buffer

	------------- location 2 -----------------------
	ssel2 <= reset & decoder_write_enable(2);
	m2 : mux4to1 generic map (n=>4) port map (rout2, write_value, data2, data2, ssel2, mout2);	--- multiplexer
	r2	: regN generic map (n=>4) port map (clock, mout2, rout2);										--- register
	tri2 : trin generic map (n=>4) port map (rout2, decoder_port1(2), value1);						--- tri-state buffer
--	tri2_2 : trin generic map (n=>4) port map (rout2, decoder_port2(2), temp2);					--- tri-state buffer

	------------- location 3 -----------------------
	ssel3 <= reset & decoder_write_enable(3);
	m3 : mux4to1 generic map (n=>4) port map (rout3, write_value, data3, data3, ssel3, mout3);	--- multiplexer
	r3	: regN generic map (n=>4) port map (clock, mout3, rout3);										--- register
	tri3 : trin generic map (n=>4) port map (rout3, decoder_port1(3), value1);						--- tri-state buffer
--	tri3_2 : trin generic map (n=>4) port map (rout3, decoder_port2(3), temp2);					--- tri-state buffer

	------------- location 4 -----------------------
	ssel4 <= reset & decoder_write_enable(4);
	m4 : mux4to1 generic map (n=>4) port map (rout4, write_value, data4, data4, ssel4, mout4);	--- multiplexer
	r4	: regN generic map (n=>4) port map (clock, mout4, rout4);										--- register
	tri4 : trin generic map (n=>4) port map (rout4, decoder_port1(4), value1);						--- tri-state buffer
--	tri4_2 : trin generic map (n=>4) port map (rout4, decoder_port2(4), temp2);					--- tri-state buffer

	------------- location 5 -----------------------
	ssel5 <= reset & decoder_write_enable(5);
	m5 : mux4to1 generic map (n=>4) port map (rout5, write_value, data5, data5, ssel5, mout5);	--- multiplexer
	r5	: regN generic map (n=>4) port map (clock, mout5, rout5);										--- register
	tri5 : trin generic map (n=>4) port map (rout5, decoder_port1(5), value1);						--- tri-state buffer
--	tri5_2 : trin generic map (n=>4) port map (rout5, decoder_port2(5), temp2);					--- tri-state buffer

	------------- location 6 -----------------------
	ssel6 <= reset & decoder_write_enable(6);
	m6 : mux4to1 generic map (n=>4) port map (rout6, write_value, data6, data6, ssel6, mout6);	--- multiplexer
	r6	: regN generic map (n=>4) port map (clock, mout6, rout6);										--- register
	tri6 : trin generic map (n=>4) port map (rout6, decoder_port1(6), value1);						--- tri-state buffer
--	tri6_2 : trin generic map (n=>4) port map (rout6, decoder_port2(6), temp2);					--- tri-state buffer

	------------- location 7 -----------------------
	ssel7 <= reset & decoder_write_enable(7);
	m7 : mux4to1 generic map (n=>4) port map (rout7, write_value, data7, data7, ssel7, mout7);	--- multiplexer
	r7	: regN generic map (n=>4) port map (clock, mout7, rout7);										--- register
	tri7 : trin generic map (n=>4) port map (rout7, decoder_port1(7), value1);						--- tri-state buffer
--	tri7_2 : trin generic map (n=>4) port map (rout7, decoder_port2(7), temp2);					--- tri-state buffer

	------------- location 8 -----------------------
	ssel8 <= reset & decoder_write_enable(8);
	m8 : mux4to1 generic map (n=>4) port map (rout8, write_value, data8, data8, ssel8, mout8);	--- multiplexer
	r8	: regN generic map (n=>4) port map (clock, mout8, rout8);										--- register
	tri8 : trin generic map (n=>4) port map (rout8, decoder_port1(8), value1);						--- tri-state buffer
--	tri8_2 : trin generic map (n=>4) port map (rout8, decoder_port2(8), temp2);					--- tri-state buffer

	------------- location 9 -----------------------
	ssel9 <= reset & decoder_write_enable(9);
	m9 : mux4to1 generic map (n=>4) port map (rout9, write_value, data9, data9, ssel9, mout9);	--- multiplexer
	r9	: regN generic map (n=>4) port map (clock, mout9, rout9);									--- register
	tri9 : trin generic map (n=>4) port map (rout9, decoder_port1(9), value1);					--- tri-state buffer
--	tri9_2 : trin generic map (n=>4) port map (rout9, decoder_port2(9), temp2);					--- tri-state buffer

	------------- location 10 -----------------------
	ssel10 <= reset & decoder_write_enable(10);
	m10 : mux4to1 generic map (n=>4) port map (rout10, write_value, data10, data10, ssel10, mout10);	--- multiplexer
	r10	: regN generic map (n=>4) port map (clock, mout10, rout10);											--- register
	tri10 : trin generic map (n=>4) port map (rout10, decoder_port1(10), value1);							--- tri-state buffer
--	tri10_2 : trin generic map (n=>4) port map (rout10, decoder_port2(10), temp2);						--- tri-state buffer

	------------- location 11 -----------------------
	ssel11 <= reset & decoder_write_enable(11);
	m11 : mux4to1 generic map (n=>4) port map (rout11, write_value, data11, data11, ssel11, mout11);	--- multiplexer
	r11	: regN generic map (n=>4) port map (clock, mout11, rout11);											--- register
	tri11 : trin generic map (n=>4) port map (rout11, decoder_port1(11), value1);							--- tri-state buffer
--	tri11_2 : trin generic map (n=>4) port map (rout11, decoder_port2(11), temp2);						--- tri-state buffer

	------------- location 12 -----------------------
	ssel12 <= reset & decoder_write_enable(12);
	m12 : mux4to1 generic map (n=>4) port map (rout12, write_value, data12, data12, ssel12, mout12);	--- multiplexer
	r12	: regN generic map (n=>4) port map (clock, mout12, rout12);											--- register
	tri12 : trin generic map (n=>4) port map (rout12, decoder_port1(12), value1);							--- tri-state buffer
--	tri12_2 : trin generic map (n=>4) port map (rout12, decoder_port2(12), temp2);						--- tri-state buffer

	------------- location 13 -----------------------
	ssel13 <= reset & decoder_write_enable(13);
	m13 : mux4to1 generic map (n=>4) port map (rout13, write_value, data13, data13, ssel13, mout13);	--- multiplexer
	r13	: regN generic map (n=>4) port map (clock, mout13, rout13);											--- register
	tri13 : trin generic map (n=>4) port map (rout13, decoder_port1(13), value1);							--- tri-state buffer
--	tri13_2 : trin generic map (n=>4) port map (rout13, decoder_port2(13), temp2);						--- tri-state buffer

	------------- location 14 -----------------------
	ssel14 <= reset & decoder_write_enable(14);
	m14 : mux4to1 generic map (n=>4) port map (rout14, write_value, data14, data14, ssel14, mout14);	--- multiplexer
	r14	: regN generic map (n=>4) port map (clock, mout14, rout14);											--- register
	tri14 : trin generic map (n=>4) port map (rout14, decoder_port1(14), value1);							--- tri-state buffer
--	tri14_2 : trin generic map (n=>4) port map (rout14, decoder_port2(14), temp2);						--- tri-state buffer

	------------- location 15 -----------------------
	ssel15 <= reset & decoder_write_enable(15);
	m15 : mux4to1 generic map (n=>4) port map (rout15, write_value, data15, data15, ssel15, mout15);	--- multiplexer
	r15	: regN generic map (n=>4) port map (clock, mout15, rout15);											--- register
	tri15 : trin generic map (n=>4) port map (rout15, decoder_port1(15), value1);							--- tri-state buffer
--	tri15_2 : trin generic map (n=>4) port map (rout15, decoder_port2(15), temp2);						--- tri-state buffer

end struc_behaviour;
