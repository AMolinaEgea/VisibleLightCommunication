----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12.07.2019 17:10:03
-- Design Name: 
-- Module Name: Segmentos - Xilinx
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

entity Segmentos is
Port ( 

    VALOR:in std_logic_vector(7 downto 0);
    SW:in std_logic_vector(3 downto 0);
    SEGMENTADO: out std_logic_vector(6 downto 0);
    AN:out std_logic_vector(3 downto 0)
  
  );
  end Segmentos;

architecture Xilinx of Segmentos is

begin


SEGMENTADO <="1000000" when (VALOR(3 downto 0)="0000")else
            "1111001" when (VALOR(3 downto 0)="0001")else
            "0100100" when (VALOR(3 downto 0)="0010")else
            "0110000" when (VALOR(3 downto 0)="0011")else
            "0011001" when (VALOR(3 downto 0)="0100")else
            "0010010" when (VALOR(3 downto 0)="0101")else
            "0000010" when (VALOR(3 downto 0)="0110")else
            "1111000" when (VALOR(3 downto 0)="0111")else
            "0000000" when (VALOR(3 downto 0)="1000")else
            "0011000" when (VALOR(3 downto 0)="1001")else
            "1111111";
         
AN<="1111" when (SW="0000")else
    "1110" when (SW="0001")else
    "1101" when (SW="0010")else
    "1011" when (SW="0100")else
    "0111" when (SW="1000")else
    "0000";


end Xilinx;
