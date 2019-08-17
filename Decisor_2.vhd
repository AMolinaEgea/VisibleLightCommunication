----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 27.06.2019 15:03:24
-- Design Name: 
-- Module Name: Top_decisor_2 - Xilinx
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


entity Decisor_2 is
  Port ( 
  
    DCLK: in std_logic;
    RESET:in std_logic;
    E:in std_logic;
    DIN:in std_logic;
    VALID:out std_logic;
    DECIDIDO_2:out std_logic_vector(15 downto 0)
  
  );
end Decisor_2;

architecture Xilinx of Decisor_2 is

type STATES is(REPOSO,SUMA,DECISION,DECOD);
signal STATE_REG,STATE_NEXT:STATES;
signal DECIDIDO_REG,DECIDIDO_NEXT:std_logic;
signal SUMA_REG,SUMA_NEXT:std_logic_vector(6 downto 0);
signal CNT_RECIB_REG,CNT_RECIB_NEXT:std_logic_vector(6 downto 0);
signal DIN_REG,DIN_NEXT:std_logic;
signal VALID_REG,VALID_NEXT:std_logic;
signal CNT_DEC_REG,CNT_DEC_NEXT:std_logic_vector(4 downto 0);
signal SALIDA_REG,SALIDA_NEXT:std_logic_vector(15 downto 0);
signal CAMBIO_BIT_REG,CAMBIO_BIT_NEXT:std_logic;
signal DATO_DECIDIDO:std_logic;

begin

COMBINACIONAL: process(STATE_REG,CNT_RECIB_REG,VALID_REG,SUMA_REG,CNT_DEC_REG,E)
    
    
    begin
     
      STATE_NEXT<=STATE_REG;
      CNT_RECIB_NEXT<=CNT_RECIB_REG;
      SUMA_NEXT<=SUMA_REG;
      VALID_NEXT<=VALID_REG;
      DIN_NEXT<=DIN_REG;
      DECIDIDO_NEXT<=DECIDIDO_REG;
      CNT_DEC_NEXT<=CNT_DEC_REG;
      SALIDA_NEXT<=SALIDA_REG;
      CAMBIO_BIT_NEXT<=CAMBIO_BIT_REG;
      DATO_DECIDIDO<='0';
    
      case STATE_REG is
              
            
            when REPOSO=>
                
                if(E='1')then
                
                    STATE_NEXT<=SUMA;
                    DIN_NEXT<=DIN;
                    CNT_RECIB_NEXT<=CNT_RECIB_REG+1;

                    if(DIN_REG/= DIN)then
                        
                        CAMBIO_BIT_NEXT<='1';
                    else
                    
                        if(CNT_RECIB_REG>=31)then
                            CAMBIO_BIT_NEXT<='1';   
                        else    
                            CAMBIO_BIT_NEXT<='0';
                        end if;        
                    end if;
                    

                else 
                    
                    STATE_NEXT<=REPOSO;
                
                end if;
                                 
             when SUMA=>
                      
                   
                    
                    if((CNT_RECIB_REG>28) and (CAMBIO_BIT_REG='1'))then
                            
                            STATE_NEXT<=DECISION;
                            CNT_RECIB_NEXT<=(others=>'0');
                            CAMBIO_BIT_NEXT<='0';

                      else  
                                                      
                            STATE_NEXT<=REPOSO;
                            CAMBIO_BIT_NEXT<='0';
                            SUMA_NEXT<=SUMA_REG+DIN_REG;

                            
                                
                      end if;
                      

              when  DECISION=>
              
                if(VALID_REG<='0')then
                
                    if(SUMA_REG>=20)then
                    
                        DECIDIDO_NEXT<='1';
                        
                        if(DECIDIDO_REG='1')then
                            STATE_NEXT<=DECOD;
                            VALID_NEXT<='1';
                            SUMA_NEXT<=(others=>'0');

                                                    
                        else    
                        
                            STATE_NEXT<=REPOSO;
                            SUMA_NEXT<=(others=>'0');
                            
                      end if;      
          
                    else
                    
                        DECIDIDO_NEXT<='0';
                        
                        STATE_NEXT<=REPOSO;
                        
                        SUMA_NEXT<=(others=>'0');


                    end if;
                    
                    
                  else 
                    
                    if(SUMA_REG>=20)then
                                      
                        DECIDIDO_NEXT<='1';
                        
                    else
                                            
                        DECIDIDO_NEXT<='0';
                                                 
                    
                   end if;
                    SUMA_NEXT<=(others=>'0');
                    STATE_NEXT<=DECOD;
                    
                   end if;
                
                when DECOD=> 
                    
                    CNT_DEC_NEXT<=CNT_DEC_REG+1;
                    if(CNT_DEC_REG>1 and CNT_DEC_REG<18)then
                    
                        SALIDA_NEXT<=SALIDA_REG(14 downto 0)&DECIDIDO_REG;
                        STATE_NEXT<=SUMA;

                    else
                    
                        if(CNT_DEC_REG<2)then
                        
                            STATE_NEXT<=SUMA;
                    
                        end if;
                        
                        if(CNT_DEC_REG=18)then
                        
                            VALID_NEXT<='0';
                            CNT_DEC_NEXT<=(others=>'0');
                            STATE_NEXT<=REPOSO;
                            SUMA_NEXT<=(others=>'0');
                            DATO_DECIDIDO<='1';
                        end if;
                        
                    end if;
                
  end case;
  end process;
  
  
  DECIDIDO_2<=SALIDA_REG;
  VALID<=DATO_DECIDIDO;
  
  SECUENCIAL: process(DCLK,RESET)
    
    begin
    
    if(RESET = '0')then
    
        STATE_REG<=REPOSO;
        DECIDIDO_REG<='0';
        CNT_RECIB_REG<=(others=>'0');
        SUMA_REG<=(others=>'0');
        VALID_REG<='0';
        DIN_REG<='0';
        CNT_DEC_REG<=(others=>'0');
        SALIDA_REG<=(others=>'0');
        CAMBIO_BIT_REG<='0';
  
    elsif(DCLK'event and DCLK='1')then
    
        STATE_REG<=STATE_NEXT;
        DECIDIDO_REG<=DECIDIDO_NEXT;
        CNT_RECIB_REG<=CNT_RECIB_NEXT;
        SUMA_REG<=SUMA_NEXT;
        VALID_REG<=VALID_NEXT;
        DIN_REG<=DIN_NEXT;
        CNT_DEC_REG<=CNT_DEC_NEXT;
        SALIDA_REG<=SALIDA_NEXT;
        CAMBIO_BIT_REG<=CAMBIO_BIT_NEXT;
        
    end if;
    end process;  


end Xilinx;
