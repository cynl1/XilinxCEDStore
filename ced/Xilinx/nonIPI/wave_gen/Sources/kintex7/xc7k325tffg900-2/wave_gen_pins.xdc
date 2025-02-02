set_property IOSTANDARD LVCMOS15 [get_ports {led_pins[0]}]
set_property IOSTANDARD LVCMOS15 [get_ports {led_pins[1]}]
set_property IOSTANDARD LVCMOS15 [get_ports {led_pins[2]}]
set_property IOSTANDARD LVCMOS15 [get_ports {led_pins[3]}]
set_property DRIVE 12 [get_ports {led_pins[0]}]
set_property DRIVE 12 [get_ports {led_pins[1]}]
set_property DRIVE 12 [get_ports {led_pins[2]}]
set_property DRIVE 12 [get_ports {led_pins[3]}]
set_property SLEW SLOW [get_ports {led_pins[0]}]
set_property SLEW SLOW [get_ports {led_pins[1]}]
set_property SLEW SLOW [get_ports {led_pins[2]}]
set_property SLEW SLOW [get_ports {led_pins[3]}]
set_property IOSTANDARD LVCMOS25 [get_ports {led_pins[4]}]
set_property IOSTANDARD LVCMOS25 [get_ports {led_pins[5]}]
set_property IOSTANDARD LVCMOS25 [get_ports {led_pins[6]}]
set_property IOSTANDARD LVCMOS25 [get_ports {led_pins[7]}]
set_property DRIVE 12 [get_ports {led_pins[4]}]
set_property DRIVE 12 [get_ports {led_pins[5]}]
set_property DRIVE 12 [get_ports {led_pins[6]}]
set_property DRIVE 12 [get_ports {led_pins[7]}]
set_property SLEW SLOW [get_ports {led_pins[4]}]
set_property SLEW SLOW [get_ports {led_pins[5]}]
set_property SLEW SLOW [get_ports {led_pins[6]}]
set_property SLEW SLOW [get_ports {led_pins[7]}]
set_property IOSTANDARD LVDS [get_ports clk_pin_p]
set_property IOSTANDARD LVCMOS25 [get_ports dac_clr_n_pin]
set_property IOSTANDARD LVCMOS25 [get_ports dac_cs_n_pin]
set_property IOSTANDARD LVCMOS25 [get_ports lb_sel_pin]
set_property IOSTANDARD LVCMOS15 [get_ports rst_pin]
set_property IOSTANDARD LVCMOS25 [get_ports rxd_pin]
set_property IOSTANDARD LVCMOS25 [get_ports spi_clk_pin]
set_property IOSTANDARD LVCMOS25 [get_ports spi_mosi_pin]
set_property IOSTANDARD LVCMOS25 [get_ports txd_pin]

set_property PACKAGE_PIN AD12 [get_ports clk_pin_p]
set_property PACKAGE_PIN AF27 [get_ports dac_clr_n_pin]
set_property PACKAGE_PIN AF26 [get_ports dac_cs_n_pin]
set_property PACKAGE_PIN Y29 [get_ports lb_sel_pin]
set_property PACKAGE_PIN AB8 [get_ports {led_pins[0]}]
set_property PACKAGE_PIN AA8 [get_ports {led_pins[1]}]
set_property PACKAGE_PIN AC9 [get_ports {led_pins[2]}]
set_property PACKAGE_PIN AB9 [get_ports {led_pins[3]}]
set_property PACKAGE_PIN AE26 [get_ports {led_pins[4]}]
set_property PACKAGE_PIN G19 [get_ports {led_pins[5]}]
set_property PACKAGE_PIN E18 [get_ports {led_pins[6]}]
set_property PACKAGE_PIN F16 [get_ports {led_pins[7]}]
set_property PACKAGE_PIN AB7 [get_ports rst_pin]
set_property PACKAGE_PIN M19 [get_ports rxd_pin]
set_property PACKAGE_PIN AK26 [get_ports spi_clk_pin]
set_property PACKAGE_PIN AJ26 [get_ports spi_mosi_pin]
set_property PACKAGE_PIN K24 [get_ports txd_pin]

set_property IOB TRUE [all_fanin -only_cells -startpoints_only -flat [all_outputs]]
