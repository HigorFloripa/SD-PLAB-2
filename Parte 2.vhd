library ieee;
use ieee.std_logic_1164.all;

entity topoPart2 is
port(SW: in std_logic_vector(3 downto 0);
     LEDR: out std_logic_vector(9 downto 0);
	  HEX0: out std_logic_vector(6 downto 0);
	  HEX1: out std_logic_vector(6 downto 0));
end topoPart2;
	
architecture topo_estru of topoPart2 is
	signal comparadorOut, m3, m2, m1, m0: std_logic;
	signal circAOut: std_logic_vector(2 downto 0);
	signal sgSW0to3, concatenaMux: std_logic_vector(3 downto 0);
	signal circBOut: std_logic_vector(6 downto 0);
     
component decod7seg
	port(entrada: in std_logic_vector(3 downto 0);
        saida: out std_logic_vector(6 downto 0));
end component;

component mux2x1
	port(y, x, z: in std_logic;
        m: out std_logic);
end component;

component comparador
	port(entrada: in std_logic_vector(3 downto 0);
		  saida:   out std_logic);
end component;

component circuitoA
port(entrada: in std_logic_vector(2 downto 0);
     saida:   out std_logic_vector(2 downto 0));
end component;

component circuitoB
port(entrada: in std_logic;
     saida: out std_logic_vector(6 downto 0));
end component;

begin
    HEX1 <= circBOut;
    sgSW0to3 <= SW(3 downto   0);
	 concatenaMux <= m3 & m2 & m1 & m0;
	 L1: comparador port map (sgSW0to3, comparadorOut);
	 L2: circuitoB port map (comparadorOut, circBOut);
	 L3: mux2x1 port map (SW(3), '0', comparadorOut, m3);
	 L4: mux2x1 port map (SW(2), circAOut(2), comparadorOut, m2);
	 L5: mux2x1 port map (SW(1), circAOut(1), comparadorOut, m1);
	 L6: mux2x1 port map (SW(0), circAOut(0), comparadorOut, m0);
	 L7: circuitoA port map (sgSW0to3(2 downto 0), circAOut);
    L8: decod7seg port map (concatenaMux, HEX0);

end topo_estru;


library IEEE;
use IEEE.Std_Logic_1164.all;

entity circuitoA is
port(entrada: in std_logic_vector(2 downto 0);
     saida:   out std_logic_vector(2 downto 0));
end circuitoA;

architecture circ of circuitoA is
begin

saida <= "000" when entrada = "010" else
			"001" when entrada = "011" else 
			"010" when entrada = "100" else 
			"011" when entrada = "101" else
			"100" when entrada = "110" else
			"101" when entrada = "111" else
			"000";
end circ;


library IEEE;
use ieee.std_logic_1164.all;

entity circuitoB is
port(entrada: in std_logic;
     saida: out std_logic_vector(6 downto 0));
end circuitoB;

architecture circ of circuitoB is
begin
    saida <= "1000000" when entrada = '0' else -- 0
				 "1111001";                        -- 1
end circ;


library IEEE;
use IEEE.Std_Logic_1164.all;

entity comparador is
port(entrada: in std_logic_vector(3 downto 0);
     saida:   out std_logic);
end comparador;

architecture comp of comparador is
begin

saida <= '1' when entrada = "1010" else
 	 '1' when entrada = "1011" else 
	 '1' when entrada = "1100" else 
	 '1' when entrada = "1101" else
	 '1' when entrada = "1110" else
	 '1' when entrada = "1111" else
	 '0';
end comp;


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


library IEEE;
use IEEE.Std_Logic_1164.all;

entity mux2x1 is
port(y, x, z: in std_logic;
     m: out std_logic);
end mux2x1;

architecture mux of mux2x1 is
begin
m <= y when z = '0' else
     x when z = '1' else
     z;
end mux;


