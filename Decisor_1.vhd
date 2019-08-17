----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 26.06.2019 18:31:43
-- Design Name: 
-- Module Name: Top_decisor_1 - Xilinx
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


entity Decisor_1 is
  Port ( 
  
    DCLK: in std_logic;
    RESET:in std_logic;
    E:in std_logic;
    VALID:out std_logic;
    DIN: in std_logic_vector(11 downto 0);
    MEDIA:in std_logic_vector(11 downto 0);
    DECIDIDO_1:out std_logic
  
  );
end Decisor_1;

architecture Xilinx of Decisor_1 is

  type STATES is(REPOSO,DECISION);
  signal STATE_REG,STATE_NEXT:STATES;
  signal DECIDIDO_REG,DECIDIDO_NEXT:std_logic;
  signal VALID_REG,VALID_NEXT:std_logic;

begin


  COMBINACIONAL: process(STATE_REG,E,DIN)
    
    
    begin
     
      STATE_NEXT<=STATE_REG;
      DECIDIDO_NEXT<=DECIDIDO_REG;
        
      case STATE_REG is
              
             when REPOSO=>
             
                  if(E='1')then
                  
                      STATE_NEXT<=DECISION;
                  else 
                  
                      STATE_NEXT<=REPOSO;
                  
                  end if;
                 VALID_NEXT<='0';
             when DECISION=>
                                
                         if(DIN>MEDIA)then
                              
                              DECIDIDO_NEXT<='1';
                              --CNT_UNO_NEXT<=CNT_UNO_REG+1;
                                  
                          else
                              
                              DECIDIDO_NEXT<='0';
                               
                          end if;
                                            
                    VALID_NEXT<='1'; 
                   
                    STATE_NEXT<=REPOSO;
        
      
  end case;
  end process;
  
  DECIDIDO_1<=DECIDIDO_REG;
  VALID<=VALID_REG;
  
   SECUENCIAL: process(DCLK,RESET)
  
  begin
  
  if(RESET = '0')then
  
      STATE_REG<=REPOSO;
      DECIDIDO_REG<='0';
      VALID_REG<='0';

  elsif(DCLK'event and DCLK='1')then
  
      STATE_REG<=STATE_NEXT;
      DECIDIDO_REG<=DECIDIDO_NEXT;
      VALID_REG<=VALID_NEXT;
      
      
  end if;
  end process;  

end Xilinx;
