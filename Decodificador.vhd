----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 30.06.2019 19:00:16
-- Design Name: 
-- Module Name: Top_decodificador - Xilinx
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

entity Decodificador is
      port(
        
        DCLK: in std_logic;
        RESET:in std_logic;
        E:in std_logic;
        DIN:in std_logic_vector(15 downto 0);
        VALID:out std_logic;
        DECODIFICADO:out std_logic_vector(7 downto 0)
);

end Decodificador;

architecture Xilinx of Decodificador is

type STATES is(REPOSO,DECODIFICAR);
signal STATE_REG,STATE_NEXT:STATES;
signal DIN_REG,DIN_NEXT:std_logic_vector(15 downto 0);
signal CNT_DECOD_REG,CNT_DECOD_NEXT:std_logic_vector(3 downto 0);
signal SALIDA_REG,SALIDA_NEXT:std_logic_vector(7 downto 0);
signal HABILITACION:std_logic;

begin


  COMBINACIONAL: process(STATE_REG,E,DIN_REG,CNT_DECOD_REG)
    
    
    begin
     
      STATE_NEXT<=STATE_REG;
      HABILITACION<='0';
      CNT_DECOD_NEXT<=CNT_DECOD_REG;
      SALIDA_NEXT<=SALIDA_REG;
      DIN_NEXT<=DIN_REG;
       
      case STATE_REG is
              
             when REPOSO=>
             
                  if(E='1')then
                  
                      STATE_NEXT<=DECODIFICAR;
                      DIN_NEXT<=DIN;
                      
                  else 
                  
                      STATE_NEXT<=REPOSO;
                  
                  end if;
            
             when DECODIFICAR=>
                        
                     
                   SALIDA_NEXT<=DIN_REG(conv_integer(CNT_DECOD_REG))&SALIDA_REG(7 downto 1);
                       
                        
                 if(CNT_DECOD_REG=0)then
                    
                      STATE_NEXT<=REPOSO;
                      HABILITACION<='1';
                      CNT_DECOD_NEXT<="1110";
                    
                    else
                        
                        STATE_NEXT<=DECODIFICAR;
                        CNT_DECOD_NEXT<=CNT_DECOD_REG-2;    

                    end if;
                    

      
  end case;
  end process;
  

  DECODIFICADO<=SALIDA_REG;
  VALID<=HABILITACION;
  
  SECUENCIAL: process(DCLK,RESET)
  
  begin
  
  if(RESET = '0')then
  
      STATE_REG<=REPOSO;
      DIN_REG<=(others=>'0');
      CNT_DECOD_REG<="1110";
      SALIDA_REG<=(others=>'0');

  elsif(DCLK'event and DCLK='1')then
  
      STATE_REG<=STATE_NEXT;
      DIN_REG<=DIN_NEXT;
      CNT_DECOD_REG<=CNT_DECOD_NEXT;
      SALIDA_REG<=SALIDA_NEXT;
      
      
  end if;
  end process;  



end Xilinx;
