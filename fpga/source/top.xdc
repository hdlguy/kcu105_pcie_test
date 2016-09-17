#
set_property PACKAGE_PIN AV40 [get_ports reset]
set_property IOSTANDARD LVCMOS18 [get_ports reset]
#
set_property PACKAGE_PIN AB8 [get_ports pcie_refclk_p]
set_property PACKAGE_PIN AB7 [get_ports pcie_refclk_n]
#
set_property PACKAGE_PIN AV35 [get_ports pcie_perst_n]
set_property IOSTANDARD LVCMOS18 [get_ports pcie_perst_n]
#LED
set_property IOSTANDARD LVCMOS18 [get_ports {led[*]}]
set_property PACKAGE_PIN AM39 [get_ports led[0]]
set_property PACKAGE_PIN AN39 [get_ports led[1]]
set_property PACKAGE_PIN AR37 [get_ports led[2]]
set_property PACKAGE_PIN AT37 [get_ports led[3]]
set_property PACKAGE_PIN AR35 [get_ports led[4]]
set_property PACKAGE_PIN AP41 [get_ports led[5]]
set_property PACKAGE_PIN AP42 [get_ports led[6]]
set_property PACKAGE_PIN AU39 [get_ports led[7]]

set_property PACKAGE_PIN AP8 [get_ports {led[0]}]
set_property PACKAGE_PIN H23 [get_ports {led[1]}]
set_property PACKAGE_PIN P20 [get_ports {led[2]}]
set_property PACKAGE_PIN P21 [get_ports {led[3]}]
set_property PACKAGE_PIN N22 [get_ports {led[4]}]
set_property PACKAGE_PIN M22 [get_ports {led[5]}]
set_property PACKAGE_PIN R23 [get_ports {led[6]}]
set_property PACKAGE_PIN P23 [get_ports {led[7]}]
set_property PACKAGE_PIN AB6 [get_ports pcie_refclk_p]
