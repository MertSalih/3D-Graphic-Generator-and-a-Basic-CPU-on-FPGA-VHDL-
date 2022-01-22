library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity cpuMain is
    Port (ramDatain: out std_logic_vector(15 downto 0);
          ramDataout: in std_logic_vector(15 downto 0);
		  ramAddress: out std_logic_vector(7 downto 0);
		  ramWE: out std_logic;
		  clk: in std_logic;
		  c1Datain, c2Datain: std_logic_vector(7 downto 0));--controller data in
end cpuMain;

architecture Behavioral of cpuMain is

component InstReg 
    Port (order: in std_logic_vector(7 downto 0);
		  inst: out std_logic_vector(31 downto 0));
end component;

component ALUMain 
    Port (inA, inB: in std_logic_vector(15 downto 0);
		  command: in std_logic_vector(4 downto 0);
		  dataOut: out std_logic_vector(15 downto 0));
end component;

component RegisterMain 
    Port (we,clk:in std_logic;
		  AddresA, AddresB, AddresW: in std_logic_vector(5 downto 0);
		  DataW: in std_logic_vector(15 downto 0);
		  con1, con2: in std_logic_vector(7 downto 0);
		  OutA, OutB: out std_logic_vector(15 downto 0));
end component;

signal currentInstOrder : std_logic_vector(7 downto 0):=x"00";
signal nextInstOrder, ALUnextInst: std_logic_vector(7 downto 0);
signal currentInst: std_logic_vector(31 downto 0):=x"00000000";
signal extendedCons: std_logic_vector(15 downto 0);
signal regOutA, regOutB, regIn : std_logic_vector(15 downto 0);
signal regWE, ALUmux, baranchCont: std_logic;
signal ALUinb, ALUout: std_logic_vector(15 downto 0);
signal ALUcom: std_logic_vector(4 downto 0);
signal regDataSel, branchDec: std_logic_vector(1 downto 0);




begin

extendedCons<=currentInst(14)&currentInst(14 downto 0);
ramAddress<=currentInst(7 downto 0);
ramDatain<=regOutA;

reg: RegisterMain port map(clk=>clk,AddresA=>currentInst(26 downto 21),AddresB=>currentInst(5 downto 0),con1=>c1Datain,con2=>c2Datain,
				           AddresW=>currentInst(20 downto 15),OutA=>regOutA,OutB=>regOutB,we=>regWE,DataW=>regIn);
alu: ALUMain port map(inA=>regOutA,inB=>ALUinb,command=>ALUcom,dataOut=>ALUout);
commandSet: InstReg port map(order=>currentInstOrder,inst=>currentInst); 

ALUinb<= extendedCons when ALUmux='1' else regOutB;

with regDataSel select
	regIn<= extendedCons when "11",
		    ALUout when "10",
			ramDataout when "01",
		    regOutA when others;

nextInstOrder<= extendedCons(7 downto 0) when baranchCont='1' else ALUnextInst;

ALUnextInst<= x"00" when currentInstOrder=x"FF" else
			  std_logic_vector(unsigned(currentInstOrder)+2) when (((not ALUout(15))and branchDec(0) and(not branchDec(1)))or((ALUout(15))and branchDec(1) and(not branchDec(0))))='1' else
			  std_logic_vector(unsigned(currentInstOrder)+1);
			  
process(clk) begin
if rising_edge(clk) then
currentInstOrder<=nextInstOrder;
end if;
end process;

--control unit
process(currentInst)begin
if unsigned(currentInst(31 downto 27))<21 then regDataSel<="10";
elsif currentInst(31 downto 27)="10101" then regDataSel<="01";
elsif currentInst(31 downto 27)="10111" then regDataSel<="00";
else regDataSel<="11";
end if;
end process;

with currentInst(31 downto 27)select
ramWE<= '1' when "10110",
		'0' when others;

process(currentInst)begin
if unsigned(currentInst(31 downto 27))<22 then regWE<='1';
elsif currentInst(31 downto 27)="10111" then regWE<='1';
elsif currentInst(31 downto 27)="11000" then regWE<='1';
else regWE<='0';
end if;
end process;

with currentInst(31 downto 27)select
branchDec<="01" when "11010"|"11100",
           "10" when "11011",
		   "00" when others;

with currentInst(31 downto 27)select
baranchCont<='1'when "11001",
             '0'when others;

process(currentInst)begin
if unsigned(currentInst(31 downto 27))<21 then ALUcom<=currentInst(31 downto 27);
else ALUcom<="00001";
end if;
end process;


with currentInst(31 downto 27)select
ALUmux<= '0' when "00000"|"00001"|"00010"|"00011"|"00100"|"00101"|"00110"|"00111"|"11100",
		 '1' when others;

end Behavioral;
