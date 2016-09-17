// Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2016.2 (lin64) Build 1577090 Thu Jun  2 16:32:35 MDT 2016
// Date        : Sat Sep 17 07:32:11 2016
// Host        : pedro-ubuntu-crucial running 64-bit Ubuntu 16.04.1 LTS
// Command     : write_verilog -force -mode synth_stub
//               /home/pedro/github/kcu105_pcie_test/fpga/source/spi_slave/ip/spi_slave_mem_stub.v
// Design      : spi_slave_mem
// Purpose     : Stub declaration of top-level module interface
// Device      : xcku040-ffva1156-2-e
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "dist_mem_gen_v8_0_10,Vivado 2016.2" *)
module spi_slave_mem(a, d, clk, we, spo)
/* synthesis syn_black_box black_box_pad_pin="a[6:0],d[7:0],clk,we,spo[7:0]" */;
  input [6:0]a;
  input [7:0]d;
  input clk;
  input we;
  output [7:0]spo;
endmodule
