# This file sets up the simulation environment.
create_project -part xc7z010clg400-1 -force sim_proj 
set_property target_language VHDL [current_project]
set_property "default_lib" "work" [current_project]
#set_property "default_lib" "xil_defaultlib" [current_project]

create_fileset -simset simset1
add_files -fileset simset1 [glob ../*.vhd ]
#add_files -fileset simset1 {./simset1.wcfg }
read_ip [glob ../ip/*.xci ]
generate_target {simulation} [get_ips *]
current_fileset -simset [ get_filesets simset1 ]

close_project


