library ieee;
use ieee.std_logic_1164.all;

entity topoPart3 is
port(SW: in std_logic_vector(8 downto 0);
     LEDR: out std_logic_vector(8 downto 0);
	  LEDG: out std_logic_vector(4 downto 0));
end topoPart3;

architecture topo_estru of topoPart3 is
	signal saida: std_logic_vector (3 downto 0);
	signal signalCOut: std_logic;

component somadorCompleto4bits
  port( a, b: in std_logic_vector (3 downto 0);
		  cIn: in std_logic;
		  s: out std_logic_vector (3 downto 0);
		  cOut: out std_logic
		  );
end component;

begin
	L1: somadorCompleto4bits port map (SW(7 downto 4), SW(3 downto 0), SW(8), saida, signalCOut);
	LEDR(8 downto 0) <= SW(8 downto 0);
	LEDG(4) <= signalCOut;
	LEDG(3 downto 0) <= saida;
end topo_estru;


library ieee;
use ieee.std_logic_1164.all;

entity somador1bit is
	port( a: in std_logic;
			b: in std_logic;
			cIn: in std_logic;
			s: out std_logic;
			cOut: out std_logic);
end somador1bit;

architecture som1bit of somador1bit is
	begin
	s <= a xor b xor cIn;
	cOut <= (a and b) or (cIn and a) or (cIn and b);
end som1bit;


library ieee; 
use ieee.std_logic_1164.all;

entity somadorCompleto4bits is
  port( a, b: in std_logic_vector (3 downto 0);
		  cIn: in std_logic;
		  s: out std_logic_vector (3 downto 0);
		  cOut: out std_logic);
end somadorCompleto4bits;

architecture som4bit of somadorCompleto4bits is
	signal cSignal: std_logic_vector(3 downto 0);
	
component somador1bit 
	port( a, b, cIn : in std_logic;
			s, cOut : out std_logic);
end component;

begin

  L1: somador1bit port map (a(0), b(0), cIn, s(0), cSignal(0));
  L2: somador1bit port map (a(1), b(1), cSignal(0), s(1), cSignal(1));
  L3: somador1bit port map (a(2), b(2), cSignal(1), s(2), cSignal(2));
  L4: somador1bit port map (a(3), b(3), cSignal(2), s(3), cOut);

end som4bit;