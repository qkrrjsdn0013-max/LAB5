# traffic: Combo II-DLD / Spartan-7 pin map
# Verify connector seating and peripheral polarity before programming.
# FPGA_CLK1
set_property PACKAGE_PIN B6 [get_ports {clk_50mhz}]
# KEY01
set_property PACKAGE_PIN K4 [get_ports {rst_p}]
# KEY02
set_property PACKAGE_PIN N8 [get_ports {flicker}]
# S_RED
set_property PACKAGE_PIN B13 [get_ports {led_red[3]}]
# W_RED
set_property PACKAGE_PIN G14 [get_ports {led_red[2]}]
# E_RED
set_property PACKAGE_PIN C17 [get_ports {led_red[1]}]
# N_RED
set_property PACKAGE_PIN C12 [get_ports {led_red[0]}]
# S_YELLOW
set_property PACKAGE_PIN L18 [get_ports {led_yellow[3]}]
# W_YELLOW
set_property PACKAGE_PIN A14 [get_ports {led_yellow[2]}]
# E_YELLOW
set_property PACKAGE_PIN C18 [get_ports {led_yellow[1]}]
# N_YELLOW
set_property PACKAGE_PIN D13 [get_ports {led_yellow[0]}]
# S_GREEN
set_property PACKAGE_PIN E16 [get_ports {led_green[3]}]
# W_GREEN
set_property PACKAGE_PIN C16 [get_ports {led_green[2]}]
# E_GREEN
set_property PACKAGE_PIN A20 [get_ports {led_green[1]}]
# N_GREEN
set_property PACKAGE_PIN E11 [get_ports {led_green[0]}]
# S_LEFT
set_property PACKAGE_PIN F15 [get_ports {led_left[3]}]
# W_LEFT
set_property PACKAGE_PIN D15 [get_ports {led_left[2]}]
# E_LEFT
set_property PACKAGE_PIN C19 [get_ports {led_left[1]}]
# N_LEFT
set_property PACKAGE_PIN F10 [get_ports {led_left[0]}]
# WALK_S_RED
set_property PACKAGE_PIN A19 [get_ports {led_walk_red[3]}]
# WALK_W_RED
set_property PACKAGE_PIN G13 [get_ports {led_walk_red[2]}]
# WALK_E_RED
set_property PACKAGE_PIN E18 [get_ports {led_walk_red[1]}]
# WALK_N_RED
set_property PACKAGE_PIN C11 [get_ports {led_walk_red[0]}]
# WALK_S_GREEN
set_property PACKAGE_PIN E19 [get_ports {led_walk_green[3]}]
# WALK_W_GREEN
set_property PACKAGE_PIN F12 [get_ports {led_walk_green[2]}]
# WALK_E_GREEN
set_property PACKAGE_PIN A16 [get_ports {led_walk_green[1]}]
# WALK_N_GREEN
set_property PACKAGE_PIN G11 [get_ports {led_walk_green[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports *]
create_clock -name clk_50mhz -period 20.000 [get_ports {clk_50mhz}]
set_false_path -from [get_ports {rst_p flicker}]
