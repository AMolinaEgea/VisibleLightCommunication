----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 18.06.2019 13:01:03
-- Design Name: 
-- Module Name: Top_media - Xilinx
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
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Media is
  Port ( 
        
  DCLK: in std_logic;
  RESET:in std_logic;
  E:in std_logic;--Sera DRDY_OUT
  DIN: in std_logic_vector(11 downto 0);
  MEDIA:out std_logic_vector(11 downto 0)
  
  );
end Media;
    
 architecture Xilinx of Media is

  type VECTOR is array (0 to 63) of std_logic_vector(11 downto 0); 
  type STATES is(REPOSO,ESCRITURA,CALCULO);
  signal STATE_REG,STATE_NEXT:STATES;
  signal CNT_ADDR_REG,CNT_ADDR_NEXT:std_logic_vector(5 downto 0);
  signal VECTOR_MOVIL_REG,VECTOR_MOVIL_NEXT:VECTOR;
  signal DIN_REG,DIN_NEXT:std_logic_vector(11 downto 0);
  signal SUMA_REG,SUMA_NEXT:std_logic_vector(17 downto 0);
  signal RESTA_REG,RESTA_NEXT:std_logic_vector(17 downto 0);


 begin
 
  COMBINACIONAL: process(STATE_REG,E,DIN)
  
  --variable SUMA: std_logic_vector(7 downto 0);
  
  begin
   
    STATE_NEXT<=STATE_REG;
    SUMA_NEXT<=SUMA_REG;
    RESTA_NEXT<=RESTA_REG;
    DIN_NEXT<=DIN_REG;
    CNT_ADDR_NEXT<=CNT_ADDR_REG;
    VECTOR_MOVIL_NEXT<=VECTOR_MOVIL_REG;
  
    case STATE_REG is
            
           when REPOSO=>
           
                if(E='1')then
                
                    DIN_NEXT<=DIN;
                    STATE_NEXT<=ESCRITURA;
                else 
                
                    STATE_NEXT<=REPOSO;
                
                end if;
               
           when ESCRITURA=>
                
                VECTOR_MOVIL_NEXT(conv_integer(CNT_ADDR_REG))<=DIN_REG;
                
                RESTA_NEXT<=SUMA_REG-VECTOR_MOVIL_REG(conv_integer(CNT_ADDR_REG));
                                
                STATE_NEXT<=CALCULO;
            
           when CALCULO=>
                
  
                SUMA_NEXT <= RESTA_REG+VECTOR_MOVIL_REG(conv_integer(CNT_ADDR_REG));
                
                CNT_ADDR_NEXT<=CNT_ADDR_REG+1;
                                
                STATE_NEXT<=REPOSO;
    
end case;
end process;

   MEDIA<=SUMA_REG(17 downto 6);
   
   SECUENCIAL: process(DCLK,RESET)
   
   begin
   
    if(RESET = '0')then
   
       STATE_REG<=REPOSO;
       CNT_ADDR_REG<=(others=>'0');
       VECTOR_MOVIL_REG<=(others=>"000000000000");
       SUMA_REG<=(others=>'0');
       DIN_REG<=(others=>'0');
       RESTA_REG<=(others=>'0');


   elsif(DCLK'event and DCLK='1')then
   
       STATE_REG<=STATE_NEXT;
       CNT_ADDR_REG<=CNT_ADDR_NEXT;
       VECTOR_MOVIL_REG<=VECTOR_MOVIL_NEXT;
       SUMA_REG<=SUMA_NEXT;
       DIN_REG<=DIN_NEXT;
       RESTA_REG<=RESTA_NEXT;

       
   end if;
   end process;

end Xilinx;
