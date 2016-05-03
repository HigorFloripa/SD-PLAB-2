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