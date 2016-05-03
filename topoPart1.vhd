library ieee;
use ieee.std_logic_1164.all;

entity topoPart1 is
port(SW: in std_logic_vector(15 downto 0);
     LEDR: out std_logic_vector(9 downto 0);
	  HEX0: out std_logic_vector(6 downto 0);
	  HEX1: out std_logic_vector(6 downto 0);
	  HEX2: out std_logic_vector(6 downto 0);
	  HEX3: out std_logic_vector(6 downto 0));
end topoPart1;
	
architecture topo_estru of topoPart1 is
	signal sgSW12to15, sgSW8to11, sgSW4to7, sgSW0to3: std_logic_vector(3 downto 0);
     
component decod7seg
	port(entrada: in std_logic_vector(3 downto 0);
        saida: out std_logic_vector(6 downto 0));
end component;

begin
    sgSW12to15 <= SW(15 downto 12);
    sgSW8to11  <= SW(11 downto  8);
    sgSW4to7   <= SW(7 downto   4);
    sgSW0to3   <= SW(3 downto   0);
    L1: decod7seg port map (sgSW12to15, HEX3);
    L2: decod7seg port map (sgSW8to11 , HEX2);
    L3: decod7seg port map (sgSW4to7  , HEX1);
    L4: decod7seg port map (sgSW0to3  , HEX0);

end topo_estru;