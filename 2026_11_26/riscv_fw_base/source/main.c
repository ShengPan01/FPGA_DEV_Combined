/*
 * Copyright (c) 2026 . All rights reserved.
 *
 * Unauthorized copying, modification, distribution, or use
 * of this software is strictly prohibited without prior
 * written permission from the copyright owner.
 *
 * Author: Sheng Pan
 * Date: 2026-11-11
 */

// ---------------------------------------------------------------------------
#include <stdio.h>
#include <string.h>
#include "sal.h"
#include "printf.h"


#include "typedef.h"
#include "debug.h"
#include "timer.h"
#include "spi.h"
#include "chip_version.h"
#include "flash_verify.h"

/*Define MCU FW Version*/
#define FW_VERSION	0x04
#define FW_BUILD_NO	0x17


#define DEF_DEBUG_MODE 1

void dead_loop(void);
void restart(void);



int main()
{
    enable_debug_output = 1;
    debug_mode = DEF_DEBUG_MODE;

    InitMCU(); 
    SYS_DBG_MSG0("\nfpga risc-v fw base start!\n");

    
    SYS_DBG_MSG2("Build at: "__DATE__" "__TIME__" \nFPGA RISCV OCM v%x.%x", \
    (FW_VERSION >> 4), (FW_VERSION & 0x0F));
    SYS_DBG_MSG2(".%x\r\n", FW_BUILD_NO);

    uint8_t version = chip_version_read();
    SYS_DBG_MSG2("FPGA h/w version: v%x.%x\r\n",
                 (unsigned int)(version >> 4), (unsigned int)(version & 0x0F));

    spi_init(AL32(0x50), AL32(0x800));

    #if LMS_SHA256_ACCEL
    SYS_DBG_MSG0("\nSHA256 acceleration enabled\n");
    #else
    SYS_DBG_MSG0("\nSHA256 acceleration disabled\n");
    #endif
    
    flash_verify_on_boot();

    SYS_DBG_MSG0("\nInit done\n");
    while (1)
    {
#ifdef CMD_LINE_DEBUG
        CommandProcess ();
#endif
        if (debug_mode)
            continue;

    }
}

#ifdef CMD_LINE_DEBUG

void external_interrupt(void)
{
    proc_serial_isr();
}

#endif

void puts_local(char *s)
{
    while (*s)
        putchar_local(*s++);
}

void exception_handler(u32 mcause, u32 mbadaddr, u32 eaddr)
{
    char s[16];
    char *s1="Exception: mcasue=";
    char *s2=" mbadaddr=";
    char *s3=" code_addr=";

    puts_local(s1);
    uli2a(mcause, 16, 0, s);
    puts_local(s);
    puts_local(s2);
    uli2a(mbadaddr, 16, 0, s);
    puts_local(s);
    puts_local(s3);
    uli2a(eaddr, 16, 0, s);
    puts_local(s);
    putchar_local('\n');
    dead_loop();
}


//void timer1_isr(void)
void mtime_isr(void)
{
    timer_isr();
}


