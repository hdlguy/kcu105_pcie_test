library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity regfilex16_v1_0 is
	generic (
		-- Users to add parameters here

		-- User parameters ends
		-- Do not modify the parameters beyond this line


		-- Parameters of Axi Slave Bus Interface S00_AXI
		C_S00_AXI_DATA_WIDTH	: integer	:= 32;
		C_S00_AXI_ADDR_WIDTH	: integer	:= 6
	);
	port (
		-- Users to add ports here
	    slv_reg0	: out std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);
	    slv_reg1	: out std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);
	    slv_reg2	: out std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);
	    slv_reg3	: out std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);
	    slv_reg4	: out std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);
	    slv_reg5	: out std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);
	    slv_reg6	: out std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);
	    slv_reg7	: out std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);
	    slv_reg8	: out std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);
	    slv_reg9	: out std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);
	    slv_reg10	: out std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);
	    slv_reg11	: out std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);
	    slv_reg12	: out std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);
	    slv_reg13	: out std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);
	    slv_reg14	: out std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);
	    slv_reg15	: out std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);
        --
	    slv_read0	: in  std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);
	    slv_read1	: in  std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);
	    slv_read2	: in  std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);
	    slv_read3	: in  std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);
	    slv_read4	: in  std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);
	    slv_read5	: in  std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);
	    slv_read6	: in  std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);
	    slv_read7	: in  std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);
	    slv_read8	: in  std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);
	    slv_read9	: in  std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);
	    slv_read10	: in  std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);
	    slv_read11	: in  std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);
	    slv_read12	: in  std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);
	    slv_read13	: in  std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);
	    slv_read14	: in  std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);
	    slv_read15	: in  std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);

		-- User ports ends
		-- Do not modify the ports beyond this line


		-- Ports of Axi Slave Bus Interface S00_AXI
		s00_axi_aclk	: in std_logic;
		s00_axi_aresetn	: in std_logic;
		s00_axi_awaddr	: in std_logic_vector(C_S00_AXI_ADDR_WIDTH-1 downto 0);
		s00_axi_awprot	: in std_logic_vector(2 downto 0);
		s00_axi_awvalid	: in std_logic;
		s00_axi_awready	: out std_logic;
		s00_axi_wdata	: in std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);
		s00_axi_wstrb	: in std_logic_vector((C_S00_AXI_DATA_WIDTH/8)-1 downto 0);
		s00_axi_wvalid	: in std_logic;
		s00_axi_wready	: out std_logic;
		s00_axi_bresp	: out std_logic_vector(1 downto 0);
		s00_axi_bvalid	: out std_logic;
		s00_axi_bready	: in std_logic;
		s00_axi_araddr	: in std_logic_vector(C_S00_AXI_ADDR_WIDTH-1 downto 0);
		s00_axi_arprot	: in std_logic_vector(2 downto 0);
		s00_axi_arvalid	: in std_logic;
		s00_axi_arready	: out std_logic;
		s00_axi_rdata	: out std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);
		s00_axi_rresp	: out std_logic_vector(1 downto 0);
		s00_axi_rvalid	: out std_logic;
		s00_axi_rready	: in std_logic
	);
end regfilex16_v1_0;

architecture arch_imp of regfilex16_v1_0 is

	-- component declaration
	component regfilex16_v1_0_S00_AXI is
		generic (
		C_S_AXI_DATA_WIDTH	: integer	:= 32;
		C_S_AXI_ADDR_WIDTH	: integer	:= 6
		);
		port (
	    slv_reg0	: out std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
	    slv_reg1	: out std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
	    slv_reg2	: out std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
	    slv_reg3	: out std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
	    slv_reg4	: out std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
	    slv_reg5	: out std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
	    slv_reg6	: out std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
	    slv_reg7	: out std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
	    slv_reg8	: out std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
	    slv_reg9	: out std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
	    slv_reg10	: out std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
	    slv_reg11	: out std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
	    slv_reg12	: out std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
	    slv_reg13	: out std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
	    slv_reg14	: out std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
	    slv_reg15	: out std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
        --
	    slv_read0	: in  std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
	    slv_read1	: in  std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
	    slv_read2	: in  std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
	    slv_read3	: in  std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
	    slv_read4	: in  std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
	    slv_read5	: in  std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
	    slv_read6	: in  std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
	    slv_read7	: in  std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
	    slv_read8	: in  std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
	    slv_read9	: in  std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
	    slv_read10	: in  std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
	    slv_read11	: in  std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
	    slv_read12	: in  std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
	    slv_read13	: in  std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
	    slv_read14	: in  std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
	    slv_read15	: in  std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
		S_AXI_ACLK	: in std_logic;
		S_AXI_ARESETN	: in std_logic;
		S_AXI_AWADDR	: in std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
		S_AXI_AWPROT	: in std_logic_vector(2 downto 0);
		S_AXI_AWVALID	: in std_logic;
		S_AXI_AWREADY	: out std_logic;
		S_AXI_WDATA	: in std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
		S_AXI_WSTRB	: in std_logic_vector((C_S_AXI_DATA_WIDTH/8)-1 downto 0);
		S_AXI_WVALID	: in std_logic;
		S_AXI_WREADY	: out std_logic;
		S_AXI_BRESP	: out std_logic_vector(1 downto 0);
		S_AXI_BVALID	: out std_logic;
		S_AXI_BREADY	: in std_logic;
		S_AXI_ARADDR	: in std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
		S_AXI_ARPROT	: in std_logic_vector(2 downto 0);
		S_AXI_ARVALID	: in std_logic;
		S_AXI_ARREADY	: out std_logic;
		S_AXI_RDATA	: out std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
		S_AXI_RRESP	: out std_logic_vector(1 downto 0);
		S_AXI_RVALID	: out std_logic;
		S_AXI_RREADY	: in std_logic
		);
	end component regfilex16_v1_0_S00_AXI;

