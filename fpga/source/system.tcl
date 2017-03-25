
################################################################
# This is a generated script based on design: system
#
# Though there are limitations about the generated script,
# the main purpose of this utility is to make learning
# IP Integrator Tcl commands easier.
################################################################

namespace eval _tcl {
proc get_script_folder {} {
   set script_path [file normalize [info script]]
   set script_folder [file dirname $script_path]
   return $script_folder
}
}
variable script_folder
set script_folder [_tcl::get_script_folder]

################################################################
# Check if script is running in correct Vivado version.
################################################################
set scripts_vivado_version 2016.4
set current_vivado_version [version -short]

if { [string first $scripts_vivado_version $current_vivado_version] == -1 } {
   puts ""
   catch {common::send_msg_id "BD_TCL-109" "ERROR" "This script was generated using Vivado <$scripts_vivado_version> and is being run in <$current_vivado_version> of Vivado. Please run the script in Vivado <$scripts_vivado_version> then open the design in Vivado <$current_vivado_version>. Upgrade the design by running \"Tools => Report => Report IP Status...\", then run write_bd_tcl to create an updated script."}

   return 1
}

################################################################
# START
################################################################

# To test this script, run the following commands from Vivado Tcl console:
# source system_script.tcl

# If there is no project opened, this script will create a
# project, but make sure you do not have an existing project
# <./myproj/project_1.xpr> in the current working folder.

set list_projs [get_projects -quiet]
if { $list_projs eq "" } {
   create_project project_1 myproj -part xcku040-ffva1156-2-e
   set_property BOARD_PART xilinx.com:kcu105:part0:1.1 [current_project]
}


# CHANGE DESIGN NAME HERE
set design_name system

# If you do not already have an existing IP Integrator design open,
# you can create a design using the following command:
#    create_bd_design $design_name

# Creating design if needed
set errMsg ""
set nRet 0

set cur_design [current_bd_design -quiet]
set list_cells [get_bd_cells -quiet]

if { ${design_name} eq "" } {
   # USE CASES:
   #    1) Design_name not set

   set errMsg "Please set the variable <design_name> to a non-empty value."
   set nRet 1

} elseif { ${cur_design} ne "" && ${list_cells} eq "" } {
   # USE CASES:
   #    2): Current design opened AND is empty AND names same.
   #    3): Current design opened AND is empty AND names diff; design_name NOT in project.
   #    4): Current design opened AND is empty AND names diff; design_name exists in project.

   if { $cur_design ne $design_name } {
      common::send_msg_id "BD_TCL-001" "INFO" "Changing value of <design_name> from <$design_name> to <$cur_design> since current design is empty."
      set design_name [get_property NAME $cur_design]
   }
   common::send_msg_id "BD_TCL-002" "INFO" "Constructing design in IPI design <$cur_design>..."

} elseif { ${cur_design} ne "" && $list_cells ne "" && $cur_design eq $design_name } {
   # USE CASES:
   #    5) Current design opened AND has components AND same names.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 1
} elseif { [get_files -quiet ${design_name}.bd] ne "" } {
   # USE CASES: 
   #    6) Current opened design, has components, but diff names, design_name exists in project.
   #    7) No opened design, design_name exists in project.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 2

} else {
   # USE CASES:
   #    8) No opened design, design_name not in project.
   #    9) Current opened design, has components, but diff names, design_name not in project.

   common::send_msg_id "BD_TCL-003" "INFO" "Currently there is no design <$design_name> in project, so creating one..."

   create_bd_design $design_name

   common::send_msg_id "BD_TCL-004" "INFO" "Making design <$design_name> as current_bd_design."
   current_bd_design $design_name

}

common::send_msg_id "BD_TCL-005" "INFO" "Currently the variable <design_name> is equal to \"$design_name\"."

if { $nRet != 0 } {
   catch {common::send_msg_id "BD_TCL-114" "ERROR" $errMsg}
   return $nRet
}

##################################################################
# DESIGN PROCs
##################################################################



