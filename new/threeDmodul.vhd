library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity threeDmodul is
    Port (clk: in std_logic;
		  Hsy, Vsy: out std_logic;
		  ObjectRamData: in std_logic_vector(95 downto 0);
		  ObjectRamAddress: out std_logic_vector(5 downto 0);
		  Rout, Gout, Bout: out std_logic_vector(3 downto 0));
end threeDmodul;

architecture Behavioral of threeDmodul is

component vgaController 
   Port (clk: in std_logic;  -- 100 Mhz clock
		 pixel: in std_logic;
         row, column : out std_logic_vector(9 downto 0); -- for current pixel
         Rout, Gout, Bout: out std_logic_vector(3 downto 0);
		 H, V, vgaRes: out std_logic);
end component;

component screenRam 
   Port (dataOut: out std_logic;
		 dataIn , clk, en: in std_logic;
		 ahdin,ahdout: in std_logic_vector(8 downto 0);
		 avdin,avdout: in std_logic_vector(7 downto 0));
		 --dataO=data out, dataIn=data input
		 -- vertical data in adress avdin
end component;

component threeDimensionModuleCore 
   Port (clk, vgaRes: in std_logic;
		 EnRam,pixelData: out std_logic;
		 objectBus: in std_logic_vector(95 downto 0);--Object Ram Data
		 ObjectAdd: out std_logic_vector(5 downto 0);
		 adressVer: out std_logic_vector(8 downto 0);
		 adressHor: out std_logic_vector(8 downto 0));
end component;



signal vgaRes: std_logic;
signal ObRamD: std_logic_vector(95 downto 0);
signal ObRamA: std_logic_vector(3 downto 0);
signal scRinV: std_logic_vector(8 downto 0);
signal scRinH: std_logic_vector(8 downto 0);
signal scRoutV: std_logic_vector(9 downto 0);
signal scRoutH: std_logic_vector(9 downto 0);
signal scRamEn: std_logic;
signal scRDout: std_logic;
signal scRDin: std_logic;

begin

threeD: threeDimensionModuleCore port map(clk=>clk,vgaRes=>vgaRes,EnRam=>scRamEn,objectBus=>ObjectRamData,ObjectAdd=>ObjectRamAddress,adressVer=>scRinV,adressHor=>scRinH,pixelData=>scRDin);
scrRam: screenRam port map(dataOut=>scRDout,dataIn=>scRDin,clk=>clk,en=>scRamEn,ahdin=>scRinH,avdin=>scRinV(7 downto 0),ahdout=>scRoutH(9 downto 1),avdout=>scRoutV(8 downto 1));
vga: vgaController port map(clk=>clk,pixel=>scRDout,row=>scRoutV,column=>scRoutH,Rout=>Rout,Gout=>Gout,Bout=>Bout,H=>Hsy,V=>Vsy,vgaRes=>vgaRes);


end Behavioral;