begin

-- Instantiation of Axi Bus Interface S00_AXI
regfilex16_v1_0_S00_AXI_inst : regfilex16_v1_0_S00_AXI
	generic map (
		C_S_AXI_DATA_WIDTH	=> C_S00_AXI_DATA_WIDTH,
		C_S_AXI_ADDR_WIDTH	=> C_S00_AXI_ADDR_WIDTH
	)
	port map (
	    slv_reg0	=> slv_reg0	,
	    slv_reg1	=> slv_reg1	,
	    slv_reg2	=> slv_reg2	,
	    slv_reg3	=> slv_reg3	,
	    slv_reg4	=> slv_reg4	,
	    slv_reg5	=> slv_reg5	,
	    slv_reg6	=> slv_reg6	,
	    slv_reg7	=> slv_reg7	,
	    slv_reg8	=> slv_reg8	,
	    slv_reg9	=> slv_reg9	,
	    slv_reg10	=> slv_reg10	,
	    slv_reg11	=> slv_reg11	,
	    slv_reg12	=> slv_reg12	,
	    slv_reg13	=> slv_reg13	,
	    slv_reg14	=> slv_reg14	,
	    slv_reg15	=> slv_reg15	,
        --
	    slv_read0	=> slv_read0	,
	    slv_read1	=> slv_read1	,
	    slv_read2	=> slv_read2	,
	    slv_read3	=> slv_read3	,
	    slv_read4	=> slv_read4	,
	    slv_read5	=> slv_read5	,
	    slv_read6	=> slv_read6	,
	    slv_read7	=> slv_read7	,
	    slv_read8	=> slv_read8	,
	    slv_read9	=> slv_read9	,
	    slv_read10	=> slv_read10	,
	    slv_read11	=> slv_read11	,
	    slv_read12	=> slv_read12	,
	    slv_read13	=> slv_read13	,
	    slv_read14	=> slv_read14	,
	    slv_read15	=> slv_read15	,
        --
		S_AXI_ACLK	=> s00_axi_aclk,
		S_AXI_ARESETN	=> s00_axi_aresetn,
		S_AXI_AWADDR	=> s00_axi_awaddr,
		S_AXI_AWPROT	=> s00_axi_awprot,
		S_AXI_AWVALID	=> s00_axi_awvalid,
		S_AXI_AWREADY	=> s00_axi_awready,
		S_AXI_WDATA	=> s00_axi_wdata,
		S_AXI_WSTRB	=> s00_axi_wstrb,
		S_AXI_WVALID	=> s00_axi_wvalid,
		S_AXI_WREADY	=> s00_axi_wready,
		S_AXI_BRESP	=> s00_axi_bresp,
		S_AXI_BVALID	=> s00_axi_bvalid,
		S_AXI_BREADY	=> s00_axi_bready,
		S_AXI_ARADDR	=> s00_axi_araddr,
		S_AXI_ARPROT	=> s00_axi_arprot,
		S_AXI_ARVALID	=> s00_axi_arvalid,
		S_AXI_ARREADY	=> s00_axi_arready,
		S_AXI_RDATA	=> s00_axi_rdata,
		S_AXI_RRESP	=> s00_axi_rresp,
		S_AXI_RVALID	=> s00_axi_rvalid,
		S_AXI_RREADY	=> s00_axi_rready
	);

	-- Add user logic here

	-- User logic ends

end arch_imp;
