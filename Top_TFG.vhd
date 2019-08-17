----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10.07.2019 10:04:52
-- Design Name: 
-- Module Name: Top_TFG - Xilinx
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

entity Top_TFG is
  Port ( 
  
        DCLK:in std_logic;
        RESET:in std_logic;
        DIN: in std_logic;
        VAUXP14: in  std_logic;
        VAUXN14: in  std_logic;
        SW:in std_logic_vector(3 downto 0);
        SEGMENTADO: out std_logic_vector(6 downto 0);
        AN:out std_logic_vector(3 downto 0);
        SALIDA_COD_EMISOR:out std_logic;
        SALIDA_RECEPTOR:out std_logic
    
  );
end Top_TFG;

architecture Xilinx of Top_TFG is
component Recepcion
    port(
    
       DCLK: in std_logic;
       RESET: in std_logic;
       DIN: in std_logic;
       VALIDO: out std_logic;
       DOUT:out std_logic_vector(7 downto 0)
    
    );
end component;


component Codificador 
    port(
    
        DCLK:in std_logic;
        RESET:in std_logic;
        DIN: in std_logic_vector(7 downto 0);
        VALIDO:in std_logic;
        E: out std_logic;
        DOUT:out std_logic_vector(15 downto 0)
    
    );
    end component;

component Transmisor
    port(
    
        DCLK:in std_logic;
        RESET:in std_logic;
        DIN: in std_logic_vector(15 downto 0);
        E:in std_logic;
        SALIDA_COD:out std_logic
        
    );
end component;    

component Conversion
    port(
    
        DCLK            : in  std_logic;                         -- Clock input for the dynamic reconfiguration port
        RESET           : in  std_logic;                         -- Reset signal for the System Monitor control logic
        VAUXP14         : in  std_logic;                         -- Auxiliary Channel 14
        VAUXN14         : in  std_logic;
        DRDY_OUT        : out  std_logic;                        -- ADC Busy signal
        SALIDA          : out std_logic_vector (11 downto 0)
    
    );
end component;

component Reloj
    port(
    
        DCLK: in std_logic;
        RESET:in std_logic;
        LOCKED:out std_logic;
        DCLK_300:out std_logic;
        DCLK_100: out std_logic
    
    );
end component;

component Media
  port ( 
      
        DCLK: in std_logic;
        RESET:in std_logic;
        E:in std_logic;--Sera DRDY_OUT
        DIN: in std_logic_vector(11 downto 0);
        MEDIA:out std_logic_vector(11 downto 0)

);
end component;

component Decisor_1 
    port(
        
        DCLK:in std_logic;
        RESET:in std_logic;
        E:in std_logic;--Sera DRDY_OUT
        DIN: in std_logic_vector(11 downto 0);
        VALID:out std_logic;
        MEDIA:in std_logic_vector(11 downto 0);
        DECIDIDO_1:out std_logic

    
    );
end component;

component Decisor_2
    port(
    
        DCLK:in std_logic;
        RESET:in std_logic;
        E:in std_logic;--Sera DRDY_OUT
        DIN: in std_logic;  
        VALID:out std_logic; 
        DECIDIDO_2:out std_logic_vector(15 downto 0)
    );
end component;

component Decodificador is
      port(
        
        DCLK: in std_logic;
        RESET:in std_logic;
        E:in std_logic;
        DIN:in std_logic_vector(15 downto 0);
        VALID:out std_logic;
        DECODIFICADO:out std_logic_vector(7 downto 0)
);
  
 end component; 
 
 component Emision
     port(
         
          DCLK: in std_logic;
          RESET: in std_logic;
          FLAG:in std_logic;
          DIN: in std_logic_vector(7 downto 0);
          DOUT:out std_logic
      
      );
      
  end component;
  
  component Segmentos
    port(
        
        VALOR:in std_logic_vector(7 downto 0);
        SW:in std_logic_vector(3 downto 0);
        SEGMENTADO: out std_logic_vector(6 downto 0);
        AN:out std_logic_vector(3 downto 0)
            
    );
    
    end component;
--AXI

signal VALIDO_INTERM:std_logic;
signal DOUT_INTERM:std_logic_vector(7 downto 0);


-- Manchester

signal E_INTERM:std_logic;
signal DOUT_INTERM_M:std_logic_vector(15 downto 0);

-- AXI
  
