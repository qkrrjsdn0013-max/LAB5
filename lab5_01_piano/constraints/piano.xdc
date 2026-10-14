# piano: Combo II-DLD / Spartan-7 pin map
# Verify connector seating and peripheral polarity before programming.
# FPGA_CLK1
set_property PACKAGE_PIN B6 [get_ports {clk_50mhz}]
# KEY01
set_property PACKAGE_PIN K4 [get_ports {rst_p}]
# KEY05
set_property PACKAGE_PIN P6 [get_ports {key[7]}]
# KEY06
set_property PACKAGE_PIN N6 [get_ports {key[6]}]
# KEY07
set_property PACKAGE_PIN L5 [get_ports {key[5]}]
# KEY08
set_property PACKAGE_PIN J2 [get_ports {key[4]}]
# KEY09
set_property PACKAGE_PIN K2 [get_ports {key[3]}]
# KEY10
set_property PACKAGE_PIN L7 [get_ports {key[2]}]
# KEY11
set_property PACKAGE_PIN L1 [get_ports {key[1]}]
# KEY12
set_property PACKAGE_PIN K6 [get_ports {key[0]}]
# PIEZO
set_property PACKAGE_PIN Y21 [get_ports {piezo}]
set_property IOSTANDARD LVCMOS33 [get_ports *]
create_clock -name clk_50mhz -period 20.000 [get_ports {clk_50mhz}]
set_false_path -from [get_ports {rst_p key[*]}]
