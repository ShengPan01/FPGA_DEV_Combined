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

#include <stdio.h>
#include <string.h>
#include <stdarg.h>
#include <stdlib.h>
#include "mcu.h"
#include "uart_int.h"
#include "timer.h"
#include "printf.h"

bit debug_mode;
bit enable_debug_output;
u8 debug_verbose_level = 1;

void InitMCU(void)
{
    init_serial(BAUD115200);
    init_printf(NULL, put_char);

    init_timer(TINTVAL_500US);
    start_timer();

//    calibrate_delay();
//    debug_printf(" %s%s \n", COLOR_RED, COLOR_NORMAL);
}


#ifdef CMD_LINE_DEBUG

void put_char(void *p, char c)
{
    if (!enable_debug_output)
        return ;
    if (c == '\n')
        add_char_to_ring_buffer(0x0d);
    add_char_to_ring_buffer(c);
    return ;
    //  stdout_port = c;
}

#else

void put_char(void *p, char c)
{
    if (!enable_debug_output)
        return ;
    if (c == '\n')
    {
        while (reg_read(UART_TX_ST) & 0x1) ;
    	reg_write(UART_TX_BUF, 0x0d);
        reg_write(UART_INT, 0x02);  // clear UART TX int
    }
    while (reg_read(UART_TX_ST) & 0x1) ;
    reg_write(UART_TX_BUF, c);
    reg_write(UART_INT, 0x02);  // clear UART TX int
    return ;
    //  stdout_port = c;
}

#endif

// int delay_factor=200;

// void calibrate_delay()
// {
//     int n1, n2, i, j;
//
//     n1 = timer_tick;
//     for (i=0; i<200; i++)
//         for (j=0; j<200; j++)
//             ;
//     n2 = timer_tick;
//     delay_factor = (n2-n1);
//     delay_factor = 9000/delay_factor;
// }

extern void delay_10us(void);

void delay_ms(int n)
{
    int i, j;

    for (i=0; i<n; i++)
    {
        for (j=0; j<100; j++)
            delay_10us();
    }
}

void _debug_printf(char *s, ...)
{
    if (enable_debug_output)
    {
        va_list v;
        va_start(v, s);
        tfp_format(NULL, put_char, s, v);
    }
}


