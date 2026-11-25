#include "Vtb_flash_layout.h"
#include "verilated.h"
#include <cstdio>
double sc_time_stamp() { return 0; }
int main(int argc, char **argv) {
    Verilated::commandArgs(argc, argv);
    Vtb_flash_layout dut;
    for (int cycle=0; cycle<5000000 && !Verilated::gotFinish(); ++cycle) {
        dut.reset_n=cycle>=4;
        dut.clk=0; dut.eval();
        dut.clk=1; dut.eval();
    }
    dut.final();
    if (!Verilated::gotFinish()) { std::fputs("Boot timeout\n",stderr); return 1; }
    return 0;
}
