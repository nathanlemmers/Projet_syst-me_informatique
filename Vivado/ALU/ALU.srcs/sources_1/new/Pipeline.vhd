----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 16.05.2023 09:59:08
-- Design Name: 
-- Module Name: Pipeline - Behavioral
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

entity Pipeline is
    PORT( rst : in STD_LOGIC ;
    CLK : in STD_LOGIC ;
    B : out STD_LOGIC_VECTOR (7 downto 0)) ;
end Pipeline;

architecture Behavioral of Pipeline is
COMPONENT memoire_instruction
 Port ( a : in STD_LOGIC_VECTOR (7 downto 0);
          CLK : in STD_LOGIC ;
          S : out STD_LOGIC_VECTOR (31 downto 0));
end COMPONENT ;


COMPONENT Banc_registres
 Port ( aA : in STD_LOGIC_VECTOR (3 downto 0);
           aB : in STD_LOGIC_VECTOR (3 downto 0);
           aW : in STD_LOGIC_VECTOR (3 downto 0);
           W : in STD_LOGIC;
           DATA : in STD_LOGIC_VECTOR (7 downto 0);
           RST : in STD_LOGIC;
           CLK1 : in STD_LOGIC;
           QA : out STD_LOGIC_VECTOR (7 downto 0);
           QB : out STD_LOGIC_VECTOR (7 downto 0));
end COMPONENT ;

signal a : STD_LOGIC_VECTOR (7 downto 0);
signal S : STD_LOGIC_VECTOR (31 downto 0);
signal lidi_a : STD_LOGIC_VECTOR(7 downto 0) ;
signal lidi_op : STD_LOGIC_VECTOR (7 downto 0) ;
signal lidi_b : STD_LOGIC_VECTOR (7 downto 0) ;
signal lidi_c : STD_LOGIC_VECTOR (7 downto 0) ;

signal diex_a : STD_LOGIC_VECTOR (7 downto 0) ;
signal diex_op : STD_LOGIC_VECTOR (7 downto 0) ;
signal diex_b : STD_LOGIC_VECTOR (7 downto 0) ;
signal diex_c : STD_LOGIC_VECTOR (7 downto 0) ;

signal exmem_a : STD_LOGIC_VECTOR (7 downto 0) ;
signal exmem_op : STD_LOGIC_VECTOR (7 downto 0) ;
signal exmem_b : STD_LOGIC_VECTOR (7 downto 0) ;

signal memre_a : STD_LOGIC_VECTOR (7 downto 0) ;
signal memre_op : STD_LOGIC_VECTOR (7 downto 0) ;
signal memre_b : STD_LOGIC_VECTOR (7 downto 0) ;

begin
Label_uut:Memoire_instruction PORT MAP( 
    a => a ,
    CLK => CLK ,
    S => S ) ;
 Label_uut1:Banc_registres PORT MAP( 
           aA => x"0" ;
           aB => x"0" ;
           aW => memre_a(3 downto 0) ,
           CLK1 => CLK ,
           W => '1' ,
           DATA => memre_b
            ) ;
process 
    begin 

wait until (CLK'event) and (CLK='1') ;

lidi_op <= S(7 downto 0) ;
lidi_a <= S(15 downto 7) ;
lidi_b <= S(23 downto 15) ;
lidi_c <= S(31 downto 23) ;

if (lidi_op=x"01") then 

    diex_a <= lidi_a ; 
    diex_op <= lidi_op ; 
    diex_b <= lidi_b ; 
    
    exmem_a <= diex_a ;
    exmem_op <= diex_op ;
    exmem_b <= diex_b ;
     
    memre_a <= exmem_a ;
    memre_op <= exmem_op ;
    memre_b <= exmem_b ;
   
    
end if ;
end Behavioral;
