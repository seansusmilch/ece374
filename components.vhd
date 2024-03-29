library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;

package components is
------------ full adder ---------------
component fulladd IS
	PORT ( Cin, x, y : IN STD_LOGIC;
		s, Cout : OUT STD_LOGIC );
END component;

------------- n stage ripple carry adder -------------------
component ripple_carry IS
	PORT ( Cin: IN STD_LOGIC;
			x,y : IN STD_LOGIC_VECTOR(3 downto 0);
			s : OUT STD_LOGIC_VECTOR(3 downto 0);
			Cout : OUT STD_LOGIC );
END component;

--------- multiplexer -----------------------
component mux2to1 IS
	generic(n : integer := 4);
	PORT ( s : IN std_logic;
			a, b : in std_logic_vector((n-1) downto 0);
			f : OUT std_logic_vector((n-1) downto 0));
END component;

component mux4to1 IS
	generic  (n : integer:= 4);
	PORT ( w0, w1, w2, w3 : IN STD_LOGIC_VECTOR((n-1) downto 0);
		s : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		f : OUT STD_LOGIC_VECTOR((n-1) downto 0));
END component;

---------------- decoders -------------------------
component dec2to4 IS
	PORT ( w : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
			En : IN STD_LOGIC;
			y : OUT STD_LOGIC_VECTOR(3 downto 0));
END component;

component dec4to16 IS
	PORT (w : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
			En : IN STD_LOGIC;
			y : OUT STD_LOGIC_VECTOR(15 downto 0));
END component;

------------- n stage tri-state buffer ------------------------
component trin IS
	GENERIC (N : INTEGER := 8);
	PORT (X : IN STD_LOGIC_VECTOR((N-1) DOWNTO 0);
			E : IN STD_LOGIC;
			F : OUT STD_LOGIC_VECTOR((N-1) DOWNTO 0));
END component;

------------ n bit register -----------------------
component regN is
	generic(N: integer:= 32);
	port (clock : in std_logic;
	  D : in std_logic_vector(N-1 downto 0);
	  Q : out std_logic_vector(N-1 downto 0));
end component;

------------ 1 bit register -----------------------
component reg1 is
	port (clock : in std_logic;
		reset : in std_logic;
		D : in std_logic;
		Q : out std_logic);
end component;

-------------- instruction memeory --------------------------
component instruction_memory is
	port(clock, reset : in std_logic;
			input : in std_logic_vector(3 downto 0);
			output : out std_logic_vector(31 downto 0));
end component;

--------------- register file -------------------------------
component register_file is
	port(clock, reset, RegWrite : in std_logic;
			read_port1, read_port2, write_port, write_value : in std_logic_vector(3 downto 0);
			value1, value2 : out std_logic_vector(3 downto 0));
end component;

------------- instruction decode ----------------------------
component instruction_decode is
	port(instr : in std_logic_vector(31 downto 0);
			MemRead, MemWrite, RegWrite, add_sub, RegDst, ALUSrc, Branch, MemtoReg : out std_logic;
			read_p1, read_p2, write_p, immediate : out std_logic_vector(3 downto 0);
			alu_op : out std_logic_vector(1 downto 0));
end component;

------------- bitwise and ---------------------------
component bitwise_and is
	PORT (
		a : IN std_logic_vector(3 downto 0);
		b : IN std_logic_vector(3 downto 0);
		q : OUT std_logic_vector(3 downto 0));
end component;
	
------------- bitwise or ----------------------
component bitwise_or is
	PORT (
		a : IN std_logic_vector(3 downto 0);
		b : IN std_logic_vector(3 downto 0);
		q : OUT std_logic_vector(3 downto 0));
end component;

---------------alu---------------------------------
component alu is
	port(
		x,y :			in std_logic_vector(3 downto 0);
		add_sub :	in std_logic;
		alu_op :		in std_logic_vector(1 downto 0);
		
		zero2 :		out std_logic;
		s :			out std_logic_vector(3 downto 0));
end component;

--------------- Data Memory ---------------------
component data_memory is
	port(clock, reset, MemWrite : in std_logic;
			address, write_value : in std_logic_vector(3 downto 0);
			value1: out std_logic_vector(3 downto 0));
end component;

--------------- Forwarding Unit ---------------------
component forwarding_unit is
	port( ID_EX_Rs, ID_EX_Rt, EX_MEM_Rd, MEM_WB_Rd : in std_logic_vector(3 downto 0);
		EX_MEM_RegWrite : in std_logic;
		MEM_WB_RegWrite : in std_logic;
		
		Fwd_A, Fwd_B : out std_logic_vector(1 downto 0));
end component;

-------------- Hazard Detection ---------------------
component haz_det is
	port( 
			ID_EX_MemRead : in std_logic;
			ID_EX_Rt, IF_ID_Rs, IF_ID_Rt : in std_logic_vector(3 downto 0);
			
			stall : out std_logic);
end component;

-------------- 1 Bit 2 to 1 Mux ---------------------
component mux2to1_1bit IS
	PORT ( con,i0,i1 : IN std_logic;
			o : OUT std_logic);
END component;

end components;