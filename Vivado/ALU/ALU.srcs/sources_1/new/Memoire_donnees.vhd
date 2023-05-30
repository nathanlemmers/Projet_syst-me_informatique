----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 16.05.2023 08:18:52
-- Design Name: 
-- Module Name: Memoire_donnees - Behavioral
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

entity Memoire_donnees is
    Port ( a : in STD_LOGIC_VECTOR (7 downto 0);
           I : in STD_LOGIC_VECTOR (7 downto 0);
           RW : in STD_LOGIC;
           RST : in STD_LOGIC;
           CLK : in STD_LOGIC;
           S : out STD_LOGIC_VECTOR (7 downto 0));
end Memoire_donnees;

architecture Behavioral of Memoire_donnees is

type mem is array (255 downto 0) of std_logic_vector (7 downto 0) ;
signal M : mem ;
begin
process
    begin   
        wait until CLK'event and CLK='1' ;
        if (RST='0') then
             M<= (others => (others => '0')) ;
             else 
             if (RW='0') then 
             M(to_integer(unsigned(a))) <= I ;  --STORE               
             end if ;
        end if ;  
end process ;

S <= M(to_integer(unsigned(a))) ;


end Behavioral;
