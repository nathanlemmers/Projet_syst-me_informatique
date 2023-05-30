----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11.05.2023 11:11:03
-- Design Name: 
-- Module Name: Banc_registres - Behavioral
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

entity Banc_registres is
    Port ( aA : in STD_LOGIC_VECTOR (3 downto 0);
           aB : in STD_LOGIC_VECTOR (3 downto 0);
           aW : in STD_LOGIC_VECTOR (3 downto 0);
           W : in STD_LOGIC;
           DATA : in STD_LOGIC_VECTOR (7 downto 0);
           RST : in STD_LOGIC;
           CLK : in STD_LOGIC;
           QA : out STD_LOGIC_VECTOR (7 downto 0);
           QB : out STD_LOGIC_VECTOR (7 downto 0));
end Banc_registres;

architecture Behavioral of Banc_registres is

type reg is array (0 to 15) of std_logic_vector (7 downto 0) ;
signal P: reg :=  (others => (others => '0'));
begin

    process
    begin
        wait until CLK'event and CLK='1' ;
        if (RST = '0') then
            P<= (others => (others => '0')) ;
        else 
            if (W='1') then
                P(to_integer(unsigned(aW))) <= DATA ;
            end if ; 
                    
         
        end if ; 

    end process ;
QA <= P(to_integer(unsigned(aA)));
QB <= P(to_integer(unsigned(aB)));  
    
end Behavioral;
