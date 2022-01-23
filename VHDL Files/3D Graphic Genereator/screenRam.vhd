library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity screenRam is
   Port (dataOut: out std_logic;
		 dataIn , clk, en: in std_logic;
		 ahdin,ahdout: in std_logic_vector(8 downto 0);
		 avdin,avdout: in std_logic_vector(7 downto 0));
		 --dataO=data out, dataIn=data input
		 -- vertical data in adress avdin
end screenRam;

architecture Behavioral of screenRam is

type ramsc is array  (0 to 319) of std_logic_vector(219 downto 0);
signal ram: ramsc;

begin

process(clk,dataIn,en)begin

	if rising_edge(clk) then
		if en='1' then
			ram(to_integer(unsigned(ahdin)))(to_integer(unsigned(avdin)))<=dataIn;
		end if;
	end if;

end process;

dataOut<=ram(to_integer(unsigned(ahdout)))(to_integer(unsigned(avdout)));

end Behavioral;

