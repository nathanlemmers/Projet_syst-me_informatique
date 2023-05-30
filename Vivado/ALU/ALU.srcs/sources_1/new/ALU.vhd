----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10.05.2023 10:46:59
-- Design Name: 
-- Module Name: ALU - Behavioral
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ALU is
    Port ( A : in STD_LOGIC_VECTOR (7 downto 0);
           B : in STD_LOGIC_VECTOR (7 downto 0);
           Ctrl_Alu : in STD_LOGIC_VECTOR (3 downto 0);
           O : out STD_LOGIC;
           Z : out STD_LOGIC;
           C : out STD_LOGIC;
           S : out STD_LOGIC_VECTOR (7 downto 0));
end ALU;

architecture Behavioral of ALU is
    signal P: STD_LOGIC_VECTOR(15 downto 0);
    
begin

process (A,B,Ctrl_Alu, P)

    begin
    if (Ctrl_Alu=x"1") then
        O <= '0' ;
        P<=(x"00"&A) +  (x"00"&B) ;
        
        if (P(15 downto 8) /= x"00") then
            C <= '1' ;
        else 
            C <= '0' ;
        end if ;
        
        
    elsif (Ctrl_Alu=x"3") then
        O <= '0' ;
        P <= (x"00" & A) -  (x"00"&B) ;
        
        if (P(15 downto 8) /= x"00") then
              C <= '1' ;
        else 
            C <= '0' ;
        end if ;
     
    elsif (Ctrl_Alu=x"2") then
        C <= '0' ;
        P<= A *  B ;
        if (P(15 downto 8) /= x"00") then
              O <= '1' ;
        else 
            O <= '0' ;
        end if ;
     elsif (Ctrl_Alu = x"9") then --LT
        if (A<B) then
            P<=x"0001" ;
        else 
            P<=x"0000" ;
        end if ; 
     elsif (Ctrl_Alu = x"a") then --GT
        if (A>B) then
            P<=x"0001" ;
        else 
            P<=x"0000" ;
        end if ; 
     elsif (Ctrl_Alu = x"b") then --EQ
        if (A=B) then
            P<=x"0001" ;
        else 
            P<=x"0000" ;
        end if ; 
     
    else 
        P <= x"0000" ;
        C <= '0' ;
        O <= '0' ;
        Z <= '0' ;   
    end if;
    if(P(7 downto 0)=x"00") then 
      Z <= '1' ;
    else 
        Z <= '0' ;
    end if ;
    
    
    S<=P(7 downto 0) ;
  end process ;  
    
end Behavioral;
