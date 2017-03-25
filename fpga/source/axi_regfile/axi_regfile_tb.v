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
`timescale 1 ns / 1 ps

module axi_regfile_tb();
    localparam clk_period = 10;
    localparam C_M00_AXI_ADDR_WIDTH = 32;
    localparam C_M00_AXI_DATA_WIDTH = 32;

	logic  m00_axi_init_axi_txn;
	logic  m00_axi_error;
	logic  m00_axi_txn_done;
    //
	logic  m00_axi_aclk;
	logic  m00_axi_aresetn;
	logic [C_M00_AXI_ADDR_WIDTH-1 : 0] m00_axi_awaddr;
	logic [2 : 0] m00_axi_awprot;
	logic  m00_axi_awvalid;
	logic  m00_axi_awready;
    logic [C_M00_AXI_DATA_WIDTH-1 : 0] m00_axi_wdata;
	logic [C_M00_AXI_DATA_WIDTH/8-1 : 0] m00_axi_wstrb;
	logic  m00_axi_wvalid;
	logic  m00_axi_wready;
	logic [1 : 0] m00_axi_bresp;
	logic  m00_axi_bvalid;
	logic  m00_axi_bready;
	logic [C_M00_AXI_ADDR_WIDTH-1 : 0] m00_axi_araddr;
	logic [2 : 0] m00_axi_arprot;
	logic  m00_axi_arvalid;
	logic  m00_axi_arready;
	logic [C_M00_AXI_DATA_WIDTH-1 : 0] m00_axi_rdata;
	logic [1 : 0] m00_axi_rresp;
	logic  m00_axi_rvalid;
	logic  m00_axi_rready;

    logic [7:0][31:0] slv_reg, slv_read;

    assign slv_read = slv_reg;

    logic clk = 0;
    initial forever #(clk_period/2) clk = ~clk;
    assign m00_axi_aclk =  clk;

    initial begin 
        m00_axi_aresetn = 0;
        m00_axi_init_axi_txn = 0;
        #(clk_period*10);
        m00_axi_aresetn = 1;
        #(clk_period*10);
        forever begin
            m00_axi_init_axi_txn = 1;
            #(clk_period*1);
            m00_axi_init_axi_txn = 0;
            #(clk_period*100);
        end
    end

    axi_sim_master_v1_0 #(.C_M00_AXI_TRANSACTIONS_NUM(8)) axi_master (.*);

    axi_regfile_v1_0_S00_AXI #(
        .C_S_AXI_DATA_WIDTH(32),
        .C_S_AXI_ADDR_WIDTH(5))
    axi_regfile (
        // registers out
        .slv_reg(slv_reg),
        // read ports in
        .slv_read(slv_read),
        // axi interface
		.S_AXI_ACLK(m00_axi_aclk),
		.S_AXI_ARESETN(m00_axi_aresetn),
		.S_AXI_AWADDR(m00_axi_awaddr),
		.S_AXI_AWPROT(m00_axi_awprot),
		.S_AXI_AWVALID(m00_axi_awvalid),
		.S_AXI_AWREADY(m00_axi_awready),
		.S_AXI_WDATA(m00_axi_wdata),
		.S_AXI_WSTRB(m00_axi_wstrb),
		.S_AXI_WVALID(m00_axi_wvalid),
		.S_AXI_WREADY(m00_axi_wready),
		.S_AXI_BRESP(m00_axi_bresp),
		.S_AXI_BVALID(m00_axi_bvalid),
		.S_AXI_BREADY(m00_axi_bready),
		.S_AXI_ARADDR(m00_axi_araddr),
		.S_AXI_ARPROT(m00_axi_arprot),
		.S_AXI_ARVALID(m00_axi_arvalid),
		.S_AXI_ARREADY(m00_axi_arready),
		.S_AXI_RDATA(m00_axi_rdata),
		.S_AXI_RRESP(m00_axi_rresp),
		.S_AXI_RVALID(m00_axi_rvalid),
		.S_AXI_RREADY(m00_axi_rready));

endmodule


