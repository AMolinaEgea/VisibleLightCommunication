----------------------------------------------------------------------------------
-- Company:
-- Engineer:
--
-- Create Date: 14.05.2019 15:23:10
-- Design Name:
-- Module Name: Top_conversion - xilinx
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


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
Library UNISIM;
use UNISIM.VCOMPONENTS.ALL;


entity Conversion is

port
   (

    --drdy_out        : out  STD_LOGIC;                        -- Data ready signal for the dynamic reconfiguration port
    --dwe_in          : in  STD_LOGIC;                         -- Write Enable for the dynamic reconfiguration port
    --den_in          : in  STD_LOGIC;                         -- Enable Signal for the dynamic reconfiguration port
    --daddr_in        : in  STD_LOGIC_VECTOR (6 downto 0);     -- Address bus for the dynamic reconfiguration port

    DCLK            : in  std_logic;                         -- Clock input for the dynamic reconfiguration port
    RESET           : in  std_logic;                         -- Reset signal for the System Monitor control logic
    VAUXP14         : in  std_logic;                         -- Auxiliary Channel 14
    VAUXN14         : in  std_logic;
    --BUSY_OUT        : out  std_logic;                        -- ADC Busy signal
    --CHANNEL_OUT     : out  STD_LOGIC_VECTOR (4 downto 0);    -- Channel Selection Outputs
    DRDY_OUT         : out  std_logic;                        -- End of Conversion Signal
    SALIDA          : out std_logic_vector (11 downto 0)


);
end Conversion;

architecture Xilinx of Conversion is
COMPONENT xadc_wiz_0
  PORT (
    di_in : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    daddr_in : IN STD_LOGIC_VECTOR(6 DOWNTO 0);
    den_in : IN STD_LOGIC;
    dwe_in : IN STD_LOGIC;
    drdy_out : OUT STD_LOGIC;
    do_out : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
    dclk_in : IN STD_LOGIC;
    reset_in : IN STD_LOGIC;
    vp_in : IN STD_LOGIC;
    vn_in : IN STD_LOGIC;
    vauxp14 : IN STD_LOGIC;
    vauxn14 : IN STD_LOGIC;
    channel_out : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
    eoc_out : OUT STD_LOGIC;
    alarm_out : OUT STD_LOGIC;
    eos_out : OUT STD_LOGIC;
    busy_out : OUT STD_LOGIC
  );
END COMPONENT;


--signal DRDY_OUT : std_logic;--Entrada al DRP(Añadida de ports)
signal DADDR_IN : std_logic_vector (6 downto 0);--Salida del DRP(Añadida de ports)
signal EOC_DRP : std_logic;
signal VP_IN : std_logic;
signal VN_IN : std_logic;
signal RESET_XADC: std_logic;
signal CHANNEL_OUT:std_logic_vector(4 downto 0);
signal BUSY_OUT:std_logic;
signal EOC_OUT:std_logic;
signal SALIDA_1:std_logic_vector(15 downto 0);

begin



XADC : xadc_wiz_0
  PORT MAP (
    di_in => (others=>'0'),
    daddr_in => DADDR_IN,
    den_in => EOC_DRP,
    dwe_in => '0',
    drdy_out => DRDY_OUT,
    do_out => SALIDA_1,
    dclk_in => DCLK,
    reset_in => RESET_XADC,
    vp_in => VP_IN,
    vn_in => VN_IN,
    vauxp14 => VAUXP14,
    vauxn14 => VAUXN14,
    channel_out => CHANNEL_OUT,
    eoc_out => EOC_DRP,
    alarm_out => open,
    eos_out => open,
    busy_out => busy_out
  );

    DADDR_IN <= "0011110";
    EOC_OUT<=EOC_DRP;
    RESET_XADC<=not RESET;
    SALIDA<=SALIDA_1(15 downto 4);

end Xilinx;
