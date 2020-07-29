LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;


entity AAC2M2P1 is port (                 	
   CP: 	in std_logic; 	-- clock
   SR:  in std_logic;  -- Active low, synchronous reset
   P:    in std_logic_vector(3 downto 0);  -- Parallel input
   PE:   in std_logic;  -- Parallel Enable (Load)
   CEP: in std_logic;  -- Count enable parallel input
   CET:  in std_logic; -- Count enable trickle input
   Q:   out std_logic_vector(3 downto 0):="0000";            			
    TC:  out std_logic  -- Terminal Count
);            		
end AAC2M2P1;

architecture counter of AAC2M2P1 is 
signal temp:unsigned(3 downto 0);
begin
proc: process(CP,SR,PE,CEP,CET)
begin
 if(rising_edge(CP)) then
if SR='0' then temp<="0000";
elsif PE='0' then temp<=unsigned(P);
elsif CET='1' and CEP='1' then temp<= temp+1;
end if;
end if;
end process proc;
Q<=std_logic_vector(temp);
TC<= '1' when temp="1111" and CET='1' else '0';
end architecture counter;