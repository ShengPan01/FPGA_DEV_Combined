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

#include "timer.h"
#include "mcu.h"
#include "printf.h"

sys_time_t timer_tick;

volatile u32 *timer_tick_l = (volatile u32 *)0x48001000;
volatile u32 *timer_tick_h = (volatile u32 *)0x48001004;
volatile u32 *timer_cmp_l = (volatile u32 *)0x48001008;
volatile u32 *timer_cmp_h = (volatile u32 *)0x4800100C;

u8 hh, mm, ss, ms;

riscv_sys_timer riscv_timer_inst;


void init_timer(u16 intval)
{
    stop_timer();

    timer_tick = 0;
    hh = 0;
    mm = 0;
    ss = 0;
    ms = 0;

    //20260909. for timer
    set_timer_tick(TIME_1ms);

    //inital riscv sys timer.
    riscv_timer_inst.riscv_sys_timer_1 = 0;
    riscv_timer_inst.riscv_sys_timer_2 = 0;

    //enable_timer_intr();
}

void timer_isr1(void)
{
    timer_tick++;
    ms++;
    if (ms == 125) {
        ms = 0;
        if (timer_tick >= _MAX_TIMER_TICK)
            timer_tick = 0;
        ss++;
        if ((ss&0xf) == 0xa)
            ss = ss + 6;

        if (ss > 0x59)
        {
            ss = 0;
            mm++;
            if ((mm&0xf) == 0xa)
                mm = mm + 6;
            if(mm > 0x59)
            {
                mm = 0;
                hh++;
            }
        }
    }
}

void timer_isr(void)
{
    if(riscv_timer_inst.riscv_sys_timer_1 > 0) riscv_timer_inst.riscv_sys_timer_1--;
    if(riscv_timer_inst.riscv_sys_timer_2 > 0) riscv_timer_inst.riscv_sys_timer_2--;

    //update system timer
    timer_isr1();
}

u1 time_gt(sys_time_t t, sys_time_t delay)
{
    u16 ct;

    ct = timer_tick;
    if (ct < t)
        ct = ct + _MAX_TIMER_TICK - t;
    else
        ct = ct -t;
    return (ct >= delay);
}

char *get_str_time(void)
{
    static char result[16];
    u8 h, m, s;
    unsigned int t;
    u64 t64;

    //EA = 0;
    t64 = get_timer_tick();
    t64 = t64/27000;
    t = t64 % 1000;
    t64 = t64/1000;
    s = t64%60;
    t64 = t64/60;
    m = t64%60;
    h = t64/60;
    tfp_sprintf(result, "%3d:%02d:%02d:%03d", h, m, s, t);
/*    m = mm;
    s = ss;
    t = timer_tick;
    //EA = 1;
    result[0] = '0'+(m>>4);
    result[1] = '0'+(m&0xf);
    result[2] = ':';
    result[3] = '0'+(s>>4);
    result[4] = '0'+(s&0xf);
    result[5] = '.';
    //t = (t % 250)*4;
    t = ms*8;
    result[6] = '0'+t/100;
    t = t % 100;
    result[7] = '0'+t/10;
    result[8] = '0'+t%10;
    result[9] = 0;
*/
    return result;
}

sys_time_t get_timer_tick(void)
{
    u32 t1, t2, t3;
    u64 t64;
    
    t1 = *timer_tick_h;
    t2 = *timer_tick_l;
    t3 = *timer_tick_h;
    if (t1 != t3) {
        t2 = *timer_tick_l;
        t64 = *timer_tick_h;
    } else
        t64 = t3;
    return (t64<<32)+t2;
}

void set_timer_tick(u64 tick)
{
    u32 t1, t2, t3;
    u64 t64;

    t1 = *timer_tick_h;
    t2 = *timer_tick_l;
    t3 = *timer_tick_h;
    if (t1 != t3)
        t64 = (((u64)t3) << 32);
    else
        t64 = (((u64)t3) << 32) + (u64)t2;

    t64 = t64 + tick; /* 27000 = 1ms */
    *timer_cmp_h = (u32)(t64 >> 32);
    *timer_cmp_l = (u32)(t64);
}
/*
void delay_us(unsigned int c)
{
    unsigned int i;
    for(i = 0; i < c; i++)
        _NOP_;
}*/

