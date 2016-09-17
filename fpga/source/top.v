module top (
    input  logic pcie_refclk_n,
    input  logic pcie_refclk_p,
    input  logic pcie_perst_n,
    input  logic [3:0] pcie_7x_mgt_rxn,
    input  logic [3:0] pcie_7x_mgt_rxp,
    output logic [3:0] pcie_7x_mgt_txn,
    output logic [3:0] pcie_7x_mgt_txp,
    //
    output logic [7:0] led);

    logic [31:0] slv_read[16];
    logic [31:0] slv_reg[16];
    //
    logic axi_clk;
    //
    logic spi_miso;
    logic spi_mosi;
    logic spi_sck;
    logic [0:0] spi_ss;

    // for now wrap the regs back to the read ports.
    assign slv_read[0] = 32'hDEADBEEF;
    assign slv_read[1] = 32'hCAFEBABE;
    assign slv_read[15:2] = slv_reg[15:2];
    assign led = slv_reg[7][7:0];

    system system_i (
        .pcie_7x_mgt_rxn(pcie_7x_mgt_rxn),
        .pcie_7x_mgt_rxp(pcie_7x_mgt_rxp),
        .pcie_7x_mgt_txn(pcie_7x_mgt_txn),
        .pcie_7x_mgt_txp(pcie_7x_mgt_txp),
        .pcie_refclk_clk_n(pcie_refclk_n),
        .pcie_refclk_clk_p(pcie_refclk_p),
        .pcie_perst_n(pcie_perst_n),
        .axi_clk(axi_clk),
        //
        .slv_read0(slv_read[0]),
        .slv_read1(slv_read[1]),
        .slv_read2(slv_read[2]),
        .slv_read3(slv_read[3]),
        .slv_read4(slv_read[4]),
        .slv_read5(slv_read[5]),
        .slv_read6(slv_read[6]),
        .slv_read7(slv_read[7]),
        .slv_read8(slv_read[8]),
        .slv_read9(slv_read[9]),
        .slv_read10(slv_read[10]),
        .slv_read11(slv_read[11]),
        .slv_read12(slv_read[12]),
        .slv_read13(slv_read[13]),
        .slv_read14(slv_read[14]),
        .slv_read15(slv_read[15]),
        .slv_reg0(slv_reg[0]),
        .slv_reg1(slv_reg[1]),
        .slv_reg2(slv_reg[2]),
        .slv_reg3(slv_reg[3]),
        .slv_reg4(slv_reg[4]),
        .slv_reg5(slv_reg[5]),
        .slv_reg6(slv_reg[6]),
        .slv_reg7(slv_reg[7]),
        .slv_reg8(slv_reg[8]),
        .slv_reg9(slv_reg[9]),
        .slv_reg10(slv_reg[10]),
        .slv_reg11(slv_reg[11]),
        .slv_reg12(slv_reg[12]),
        .slv_reg13(slv_reg[13]),
        .slv_reg14(slv_reg[14]),
        .slv_reg15(slv_reg[15]),
        .spi_miso(spi_miso),
        .spi_mosi(spi_mosi),
        .spi_sck(spi_sck),
        .spi_ss(spi_ss));

    // This is a spi memory that compiles into the fpga for sw development.
    spi_slave spi_slave_inst(.clk(axi_clk), .sck(spi_sck), .ss_n(spi_ss), .sdi(sdi_mosi), .sdo(sdi_miso));


endmodule
