library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity controlUnit is
    Port (overflow,finish,ramEn, vgaRes, clk, clkres: in std_logic;
		  Obadress: out std_logic_vector(5 downto 0);--object adress
		  adressv: out std_logic_vector(8 downto 0);
		  adressh: out std_logic_vector(8 downto 0);
		  dataSelect, data, enable, start: out std_logic);
		  -- dataSelect='0' for reset, '1' for write
		  -- data should be 1 for drawline
end controlUnit;

architecture Behavioral of controlUnit is
signal resetCondition: std_logic:='0';
signal resetFinish: std_logic:='0';
signal resetEn: std_logic:='0';
signal writeEn: std_logic:='0';
begin

enable<=resetEn or (writeEn and ramEn);

resetScreen: process(clkres,resetCondition)
variable hlen: unsigned (8 downto 0):=(others => '0');
variable vlen: unsigned (8 downto 0):=(others => '0');
variable rstate: integer range 0 to 1;
begin
if rising_edge(clkres)then
	if rstate=0 then
		
		if resetCondition='1' then
			resetFinish<='0';
			rstate:=1;
		end if;
	elsif rstate=1 then
		adressv<=std_logic_vector(vlen);
		adressh<=std_logic_vector(hlen);
		if hlen=319 then
			hlen:=(others => '0');
			vlen:=vlen+1;
		else
			hlen:=hlen+1;
		end if;
		if vlen=219 then
			vlen:=(others => '0');
			rstate:=0;
			resetFinish<='1';
		end if;
	end if;
end if;

end process resetScreen;


main: process(clk,finish,vgaRes,ramEn)
variable state: integer range 0 to 7;
variable ObjectCount: unsigned(5 downto 0);--Length of Object Ram
begin

if rising_edge(clk)then
	if state=0 then
		ObjectCount:=(others => '0');
		writeEn<='0';
		start<='0';
		if vgaRes='1' then
			resetCondition<='1';
			resetEn<='1';
			data<='0';--To reset screen
			dataSelect<='0';
			state:=1;
		else	
			resetCondition<='0';
			resetEn<='0';
			state:=0;
		end if;
	
	elsif state=1 then
		resetCondition<='0';
		if resetFinish='1' then
			state:=2;
			resetEn<='0';
			data<='1';--To write screen
			dataSelect<='1';
		end if;
	
	elsif state=2 then
		Obadress<=std_logic_vector(ObjectCount);
		state:=3;
	elsif state=3 then 
		if overflow='0'then
			state:=4;
		else
			state:=6;
		end if;
	elsif state=4 then
		start<='1';
		writeEn<='1';
		start<='1';
		state:=5;
	elsif state=5 then
		start<='0';
		if finish='1' then
			state:=6;
			writeEn<='0';
		else 
			state:=5;
		end if;
	elsif state=6 then
		writeEn<='0';
		if ObjectCount="011111" then
			ObjectCount:= (others => '0');
			state:=0;
		else
			ObjectCount:=ObjectCount+1;
			state:=2;
		end if;
	end if;		
end if;

end process main;

end Behavioral;