signal SALIDA_INTERM_2:std_logic_vector(11 downto 0);

                                                        
--DCM
                   
signal DCLK_300:std_logic;
signal DCLK_100: std_logic;                               
signal LOCKED_INTERM:std_logic;


signal DRDY_OUT:std_logic;
signal FLAG_INTERM:std_logic;
signal TX_INTERM:std_logic;

--MEDIA

signal MEDIA_INTERM:std_logic_vector(11 downto 0);

--DECISOR_1

signal DECIDIDO_INTERM_1:std_logic;
signal VALID_INTERM:std_logic;

--DECISOR_2

signal DECIDIDO_INTERM_2:std_logic_vector(15 downto 0);
signal HABILITACION_1:std_logic;

--DECODIFICADOR

signal HABILITACION_2:std_logic;
signal DECODIFICADO_INTERM:std_logic_vector(7 downto 0);


begin

 DCM: Reloj
    
    port map(
    
        DCLK=>DCLK,
        RESET=>RESET,
        LOCKED=>LOCKED_INTERM,
        DCLK_300=>DCLK_300,
        DCLK_100=>DCLK_100
        
    );


AXI_RECEPTOR: Recepcion
   port map(
    
        DCLK=>DCLK_100,
        RESET=>LOCKED_INTERM,
        DIN=>DIN,
        VALIDO=>VALIDO_INTERM,
        DOUT=>DOUT_INTERM
     
);



MANCHESTER: Codificador
    port map(
    
        DCLK=>DCLK_100,
        RESET=>LOCKED_INTERM,
        DIN=>DOUT_INTERM,
        VALIDO=>VALIDO_INTERM,
        E=>E_INTERM,
        DOUT=>DOUT_INTERM_M

    );

TX: Transmisor
    port map(
    
        DCLK=>DCLK_100,
        RESET=>LOCKED_INTERM,
        DIN=>DOUT_INTERM_M,
        E=>E_INTERM,
        SALIDA_COD=>SALIDA_COD_EMISOR
    );
  XADC: Conversion
    
    port map(
    
        DCLK=>DCLK_100,
        RESET=>LOCKED_INTERM,
        VAUXP14=>VAUXP14,
        VAUXN14=>VAUXN14,
        DRDY_OUT=>FLAG_INTERM,
        SALIDA=>SALIDA_INTERM_2
        
    );


MEDIA_MOVIL: Media

 port map(
    
    DCLK=>DCLK_100,
    RESET=>LOCKED_INTERM,
    E=>FLAG_INTERM,
    DIN=>SALIDA_INTERM_2,
    MEDIA=>MEDIA_INTERM
    
 );
 
  DECISOR_A: Decisor_1
 
  port map(
  
    DCLK=>DCLK_100,
    RESET=>LOCKED_INTERM,
    E=>FLAG_INTERM,
    VALID=>VALID_INTERM,
    DIN=>SALIDA_INTERM_2,
    MEDIA=>MEDIA_INTERM,
    DECIDIDO_1=>DECIDIDO_INTERM_1

  );

 DECISOR_B: Decisor_2
 
 port map(
 
    DCLK=>DCLK_100,
    RESET=>LOCKED_INTERM,
    E=>VALID_INTERM,
    DIN=>DECIDIDO_INTERM_1,
    VALID=>HABILITACION_1,
    DECIDIDO_2=>DECIDIDO_INTERM_2
 
 
 );
 
 DECODIFICADOR_M: Decodificador
 
 port map(
 
  
     DCLK=>DCLK_100,
     RESET=>LOCKED_INTERM,
     E=>HABILITACION_1,
     DIN=>DECIDIDO_INTERM_2,
     VALID=>HABILITACION_2,
     DECODIFICADO=>DECODIFICADO_INTERM

 
 );
 
 AXI_EMISOR: Emision
  
  port map(
  
      DCLK=>DCLK_300,
      RESET=>LOCKED_INTERM, 
      FLAG=>HABILITACION_2, 
      DIN=>DECODIFICADO_INTERM,
      DOUT=>SALIDA_RECEPTOR
  
  );
  
  SIETE_SEG: Segmentos
  
  port map(
  
      VALOR=>DOUT_INTERM,
      SW=>SW,
      SEGMENTADO=>SEGMENTADO,
      AN=>AN
  );

end Xilinx;


