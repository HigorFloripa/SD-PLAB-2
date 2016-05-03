library ieee;
use ieee.std_logic_1164.all;

entity topoPart4 is
port(SW: in std_logic_vector(8 downto 0);
     LEDR: out std_logic_vector(8 downto 0);
	  HEX0: out std_logic_vector(6 downto 0);
	  HEX1: out std_logic_vector(6 downto 0);
	  HEX4: out std_logic_vector(6 downto 0);
	  HEX6: out std_logic_vector(6 downto 0));
end topoPart4;

architecture topo_estru of topoPart4 is
	signal F1, F2, saidaSomador: std_logic_vector(3 downto 0);
	signal signalCOut: std_logic;
	signal outBCDHEX1, saidaDecod1, saidaDecod2, saidaDecod3: std_logic_vector (6 downto 0);

component SWtoBCD
	port(entrada: in std_logic_vector(3 downto 0);
		  saida:   out std_logic_vector(3 downto 0));
end component;

component somadorCompleto4bits
  port( a, b: in std_logic_vector (3 downto 0);
		  cIn: in std_logic;
		  s: out std_logic_vector (3 downto 0);
		  cOut: out std_logic);
end component;

component BCDHEX1
port(entrada: in std_logic;
     saida: out std_logic_vector(6 downto 0));
end component;

component decod7seg
port(entrada: in std_logic_vector(3 downto 0);
     saida: out std_logic_vector(6 downto 0));
end component;

begin
	HEX0 <= saidaDecod1;
	HEX1 <= outBCDHEX1;
	HEX4 <= saidaDecod2;
	HEX6 <= saidaDecod3;
	L1: SWtoBCD port map (SW(7 downto 4), F1);
	L2: SWtoBCD port map (SW(3 downto 0), F2);
	L3: somadorCompleto4bits port map (F1, F2, SW(8), saidaSomador, signalCOut);
	L4: BCDHEX1 port map (signalCOut, outBCDHEX1);
	L5: decod7seg port map (saidaSomador, saidaDecod1);
	L6: decod7seg port map (saidaSomador, saidaDecod2);
	L7: decod7seg port map (saidaSomador, saidaDecod3);
end topo_estru;


library IEEE;
use ieee.std_logic_1164.all;

entity BCDHEX1 is
port(entrada: in std_logic;
     saida: out std_logic_vector(6 downto 0));
end BCDHEX1;

architecture circ of BCDHEX1 is
begin
    saida <= "1000000" when entrada = '0' else -- 0
				 "1111001";                        -- 1
end circ;


library IEEE;
use ieee.std_logic_1164.all;

entity decod7seg is
port(entrada: in std_logic_vector(3 downto 0);
     saida: out std_logic_vector(6 downto 0));
end decod7seg;

architecture decod of decod7seg is
begin
    saida <= "1000000" when entrada = "0000" else -- 0
             "1111001" when entrada = "0001" else -- 1
             "0100100" when entrada = "0010" else -- 2
             "0110000" when entrada = "0011" else -- 3
             "0011001" when entrada = "0100" else -- 4
             "0010010" when entrada = "0101" else -- 5
             "0000011" when entrada = "0110" else -- 6
             "1111000" when entrada = "0111" else -- 7
             "0000000" when entrada = "1000" else -- 8
             "0011000" when entrada = "1001" else -- 9
	          "1111111";
end decod;


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


library ieee;
use ieee.Std_Logic_1164.all;

entity SWtoBCD is
port(entrada: in std_logic_vector(3 downto 0);
     saida:   out std_logic_vector(3 downto 0));
end SWtoBCD;

architecture circ of SWtoBCD is
begin

saida <= "1010" when entrada = "0000" else
			"1011" when entrada = "0001" else 
			"1100" when entrada = "0010" else 
			"1101" when entrada = "0011" else
			"1110" when entrada = "0100" else
			"1111" when entrada = "0111" else
			"0000";
end circ;