library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity lineDrawer is
   Port (start, clk: in std_logic;
		 point1,point2: in std_logic_vector(16 downto 0);
		 -- 8 downto 0 is x coordinate 16-9 is y coordinate
		 finish,en: out std_logic;
		 adressv, adressh: out std_logic_vector(8 downto 0));
end lineDrawer;

architecture Behavioral of lineDrawer is

signal x1,y1,x2,y2: signed(9 downto 0);
signal regx1,regy1,regx2,regy2: signed(9 downto 0);
signal deltax,deltay: signed(9 downto 0);
signal temporal: signed(18 downto 0);

begin

x1 <= resize(signed('0'&point1(8 downto 0)), 10);
y1 <= resize(signed('0'&point1(16 downto 9)), 10);
x2 <= resize(signed('0'&point2(8 downto 0)), 10);
y2 <= resize(signed('0'&point2(16 downto 9)), 10);


process(clk,start,point1,point2)
variable state: integer range 0 to 7;
variable algo: integer range 0 to 3;
variable xs: signed(8 downto 0):=(others => '0');--x step
variable ys: signed(8 downto 0):=(others => '0');--y step
variable adressht, adressvt: std_logic_vector(9 downto 0);
begin
if rising_edge(clk)then
	if state=0 then
		finish<='0';
		if start='1' then state:=1;
		else state:=0;
		end if;
	elsif state=1 then
		if abs(x1-x2)>abs(y1-y2) then 
			state:=2;
			if x1<x2 then
				algo:=0;
				regx1<=x1;--small one
				regy1<=y1;
				regx2<=x2;
				regy2<=y2;
				deltax<= x2-x1;
				deltay<= y2-y1;
			else
				algo:=1;
				regx1<=x2;
				regy1<=y2;
				regx2<=x1;
				regy2<=y1;
				deltax<= x1-x2;
				deltay<= y1-y2;
			end if;
		else 
			state:=4;
			if y1<y2 then
				algo:=2;
				regx1<=x1;
				regy1<=y1;--small one
				regx2<=x2;
				regy2<=y2;
				deltax<= x2-x1;
				deltay<= y2-y1;
			else
				algo:=3;
				regx1<=x2;
				regy1<=y2;
				regx2<=x1;
				regy2<=y1;
				deltax<= x1-x2;
				deltay<= y1-y2;
			end if;
		end if;
	elsif state=2 then
		en<='0';
		temporal<=deltay*xs;
		state:=3;
	elsif state=3 then
		en<='1';
		adressht:= std_logic_vector(resize(xs+regx1,10));
		adressvt:= std_logic_vector(resize((temporal/deltax)+regy1,10));
		adressh<=adressht(8 downto 0);
		adressv<=adressvt(8 downto 0);
		if xs<deltax then 
			xs:=xs+1;
			state:=2;
		else 
			xs:=(others => '0');
			state:=6;
		end if;
	elsif state=4 then
		en<='0';
		temporal<=deltax*ys;
		state:=5;
	elsif state=5 then
		en<='1';
		adressht:= std_logic_vector(resize((temporal/deltay)+regx1,10));
		adressvt:= std_logic_vector(resize(ys+regy1,10));
		adressh<=adressht(8 downto 0);
		adressv<=adressvt(8 downto 0);
		if ys<deltay then 
			ys:=ys+1;
			state:=4;
		else 
			ys:=(others => '0');
			state:=6;
		end if;
	else
		en<='0';
		state:=0;
		finish<='1';
	end if;
	
end if;

end process;


end Behavioral;