# Procedure to create entire design; Provide argument to make
# procedure reusable. If parentCell is "", will use root.
proc create_root_design { parentCell } {

  variable script_folder

  if { $parentCell eq "" } {
     set parentCell [get_bd_cells /]
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_msg_id "BD_TCL-100" "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_msg_id "BD_TCL-101" "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj


  # Create interface ports
  set M00_AXI [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M00_AXI ]
  set_property -dict [ list \
CONFIG.ADDR_WIDTH {32} \
CONFIG.DATA_WIDTH {32} \
CONFIG.FREQ_HZ {125000000} \
CONFIG.HAS_BURST {0} \
CONFIG.HAS_CACHE {0} \
CONFIG.HAS_LOCK {0} \
CONFIG.HAS_QOS {0} \
CONFIG.HAS_REGION {0} \
CONFIG.PROTOCOL {AXI4LITE} \
 ] $M00_AXI
  set pcie_7x_mgt [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:pcie_7x_mgt_rtl:1.0 pcie_7x_mgt ]
  set pcie_refclk [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_clock_rtl:1.0 pcie_refclk ]

  # Create ports
  set axi_clk [ create_bd_port -dir O -type clk axi_clk ]
  set pcie_perst_n [ create_bd_port -dir I -type rst pcie_perst_n ]

  # Create instance: axi_bram_ctrl_0, and set properties
  set axi_bram_ctrl_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_bram_ctrl:4.0 axi_bram_ctrl_0 ]
  set_property -dict [ list \
CONFIG.SINGLE_PORT_BRAM {1} \
 ] $axi_bram_ctrl_0

  # Create instance: axi_interconnect_0, and set properties
  set axi_interconnect_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_interconnect_0 ]
  set_property -dict [ list \
CONFIG.NUM_MI {2} \
 ] $axi_interconnect_0

  # Create instance: axi_pcie3_0, and set properties
  set axi_pcie3_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_pcie3:3.0 axi_pcie3_0 ]
  set_property -dict [ list \
CONFIG.axi_aclk_loopback {true} \
CONFIG.axi_data_width {256_bit} \
CONFIG.axisten_freq {125} \
CONFIG.c_s_axi_supports_narrow_burst {true} \
CONFIG.mcap_enablement {None} \
CONFIG.mode_selection {Advanced} \
CONFIG.pf0_bar0_scale {Megabytes} \
CONFIG.pf0_bar0_size {1} \
CONFIG.pf0_device_id {8028} \
CONFIG.pl_link_cap_max_link_speed {5.0_GT/s} \
CONFIG.pl_link_cap_max_link_width {X8} \
CONFIG.plltype {QPLL1} \
 ] $axi_pcie3_0

  # Need to retain value_src of defaults
  set_property -dict [ list \
CONFIG.axi_aclk_loopback.VALUE_SRC {DEFAULT} \
 ] $axi_pcie3_0

  # Create instance: blk_mem_gen_0, and set properties
  set blk_mem_gen_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:blk_mem_gen:8.3 blk_mem_gen_0 ]
  set_property -dict [ list \
CONFIG.use_bram_block {BRAM_Controller} \
 ] $blk_mem_gen_0

  # Need to retain value_src of defaults
  set_property -dict [ list \
CONFIG.use_bram_block.VALUE_SRC {DEFAULT} \
 ] $blk_mem_gen_0

  # Create instance: fit_timer_0, and set properties
  set fit_timer_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:fit_timer:2.0 fit_timer_0 ]
  set_property -dict [ list \
CONFIG.C_NO_CLOCKS {125000} \
 ] $fit_timer_0

  # Create instance: util_ds_buf_0, and set properties
  set util_ds_buf_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_ds_buf:2.1 util_ds_buf_0 ]
  set_property -dict [ list \
CONFIG.C_BUF_TYPE {IBUFDSGTE} \
 ] $util_ds_buf_0

  # Create instance: xlconstant_0, and set properties
  set xlconstant_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_0 ]
  set_property -dict [ list \
CONFIG.CONST_VAL {15} \
CONFIG.CONST_WIDTH {5} \
 ] $xlconstant_0

  # Create interface connections
  connect_bd_intf_net -intf_net CLK_IN_D_1 [get_bd_intf_ports pcie_refclk] [get_bd_intf_pins util_ds_buf_0/CLK_IN_D]
  connect_bd_intf_net -intf_net axi_bram_ctrl_0_BRAM_PORTA [get_bd_intf_pins axi_bram_ctrl_0/BRAM_PORTA] [get_bd_intf_pins blk_mem_gen_0/BRAM_PORTA]
  connect_bd_intf_net -intf_net axi_interconnect_0_M00_AXI [get_bd_intf_ports M00_AXI] [get_bd_intf_pins axi_interconnect_0/M00_AXI]
  connect_bd_intf_net -intf_net axi_interconnect_0_M01_AXI [get_bd_intf_pins axi_bram_ctrl_0/S_AXI] [get_bd_intf_pins axi_interconnect_0/M01_AXI]
  connect_bd_intf_net -intf_net axi_pcie3_0_M_AXI [get_bd_intf_pins axi_interconnect_0/S00_AXI] [get_bd_intf_pins axi_pcie3_0/M_AXI]
  connect_bd_intf_net -intf_net axi_pcie3_0_pcie_7x_mgt [get_bd_intf_ports pcie_7x_mgt] [get_bd_intf_pins axi_pcie3_0/pcie_7x_mgt]

  # Create port connections
  connect_bd_net -net axi_pcie_0_axi_aclk_out [get_bd_ports axi_clk] [get_bd_pins axi_bram_ctrl_0/s_axi_aclk] [get_bd_pins axi_interconnect_0/ACLK] [get_bd_pins axi_interconnect_0/M00_ACLK] [get_bd_pins axi_interconnect_0/M01_ACLK] [get_bd_pins axi_interconnect_0/S00_ACLK] [get_bd_pins axi_pcie3_0/axi_aclk] [get_bd_pins axi_pcie3_0/axi_ctl_aclk] [get_bd_pins fit_timer_0/Clk]
  connect_bd_net -net fit_timer_0_Interrupt [get_bd_pins axi_pcie3_0/intx_msi_request] [get_bd_pins fit_timer_0/Interrupt]
  connect_bd_net -net pcie_perst_n_1 [get_bd_ports pcie_perst_n] [get_bd_pins axi_pcie3_0/sys_rst_n]
  connect_bd_net -net proc_sys_reset_0_interconnect_aresetn [get_bd_pins axi_bram_ctrl_0/s_axi_aresetn] [get_bd_pins axi_interconnect_0/ARESETN] [get_bd_pins axi_interconnect_0/M00_ARESETN] [get_bd_pins axi_interconnect_0/M01_ARESETN] [get_bd_pins axi_interconnect_0/S00_ARESETN] [get_bd_pins axi_pcie3_0/axi_aresetn] [get_bd_pins fit_timer_0/Rst]
  connect_bd_net -net util_ds_buf_0_IBUF_DS_ODIV2 [get_bd_pins axi_pcie3_0/refclk] [get_bd_pins util_ds_buf_0/IBUF_DS_ODIV2]
  connect_bd_net -net util_ds_buf_0_IBUF_OUT [get_bd_pins axi_pcie3_0/sys_clk_gt] [get_bd_pins util_ds_buf_0/IBUF_OUT]
  connect_bd_net -net xlconstant_0_dout [get_bd_pins axi_pcie3_0/msi_vector_num] [get_bd_pins xlconstant_0/dout]

  # Create address segments
  create_bd_addr_seg -range 0x00010000 -offset 0x00010000 [get_bd_addr_spaces axi_pcie3_0/M_AXI] [get_bd_addr_segs M00_AXI/Reg] SEG_M00_AXI_Reg
  create_bd_addr_seg -range 0x00001000 -offset 0x00030000 [get_bd_addr_spaces axi_pcie3_0/M_AXI] [get_bd_addr_segs axi_bram_ctrl_0/S_AXI/Mem0] SEG_axi_bram_ctrl_0_Mem0

  # Perform GUI Layout
  regenerate_bd_layout -layout_string {
   guistr: "# # String gsaved with Nlview 6.6.5b  2016-09-06 bk=1.3687 VDI=39 GEI=35 GUI=JA:1.6
#  -string -flagsOSRD
preplace port pcie_perst_n -pg 1 -y 370 -defaultsOSRD
preplace port pcie_refclk -pg 1 -y 430 -defaultsOSRD
preplace port axi_clk -pg 1 -y 270 -defaultsOSRD
preplace port M00_AXI -pg 1 -y 130 -defaultsOSRD
preplace port pcie_7x_mgt -pg 1 -y 310 -defaultsOSRD
preplace inst xlconstant_0 -pg 1 -lvl 2 -y 450 -defaultsOSRD
preplace inst fit_timer_0 -pg 1 -lvl 2 -y 310 -defaultsOSRD
preplace inst axi_pcie3_0 -pg 1 -lvl 3 -y 400 -defaultsOSRD
preplace inst blk_mem_gen_0 -pg 1 -lvl 6 -y 200 -defaultsOSRD
preplace inst axi_interconnect_0 -pg 1 -lvl 4 -y 150 -defaultsOSRD
preplace inst axi_bram_ctrl_0 -pg 1 -lvl 5 -y 200 -defaultsOSRD
preplace inst util_ds_buf_0 -pg 1 -lvl 1 -y 430 -defaultsOSRD
preplace netloc axi_pcie_0_axi_aclk_out 1 1 6 310 560 530 560 940 560 1220 560 NJ 560 1710J
preplace netloc axi_bram_ctrl_0_BRAM_PORTA 1 5 1 NJ
preplace netloc CLK_IN_D_1 1 0 1 NJ
preplace netloc axi_pcie3_0_M_AXI 1 3 1 920
preplace netloc util_ds_buf_0_IBUF_OUT 1 1 2 300 400 510J
preplace netloc proc_sys_reset_0_interconnect_aresetn 1 1 4 300 110 NJ 110 930 290 1230
preplace netloc fit_timer_0_Interrupt 1 2 1 520
preplace netloc xlconstant_0_dout 1 2 1 NJ
preplace netloc axi_pcie3_0_pcie_7x_mgt 1 3 4 NJ 310 NJ 310 NJ 310 NJ
preplace netloc axi_interconnect_0_M00_AXI 1 4 3 1220J 130 NJ 130 NJ
preplace netloc pcie_perst_n_1 1 0 3 NJ 370 NJ 370 NJ
preplace netloc axi_interconnect_0_M01_AXI 1 4 1 1220
preplace netloc util_ds_buf_0_IBUF_DS_ODIV2 1 1 2 300 500 540J
levelinfo -pg 1 0 160 410 730 1080 1360 1600 1730 -top 0 -bot 570
",
}

  # Restore current instance
  current_bd_instance $oldCurInst

  save_bd_design
}
# End of create_root_design()


##################################################################
# MAIN FLOW
##################################################################

create_root_design ""


