//============================================================================
//
// This document contains information that is the proprietary property of SEAKR 
// Engineering Inc. and third parties to whom SEAKR owes an obligation of 
// confidential handling.  The information contained herein shall not be 
// published, disclosed to others duplicated in whole or in part or used for 
// any purpose other than the intended purpose.
//
// This document contains technical data whose export is restricted by the Arms 
// Export Control Act (Title 22, U.S.C. Sec 2751, et seq.) or the Export 
// Administration Act of 1979, as amended (Title 50, U.S.C., app.  2401 et seq.).
// This information may not be exported, released or disclosed to foreign 
// persons whether here in the United States or abroad without first obtaining 
// the proper export authority. Recipient shall include this notice with any 
// portion of this document that is authorized to be reproduced.
//
// Copyright © 2016 SEAKR Engineering, Inc.
//
//============================================================================
    // This module wraps the register file so that it can be instantiated in VHDL.
    module axi_regfile_v1_0_S00_AXI_wrapper # (
		parameter integer C_S_AXI_DATA_WIDTH	= 32,  // only 32 has been tested.
		parameter integer C_S_AXI_ADDR_WIDTH	= 5)   // address width of the register file in bytes. For 16 32bit registers set this to 6.
    (
        // register file i/o
        output  wire    [31:0]  reg0_out,
        output  wire    [31:0]  reg1_out,
        output  wire    [31:0]  reg2_out,
        output  wire    [31:0]  reg3_out,
        output  wire    [31:0]  reg4_out,
        output  wire    [31:0]  reg5_out,
        output  wire    [31:0]  reg6_out,
        output  wire    [31:0]  reg7_out,
        //
        input   wire    [31:0]  reg0_in,
        input   wire    [31:0]  reg1_in,
        input   wire    [31:0]  reg2_in,
        input   wire    [31:0]  reg3_in,
        input   wire    [31:0]  reg4_in,
        input   wire    [31:0]  reg5_in,
        input   wire    [31:0]  reg6_in,
        input   wire    [31:0]  reg7_in,
		// axi port
		input wire  S_AXI_ACLK,
		input wire  S_AXI_ARESETN,
		input wire [C_S_AXI_ADDR_WIDTH-1 : 0] S_AXI_AWADDR,
		input wire [2 : 0] S_AXI_AWPROT,
		input wire  S_AXI_AWVALID,
		output wire  S_AXI_AWREADY,
		input wire [C_S_AXI_DATA_WIDTH-1 : 0] S_AXI_WDATA,
		input wire [(C_S_AXI_DATA_WIDTH/8)-1 : 0] S_AXI_WSTRB,
		input wire  S_AXI_WVALID,
		output wire  S_AXI_WREADY,
		output wire [1 : 0] S_AXI_BRESP,
		output wire  S_AXI_BVALID,
		input wire  S_AXI_BREADY,
		input wire [C_S_AXI_ADDR_WIDTH-1 : 0] S_AXI_ARADDR,
		input wire [2 : 0] S_AXI_ARPROT,
		input wire  S_AXI_ARVALID,
		output wire  S_AXI_ARREADY,
		output wire [C_S_AXI_DATA_WIDTH-1 : 0] S_AXI_RDATA,
		output wire [1 : 0] S_AXI_RRESP,
		output wire  S_AXI_RVALID,
		input wire  S_AXI_RREADY);

    logic  [2**(C_S_AXI_ADDR_WIDTH-2)-1:0][C_S_AXI_DATA_WIDTH-1:0]	slv_reg;
    logic  [2**(C_S_AXI_ADDR_WIDTH-2)-1:0][C_S_AXI_DATA_WIDTH-1:0]	slv_read;

    axi_regfile_v1_0_S00_AXI #(
        .C_S_AXI_DATA_WIDTH(C_S_AXI_DATA_WIDTH),
        .C_S_AXI_ADDR_WIDTH(C_S_AXI_ADDR_WIDTH))
    axi_regfile (
        // registers out
        .slv_reg(slv_reg),
        // read ports in
        .slv_read(slv_read),
        // axi interface
		.S_AXI_ACLK(S_AXI_ACLK),
		.S_AXI_ARESETN(S_AXI_ARESETN),
		.S_AXI_AWADDR(S_AXI_AWADDR),
		.S_AXI_AWPROT(S_AXI_AWPROT),
		.S_AXI_AWVALID(S_AXI_AWVALID),
		.S_AXI_AWREADY(S_AXI_AWREADY),
		.S_AXI_WDATA(S_AXI_WDATA),
		.S_AXI_WSTRB(S_AXI_WSTRB),
		.S_AXI_WVALID(S_AXI_WVALID),
		.S_AXI_WREADY(S_AXI_WREADY),
		.S_AXI_BRESP(S_AXI_BRESP),
		.S_AXI_BVALID(S_AXI_BVALID),
		.S_AXI_BREADY(S_AXI_BREADY),
		.S_AXI_ARADDR(S_AXI_ARADDR),
		.S_AXI_ARPROT(S_AXI_ARPROT),
		.S_AXI_ARVALID(S_AXI_ARVALID),
		.S_AXI_ARREADY(S_AXI_ARREADY),
		.S_AXI_RDATA(S_AXI_RDATA),
		.S_AXI_RRESP(S_AXI_RRESP),
		.S_AXI_RVALID(S_AXI_RVALID),
		.S_AXI_RREADY(S_AXI_RREADY));

    assign reg0_out = slv_reg[0];
    assign reg1_out = slv_reg[1];
    assign reg2_out = slv_reg[2];
    assign reg3_out = slv_reg[3];
    assign reg4_out = slv_reg[4];
    assign reg5_out = slv_reg[5];
    assign reg6_out = slv_reg[6];
    assign reg7_out = slv_reg[7];

    assign slv_read[0] = reg0_in;
    assign slv_read[1] = reg1_in;
    assign slv_read[2] = reg2_in;
    assign slv_read[3] = reg3_in;
    assign slv_read[4] = reg4_in;
    assign slv_read[5] = reg5_in;
    assign slv_read[6] = reg6_in;
    assign slv_read[7] = reg7_in;

endmodule
