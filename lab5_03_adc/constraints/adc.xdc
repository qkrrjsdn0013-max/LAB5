# adc: Combo II-DLD / Spartan-7 pin map
# Verify connector seating and peripheral polarity before programming.
# FPGA_CLK1
set_property PACKAGE_PIN B6 [get_ports {clk_50mhz}]
# KEY01
set_property PACKAGE_PIN K4 [get_ports {rst_p}]
# DIP_SW1
set_property PACKAGE_PIN Y1 [get_ports {add_sel[2]}]
# DIP_SW2
set_property PACKAGE_PIN W3 [get_ports {add_sel[1]}]
# DIP_SW3
set_property PACKAGE_PIN U2 [get_ports {add_sel[0]}]
# SPI_AD
set_property PACKAGE_PIN H3 [get_ports {adc_ncs}]
# SPI_DIN
set_property PACKAGE_PIN H5 [get_ports {adc_din}]
# SPI_DOUT
set_property PACKAGE_PIN J6 [get_ports {adc_dout}]
# SPI_SCK
set_property PACKAGE_PIN H7 [get_ports {adc_sclk}]
# LED_D8
set_property PACKAGE_PIN N5 [get_ports {led_out[0]}]
# LED_D7
set_property PACKAGE_PIN M1 [get_ports {led_out[1]}]
# LED_D6
set_property PACKAGE_PIN M3 [get_ports {led_out[2]}]
# LED_D5
set_property PACKAGE_PIN M7 [get_ports {led_out[3]}]
# LED_D4
set_property PACKAGE_PIN N7 [get_ports {led_out[4]}]
# LED_D3
set_property PACKAGE_PIN M2 [get_ports {led_out[5]}]
# LED_D2
set_property PACKAGE_PIN M4 [get_ports {led_out[6]}]
# LED_D1
set_property PACKAGE_PIN L4 [get_ports {led_out[7]}]
# EXT[0]
set_property PACKAGE_PIN G10 [get_ports {sample[0]}]
# EXT[1]
set_property PACKAGE_PIN C10 [get_ports {sample[1]}]
# EXT[2]
set_property PACKAGE_PIN F11 [get_ports {sample[2]}]
# EXT[3]
set_property PACKAGE_PIN D11 [get_ports {sample[3]}]
# EXT[4]
set_property PACKAGE_PIN A11 [get_ports {sample[4]}]
# EXT[5]
set_property PACKAGE_PIN E12 [get_ports {sample[5]}]
# EXT[6]
set_property PACKAGE_PIN A12 [get_ports {sample[6]}]
# EXT[7]
set_property PACKAGE_PIN F13 [get_ports {sample[7]}]
# EXT[8]
set_property PACKAGE_PIN C13 [get_ports {sample[8]}]
# EXT[9]
set_property PACKAGE_PIN A13 [get_ports {sample[9]}]
# EXT[10]
set_property PACKAGE_PIN F14 [get_ports {sample[10]}]
# EXT[11]
set_property PACKAGE_PIN B14 [get_ports {sample[11]}]
# EXT[12]
set_property PACKAGE_PIN G15 [get_ports {data_valid}]
set_property IOSTANDARD LVCMOS33 [get_ports *]
create_clock -name clk_50mhz -period 20.000 [get_ports {clk_50mhz}]
set_false_path -from [get_ports {rst_p add_sel[*] adc_dout}]
