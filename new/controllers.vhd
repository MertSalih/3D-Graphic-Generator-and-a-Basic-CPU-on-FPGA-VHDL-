library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity controllers is
   Port (clk: in std_logic;
		 clkout,load: out std_logic_vector(1 downto 0);
		 data: in std_logic_vector(1 downto 0);
		 datareg1,datareg2: out std_logic_vector(7 downto 0));
end controllers;

architecture Behavioral of controllers is
signal clkin: std_logic;
signal clkin2: std_logic;
begin

clockOut: process(clkin2)
variable stepn :integer range 0 to 1;
begin
if falling_edge(clkin2)then 
	if stepn=1 then
		clkOut<="11";
		stepn:=0;
	else 
		clkOut<="00";
		stepn:=1;
	end if;
end if;

end process clockOut;

state: process(clkin) 
variable situ: integer range 0 to 8;
begin
if rising_edge(clkin) then
	if situ=8 then
		load<="00";
		situ:=0;
	else 
		load<="11";
		datareg1(situ)<=data(0);
		datareg2(situ)<=data(1);
		situ:=situ+1;
	end if;
end if;

end process state;

clkArrange: process(clk)
variable step: integer range 0 to 100000;
begin
if rising_edge(clk) then
	if step=100000 then
		step:=0;
		clkin<='1';
	elsif step=50000 then
		clkin<='0';
		step:=step+1;
	else  
		step:=step+1;
	end if;
end if;	
end process clkArrange;

clkArrange2: process(clk)
variable stepk: integer range 0 to 50000;
begin
if rising_edge(clk) then
	if stepk=50000 then
		stepk:=0;
		clkin2<='1';
	elsif stepk=25000 then
		clkin2<='0';
		stepk:=stepk+1;
	else  
		stepk:=stepk+1;
	end if;
end if;	
end process clkArrange2;

end Behavioral;
