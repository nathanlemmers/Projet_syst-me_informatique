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
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL ;

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
 Port (  a : in STD_LOGIC_VECTOR (7 downto 0) ;
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
           CLK : in STD_LOGIC;
           QA : out STD_LOGIC_VECTOR (7 downto 0);
           QB : out STD_LOGIC_VECTOR (7 downto 0));
end COMPONENT ;


COMPONENT ALU 
Port ( A : in STD_LOGIC_VECTOR (7 downto 0);
           B : in STD_LOGIC_VECTOR (7 downto 0);
           Ctrl_Alu : in STD_LOGIC_VECTOR (2 downto 0);
           O : out STD_LOGIC;
           Z : out STD_LOGIC;
           C : out STD_LOGIC;
           S : out STD_LOGIC_VECTOR (7 downto 0));
 end COMPONENT ;
 
 COMPONENT Memoire_donnees 
Port ( a : in STD_LOGIC_VECTOR (7 downto 0);
            I : in STD_LOGIC_VECTOR (7 downto 0);
            RW : in STD_LOGIC;
            RST : in STD_LOGIC;
            CLK : in STD_LOGIC;
            S : out STD_LOGIC_VECTOR (7 downto 0));
  end COMPONENT ;

signal a : STD_LOGIC_VECTOR (7 downto 0) := x"00"  ;
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

signal qa : STD_LOGIC_VECTOR (7 downto 0) ;
signal qb : STD_LOGIC_VECTOR (7 downto 0) ;
signal write : STD_LOGIC ;



signal S_Alu : STD_LOGIC_VECTOR (7 downto 0) ;
signal S_memoire : STD_LOGIC_VECTOR (7 downto 0) ;
signal mux1 : STD_LOGIC_VECTOR (7 downto 0) ;
signal mux2 : STD_LOGIC_VECTOR (7 downto 0) ;
signal mux3 : STD_LOGIC_VECTOR (7 downto 0) ;
signal mux4 : STD_LOGIC_VECTOR (7 downto 0) ;
signal lc1 : STD_LOGIC_VECTOR (2 downto 0) ;
signal lc2 : STD_LOGIC ;



begin
Label_uut: memoire_instruction PORT MAP( 
    a => a ,
    CLK => CLK ,
    S => S ) ;
    
 Label_uut1:Banc_registres PORT MAP( 
            aa=> lidi_b(3 downto 0),        
            ab=> lidi_c(3 downto 0),   
            RST => RST,    
           aW => memre_a(3 downto 0) ,
           CLK => CLK ,
           W => write ,
           DATA => memre_b, 
           QA => qa ,
           QB => qb
            ) ;

 
 Label_uut2 : ALU PORT MAP (
    A => diex_b ,
    B => diex_c ,
    Ctrl_Alu => lc1,
    S => S_Alu           
 );
 
 Label_uut3 : Memoire_donnees PORT MAP (
     a => mux3 ,
     I => exmem_B,
     RW => lc2,
     RST => RST,
     CLK => CLK,
     S => S_memoire 
 );
 
 
    mux1 <= lidi_b when lidi_op=x"06" else qa;
    mux2 <= diex_b when diex_op=x"05" or diex_op=x"06" else S_Alu ;
    write <= '1' when memre_op=x"06" or memre_op=x"05" or memre_op = x"03" or memre_op=x"01" or memre_op=x"02" else '0' ;
    lc1 <= "001" when diex_op = x"01" else
            "010" when diex_op=x"02" else
            "011" when diex_op= x"03" else (others=>'0') ;
            
    mux3 <= exmem_a when exmem_op = x"07" else exmem_b ;
    lc2 <= '0' when exmem_op = x"08" else '1' ;
    
    mux4 <= S_memoire when exmem_op =x"07" else exmem_b ;
 
    process 
        begin 
    
            wait until (CLK'event) and (CLK='1') ;
            
            if (RST ='1') then 
                a <= x"00" ;
            else 
                if (a=x"FF") then
                a <= x"00";
                else
                a <= a+1 ;
                end if ;
            end if ;
                
            
            
            lidi_op <= S(31 downto 24) ;
            lidi_b <= S(15 downto 8) ;
            lidi_a <= S(23 downto 16) ;
            lidi_c <= S(7 downto 0) ;
            
            diex_op <= lidi_op ;
            diex_a <= lidi_a ;
            diex_b <= mux1 ;
            diex_c <= qb ;
                        
            exmem_op <= diex_op;
            exmem_a <= diex_a;
            exmem_b <= mux2;
            
            memre_a <= exmem_a ;
            memre_op <= exmem_op ;
            memre_b <= mux4 ;
            
            
                        
            B <= memre_b ;
            
            
            
        end process ;
end Behavioral;
