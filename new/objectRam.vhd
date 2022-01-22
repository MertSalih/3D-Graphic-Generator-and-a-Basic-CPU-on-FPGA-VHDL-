library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
 
entity ObjectRam is
    Port (clk,WE: in std_logic;
		  dataGPU: out std_logic_vector(95 downto 0);
		  dataCPUout: out std_logic_vector(15 downto 0);
		  dataCPUin: in std_logic_vector(15 downto 0);
		  addressCPU: in std_logic_vector(7 downto 0);
		  addressGPU: in std_logic_vector(5 downto 0));
end ObjectRam;

architecture Behavioral of ObjectRam is

type ramOb is array  (0 to 255) of std_logic_vector(15 downto 0);
signal ram: ramOb:=(
x"FED4",x"0048",x"0190",x"FED4",x"0048",x"0226",
x"FED4",x"0048",x"0190",x"FF6A",x"0048",x"0190",
x"FF6A",x"0048",x"0190",x"FF6A",x"0048",x"0226",
x"FF6A",x"0048",x"0226",x"FED4",x"0048",x"0226",
x"FED4",x"FFB8",x"0226",x"FED4",x"FFB8",x"0190",
x"FED4",x"FFB8",x"0190",x"FF6A",x"FFB8",x"0190",
x"FF6A",x"FFB8",x"0190",x"FF6A",x"FFB8",x"0226",
x"FF6A",x"FFB8",x"0226",x"FED4",x"FFB8",x"0226",
x"FED4",x"0048",x"0226",x"FED4",x"FFB8",x"0226",
x"FED4",x"0048",x"0190",x"FED4",x"FFB8",x"0190",
x"FF6A",x"0048",x"0190",x"FF6A",x"FFB8",x"0190",
x"FF6A",x"0048",x"0226",x"FF6A",x"FFB8",x"0226",

x"0096",x"0048",x"0190",x"0096",x"0048",x"0226",
x"0096",x"0048",x"0190",x"012C",x"0048",x"0190",
x"012C",x"0048",x"0190",x"012C",x"0048",x"0226",
x"012C",x"0048",x"0226",x"0096",x"0048",x"0226",
x"0096",x"FFB8",x"0226",x"0096",x"FFB8",x"0190",
x"0096",x"FFB8",x"0190",x"012C",x"FFB8",x"0190",
x"012C",x"FFB8",x"0190",x"012C",x"FFB8",x"0226",
x"012C",x"FFB8",x"0226",x"0096",x"FFB8",x"0226",
x"0096",x"0048",x"0226",x"0096",x"FFB8",x"0226",
x"0096",x"0048",x"0190",x"0096",x"FFB8",x"0190",
x"012C",x"0048",x"0190",x"012C",x"FFB8",x"0190",
x"012C",x"0048",x"0226",x"012C",x"FFB8",x"0226",

x"FFF0",x"FFF0",x"01DB",x"FFF0",x"FFF0",x"01DB",
x"FFF0",x"FFF0",x"01DB",x"FFF0",x"FFF0",x"01DB",
x"FFF0",x"FFF0",x"FFF0",x"FFF0",x"FFF0",x"FFF0",
x"FFF0",x"FFF0",x"FFF0",x"FFF0",x"FFF0",x"FFF0",
x"FFF0",x"FFF0",x"FFF0",x"FFF0",x"FFF0",x"FFF0",
x"FFF0",x"FFF0",x"FFF0",x"FFF0",x"FFF0",x"FFF0",
x"FFF0",x"FFF0",x"FFF0",x"FFF0",x"FFF0",x"FFF0",
x"FFF0",x"FFF0",x"FFF0",x"FFF0",x"FFF0",x"FFF0",
x"FFF0",x"FFF0",x"FFF0",x"FFF0",x"FFF0",x"FFF0",
x"FFF0",x"FFF0",x"FFF0",x"FFF0",x"FFF0",x"FFF0",
x"FFF0",x"FFF0",x"FFF0",x"FFF0",x"FFF0",x"FFF0",
x"FFF0",x"FFF0",x"FFF0",x"FFF0",x"FFF0",x"FFF0",
x"FFF0",x"FFF0",x"FFF0",x"FFF0",x"FFF0",x"FFF0",
x"FFF0",x"FFF0",x"FFF0",x"FFF0",x"FFF0",x"FFF0",
x"FFF0",x"FFF0",x"FFF0",x"FFF0",x"FFF0",x"FFF0",
x"FFF0",x"FFF0",x"FFF0",x"FFF0",x"FFF0",x"FFF0",
x"FFF0",x"FFF0",x"FFF0",x"FFF0",x"FFF0",x"FFF0",
x"FFF0",x"FFF0",x"FFF0",x"FFF0",x"FFF0",x"FFF0", 
x"FFF0",x"FFF0",x"FFF0",x"FFF0"
);


begin
process (clk)
variable partofRam: integer;
variable partofRam2: integer;
begin
if rising_edge(clk)then
partofRam:=to_integer((unsigned(addressCPU) mod 6)*16);
partofRam2:=partofRam+15;
dataGPU<=ram(to_integer(unsigned(addressGPU)*6+5))&ram(to_integer(unsigned(addressGPU)*6+4))&ram(to_integer(unsigned(addressGPU)*6+3))
        &ram(to_integer(unsigned(addressGPU)*6+2))&ram(to_integer(unsigned(addressGPU)*6+1))&ram(to_integer(unsigned(addressGPU)*6));
if WE='1'then
ram(to_integer(unsigned(addressCPU)))<=dataCPUin;
else 
dataCPUout<=ram(to_integer(unsigned(addressCPU)));
end if;
end if;
end process;
end Behavioral;

