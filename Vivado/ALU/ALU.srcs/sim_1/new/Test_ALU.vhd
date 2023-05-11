----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10.05.2023 12:09:06
-- Design Name: 
-- Module Name: Test_ALU - Behavioral
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

entity Test_ALU is
--  Port ( );
end Test_ALU;

architecture Behavioral of Test_ALU is

COMPONENT ALU
PORT(
    A : in STD_LOGIC_VECTOR (7 downto 0) ;
    B : in STD_LOGIC_VECTOR (7 downto 0) ;
    Ctrl_Alu : in STD_LOGIC_VECTOR (2 downto 0) ;
    O : out STD_LOGIC;
    Z : out STD_LOGIC;
    C : out STD_LOGIC;
    S : out STD_LOGIC_VECTOR (7 downto 0));
END COMPONENT ;

signal A  : STD_LOGIC_VECTOR(7 downto 0) := x"FF" ;
signal B : STD_LOGIC_VECTOR (7 downto 0) := x"04";
signal Ctrl_Alu :  STD_LOGIC_VECTOR (2 downto 0) := "001";
 signal   O : STD_LOGIC;
 signal   Z : STD_LOGIC;
  signal  C : STD_LOGIC;
 signal   S : STD_LOGIC_VECTOR (7 downto 0);


begin


Label_uut:ALU PORT MAP(
    A => A ,
    B => B ,
    Ctrl_Alu => Ctrl_Alu ,
    O => O ,
    Z => Z ,
    C => C ,
    S => S 
    );

A <= x"00" after 10ns, x"FF" after 20 ns, x"03" after 50 ns ;
B <= x"00" after 10ns, x"06" after 20 ns, x"03" after 50 ns ;
Ctrl_Alu <= "001" after 10 ns, "010" after 30 ns, "100" after 40 ns ;



end Behavioral;
