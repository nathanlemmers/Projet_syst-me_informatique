----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 16.05.2023 09:08:14
-- Design Name: 
-- Module Name: test_memoire_instru - Behavioral
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

entity test_memoire_instru is
    
end test_memoire_instru;

architecture Behavioral of test_memoire_instru is

COMPONENT memoire_instruction 
 Port ( a : in STD_LOGIC_VECTOR (7 downto 0);
           CLK : in STD_LOGIC ;
           S : out STD_LOGIC_VECTOR (31 downto 0));
end COMPONENT ;

signal a : STD_LOGIC_VECTOR (7 downto 0);
signal CLK : STD_LOGIC := '0' ;
signal S : STD_LOGIC_VECTOR (31 downto 0);

constant clock_period : time := 10 ns ;
begin
Label_uut:Memoire_instruction PORT MAP( 
    a => a ,
    CLK => CLK ,
    S => S ) ;
 
    Clock_process: process 
        begin 
        CLK <= not(CLK) ;
        wait for Clock_period/2 ;
     end process ;
     
     
     a <= x"00" after 5ns ;
     
     
     
end Behavioral;
