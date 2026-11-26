#include "Vtb_hw_cfg.h"
#include <cstdio>
#include <cstdlib>
Vtb_hw_cfg dut;
void tick() { dut.clk=0; dut.eval(); dut.clk=1; dut.eval(); dut.clk=0; dut.eval(); }
void check(unsigned addr, unsigned expected) {
    dut.wr=0; dut.rd=1; dut.addr=addr; dut.eval();
    if (dut.rdata != expected) { std::fprintf(stderr,"addr %04x: got %02x expected %02x\n",addr,dut.rdata,expected); std::exit(1); }
}
void write_reg(unsigned addr, unsigned data) {
    dut.rd=0; dut.wr=1; dut.addr=addr; dut.wdata=data; tick(); dut.wr=0; dut.eval();
}
int main(int argc, char **argv) {
    Verilated::commandArgs(argc,argv);
    dut.reset_n=0; dut.wr=0; tick(); dut.reset_n=1; tick();
    check(0xc0,0x02);
    for(unsigned i=1;i<16;i++) check(0xc0+i,0);
    write_reg(0xc0,0xff); check(0xc0,0x02);
    for(unsigned i=1;i<16;i++) write_reg(0xc0+i,i*17);
    for(unsigned i=1;i<16;i++) check(0xc0+i,i*17);
    write_reg(0xb1,0); write_reg(0xd1,0); write_reg(0x1c1,0); check(0xc1,0x11);
    dut.wdata=0; tick(); check(0xc1,0x11);
    check(0x50,0x55); check(0x70,0x77); check(0x800,0x88); check(0xcf,0xff);
    for(unsigned i=0;i<16;i++) check(0xd0+i,0x80+i);
    check(0xe0,0); check(0x1d0,0);
    dut.rd=0; dut.wr=1; dut.addr=0xdf; dut.eval();
    if (dut.rdata != 0x4f) return 1;
    dut.wr=0;
    dut.reset_n=0; tick(); dut.reset_n=1; tick();
    for(unsigned i=1;i<16;i++) check(0xc0+i,0);
    check(0xc0,0x02);
    std::puts("PASS: reset, RO version, all RW registers, bus isolation and peripheral decode");
    dut.final();
}
