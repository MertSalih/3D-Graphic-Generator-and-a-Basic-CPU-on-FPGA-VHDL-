library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity pointFinder is
   Port (ramData: in std_logic_vector(95 downto 0);-- 47-0 first point 15-0 x 31-16y 47-32z
		 point1, point2: out std_logic_vector(16 downto 0); -- 8 downto 0 is x coordinate 16-9 is y coordinate
		 overFlow: out std_logic);
end pointFinder;

architecture Behavioral of pointFinder is


signal x1,y1,z1,x2,y2,z2: signed(15 downto 0);
signal px1,px2: signed(31 downto 0);
signal py1,py2: signed(31 downto 0);

begin

x1 <= resize(signed(ramData(15 downto 0)), 16);x2 <= resize(signed(ramData(63 downto 48)), 16);
y1 <= resize(signed(ramData(31 downto 16)), 16);y2 <= resize(signed(ramData(79 downto 64)), 16);
z1 <= resize(signed(ramData(47 downto 32)), 16);z2 <= resize(signed(ramData(95 downto 80)), 16);

px1<=((100*x1)/(100+z1))+159;
py1<=((100*y1)/(100+z1))+109;
px2<=((100*x2)/(100+z2))+159;
py2<=((100*y2)/(100+z2))+109;

point1(8 downto 0)<=std_logic_vector(px1(8 downto 0));
point1(16 downto 9)<=std_logic_vector(py1(7 downto 0));
point2(8 downto 0)<=std_logic_vector(px2(8 downto 0));
point2(16 downto 9)<=std_logic_vector(py2(7 downto 0));

process(px1,px2,py2,py1) begin
if px1<0 or px1>319 then overFlow<='1';
elsif py1<0 or py1>219 then overFlow<='1';
elsif px2<0 or px2>319 then overFlow<='1';
elsif py2<0 or py2>219 then overFlow<='1';
else overFlow<='0';
end if;
end process;

end Behavioral;
