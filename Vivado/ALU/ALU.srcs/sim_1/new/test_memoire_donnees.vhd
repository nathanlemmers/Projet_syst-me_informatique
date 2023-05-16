----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 16.05.2023 08:33:41
-- Design Name: 
-- Module Name: test_memoire_donnees - Behavioral
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

entity test_memoire_donnees is
    --Port () ;
end test_memoire_donnees;

architecture Behavioral of test_memoire_donnees is

COMPONENT Memoire_donnees 
Port ( a : in STD_LOGIC_VECTOR (7 downto 0);
           I : in STD_LOGIC_VECTOR (7 downto 0);
           RW : in STD_LOGIC;
           RST : in STD_LOGIC;
           CLK : in STD_LOGIC;
           S : out STD_LOGIC_VECTOR (7 downto 0));
END COMPONENT ;
signal a : STD_LOGIC_VECTOR (7 downto 0);
signal I : STD_LOGIC_VECTOR (7 downto 0);
signal RW : STD_LOGIC;
signal RST : STD_LOGIC;
signal CLK : STD_LOGIC :='0';
signal S : STD_LOGIC_VECTOR (7 downto 0);

constant Clock_period : time := 10 ns;

begin
Label_uut:Memoire_donnees PORT MAP(
 a => a ,
 I => I ,
 RW => RW ,
 RST => RST ,
 CLK => CLK ,
 S => S
 );
 
 Clock_process: process 
     begin 
     CLK <= not(CLK) ;
     wait for Clock_period/2 ;
  end process ;
 
 RST <= '0' after 0 ns, '1' after 15ns ;
 RW <= '1' after 40 ns, '0' after 80 ns, '1' after 120ns  ;
 a <= x"01" after 0 ns , x"02" after 80 ns ;
 I <= x"0A" after 0 ns ;

end Behavioral;
