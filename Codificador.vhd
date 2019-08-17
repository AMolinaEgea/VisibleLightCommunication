----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 13.06.2019 10:24:11
-- Design Name: 
-- Module Name: Codificador - Xilinx
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




entity Codificador is
  Port ( 
    
    DCLK:in std_logic;
    RESET:in std_logic;
    DIN: in std_logic_vector(7 downto 0);
    VALIDO:in std_logic;
    E: out std_logic;
    DOUT:out std_logic_vector(15 downto 0)
  
  );
end Codificador;

architecture Xilinx of Codificador is

type STATES is(REPOSO,CODIF,VALIDACION);
signal STATE_NEXT,STATE_REG:STATES;
signal CNT_RD_NEXT,CNT_RD_REG:std_logic_vector(2 downto 0);
signal DOUT_NEXT,DOUT_REG:std_logic_vector(15 downto 0);
signal SALIDA_NEXT,SALIDA_REG:std_logic_vector(15 downto 0);
signal VALID_NEXT,VALID_REG:std_logic;

begin

COMBINACIONAL: process(STATE_REG,VALIDO,CNT_RD_REG,DIN)


begin

STATE_NEXT<=STATE_REG;
CNT_RD_NEXT<=(others=>'1');
DOUT_NEXT<=DOUT_REG;
VALID_NEXT<='0';
SALIDA_NEXT<="0101010101010101";

case STATE_REG is

        when REPOSO=>
            
            if(VALIDO='1')then
            
                STATE_NEXT<=CODIF;
            
            else
          
                STATE_NEXT<=REPOSO;
             end if;
               
        when CODIF=>


             if(DIN(conv_integer(CNT_RD_REG))='1')then
     
                DOUT_NEXT<=DOUT_REG(13 downto 0)&"10";
                
             end if;
             
             if(DIN(conv_integer(CNT_RD_REG))='0')then
    
                DOUT_NEXT<=DOUT_REG(13 downto 0)&"01";
                end if;
     
            CNT_RD_NEXT<=CNT_RD_REG-1;
            STATE_NEXT<=CODIF;
            
            
            
           if(CNT_RD_REG=0)then
          
                STATE_NEXT<=VALIDACION;
                CNT_RD_NEXT<=(others=>'1');        
            
            else 
            
                STATE_NEXT<=CODIF;
                
            end if;

            
          when VALIDACION=>
                
                SALIDA_NEXT<=DOUT_REG;
                VALID_NEXT<='1';
                STATE_NEXT<=REPOSO;

end case;
end process;

DOUT <= SALIDA_REG when VALID_REG='1'else 
      (others=>'1');
E<= VALID_REG;

SECUENCIAL: process(RESET,DCLK)

begin

if(RESET = '0')then

    STATE_REG<=REPOSO;
    DOUT_REG<="0101010101010101";
    CNT_RD_REG<=(others=>'1');
    VALID_REG<='0';
    SALIDA_REG<="0101010101010101";
    
elsif(DCLK'event and DCLK='1')then

    STATE_REG<=STATE_NEXT;
    DOUT_REG<=DOUT_NEXT;
    CNT_RD_REG<=CNT_RD_NEXT;
    VALID_REG<=VALID_NEXT;
    SALIDA_REG<=SALIDA_NEXT;
        
end if;
end process;


end Xilinx;


