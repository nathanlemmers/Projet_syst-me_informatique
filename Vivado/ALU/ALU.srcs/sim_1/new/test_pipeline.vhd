----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 16.05.2023 14:57:03
-- Design Name: 
-- Module Name: test_pipeline - Behavioral
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

entity test_pipeline is
--  Port ( );
end test_pipeline;

architecture Behavioral of test_pipeline is

COMPONENT Pipeline
Port (rst : in STD_LOGIC ;
          CLK : in STD_LOGIC ;
          B : out STD_LOGIC_VECTOR (7 downto 0));
END COMPONENT ;

signal RST : STD_LOGIC ;
signal CLK : STD_LOGIC := '0' ;
signal B : STD_LOGIC_VECTOR (7 downto 0) ;

constant clock_period : time := 10 ns ; 






begin

label_uut : Pipeline PORT MAP (
rst => RST,
CLK => CLK ,
B => B ) ;

Clock_process: process 
        begin 
        CLK <= not(CLK) ;
        wait for Clock_period/2 ;
     end process ;
     
     
     



end Behavioral;
