----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.06.2019 10:07:11
-- Design Name: 
-- Module Name: Transmisor - Xilinx
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



entity Transmisor is
  Port ( 
    
      DCLK:in std_logic;
      RESET:in std_logic;
      DIN: in std_logic_vector(15 downto 0);
      E:in std_logic;
      SALIDA_COD:out std_logic
  
  
  );
end Transmisor;

architecture Xilinx of Transmisor is

type STATES is(REPOSO_1,REPOSO_2,TRANSMISION);
signal STATE_NEXT,STATE_REG:STATES;
signal DOUT_NEXT,DOUT_REG:std_logic;
signal CNT_WR_NEXT, CNT_WR_REG: std_logic_vector(4 downto 0);
signal CNT_TX_NEXT, CNT_TX_REG: std_logic_vector(15 downto 0);
signal DIN_NEXT,DIN_REG:std_logic_vector(19 downto 0);
signal E_NEXT,E_REG:std_logic;
begin

COMBINACIONAL: process(STATE_REG,E,CNT_WR_REG,CNT_TX_REG)

begin

DOUT_NEXT<=DOUT_REG;
CNT_WR_NEXT<=CNT_WR_REG;
STATE_NEXT<=STATE_REG;
CNT_TX_NEXT<=CNT_TX_REG;
DIN_NEXT<=DIN_REG;
E_NEXT<=E_REG;
case STATE_REG is

        when REPOSO_1=>
            
            CNT_TX_NEXT<=CNT_TX_REG+1;  
            if(E='1')then
                
                DIN_NEXT<="10"&DIN&"01";
                STATE_NEXT<=REPOSO_2;
                
         
            else
                
                if(CNT_TX_REG=41666)then
                      
                      DOUT_NEXT<=not(DOUT_REG);
                      CNT_TX_NEXT<=(others=>'0');
                
                else
                    STATE_NEXT<=REPOSO_1;
                
                end if;

            end if;
        
        when REPOSO_2=>
        
               if(CNT_TX_REG=41666 and DOUT_REG='1')then
                              
                     STATE_NEXT<=TRANSMISION;
               
               elsif(CNT_TX_REG=41666 and DOUT_REG='0')then
               
                    DOUT_NEXT<=not(DOUT_REG);
                    CNT_TX_NEXT<=(others=>'0');
                    STATE_NEXT<=REPOSO_2;

               
               else
                     CNT_TX_NEXT<=CNT_TX_REG+1;   
                     STATE_NEXT<=REPOSO_2;
                
               end if;
            

        when TRANSMISION=>
           
           CNT_TX_NEXT<=CNT_TX_REG+1;        
           
           if(CNT_TX_REG=41666)then
                
                CNT_TX_NEXT<=(others=>'0');
                CNT_WR_NEXT<=CNT_WR_REG+1;

           
                if(CNT_WR_REG=19)then
                    
                    DOUT_NEXT<=DIN_NEXT(conv_integer(CNT_WR_REG));
                    
                    STATE_NEXT<=REPOSO_1;
                    CNT_WR_NEXT<=(others=>'0');
            
                else
                    
                    DOUT_NEXT<=DIN_NEXT(conv_integer(CNT_WR_REG));

                    STATE_NEXT<=TRANSMISION;     
           
                end if;
                
             else
             
                STATE_NEXT<=TRANSMISION;
                
             end if;           
end case;
end process;

SALIDA_COD<=not(DOUT_REG);

SECUENCIAL: process(RESET,DCLK)

begin

if(RESET = '0')then

    STATE_REG<=REPOSO_1;
    DOUT_REG<='0';
    CNT_WR_REG<=(others=>'0');
    CNT_TX_REG<=(others=>'0');
    DIN_REG<=(others=>'1');
    E_REG<='0';

    
elsif(DCLK'event and DCLK='1')then

    STATE_REG<=STATE_NEXT;
    DOUT_REG<=DOUT_NEXT;
    CNT_WR_REG<=CNT_WR_NEXT;
    CNT_TX_REG<=CNT_TX_NEXT;
    DIN_REG<=DIN_NEXT;
    E_REG<=E_NEXT;

            
end if;
end process;
end Xilinx;
