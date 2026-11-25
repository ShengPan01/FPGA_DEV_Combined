#ifndef _CLK_MEASURE_H
#define _CLK_MEASURE_H

#include "sal.h"

#define CLK_MEA_REG_BASE (0x80000000 + AL32(0x40))

#define CLK_FREQ_GATE0_ADDR     CLK_MEA_REG_BASE + AL32(0x0)
#define CLK_FREQ_GATE1_ADDR     CLK_MEA_REG_BASE + AL32(0x1)
#define CLK0_FREQ0_ADDR         CLK_MEA_REG_BASE + AL32(0x2)
#define CLK0_FREQ1_ADDR         CLK_MEA_REG_BASE + AL32(0x3)
#define CLK1_FREQ0_ADDR         CLK_MEA_REG_BASE + AL32(0x4)
#define CLK1_FREQ1_ADDR         CLK_MEA_REG_BASE + AL32(0x5)
#define CLK2_FREQ0_ADDR         CLK_MEA_REG_BASE + AL32(0x6)
#define CLK2_FREQ1_ADDR         CLK_MEA_REG_BASE + AL32(0x7)
#define CLK3_FREQ0_ADDR         CLK_MEA_REG_BASE + AL32(0x8)
#define CLK3_FREQ1_ADDR         CLK_MEA_REG_BASE + AL32(0x9)

#define OSC_CLK_FREQ        2700

#define show_clk_freq(s0, s1, s2, s3) do {\
    u32 gate, f_clk;\
\
    gate = reg_read(CLK_FREQ_GATE1_ADDR);\
    gate = (gate << 8) | reg_read(CLK_FREQ_GATE0_ADDR);\
    f_clk = reg_read(CLK0_FREQ1_ADDR);\
    f_clk = (f_clk << 8) | reg_read(CLK0_FREQ0_ADDR);\
    f_clk = f_clk * OSC_CLK_FREQ / gate;\
    debug_printf("   --- Clock Frequencies ---   \n");\
    debug_printf("%s Freq: %u.%02uMHz\n", (s0!=NULL)?(s0):"CLK0(SPI clk)", (u16)(f_clk/100), (u16)(f_clk%100));\
    f_clk = reg_read(CLK1_FREQ1_ADDR);\
    f_clk = (f_clk << 8) | reg_read(CLK1_FREQ0_ADDR);\
    f_clk = f_clk * OSC_CLK_FREQ / gate;\
    debug_printf("%s Freq: %u.%02uMHz\n", (s1!=NULL)?(s1):"CLK1(AXI clk)", (u16)(f_clk/100), (u16)(f_clk%100));\
    f_clk = reg_read(CLK2_FREQ1_ADDR);\
    f_clk = (f_clk << 8) | reg_read(CLK2_FREQ0_ADDR);\
    f_clk = f_clk * OSC_CLK_FREQ / gate;\
    debug_printf("%s Freq: %u.%02uMHz\n", (s2!=NULL)?(s2):"CLK2(Pixel clk)", (u16)(f_clk/100), (u16)(f_clk%100));\
    f_clk = reg_read(CLK3_FREQ1_ADDR);\
    f_clk = (f_clk << 8) | reg_read(CLK3_FREQ0_ADDR);\
    f_clk = f_clk * OSC_CLK_FREQ / gate;\
    debug_printf("%s Freq: %u.%02uMHz\n", (s3!=NULL)?(s3):"CLK3(tx clk)", (u16)(f_clk/100), (u16)(f_clk%100));\
    debug_printf("\n");\
} while (0);

#endif
