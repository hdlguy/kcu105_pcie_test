#include <stdio.h>
#include <stdint.h>
#include <unistd.h>
#include <stdlib.h>
#include <sys/mman.h>
#include <fcntl.h>
#include <string.h>

#include "mem-io.h"
#include "utils.h"
#include "proto2_hw.h"

int main(int argc,char** argv)
{
    void* pcie_addr;

    uint32_t pcie_bar0_addr=PROTO_BASE;
    uint32_t pcie_bar0_size=PROTO_SIZE;
    //if(sscanf(argv[1],"%x",&pcie_bar0_addr)!=1) { fprintf(stderr,"invalid PCIE BAR0 ADDR %s\n",argv[1]); exit(-1); }

    pcie_addr=phy_addr_2_vir_addr(pcie_bar0_addr,pcie_bar0_size);
    if(pcie_addr==NULL)
    {
       fprintf(stderr,"can't mmap phy_addr 0x%08x with size 0x%08x to viraddr. you must be in root.\n",pcie_bar0_addr,pcie_bar0_size);
       exit(-1);
    }

    fprintf(stdout,"FPGA ID: 0x%08X\n",read_reg(pcie_addr,FPGA_ID));
    fprintf(stdout,"VERSION: 0x%08X\n",read_reg(pcie_addr,FPGA_VERSION));


    fprintf(stdout, "filling Test BRAM.\n");
    uint32_t bram_data[TEST_BRAM_SIZE/4], bram_results[TEST_BRAM_SIZE/4];
    for(uint32_t i=0; i<TEST_BRAM_SIZE/4; i++) bram_data[i] = i;
    memcpy(pcie_addr+TEST_BRAM_OFFSET, bram_data, TEST_BRAM_SIZE);
    fprintf(stdout, "reading Test BRAM.\n");
    memcpy(bram_results, pcie_addr+TEST_BRAM_OFFSET, TEST_BRAM_SIZE);
    int bram_errors = 0;
    for(uint32_t i=0; i<TEST_BRAM_SIZE/4; i++) if(bram_data[i] != bram_results[i]) bram_errors++;
    fprintf(stdout, "number of BRAM errors = %d\n", bram_errors);
    

    munmap(pcie_addr,pcie_bar0_size);

    return 0;
}
