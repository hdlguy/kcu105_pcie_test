# Script to compile the FPGA with zynq processor system all the way to bit file.
set outputDir ./results
file mkdir ./results
open_project proj.xpr

set list1 [get_ips *];
set list2 [get_ips system*];
set list3 {};
foreach core $list1 {if {[lsearch $list2 $core]==-1} { set list3 "$list3 $core" }};
puts $list3;
synth_ip [get_ips $list3]


synth_design -top top

write_checkpoint -force ./results/post_synth.dcp

# add ila logic analyzer.
#source add_ila.tcl

opt_design

place_design

phys_opt_design

route_design

write_checkpoint -force ./results/post_route.dcp

report_clocks               -file ./results/clocks.rpt
report_clock_interaction    -file ./results/clock_interaction.rpt
report_clock_networks       -file ./results/clock_networks.rpt
report_route_status         -file ./results/post_route_status.rpt
report_timing_summary       -file ./results/post_route_timing_summary.rpt
report_utilization          -file ./results/post_route_util.rpt
report_power                -file ./results/post_route_power.rpt
report_drc                  -file ./results/post_imp_drc.rpt
report_io                   -file ./results/post_imp_io.rpt

xilinx::ultrafast::report_io_reg -verbose -file ./results/io_regs.rpt

#set_property SPI_BUSWIDTH 8 [current_design]
#set_property CFGBVS VCCO [current_design]
#set_property CONFIG_VOLTAGE 2.5 [current_design]
#set_property BITSTREAM.CONFIG.CONFIGRATE 6 [current_design]
#write_bitstream -verbose -force ./results/top.bit

#close_project

#write_cfgmem -force -format MCS -size 128 -interface BPIx16 -loadbit "up 0x0 ./results/top.bit" -verbose ./results/top.mcs

set_property CFGBVS GND [current_design]
set_property CONFIG_VOLTAGE 1.8 [current_design]

set_property BITSTREAM.CONFIG.CONFIGRATE 50 [current_design]
set_property BITSTREAM.Config.SPI_BUSWIDTH 4 [current_design]
write_bitstream -verbose -force $outputDir/top.bit

close_project

write_cfgmem -force -format MCS -size 256 -interface SPIx4 -loadbit "up 0x0 ./results/top.bit" -verbose ./results/top.mcs
