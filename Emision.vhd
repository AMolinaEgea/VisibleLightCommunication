----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.05.2019 12:11:53
-- Design Name: 
-- Module Name: Top_emision - xilinx
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

entity Emision is
  Port (

   DCLK: in std_logic;
   RESET: in std_logic;
   FLAG:in std_logic;
   DIN: in std_logic_vector(7 downto 0);
   DOUT:out std_logic
   
 );end Emision;
architecture Xilinx of Emision is

component axi_uartlite_0
  port (
    s_axi_aclk : IN STD_LOGIC;
    s_axi_aresetn : IN STD_LOGIC;
    interrupt : OUT STD_LOGIC;
    s_axi_awaddr : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    s_axi_awvalid : IN STD_LOGIC;
    s_axi_awready : OUT STD_LOGIC;
    s_axi_wdata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    s_axi_wstrb : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    s_axi_wvalid : IN STD_LOGIC;
    s_axi_wready : OUT STD_LOGIC;
    s_axi_bresp : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
    s_axi_bvalid : OUT STD_LOGIC;
    s_axi_bready : IN STD_LOGIC;
    s_axi_araddr : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    s_axi_arvalid : IN STD_LOGIC;
    s_axi_arready : OUT STD_LOGIC;
    s_axi_rdata : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    s_axi_rresp : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
    s_axi_rvalid : OUT STD_LOGIC;
    s_axi_rready : IN STD_LOGIC;
    rx : IN STD_LOGIC;
    tx : OUT STD_LOGIC
  );
  end component;
  
  signal S_AXI_ACLK : STD_LOGIC;
  signal S_AXI_ARESETN :  STD_LOGIC;
  signal INTERRUPT :  STD_LOGIC;
  signal S_AXI_AWADDR :  STD_LOGIC_VECTOR(3 DOWNTO 0);
  signal S_AXI_AWVALID:  STD_LOGIC;
  signal S_AXI_AWREADY :  STD_LOGIC;
  signal S_AXI_WDATA :  STD_LOGIC_VECTOR(31 DOWNTO 0);
  signal S_AXI_WSTRB :  STD_LOGIC_VECTOR(3 DOWNTO 0);
  signal S_AXI_WVALID :  STD_LOGIC;
  signal S_AXI_WREADY :  STD_LOGIC;
  signal S_AXI_BRESP :  STD_LOGIC_VECTOR(1 DOWNTO 0);
  signal S_AXI_BVALID :  STD_LOGIC;
  signal S_AXI_BREADY :  STD_LOGIC;
  signal S_AXI_ARADDR :  STD_LOGIC_VECTOR(3 DOWNTO 0);
  signal S_AXI_ARVALID :  STD_LOGIC;
  signal S_AXI_ARREADY :  STD_LOGIC;
  signal S_AXI_RDATA :  STD_LOGIC_VECTOR(31 DOWNTO 0);
  signal S_AXI_RRESP :  STD_LOGIC_VECTOR(1 DOWNTO 0);
  signal S_AXI_RVALID :  STD_LOGIC;
  signal S_AXI_RREADY :  STD_LOGIC;
  signal RX :  STD_LOGIC:='1';
  signal TX :  STD_LOGIC;
  type STATES is(REPOSO,LECTURA_1,LECTURA_2,ESCRITURA);--,INICIO_LECTURA,LECTURA_1,CONFIGURACION);
  signal STATE_REG,STATE_NEXT:STATES;
  signal SALIDA_NEXT,SALIDA_REG: std_logic_vector(7 downto 0);
  signal CARGA_NEXT,CARGA_REG:std_logic;
  
begin

UART : axi_uartlite_0
  PORT MAP (
    s_axi_aclk => s_axi_aclk,
    s_axi_aresetn => RESET,
    interrupt => interrupt,
    s_axi_awaddr => s_axi_awaddr,
    s_axi_awvalid => s_axi_awvalid,
    s_axi_awready => s_axi_awready,
    s_axi_wdata => s_axi_wdata,
    s_axi_wstrb => s_axi_wstrb,
    s_axi_wvalid => s_axi_wvalid,
    s_axi_wready => s_axi_wready,
    s_axi_bresp => s_axi_bresp,
    s_axi_bvalid => s_axi_bvalid,
    s_axi_bready => s_axi_bready,
    s_axi_araddr => s_axi_araddr,
    s_axi_arvalid => s_axi_arvalid,
    s_axi_arready => s_axi_arready,
    s_axi_rdata => s_axi_rdata,
    s_axi_rresp => s_axi_rresp,
    s_axi_rvalid => s_axi_rvalid,
    s_axi_rready => s_axi_rready,
    rx => rx,
    tx => tx
  );
    --S_AXI_ARESETN<= not RESET;
    
   S_AXI_ACLK<=DCLK;
   DOUT<=TX;
   
   COMBINACIONAL: process(STATE_REG,S_AXI_BVALID,S_AXI_RVALID,S_AXI_ARREADY,S_AXI_RDATA,FLAG)
   
   
   begin
   
   STATE_NEXT<=STATE_REG;
   S_AXI_AWADDR<=x"8";
   S_AXI_AWVALID<='0';
   S_AXI_WVALID<='0';    
   S_AXI_BREADY<='0';
   S_AXI_ARVALID<='0';
   S_AXI_RREADY<='0';
   S_AXI_ARADDR<=x"8";
   S_AXI_WDATA <= (others =>'0');
   
 
   
   case STATE_REG is
   
           when REPOSO=>
            
                 if(FLAG='1')then
                     STATE_NEXT<=LECTURA_1;
                 else
                     STATE_NEXT<=REPOSO;
                 end if;  
           when LECTURA_1=>
                                    
                  S_AXI_ARADDR<=x"8";
                  S_AXI_ARVALID<='1';
                  S_AXI_RREADY<='1';
                                        
                  if(S_AXI_ARREADY='1')then
                                             
                        STATE_NEXT<=LECTURA_2;                
                             
                  else
                                         
                        STATE_NEXT<=LECTURA_1;
                  end if; 
                              
                              
            when LECTURA_2=>
                              
                  S_AXI_RREADY<='1';
                  if(S_AXI_RVALID='1')then
                                                                        
                     if(S_AXI_RDATA(3)='0')then
                                     
                           STATE_NEXT<=ESCRITURA;
                                     
                     else
                                         
                           STATE_NEXT<=LECTURA_1;
                                         
                     end if;                                                      
                     
                     else
                                                       
                           STATE_NEXT<=LECTURA_1;
                     end if;
                      
             
            when ESCRITURA=>
                   
 
                     S_AXI_AWADDR<=x"4";
                     S_AXI_AWVALID<='1';
                     S_AXI_WDATA(7 downto 0)<=DIN;
                     S_AXI_WVALID<='1';
                     S_AXI_BREADY<='1';
                     
                     if(S_AXI_BVALID='1')then
                         STATE_NEXT<=REPOSO;
                         
                     else
                         
                         STATE_NEXT<=ESCRITURA;
                                
                     end if;
                 
                   
   end case;
   end process; 
 
   SECUENCIAL: process(DCLK,RESET)
   
   begin
   
   if(RESET = '0')then
   
       STATE_REG<=REPOSO;
       
     
   elsif(DCLK'event and DCLK='1')then
   
   
       STATE_REG<=STATE_NEXT;
       
       
   end if;
   end process;
end Xilinx;
