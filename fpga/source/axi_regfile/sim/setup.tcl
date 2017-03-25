# This file sets up the simulation environment.
create_project -force proj 
set_property board_part xilinx.com:vc709:part0:1.7 [current_project]
set_property target_language Verilog [current_project]
set_property "default_lib" "work" [current_project]
create_fileset -simset simset

#read_ip [glob ../dac_clock_wiz/dac_clock_wiz.xci ]
#read_ip [glob ../dac_if_fifo/dac_if_fifo.xci ]
#generate_target {all} [get_ips *]

read_verilog -sv [glob ../axi_sim_master_1.0/hdl/axi_sim_master_v1_0_M00_AXI.v]
read_verilog -sv [glob ../axi_sim_master_1.0/hdl/axi_sim_master_v1_0.v]
read_verilog -sv [glob ../axi_regfile_v1_0_S00_AXI.v]
read_verilog -sv [glob ../axi_regfile_tb.v]

current_fileset -simset [ get_filesets simset ]

set_property -name {xsim.elaborate.debug_level} -value {all} -objects [current_fileset -simset]
set_property -name {xsim.simulate.runtime} -value {1000ns} -objects [current_fileset -simset]

close_project


