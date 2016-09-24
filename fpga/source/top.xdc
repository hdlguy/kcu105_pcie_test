#
create_clock -period 10.000 -name pcie_refclk_p -waveform {0.000 5.000} [get_ports {pcie_refclk_p}]
#
set_property PACKAGE_PIN AB6 [get_ports pcie_refclk_p]
#
set_property IOSTANDARD LVCMOS18 [get_ports pcie_perst_n]
set_property PACKAGE_PIN K22 [get_ports pcie_perst_n]
#LED
set_property IOSTANDARD LVCMOS18 [get_ports {led[*]}]
set_property PACKAGE_PIN AP8 [get_ports {led[0]}]
set_property PACKAGE_PIN H23 [get_ports {led[1]}]
set_property PACKAGE_PIN P20 [get_ports {led[2]}]
set_property PACKAGE_PIN P21 [get_ports {led[3]}]
set_property PACKAGE_PIN N22 [get_ports {led[4]}]
set_property PACKAGE_PIN M22 [get_ports {led[5]}]
set_property PACKAGE_PIN R23 [get_ports {led[6]}]
set_property PACKAGE_PIN P23 [get_ports {led[7]}]
set_property PACKAGE_PIN AB6 [get_ports pcie_refclk_p]
