library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
--library UNISIM;
--use UNISIM.VComponents.all;

entity spi_slave is
Port ( 
    clk   : in STD_LOGIC;
    --reset : in  std_logic;
    sck  : in STD_LOGIC;
    ss_n  : in STD_LOGIC;
    sdi   : in STD_LOGIC;
    sdo   : out STD_LOGIC);
end spi_slave;

architecture Behavioral of spi_slave is

    COMPONENT spi_slave_mem
    PORT (
        a : IN STD_LOGIC_VECTOR(6 DOWNTO 0);
        d : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        clk : IN STD_LOGIC;
        we : IN STD_LOGIC;
        spo : OUT STD_LOGIC_VECTOR(7 DOWNTO 0));
    END COMPONENT;
    ATTRIBUTE SYN_BLACK_BOX : BOOLEAN;
    ATTRIBUTE SYN_BLACK_BOX OF spi_slave_mem : COMPONENT IS TRUE;
    
    --constant d_width : natural := 8;
    --constant a_width : natural := 8; -- really address width + 1 for the read/write bit.
    signal mem_we : std_logic;
    signal shreg, mem_addr, mem_din, mem_dout : std_logic_vector(7 downto 0);
    signal scount : std_logic_vector(4 downto 0);
    --signal state  : std_logic_vector(2 downto 0);
    signal ss_fall, ss_rise, sck_fall, sck_rise : std_logic;
    signal ss_n_q, ss_n_qq, sck_q, sck_qq, sdi_q : std_logic;
    signal mem_data_ld, mem_addr_ld, shreg_ld : std_logic;
    
begin

    --state_proc:process
    --begin
        --wait until rising_edge(clk);
        --if reset = '1' then
            --state <= "000";
        --else
            --case state is 
                --when "000" =>            
                --when "001" =>
                --when others =>
            --end case;           
        --end if;               
    --end process;        
    
    sclk_count_proc:process
    begin
        wait until rising_edge(clk);
        if ss_n_q = '1' then
            scount <= (others=>'0');
        else
            if sck_rise = '1' then
                scount <= std_logic_vector(unsigned(scount)+1);
            end if;
        end if;               
    end process;    

    regs_proc:process
    begin

        wait until rising_edge(clk);
        --if reset = '1' then
            --ss_n_q  <= '1';
            --ss_n_qq <= '1';
            --sck_q  <= '0';
            --sck_qq <= '0';
        --else
            ss_n_q  <= ss_n;
            ss_n_qq <= ss_n_q;
            sck_q  <= sck;
            sck_qq <= sck_q;
        --end if;               

        sdi_q <= sdi;

        if (sck_rise='1') then
            shreg(7 downto 1) <= shreg(6 downto 0);
            shreg(0) <= sdi_q;
        else
            if shreg_ld='1' then
                shreg <= mem_dout;
            end if;
        end if;
        if sck_fall='1' then
            sdo <= shreg(7);
        end if;

        if (sck_rise='1') and (unsigned(scount) = 7) then
            mem_addr_ld <= '1';
        else
            mem_addr_ld <= '0';
        end if;
        if mem_addr_ld='1' then
            mem_addr <= shreg;
        end if;
        if (mem_addr_ld='1') then
            shreg_ld <= '1';
        else
            shreg_ld <= '0';
        end if;

        if (sck_rise='1') and (unsigned(scount) = 15) then
            mem_data_ld <= '1';
        else
            mem_data_ld <= '0';
        end if;
        if mem_data_ld='1' then
            mem_din <= shreg;
            if mem_addr(7)='1' then
                mem_we <= '1';
            else
                mem_we <= '0';
            end if;
        else
            mem_we <= '0';
        end if;

    end process;
    
    -- some edge detection.
    ss_fall  <= ss_n_qq and (not ss_n_q);
    ss_rise  <= (not ss_n_qq) and ss_n_q;
    sck_fall <= sck_qq and (not sck_q);
    sck_rise <= (not sck_qq) and sck_q;

    -- This is the 128x8 memory created with ip core tool.
    --mem_inst : entity work.spi_slave_mem PORT MAP (a=>mem_addr(6 downto 0), d=>mem_din, clk=>clk, we=>mem_we, spo=>mem_dout);
    mem_inst : component spi_slave_mem PORT MAP (a=>mem_addr(6 downto 0), d=>mem_din, clk=>clk, we=>mem_we, spo=>mem_dout);
  
end Behavioral;

