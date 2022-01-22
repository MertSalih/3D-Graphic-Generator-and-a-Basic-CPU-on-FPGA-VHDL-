Library IEEE;
use IEEE.STD_Logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;


entity vgaController is
   Port (clk: in std_logic;  -- 100 Mhz clock
		 pixel: in std_logic;
         row, column : out std_logic_vector(9 downto 0); -- for current pixel
         Rout, Gout, Bout: out std_logic_vector(3 downto 0);
		 H, V, vgaRes : out std_logic);
end vgaController;

architecture Behavioral of vgaController is

subtype counter is std_logic_vector(9 downto 0);
  constant B : natural := 93;  -- horizontal blank: 3.77 us
  constant C : natural := 45;  -- front guard: 1.89 us
  constant D : natural := 640; -- horizontal columns: 25.17 us
  constant E : natural := 22;  -- rear guard: 0.94 us
  constant A : natural := B + C + D + E;  -- one horizontal sync cycle: 31.77 us
  constant P : natural := 2;   -- vertical blank: 64 us
  constant Q : natural := 32;  -- front guard: 1.02 ms
  constant R : natural := 480; -- vertical rows: 15.25 ms
  constant S : natural := 11;  -- rear guard: 0.35 ms
  constant O : natural := P + Q + R + S;  -- one vertical sync cycle: 16.6 ms

signal clock : std_logic;

begin
	
clk25: process (clk) -- Clock divider. Clock out is 25MHz
variable state: integer range 0 to 3;
begin
if rising_edge(clk)then 
	if state<3 then state:=state+1;
	else state:=0;
	end if;
	if state=3 then clock<='1';
	else clock<='0';
	end if;
end if;
end process clk25;

  process
    variable vertical, horizontal : counter;  -- define counters
  begin
    wait until clock = '1';

  -- increment counters
      if  horizontal < A - 1  then
        horizontal := horizontal + 1;
      else
        horizontal := (others => '0');

        if  vertical < O - 1  then -- less than oh
          vertical := vertical + 1;
        else
          vertical := (others => '0');       -- is set to zero
        end if;
      end if;

  -- define H pulse
      if  horizontal >= (D + E)  and  horizontal < (D + E + B)  then
        H <= '0';
      else
        H <= '1';
      end if;

  -- define V pulse
      if  vertical >= (R + S)  and  vertical < (R + S + P)  then
        V <= '0';
		vgaRes<='1';
      else
        V <= '1';
		vgaRes<='0';
      end if;

	  if  (vertical < 440) and (horizontal<D) then
		row <= vertical;
		column <= horizontal;
		Rout <= pixel&pixel&pixel&pixel;
        Gout <= pixel&pixel&pixel&pixel;
		Bout <= pixel&pixel&pixel&pixel;
	 else 
		Rout <= (others=>'1');
		Gout <= (others=>'1');
		Bout <= (others=>'1');
	 end if;

    -- mapping of the variable to the signals
    -- negative signs are because the conversion bits are reversed


  end process;

end architecture;
