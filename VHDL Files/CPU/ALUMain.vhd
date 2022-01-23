library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ALUMain is
    Port (inA, inB: in std_logic_vector(15 downto 0);
		  command: in std_logic_vector(4 downto 0);
		  dataOut: out std_logic_vector(15 downto 0));
end ALUMain;

architecture Behavioral of ALUMain is

signal mina, minb, mout : signed(15 downto 0);
signal command2: std_logic_vector(7 downto 0);

begin

mina<=signed(ina);
minb<=signed(inb);
dataOut<=std_logic_vector(mout);
command2<="000"&command;
with command2 select
mout<= mina+minb when X"00"|X"0A",
	   mina-minb when X"01"|X"0B",
	   resize(mina*minb,16) when x"02"|X"0C",
	   mina/minb when x"03"|X"0D",
	   mina mod minb when x"04"|X"0E",
	   mina or minb when x"05"|X"0F",
	   mina and minb when x"06"|X"10",
	   mina xor minb when x"07"|X"11",
	   mina sll to_integer(minb) when x"08",
	   mina srl to_integer(minb) when x"09",
	   minb-mina when X"12",
	   minb-mina when X"13",
	   -mina when X"14",
	   mina + minb when others;



end Behavioral;
