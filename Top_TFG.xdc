## Clock signal
set_property PACKAGE_PIN W5 [get_ports DCLK]
set_property IOSTANDARD LVCMOS33 [get_ports DCLK]
create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports DCLK]


## Switches
set_property PACKAGE_PIN V17 [get_ports SW[0]]
set_property IOSTANDARD LVCMOS33 [get_ports SW[0]]
set_property PACKAGE_PIN V16 [get_ports SW[1]]
set_property IOSTANDARD LVCMOS33 [get_ports SW[1]]
set_property PACKAGE_PIN W16 [get_ports SW[2]]
set_property IOSTANDARD LVCMOS33 [get_ports SW[2]]
set_property PACKAGE_PIN W17 [get_ports SW[3]]
set_property IOSTANDARD LVCMOS33 [get_ports SW[3]]

##7 segment display
set_property PACKAGE_PIN W7 [get_ports SEGMENTADO[0]]
set_property IOSTANDARD LVCMOS33 [get_ports SEGMENTADO[0]]
set_property PACKAGE_PIN W6 [get_ports SEGMENTADO[1]]
set_property IOSTANDARD LVCMOS33 [get_ports SEGMENTADO[1]]
set_property PACKAGE_PIN U8 [get_ports SEGMENTADO[2]]
set_property IOSTANDARD LVCMOS33 [get_ports SEGMENTADO[2]]
set_property PACKAGE_PIN V8 [get_ports SEGMENTADO[3]]
set_property IOSTANDARD LVCMOS33 [get_ports SEGMENTADO[3]]
set_property PACKAGE_PIN U5 [get_ports SEGMENTADO[4]]
set_property IOSTANDARD LVCMOS33 [get_ports SEGMENTADO[4]]
set_property PACKAGE_PIN V5 [get_ports SEGMENTADO[5]]
set_property IOSTANDARD LVCMOS33 [get_ports SEGMENTADO[5]]
set_property PACKAGE_PIN U7 [get_ports SEGMENTADO[6]]
set_property IOSTANDARD LVCMOS33 [get_ports SEGMENTADO[6]]

set_property PACKAGE_PIN U2 [get_ports AN[0]]
set_property IOSTANDARD LVCMOS33 [get_ports AN[0]]
set_property PACKAGE_PIN U4 [get_ports AN[1]]
set_property IOSTANDARD LVCMOS33 [get_ports AN[1]]
set_property PACKAGE_PIN V4 [get_ports AN[2]]
set_property IOSTANDARD LVCMOS33 [get_ports AN[2]]
set_property PACKAGE_PIN W4 [get_ports AN[3]]
set_property IOSTANDARD LVCMOS33 [get_ports AN[3]]

##Pmod Header JXADC

##Sch name = XA2_P
set_property PACKAGE_PIN L3 [get_ports VAUXP14]
set_property IOSTANDARD LVCMOS33 [get_ports VAUXP14]

##Sch name = XA2_N
set_property PACKAGE_PIN M3 [get_ports VAUXN14]
set_property IOSTANDARD LVCMOS33 [get_ports VAUXN14]

##Buttons
set_property PACKAGE_PIN T18 [get_ports RESET]
set_property IOSTANDARD LVCMOS33 [get_ports RESET]

##Pmod Header JA

##Sch name = JA1
set_property PACKAGE_PIN J1 [get_ports SALIDA_COD_EMISOR]
set_property IOSTANDARD LVCMOS33 [get_ports SALIDA_COD_EMISOR]

##USB-RS232 Interface
set_property PACKAGE_PIN B18 [get_ports DIN]
set_property IOSTANDARD LVCMOS33 [get_ports DIN]
set_property PACKAGE_PIN H1 [get_ports SALIDA_RECEPTOR]
set_property IOSTANDARD LVCMOS33 [get_ports SALIDA_RECEPTOR]
    
## Configuration options, can be used for all designs
set_property CONFIG_VOLTAGE 3.3 [current_design]
set_property CFGBVS VCCO [current_design]
