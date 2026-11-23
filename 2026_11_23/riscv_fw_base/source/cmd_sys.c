/*
 * Copyright (c) 2026 . All rights reserved.
 *
 * Unauthorized copying, modification, distribution, or use
 * of this software is strictly prohibited without prior
 * written permission from the copyright owner.
 *
 * Author: 
 * Date: 2026-11-11
 */
#include <string.h>
#include "cmd_sys.h"
#include "sal.h"
#include "printf.h"

#ifdef CMD_LINE_DEBUG

void set_debug_mode(char **argv)
{
    if (strlen(argv[0])==7)
        debug_mode = 1;
    else
        debug_mode = 0;
}

void read_register(char **argv)
{
    u8 c1;
    u32 addr;

    
    addr = 0x20000000+hex_to_int(argv[1]);
    c1 = reg_read_align32(addr);
    debug_printf("[%s]=%02x\n", argv[1], c1);
}

void write_register(char **argv)
{
    u8 c;
    u16 addr;

    addr = hex_to_int(argv[1]);
//    if (addr < 0x8000) {
//        debug_printf("ERROR: Cannot write XDATA\n");
//        return;
//    }
	reg_write_align32(0x20000000+addr, hex_to_int(argv[2]));
    debug_printf("[%s]=%s\n", argv[1], argv[2]);
    c = reg_read_align32(0x20000000+hex_to_int(argv[1]));
    debug_printf("read back: [%s]=%02x\n", argv[1], c);
}


/********************************************************************/

// Base address of DP130 registers          0x8000_0800

//Base address of DP TX CO3 registers
// i2c slave address 0x72:              0x8000_0400
// i2c slave address 0x70:              0x8000_0800
// i2c slave address 0x7A:              0x8000_0c00

// Base address of DP PHY registers         0x8000_0100
// Base address of video BIST registers     0x8000_0200

//Base address of LMK04906 registers    0x8000_0040
//#define LMK04906_REG_BASE (0x80000000 + AL32(0x10))

//Base address of Clock Measure registers    0x8000_0100 0x8000_0280
//#define CLK_MEA_REG_BASE (0x80000000 + AL32(0x40))
/********************************************************************/

void dump_registers(char **argv)
{
	u8 i;// j;
	//u16 base;
    u8 c1;
    u32 addr;

    u8 reg_base;

    reg_base = hex_to_int(argv[1]);

    switch(reg_base)
    {

        case 0:
            debug_printf("Dumping CLOCK MEASURE registers\n");
            addr = 0x80000000 + AL32(0x40);
            break;

        case 1:
            debug_printf("Dumping LMK04906 registers\n");
            addr = 0x80000000 + AL32(0x10);
            break;
        case 2:
            debug_printf("Dumping dp phy registers\n");
            //addr = 0x80000000+AL32(0x40);
            addr = 0x80000000+AL32(0x100);
            break;

        case 3: //dpt0
            debug_printf("Dumping dptx0 registers\n");
            addr = 0x80000000+AL32(1<<8);
            break;

        case 4://dptx1
            debug_printf("Dumping dptx1 registers\n");
            addr = 0x80000000+AL32(2<<8);
            break;

        case 5: //dptx2
            debug_printf("Dumping dptx2 registers\n");
            addr = 0x80000000+AL32(3<<8);
            break; 

        case 6: //video bist
            debug_printf("Dumping vbist registers\n");
            addr = 0x80000000+AL32(0x80);
            break;

        default:
            addr = 0xffffffff;
            debug_printf("input 0~6 to select register base address\n");
            debug_printf("0: CLOCK MEASURE\n");
            debug_printf("1: LMK04906\n");
            debug_printf("2: DP PHY\n");
            debug_printf("3: DPTX0\n");
            debug_printf("4: DPTX1\n");
            debug_printf("5: DPTX2\n");
            debug_printf("6: VIDEO BIST\n");
            break;
    }
    if (addr == 0xffffffff) {
        return;
    }

    //debug_printf("A\n");
	debug_printf("       0  1  2  3  4  5  6  7    8  9  a  b  c  d  e  f\n");
	debug_printf("-------------------------------------------------------\n");
    //debug_printf("B\n");
    //delay_ms(100);

    for (i=0; i<16; i++) {
        c1 = reg_read(addr+ AL32(i));
        //delay_ms(10);
        //delay_10us();
        debug_printf(" %02x", c1);
        
    }
    debug_printf("%s\n", i&1?COLOR_NORMAL:"");

    //delay_ms(3000);

 #if 0   
	base = hex_to_int(argv[1]) << 8;
	for (i=0; i<16; i++) {
	    debug_printf("%s%04x ", i&1?COLOR_BLUE:"", base);
		for (j=0; j<16; j++) {
			if (j == 8)
				debug_printf("  ");
            addr = 0x20000000+base+j;
            debug_printf("reg addr:%04x ", addr);
            delay_ms(1000);
            c1 = reg_read_align32(addr);
			debug_printf(" %02x", c1);
		}
		debug_printf("%s\n", i&1?COLOR_NORMAL:"");
		base = base + 0x10;
	}
#endif
}

void show_time(char **argv)
{
    REF_VAR(argv);

//    sys_time_t t;
//    u32 l, h;
    
//    t = get_timer_tick();
//    l = t;
//    h = t >> 32;
//    debug_printf("%08x%08x\n", h, l);
    debug_printf("%s :-)\n", get_str_time());
}

u1 exit_program = FALSE;

void exit_proc(char **argv)
{
    REF_VAR(argv);

    exit_program = TRUE;
}

#endif
