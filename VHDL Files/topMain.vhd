library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity topMain is
    Port (clk: in std_logic;
		  Hsy, Vsy: out std_logic;
		  datareg1, datareg2: out std_logic_vector(7 downto 0);
		  Rout, Gout, Bout: out std_logic_vector(3 downto 0);
		  clkout,load: out std_logic_vector(1 downto 0);
		  data: in std_logic_vector(1 downto 0));
end topMain;

architecture Behavioral of topMain is

component controllers 
   Port (clk: in std_logic;
		 clkout,load: out std_logic_vector(1 downto 0);
		 data: in std_logic_vector(1 downto 0);
		 datareg1,datareg2: out std_logic_vector(7 downto 0));
end component;

component threeDmodul 
    Port (clk: in std_logic;
		  Hsy, Vsy: out std_logic;
		  ObjectRamData: in std_logic_vector(95 downto 0);
		  ObjectRamAddress: out std_logic_vector(5 downto 0);
		  Rout, Gout, Bout: out std_logic_vector(3 downto 0));
end component;

component ObjectRam 
    Port (clk,WE: in std_logic;
		  dataGPU: out std_logic_vector(95 downto 0);
		  dataCPUout: out std_logic_vector(15 downto 0);
		  dataCPUin: in std_logic_vector(15 downto 0);
		  addressCPU: in std_logic_vector(7 downto 0);
		  addressGPU: in std_logic_vector(5 downto 0));
end component;

component cpuMain is
    Port (ramDatain: out std_logic_vector(15 downto 0);
          ramDataout: in std_logic_vector(15 downto 0);
		  ramAddress: out std_logic_vector(7 downto 0);
		  ramWE: out std_logic;
		  clk: in std_logic;
		  c1Datain, c2Datain: std_logic_vector(7 downto 0));--controller data in
end component;

signal cputoRam, ramtoCPU : std_logic_vector(15 downto 0);
signal cpuRamAdd: std_logic_vector(7 downto 0);
signal ramWE: std_logic;
signal cpuClk: std_logic;
signal contCPUreg1, contCPUreg2: std_logic_vector(7 downto 0);
signal ramtoGPU: std_logic_vector(95 downto 0);
signal gpuRamAdd: std_logic_vector(5 downto 0);

begin
datareg1<=contCPUreg1;
datareg2<=contCPUreg2;
cpucore : cpuMain port map(ramDatain=>cputoRam,ramDataout=>ramtoCPU,ramAddress=>cpuRamAdd,ramWE=>ramWE,clk=>cpuClk,c1Datain=>contCPUreg1,c2Datain=>contCPUreg2);
controllerModule: controllers port map(clk=>clk,clkout=>clkout,load=>load,data=>data,datareg1=>contCPUreg1,datareg2=>contCPUreg2);
mainRam : ObjectRam port map(clk=>clk,WE=>ramWE,dataCPUout=>ramtoCPU,dataCPUin=>cputoRam,addressCPU=>cpuRamAdd,dataGPU=>ramtoGPU,addressGPU=>gpuRamAdd);
threeD: threeDmodul port map(clk=>clk,Hsy=>Hsy,Vsy=>Vsy,ObjectRamData=>ramtoGPU,ObjectRamAddress=>gpuRamAdd,Rout=>Rout,Gout=>Gout,Bout=>Bout);

clkCpu: process (clk) 
variable state: integer range 0 to 4000;
begin
if rising_edge(clk)then 
	if state<4000 then state:=state+1;
	else state:=0;
	end if;
	if state=4000 then cpuClk<='1';
	else cpuClk<='0';
	end if;
end if;
end process clkCpu;

end Behavioral;
