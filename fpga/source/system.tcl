
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
set scripts_vivado_version 2016.2
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
  set pcie_7x_mgt [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:pcie_7x_mgt_rtl:1.0 pcie_7x_mgt ]
  set pcie_refclk [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_clock_rtl:1.0 pcie_refclk ]

  # Create ports
  set axi_clk [ create_bd_port -dir O -type clk axi_clk ]
  set pcie_perst_n [ create_bd_port -dir I -type rst pcie_perst_n ]
  set slv_read0 [ create_bd_port -dir I -from 31 -to 0 slv_read0 ]
  set slv_read1 [ create_bd_port -dir I -from 31 -to 0 slv_read1 ]
  set slv_read2 [ create_bd_port -dir I -from 31 -to 0 slv_read2 ]
  set slv_read3 [ create_bd_port -dir I -from 31 -to 0 slv_read3 ]
  set slv_read4 [ create_bd_port -dir I -from 31 -to 0 slv_read4 ]
  set slv_read5 [ create_bd_port -dir I -from 31 -to 0 slv_read5 ]
  set slv_read6 [ create_bd_port -dir I -from 31 -to 0 slv_read6 ]
  set slv_read7 [ create_bd_port -dir I -from 31 -to 0 slv_read7 ]
  set slv_read8 [ create_bd_port -dir I -from 31 -to 0 slv_read8 ]
  set slv_read9 [ create_bd_port -dir I -from 31 -to 0 slv_read9 ]
  set slv_read10 [ create_bd_port -dir I -from 31 -to 0 slv_read10 ]
  set slv_read11 [ create_bd_port -dir I -from 31 -to 0 slv_read11 ]
  set slv_read12 [ create_bd_port -dir I -from 31 -to 0 slv_read12 ]
  set slv_read13 [ create_bd_port -dir I -from 31 -to 0 slv_read13 ]
  set slv_read14 [ create_bd_port -dir I -from 31 -to 0 slv_read14 ]
  set slv_read15 [ create_bd_port -dir I -from 31 -to 0 slv_read15 ]
  set slv_reg0 [ create_bd_port -dir O -from 31 -to 0 slv_reg0 ]
  set slv_reg1 [ create_bd_port -dir O -from 31 -to 0 slv_reg1 ]
  set slv_reg2 [ create_bd_port -dir O -from 31 -to 0 slv_reg2 ]
  set slv_reg3 [ create_bd_port -dir O -from 31 -to 0 slv_reg3 ]
  set slv_reg4 [ create_bd_port -dir O -from 31 -to 0 slv_reg4 ]
  set slv_reg5 [ create_bd_port -dir O -from 31 -to 0 slv_reg5 ]
  set slv_reg6 [ create_bd_port -dir O -from 31 -to 0 slv_reg6 ]
  set slv_reg7 [ create_bd_port -dir O -from 31 -to 0 slv_reg7 ]
  set slv_reg8 [ create_bd_port -dir O -from 31 -to 0 slv_reg8 ]
  set slv_reg9 [ create_bd_port -dir O -from 31 -to 0 slv_reg9 ]
  set slv_reg10 [ create_bd_port -dir O -from 31 -to 0 slv_reg10 ]
  set slv_reg11 [ create_bd_port -dir O -from 31 -to 0 slv_reg11 ]
  set slv_reg12 [ create_bd_port -dir O -from 31 -to 0 slv_reg12 ]
  set slv_reg13 [ create_bd_port -dir O -from 31 -to 0 slv_reg13 ]
  set slv_reg14 [ create_bd_port -dir O -from 31 -to 0 slv_reg14 ]
  set slv_reg15 [ create_bd_port -dir O -from 31 -to 0 slv_reg15 ]
  set spi_miso [ create_bd_port -dir I spi_miso ]
  set spi_mosi [ create_bd_port -dir O spi_mosi ]
  set spi_sck [ create_bd_port -dir O spi_sck ]
  set spi_ss [ create_bd_port -dir O -from 0 -to 0 spi_ss ]

  # Create instance: axi_bram_ctrl_0, and set properties
  set axi_bram_ctrl_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_bram_ctrl:4.0 axi_bram_ctrl_0 ]
  set_property -dict [ list \
CONFIG.SINGLE_PORT_BRAM {1} \
 ] $axi_bram_ctrl_0

  # Create instance: axi_interconnect_0, and set properties
  set axi_interconnect_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_interconnect_0 ]
  set_property -dict [ list \
CONFIG.NUM_MI {3} \
 ] $axi_interconnect_0

  # Create instance: axi_pcie3_0, and set properties
  set axi_pcie3_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_pcie3:2.1 axi_pcie3_0 ]
  set_property -dict [ list \
CONFIG.axi_data_width {128_bit} \
CONFIG.axisten_freq {125} \
CONFIG.pf0_device_id {8024} \
CONFIG.pl_link_cap_max_link_speed {5.0_GT/s} \
CONFIG.pl_link_cap_max_link_width {X4} \
CONFIG.plltype {QPLL1} \
 ] $axi_pcie3_0

  # Create instance: axi_quad_spi_0, and set properties
  set axi_quad_spi_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_quad_spi:3.2 axi_quad_spi_0 ]
  set_property -dict [ list \
CONFIG.C_NUM_TRANSFER_BITS {8} \
CONFIG.C_USE_STARTUP {0} \
CONFIG.C_USE_STARTUP_INT {0} \
 ] $axi_quad_spi_0

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

  # Create instance: regfilex16_v1_0_0, and set properties
  set regfilex16_v1_0_0 [ create_bd_cell -type ip -vlnv user.org:user:regfilex16_v1_0:1.0 regfilex16_v1_0_0 ]

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
  connect_bd_intf_net -intf_net axi_interconnect_0_M00_AXI [get_bd_intf_pins axi_interconnect_0/M00_AXI] [get_bd_intf_pins regfilex16_v1_0_0/s00_axi]
  connect_bd_intf_net -intf_net axi_interconnect_0_M01_AXI [get_bd_intf_pins axi_bram_ctrl_0/S_AXI] [get_bd_intf_pins axi_interconnect_0/M01_AXI]
  connect_bd_intf_net -intf_net axi_interconnect_0_M02_AXI [get_bd_intf_pins axi_interconnect_0/M02_AXI] [get_bd_intf_pins axi_quad_spi_0/AXI_LITE]
  connect_bd_intf_net -intf_net axi_pcie3_0_M_AXI [get_bd_intf_pins axi_interconnect_0/S00_AXI] [get_bd_intf_pins axi_pcie3_0/M_AXI]
  connect_bd_intf_net -intf_net axi_pcie3_0_pcie_7x_mgt [get_bd_intf_ports pcie_7x_mgt] [get_bd_intf_pins axi_pcie3_0/pcie_7x_mgt]

  # Create port connections
  connect_bd_net -net axi_pcie_0_axi_aclk_out [get_bd_ports axi_clk] [get_bd_pins axi_bram_ctrl_0/s_axi_aclk] [get_bd_pins axi_interconnect_0/ACLK] [get_bd_pins axi_interconnect_0/M00_ACLK] [get_bd_pins axi_interconnect_0/M01_ACLK] [get_bd_pins axi_interconnect_0/M02_ACLK] [get_bd_pins axi_interconnect_0/S00_ACLK] [get_bd_pins axi_pcie3_0/axi_aclk] [get_bd_pins axi_pcie3_0/axi_ctl_aclk] [get_bd_pins axi_quad_spi_0/ext_spi_clk] [get_bd_pins axi_quad_spi_0/s_axi_aclk] [get_bd_pins fit_timer_0/Clk] [get_bd_pins regfilex16_v1_0_0/s00_axi_aclk]
  connect_bd_net -net axi_quad_spi_0_io0_o [get_bd_ports spi_mosi] [get_bd_pins axi_quad_spi_0/io0_o]
  connect_bd_net -net axi_quad_spi_0_sck_o [get_bd_ports spi_sck] [get_bd_pins axi_quad_spi_0/sck_o]
  connect_bd_net -net axi_quad_spi_0_ss_o [get_bd_ports spi_ss] [get_bd_pins axi_quad_spi_0/ss_o]
  connect_bd_net -net fit_timer_0_Interrupt [get_bd_pins axi_pcie3_0/intx_msi_request] [get_bd_pins fit_timer_0/Interrupt]
  connect_bd_net -net io1_i_1 [get_bd_ports spi_miso] [get_bd_pins axi_quad_spi_0/io1_i]
  connect_bd_net -net pcie_perst_n_1 [get_bd_ports pcie_perst_n] [get_bd_pins axi_pcie3_0/sys_rst_n]
  connect_bd_net -net proc_sys_reset_0_interconnect_aresetn [get_bd_pins axi_bram_ctrl_0/s_axi_aresetn] [get_bd_pins axi_interconnect_0/ARESETN] [get_bd_pins axi_interconnect_0/M00_ARESETN] [get_bd_pins axi_interconnect_0/M01_ARESETN] [get_bd_pins axi_interconnect_0/M02_ARESETN] [get_bd_pins axi_interconnect_0/S00_ARESETN] [get_bd_pins axi_pcie3_0/axi_aresetn] [get_bd_pins axi_quad_spi_0/s_axi_aresetn] [get_bd_pins fit_timer_0/Rst] [get_bd_pins regfilex16_v1_0_0/s00_axi_aresetn]
  connect_bd_net -net regfilex16_v1_0_0_slv_reg0 [get_bd_ports slv_reg0] [get_bd_pins regfilex16_v1_0_0/slv_reg0]
  connect_bd_net -net regfilex16_v1_0_0_slv_reg1 [get_bd_ports slv_reg1] [get_bd_pins regfilex16_v1_0_0/slv_reg1]
  connect_bd_net -net regfilex16_v1_0_0_slv_reg2 [get_bd_ports slv_reg2] [get_bd_pins regfilex16_v1_0_0/slv_reg2]
  connect_bd_net -net regfilex16_v1_0_0_slv_reg3 [get_bd_ports slv_reg3] [get_bd_pins regfilex16_v1_0_0/slv_reg3]
  connect_bd_net -net regfilex16_v1_0_0_slv_reg4 [get_bd_ports slv_reg4] [get_bd_pins regfilex16_v1_0_0/slv_reg4]
  connect_bd_net -net regfilex16_v1_0_0_slv_reg5 [get_bd_ports slv_reg5] [get_bd_pins regfilex16_v1_0_0/slv_reg5]
  connect_bd_net -net regfilex16_v1_0_0_slv_reg6 [get_bd_ports slv_reg6] [get_bd_pins regfilex16_v1_0_0/slv_reg6]
  connect_bd_net -net regfilex16_v1_0_0_slv_reg7 [get_bd_ports slv_reg7] [get_bd_pins regfilex16_v1_0_0/slv_reg7]
  connect_bd_net -net regfilex16_v1_0_0_slv_reg8 [get_bd_ports slv_reg8] [get_bd_pins regfilex16_v1_0_0/slv_reg8]
  connect_bd_net -net regfilex16_v1_0_0_slv_reg9 [get_bd_ports slv_reg9] [get_bd_pins regfilex16_v1_0_0/slv_reg9]
  connect_bd_net -net regfilex16_v1_0_0_slv_reg10 [get_bd_ports slv_reg10] [get_bd_pins regfilex16_v1_0_0/slv_reg10]
  connect_bd_net -net regfilex16_v1_0_0_slv_reg11 [get_bd_ports slv_reg11] [get_bd_pins regfilex16_v1_0_0/slv_reg11]
  connect_bd_net -net regfilex16_v1_0_0_slv_reg12 [get_bd_ports slv_reg12] [get_bd_pins regfilex16_v1_0_0/slv_reg12]
  connect_bd_net -net regfilex16_v1_0_0_slv_reg13 [get_bd_ports slv_reg13] [get_bd_pins regfilex16_v1_0_0/slv_reg13]
  connect_bd_net -net regfilex16_v1_0_0_slv_reg14 [get_bd_ports slv_reg14] [get_bd_pins regfilex16_v1_0_0/slv_reg14]
  connect_bd_net -net regfilex16_v1_0_0_slv_reg15 [get_bd_ports slv_reg15] [get_bd_pins regfilex16_v1_0_0/slv_reg15]
  connect_bd_net -net slv_read0_1 [get_bd_ports slv_read0] [get_bd_pins regfilex16_v1_0_0/slv_read0]
  connect_bd_net -net slv_read10_1 [get_bd_ports slv_read10] [get_bd_pins regfilex16_v1_0_0/slv_read10]
  connect_bd_net -net slv_read11_1 [get_bd_ports slv_read11] [get_bd_pins regfilex16_v1_0_0/slv_read11]
  connect_bd_net -net slv_read12_1 [get_bd_ports slv_read12] [get_bd_pins regfilex16_v1_0_0/slv_read12]
  connect_bd_net -net slv_read13_1 [get_bd_ports slv_read13] [get_bd_pins regfilex16_v1_0_0/slv_read13]
  connect_bd_net -net slv_read14_1 [get_bd_ports slv_read14] [get_bd_pins regfilex16_v1_0_0/slv_read14]
  connect_bd_net -net slv_read15_1 [get_bd_ports slv_read15] [get_bd_pins regfilex16_v1_0_0/slv_read15]
  connect_bd_net -net slv_read1_1 [get_bd_ports slv_read1] [get_bd_pins regfilex16_v1_0_0/slv_read1]
  connect_bd_net -net slv_read2_1 [get_bd_ports slv_read2] [get_bd_pins regfilex16_v1_0_0/slv_read2]
  connect_bd_net -net slv_read3_1 [get_bd_ports slv_read3] [get_bd_pins regfilex16_v1_0_0/slv_read3]
  connect_bd_net -net slv_read4_1 [get_bd_ports slv_read4] [get_bd_pins regfilex16_v1_0_0/slv_read4]
  connect_bd_net -net slv_read5_1 [get_bd_ports slv_read5] [get_bd_pins regfilex16_v1_0_0/slv_read5]
  connect_bd_net -net slv_read6_1 [get_bd_ports slv_read6] [get_bd_pins regfilex16_v1_0_0/slv_read6]
  connect_bd_net -net slv_read7_1 [get_bd_ports slv_read7] [get_bd_pins regfilex16_v1_0_0/slv_read7]
  connect_bd_net -net slv_read8_1 [get_bd_ports slv_read8] [get_bd_pins regfilex16_v1_0_0/slv_read8]
  connect_bd_net -net slv_read9_1 [get_bd_ports slv_read9] [get_bd_pins regfilex16_v1_0_0/slv_read9]
  connect_bd_net -net util_ds_buf_0_IBUF_DS_ODIV2 [get_bd_pins axi_pcie3_0/refclk] [get_bd_pins util_ds_buf_0/IBUF_DS_ODIV2]
  connect_bd_net -net util_ds_buf_0_IBUF_OUT [get_bd_pins axi_pcie3_0/sys_clk_gt] [get_bd_pins util_ds_buf_0/IBUF_OUT]
  connect_bd_net -net xlconstant_0_dout [get_bd_pins axi_pcie3_0/msi_vector_num] [get_bd_pins xlconstant_0/dout]

  # Create address segments
  create_bd_addr_seg -range 0x00001000 -offset 0xC0000000 [get_bd_addr_spaces axi_pcie3_0/M_AXI] [get_bd_addr_segs axi_bram_ctrl_0/S_AXI/Mem0] SEG_axi_bram_ctrl_0_Mem0
  create_bd_addr_seg -range 0x00010000 -offset 0x44A00000 [get_bd_addr_spaces axi_pcie3_0/M_AXI] [get_bd_addr_segs axi_quad_spi_0/AXI_LITE/Reg] SEG_axi_quad_spi_0_Reg
  create_bd_addr_seg -range 0x00010000 -offset 0x44A10000 [get_bd_addr_spaces axi_pcie3_0/M_AXI] [get_bd_addr_segs regfilex16_v1_0_0/s00_axi/reg0] SEG_regfilex16_v1_0_0_reg0

  # Perform GUI Layout
  regenerate_bd_layout -layout_string {
   guistr: "# # String gsaved with Nlview 6.5.12  2016-01-29 bk=1.3547 VDI=39 GEI=35 GUI=JA:1.6
#  -string -flagsOSRD
preplace port pcie_perst_n -pg 1 -y 760 -defaultsOSRD
preplace port spi_sck -pg 1 -y 820 -defaultsOSRD
preplace port spi_miso -pg 1 -y 620 -defaultsOSRD
preplace port pcie_refclk -pg 1 -y 820 -defaultsOSRD
preplace port spi_mosi -pg 1 -y 780 -defaultsOSRD
preplace port axi_clk -pg 1 -y 630 -defaultsOSRD
preplace port pcie_7x_mgt -pg 1 -y 710 -defaultsOSRD
preplace portBus slv_read11 -pg 1 -y 290 -defaultsOSRD
preplace portBus slv_reg8 -pg 1 -y 240 -defaultsOSRD
preplace portBus slv_read12 -pg 1 -y 310 -defaultsOSRD
preplace portBus slv_reg9 -pg 1 -y 260 -defaultsOSRD
preplace portBus slv_read13 -pg 1 -y 330 -defaultsOSRD
preplace portBus slv_read14 -pg 1 -y 350 -defaultsOSRD
preplace portBus slv_read0 -pg 1 -y 70 -defaultsOSRD
preplace portBus slv_read1 -pg 1 -y 90 -defaultsOSRD
preplace portBus slv_read15 -pg 1 -y 370 -defaultsOSRD
preplace portBus slv_read2 -pg 1 -y 110 -defaultsOSRD
preplace portBus slv_reg0 -pg 1 -y 80 -defaultsOSRD
preplace portBus spi_ss -pg 1 -y 840 -defaultsOSRD
preplace portBus slv_read3 -pg 1 -y 130 -defaultsOSRD
preplace portBus slv_reg1 -pg 1 -y 100 -defaultsOSRD
preplace portBus slv_read4 -pg 1 -y 150 -defaultsOSRD
preplace portBus slv_reg10 -pg 1 -y 280 -defaultsOSRD
preplace portBus slv_reg2 -pg 1 -y 120 -defaultsOSRD
preplace portBus slv_read5 -pg 1 -y 170 -defaultsOSRD
preplace portBus slv_reg11 -pg 1 -y 300 -defaultsOSRD
preplace portBus slv_reg3 -pg 1 -y 140 -defaultsOSRD
preplace portBus slv_read6 -pg 1 -y 190 -defaultsOSRD
preplace portBus slv_reg12 -pg 1 -y 320 -defaultsOSRD
preplace portBus slv_reg4 -pg 1 -y 160 -defaultsOSRD
preplace portBus slv_read7 -pg 1 -y 210 -defaultsOSRD
preplace portBus slv_reg13 -pg 1 -y 340 -defaultsOSRD
preplace portBus slv_reg5 -pg 1 -y 180 -defaultsOSRD
preplace portBus slv_read8 -pg 1 -y 230 -defaultsOSRD
preplace portBus slv_reg14 -pg 1 -y 360 -defaultsOSRD
preplace portBus slv_reg6 -pg 1 -y 200 -defaultsOSRD
preplace portBus slv_read9 -pg 1 -y 250 -defaultsOSRD
preplace portBus slv_read10 -pg 1 -y 270 -defaultsOSRD
preplace portBus slv_reg15 -pg 1 -y 380 -defaultsOSRD
preplace portBus slv_reg7 -pg 1 -y 220 -defaultsOSRD
preplace inst xlconstant_0 -pg 1 -lvl 2 -y 840 -defaultsOSRD
preplace inst fit_timer_0 -pg 1 -lvl 2 -y 700 -defaultsOSRD
preplace inst regfilex16_v1_0_0 -pg 1 -lvl 5 -y 230 -defaultsOSRD
preplace inst axi_pcie3_0 -pg 1 -lvl 3 -y 790 -defaultsOSRD
preplace inst blk_mem_gen_0 -pg 1 -lvl 6 -y 560 -defaultsOSRD
preplace inst axi_interconnect_0 -pg 1 -lvl 4 -y 540 -defaultsOSRD
preplace inst axi_bram_ctrl_0 -pg 1 -lvl 5 -y 560 -defaultsOSRD
preplace inst util_ds_buf_0 -pg 1 -lvl 1 -y 820 -defaultsOSRD
preplace inst axi_quad_spi_0 -pg 1 -lvl 5 -y 810 -defaultsOSRD
preplace netloc slv_read6_1 1 0 5 NJ 190 NJ 190 NJ 190 NJ 190 NJ
preplace netloc slv_read5_1 1 0 5 NJ 170 NJ 170 NJ 170 NJ 170 NJ
preplace netloc slv_read4_1 1 0 5 NJ 150 NJ 150 NJ 150 NJ 150 NJ
preplace netloc slv_read11_1 1 0 5 NJ 290 NJ 290 NJ 290 NJ 290 NJ
preplace netloc regfilex16_v1_0_0_slv_reg8 1 5 2 NJ 240 NJ
preplace netloc io1_i_1 1 0 6 NJ 620 NJ 620 NJ 620 NJ 710 NJ 710 1540
preplace netloc regfilex16_v1_0_0_slv_reg9 1 5 2 NJ 260 NJ
preplace netloc axi_pcie_0_axi_aclk_out 1 1 6 310 640 530 630 920 380 1240 630 NJ 630 NJ
preplace netloc axi_quad_spi_0_ss_o 1 5 2 NJ 840 NJ
preplace netloc axi_bram_ctrl_0_BRAM_PORTA 1 5 1 NJ
preplace netloc slv_read2_1 1 0 5 NJ 110 NJ 110 NJ 110 NJ 110 NJ
preplace netloc slv_read15_1 1 0 5 NJ 370 NJ 370 NJ 370 NJ 370 NJ
preplace netloc CLK_IN_D_1 1 0 1 NJ
preplace netloc axi_interconnect_0_M02_AXI 1 4 1 1230
preplace netloc slv_read8_1 1 0 5 NJ 230 NJ 230 NJ 230 NJ 230 NJ
preplace netloc axi_pcie3_0_M_AXI 1 3 1 930
preplace netloc regfilex16_v1_0_0_slv_reg0 1 5 2 NJ 80 NJ
preplace netloc util_ds_buf_0_IBUF_OUT 1 1 2 310 790 NJ
preplace netloc regfilex16_v1_0_0_slv_reg10 1 5 2 NJ 280 NJ
preplace netloc regfilex16_v1_0_0_slv_reg1 1 5 2 NJ 100 NJ
preplace netloc proc_sys_reset_0_interconnect_aresetn 1 1 4 300 600 NJ 600 940 720 1250
preplace netloc fit_timer_0_Interrupt 1 2 1 520
preplace netloc axi_quad_spi_0_io0_o 1 5 2 NJ 780 NJ
preplace netloc xlconstant_0_dout 1 2 1 NJ
preplace netloc slv_read3_1 1 0 5 NJ 130 NJ 130 NJ 130 NJ 130 NJ
preplace netloc slv_read10_1 1 0 5 NJ 270 NJ 270 NJ 270 NJ 270 NJ
preplace netloc slv_read0_1 1 0 5 NJ 70 NJ 70 NJ 70 NJ 70 NJ
preplace netloc regfilex16_v1_0_0_slv_reg11 1 5 2 NJ 300 NJ
preplace netloc regfilex16_v1_0_0_slv_reg2 1 5 2 NJ 120 NJ
preplace netloc axi_quad_spi_0_sck_o 1 5 2 NJ 820 NJ
preplace netloc axi_pcie3_0_pcie_7x_mgt 1 3 4 NJ 700 NJ 700 NJ 700 NJ
preplace netloc slv_read14_1 1 0 5 NJ 350 NJ 350 NJ 350 NJ 350 NJ
preplace netloc regfilex16_v1_0_0_slv_reg12 1 5 2 NJ 320 NJ
preplace netloc regfilex16_v1_0_0_slv_reg3 1 5 2 NJ 140 NJ
preplace netloc axi_interconnect_0_M00_AXI 1 4 1 1230
preplace netloc regfilex16_v1_0_0_slv_reg13 1 5 2 NJ 340 NJ
preplace netloc regfilex16_v1_0_0_slv_reg4 1 5 2 NJ 160 NJ
preplace netloc pcie_perst_n_1 1 0 3 NJ 760 NJ 760 NJ
preplace netloc axi_interconnect_0_M01_AXI 1 4 1 N
preplace netloc slv_read13_1 1 0 5 NJ 330 NJ 330 NJ 330 NJ 330 NJ
preplace netloc regfilex16_v1_0_0_slv_reg14 1 5 2 NJ 360 NJ
preplace netloc regfilex16_v1_0_0_slv_reg5 1 5 2 NJ 180 NJ
preplace netloc slv_read9_1 1 0 5 NJ 250 NJ 250 NJ 250 NJ 250 NJ
preplace netloc regfilex16_v1_0_0_slv_reg15 1 5 2 NJ 380 NJ
preplace netloc regfilex16_v1_0_0_slv_reg6 1 5 2 NJ 200 NJ
preplace netloc util_ds_buf_0_IBUF_DS_ODIV2 1 1 2 300 890 NJ
preplace netloc slv_read7_1 1 0 5 NJ 210 NJ 210 NJ 210 NJ 210 NJ
preplace netloc slv_read1_1 1 0 5 NJ 90 NJ 90 NJ 90 NJ 90 NJ
preplace netloc slv_read12_1 1 0 5 NJ 310 NJ 310 NJ 310 NJ 310 NJ
preplace netloc regfilex16_v1_0_0_slv_reg7 1 5 2 NJ 220 NJ
levelinfo -pg 1 0 160 410 720 1090 1400 1650 1780 -top 0 -bot 950
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


