library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
--library UNISIM;
--use UNISIM.VComponents.all;

entity spi_slave_tb is
end spi_slave_tb;

architecture Behavioral of spi_slave_tb is
    signal clk, sck, ss_n, sdi, sdo  :  STD_LOGIC;
    constant clk_period : time := 10ns;
    constant spi_clk_div : natural := 8; -- this is the number of clk periods in an SCK phase.
    constant a_width : natural := 7;
    constant d_width : natural := 8;
    signal address : std_logic_vector(6 downto 0);
    signal data    : std_logic_vector(7 downto 0);
    signal wr_bit  : std_logic;
begin

    sti_proc:process
    begin
        --reset <= '1';
        ss_n <= '1';
        sck <= '0';
        address <= (others=>'0');
        data    <= (others=>'1');
        wr_bit <= '1';
        wait for clk_period*5;
        --reset <= '0';
        wait for clk_period*5;

        for k in 0 to 0 loop

            -- do some writes
            address <= (others=>'0');
            data    <= (others=>'1');
            wr_bit <= '1';
            for j in 0 to 5 loop
                ss_n <= '0';
                wait for clk_period*spi_clk_div;
                -- The write bit
                sdi <= wr_bit;
                sck <= '0';
                wait for clk_period*spi_clk_div;
                sck <= '1';
                wait for clk_period*spi_clk_div;
                -- The address
                for i in a_width-1 downto 0 loop
                    sdi <= address(i);
                    sck <= '0';
                    wait for clk_period*spi_clk_div;
                    sck <= '1';
                    wait for clk_period*spi_clk_div;
                end loop;
                -- The data
                for i in d_width-1 downto 0 loop
                    sdi <= data(i);
                    sck <= '0';
                    wait for clk_period*spi_clk_div;
                    sck <= '1';
                    wait for clk_period*spi_clk_div;
                end loop;
                ss_n <= '1';
                sck <= '0';
                address <= std_logic_vector(unsigned(address)+1);
                data    <= std_logic_vector(unsigned(   data)-3);
                wait for clk_period*spi_clk_div*4;
            end loop;

            -- do some reads
            address <= (others=>'0');
            data    <= (others=>'1');
            wr_bit <= '0';
            for j in 0 to 5 loop
                ss_n <= '0';
                wait for clk_period*spi_clk_div;
                -- The write bit
                sdi <= wr_bit;
                sck <= '0';
                wait for clk_period*spi_clk_div;
                sck <= '1';
                wait for clk_period*spi_clk_div;
                -- The address
                for i in a_width-1 downto 0 loop
                    sdi <= address(i);
                    sck <= '0';
                    wait for clk_period*spi_clk_div;
                    sck <= '1';
                    wait for clk_period*spi_clk_div;
                end loop;
                -- The data
                for i in d_width-1 downto 0 loop
                    sdi <= 'X';--data(i);
                    sck <= '0';
                    wait for clk_period*spi_clk_div;
                    sck <= '1';
                    wait for clk_period*spi_clk_div;
                end loop;
                ss_n <= '1';
                sck <= '0';
                address <= std_logic_vector(unsigned(address)+1);
                data    <= std_logic_vector(unsigned(   data)-3);
                wait for clk_period*spi_clk_div*4;
            end loop;

        end loop;

        wait for clk_period*spi_clk_div*4;
        assert false report "simulation ended" severity failure;

        wait;
    end process;

    clk_proc:process
    begin
        clk <= '0';
        wait for clk_period/2;
        clk <= '1';
        wait for clk_period/2;
    end process;
    
    uut: entity work.spi_slave port map(clk=>clk, sck=>sck, ss_n=>ss_n, sdi=>sdi, sdo=>sdo);
    
end Behavioral;
