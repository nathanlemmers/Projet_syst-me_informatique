----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11.05.2023 11:44:10
-- Design Name: 
-- Module Name: test_Banc_registres - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity test_Banc_registres is
--  Port ( );
end test_Banc_registres;

architecture Behavioral of test_Banc_registres is

COMPONENT Banc_registres 
Port ( aA : in STD_LOGIC_VECTOR (3 downto 0);
           aB : in STD_LOGIC_VECTOR (3 downto 0);
           aW : in STD_LOGIC_VECTOR (3 downto 0);
           W : in STD_LOGIC;
           DATA : in STD_LOGIC_VECTOR (7 downto 0);
           RST : in STD_LOGIC;
           CLK : in STD_LOGIC ;
           QA : out STD_LOGIC_VECTOR (7 downto 0);
           QB : out STD_LOGIC_VECTOR (7 downto 0));

END COMPONENT ;
signal aA : STD_LOGIC_VECTOR (3 downto 0);
signal aB : STD_LOGIC_VECTOR (3 downto 0);
signal aW : STD_LOGIC_VECTOR (3 downto 0);
signal W : STD_LOGIC;
signal DATA : STD_LOGIC_VECTOR (7 downto 0);
signal RST : STD_LOGIC;
signal CLK : STD_LOGIC := '0';
signal QA : STD_LOGIC_VECTOR (7 downto 0);
signal QB : STD_LOGIC_VECTOR (7 downto 0);

constant Clock_period : time := 10 ns;

begin
Label_uut:Banc_registres PORT MAP(
    aA => aA ,
    aB => aB ,
    aW => aW ,
    W => W ,
    DATA => DATA ,
    RST => RST ,
    CLK => CLK,
    QA => QA, 
    QB => QB
    );

Clock_process: process 
    begin 
    CLK <= not(CLK) ;
    wait for Clock_period/2 ;
 end process ;

RST <= '0' after 0 ns, '1' after 15 ns ;
aA <= x"0" after 105 ns, x"1" after 115ns ;
aB <= x"F" after 105 ns, x"2" after 125 ns ;
aW <= x"1" after 100 ns, x"2" after 120 ns ;
W <= '1' after 105 ns ;
DATA <= x"AA" after 100 ns ;



end Behavioral;
