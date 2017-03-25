module top (
    input  logic pcie_refclk_n,
    input  logic pcie_refclk_p,
    input  logic pcie_perst_n,
    input  logic [7:0] pcie_7x_mgt_rxn,
    input  logic [7:0] pcie_7x_mgt_rxp,
    output logic [7:0] pcie_7x_mgt_txn,
    output logic [7:0] pcie_7x_mgt_txp,
    //
    output logic [7:0] led
);

    logic [15:0][31:0] slv_read;
    logic [15:0][31:0] slv_reg;

    // for now wrap the regs back to the read ports.
    assign slv_read[0] = 32'hDEADBEEF;
    assign slv_read[1] = 32'h76543210;
    assign slv_read[15:2] = slv_reg[15:2];
    assign led = slv_reg[7][7:0];

    logic [31:0]M00_AXI_araddr;
    logic [2:0]M00_AXI_arprot;
    logic M00_AXI_arready;
    logic M00_AXI_arvalid;
    logic [31:0]M00_AXI_awaddr;
    logic [2:0]M00_AXI_awprot;
    logic M00_AXI_awready;
    logic M00_AXI_awvalid;
    logic M00_AXI_bready;
    logic [1:0]M00_AXI_bresp;
    logic M00_AXI_bvalid;
    logic [31:0]M00_AXI_rdata;
    logic M00_AXI_rready;
    logic [1:0]M00_AXI_rresp;
    logic M00_AXI_rvalid;
    logic [31:0]M00_AXI_wdata;
    logic M00_AXI_wready;
    logic [3:0]M00_AXI_wstrb;
    logic M00_AXI_wvalid;
    logic axi_clk;
  
    // this is the IPI block diagram design.
    system system_i (
        .M00_AXI_araddr(M00_AXI_araddr),
        .M00_AXI_arprot(M00_AXI_arprot),
        .M00_AXI_arready(M00_AXI_arready),
        .M00_AXI_arvalid(M00_AXI_arvalid),
        .M00_AXI_awaddr(M00_AXI_awaddr),
        .M00_AXI_awprot(M00_AXI_awprot),
        .M00_AXI_awready(M00_AXI_awready),
        .M00_AXI_awvalid(M00_AXI_awvalid),
        .M00_AXI_bready(M00_AXI_bready),
        .M00_AXI_bresp(M00_AXI_bresp),
        .M00_AXI_bvalid(M00_AXI_bvalid),
        .M00_AXI_rdata(M00_AXI_rdata),
        .M00_AXI_rready(M00_AXI_rready),
        .M00_AXI_rresp(M00_AXI_rresp),
        .M00_AXI_rvalid(M00_AXI_rvalid),
        .M00_AXI_wdata(M00_AXI_wdata),
        .M00_AXI_wready(M00_AXI_wready),
        .M00_AXI_wstrb(M00_AXI_wstrb),
        .M00_AXI_wvalid(M00_AXI_wvalid),
        .axi_clk(axi_clk),
         //
        .pcie_7x_mgt_rxn(pcie_7x_mgt_rxn),
        .pcie_7x_mgt_rxp(pcie_7x_mgt_rxp),
        .pcie_7x_mgt_txn(pcie_7x_mgt_txn),
        .pcie_7x_mgt_txp(pcie_7x_mgt_txp),
        .pcie_refclk_clk_n(pcie_refclk_n),
        .pcie_refclk_clk_p(pcie_refclk_p),
        .pcie_perst_n(pcie_perst_n)
    );

    // This is the axi register file.
    axi_regfile_v1_0_S00_AXI #(
        .C_S_AXI_DATA_WIDTH(32),
        .C_S_AXI_ADDR_WIDTH(5))
    axi_regfile (
        // registers out
        .slv_reg(slv_reg),
        // read ports in
        .slv_read(slv_read),
        // axi interface
		.S_AXI_ACLK    (axi_clk),
		.S_AXI_ARESETN (M00_AXI_aresetn),
		.S_AXI_AWADDR  (M00_AXI_awaddr),
		.S_AXI_AWPROT  (M00_AXI_awprot),
		.S_AXI_AWVALID (M00_AXI_awvalid),
		.S_AXI_AWREADY (M00_AXI_awready),
		.S_AXI_WDATA   (M00_AXI_wdata),
		.S_AXI_WSTRB   (M00_AXI_wstrb),
		.S_AXI_WVALID  (M00_AXI_wvalid),
		.S_AXI_WREADY  (M00_AXI_wready),
		.S_AXI_BRESP   (M00_AXI_bresp),
		.S_AXI_BVALID  (M00_AXI_bvalid),
		.S_AXI_BREADY  (M00_AXI_bready),
		.S_AXI_ARADDR  (M00_AXI_araddr),
		.S_AXI_ARPROT  (M00_AXI_arprot),
		.S_AXI_ARVALID (M00_AXI_arvalid),
		.S_AXI_ARREADY (M00_AXI_arready),
		.S_AXI_RDATA   (M00_AXI_rdata),
		.S_AXI_RRESP   (M00_AXI_rresp),
		.S_AXI_RVALID  (M00_AXI_rvalid),
		.S_AXI_RREADY  (M00_AXI_rready)
    );

endmodule

