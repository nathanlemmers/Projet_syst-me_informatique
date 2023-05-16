----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 16.05.2023 09:04:33
-- Design Name: 
-- Module Name: memoire_instruction - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity memoire_instruction is
    Port ( a : in STD_LOGIC_VECTOR (7 downto 0);
           CLK : in STD_LOGIC;
           S : out STD_LOGIC_VECTOR (31 downto 0));
end memoire_instruction;

architecture Behavioral of memoire_instruction is

type mem is array (255 downto 0) of std_logic_vector (31 downto 0) ;
signal M : mem := (others => (others => '0')) ;

begin
process
    begin   
        wait until CLK'event and CLK='1' ;
        S <= M(to_integer(unsigned(a))) ;
        
        
end process ;



end Behavioral;
