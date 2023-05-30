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

type mem is array (0 to 255) of std_logic_vector (31 downto 0) ;
signal M : mem := (x"00000000",
x"06010000",
x"08030100",
x"07010300",
x"08020100",
x"05040200",
x"06050000",
x"07010400",
x"07020500",
x"0b010102",
x"08040100",
x"07010400",
x"0c130100",
x"06010700",
x"08050100",
x"07010500",
x"08030100",
x"0c180000",
x"00000000",
x"06010100",
x"08040100",
x"07010400",
x"08030100",
x"00000000",
x"07010300",
x"08040100",
x"07000400",
x"00000000",

others => (others => '0')) ;

begin
--process
--    begin   
--        wait until CLK'event and CLK='1' ;
        S <= M(to_integer(unsigned(a))) ;
        
        
--end process ;



end Behavioral;
