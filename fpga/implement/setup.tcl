# This script sets up a Vivado project with all ip references resolved.
# tclapp::install ultrafast
file delete -force proj.xpr *.os *.jou *.log implement/* proj.srcs proj.cache proj.runs proj.sim proj.hw proj.ip_user_files ip
#
create_project -force proj 
set_property board_part xilinx.com:kcu105:part0:1.1 [current_project]
#set_property board_part xilinx.com:kcu105:part0:1.1 [current_project]
#set_property part xcku040-ffva1156-2-e [current_project]
#set_property board_part xilinx.com:vc707:part0:1.2 [current_project]
#set_property board_part xilinx.com:vc709:part0:1.0 [current_project]
#set_property board_part em.avnet.com:7a50t:part0:1.0 [current_project]
#
set_property target_language Verilog [current_project]
set_property default_lib work [current_project]
load_features ipintegrator
tclapp::install ultrafast -quiet

# Load in the custom IP block for the register file.
file delete -force ./ip
file mkdir ./ip
set_property ip_repo_paths ./ip [current_fileset]
update_ip_catalog
update_ip_catalog -add_ip ../source/regfilex16/user.org_user_regfilex16_v1_0_1.0.zip -repo_path ./ip

# read in ip cores
read_ip ../source/spi_slave/ip/spi_slave_mem.xci
upgrade_ip -quiet [get_ips *]
generate_target {all} [get_ips *]
synth_ip -force [get_ips *]

# Recreate the Block Diagram of the processor system.
source ../source/system.tcl
generate_target {synthesis implementation} [get_files ./proj.srcs/sources_1/bd/system/system.bd]
set_property synth_checkpoint_mode None [get_files ./proj.srcs/sources_1/bd/system/system.bd]

# Read in the hdl source.
read_vhdl        [glob ../source/spi_slave/spi_slave.vhd]
read_verilog -sv [glob ../source/top.v]

read_xdc ../source/top.xdc

close_project



