
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity RegisterMain is
    Port (we,clk:in std_logic;
		  AddresA, AddresB, AddresW: in std_logic_vector(5 downto 0);
		  DataW: in std_logic_vector(15 downto 0);
		  con1, con2: in std_logic_vector(7 downto 0);
		  OutA, OutB: out std_logic_vector(15 downto 0));
end RegisterMain;

architecture Behavioral of RegisterMain is

type reg64_16 is array  (0 to 63) of std_logic_vector(15 downto 0);
signal reg: reg64_16:=(others=>(others=>'0'));

begin

OutA<=reg(to_integer(unsigned(AddresA)));
OutB<=reg(to_integer(unsigned(AddresB)));

process(we,clk) begin
if rising_edge(clk)then
reg(62)<=x"00"&con1;
reg(63)<=x"00"&con2;
if we='1' then
	reg(to_integer(unsigned(AddresW)))<=DataW;
end if;
end if;
end process;

end Behavioral;
