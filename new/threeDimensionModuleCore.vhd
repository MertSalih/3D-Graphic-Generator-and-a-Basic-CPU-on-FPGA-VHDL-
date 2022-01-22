library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity threeDimensionModuleCore is
   Port (clk, vgaRes: in std_logic;
		 EnRam,pixelData: out std_logic;
		 objectBus: in std_logic_vector(95 downto 0);--Object Ram Data
		 ObjectAdd: out std_logic_vector(5 downto 0);
		 adressVer: out std_logic_vector(8 downto 0);
		 adressHor: out std_logic_vector(8 downto 0));
end threeDimensionModuleCore;

architecture Behavioral of threeDimensionModuleCore is

component controlUnit 
    Port (overflow,finish,ramEn, vgaRes, clk, clkres: in std_logic;
		  Obadress: out std_logic_vector(5 downto 0);--object adress
		  adressv: out std_logic_vector(8 downto 0);
		  adressh: out std_logic_vector(8 downto 0);
		  dataSelect, data, enable, start: out std_logic);
end component;

component pointFinder 
   Port (ramData: in std_logic_vector(95 downto 0);-- 47-0 first point 15-0 x 31-16y 47-32z
		 point1, point2: out std_logic_vector(16 downto 0); -- 8 downto 0 is x coordinate 16-9 is y coordinate
		 overFlow: out std_logic);
end component;

component lineDrawer 
   Port (start, clk: in std_logic;
		 point1,point2: in std_logic_vector(16 downto 0);
		 -- 8 downto 0 is x coordinate 16-9 is y coordinate
		 finish,en: out std_logic;
		 adressv, adressh: out std_logic_vector(8 downto 0));
end component;

signal overflow: std_logic;
signal finish: std_logic;
signal lineEn: std_logic;
signal clkFast: std_logic;
signal clkSlow: std_logic;
signal dataSelect: std_logic;
signal adressvc, adressvl: std_logic_vector(8 downto 0);
signal adresshc, adresshl: std_logic_vector(8 downto 0);
signal start: std_logic;
signal pointD1, pointD2: std_logic_vector(16 downto 0);

begin

pointFind: pointFinder port map(ramData=>objectBus,point1=>pointD1,point2=>pointD2,overFlow=>overflow);
lineDraw: lineDrawer port map(start=>start,clk=>clkSlow,point1=>pointD1,point2=>pointD2,finish=>finish,en=>lineEn,adressv=>adressvl,adressh=>adresshl);
contUnit: controlUnit port map(overflow=>overflow,finish=>finish,ramEn=>lineEn,vgaRes=>vgaRes,
	clk=>clkSlow,clkres=>clkFast,Obadress=>ObjectAdd,adressv=>adressvc,adressh=>adresshc,dataSelect=>dataSelect, data=>pixelData, enable=>EnRam, start=>start);

with dataSelect select
	adressVer<= adressvl when '1',
				adressvc when others;
with dataSelect select
	adressHor<= adresshl when '1',
				adresshc when others;

clkFast<=clk;
clk500: process(clkFast)
variable step:integer range 0 to 99;
begin
if rising_edge(clkFast)then
	if step=99 then
		step:=0;
		clkSlow<='1';
	else
		step:=step+1;
		clkSlow<='0';
	end if;
end if;
end process clk500;

end Behavioral;
