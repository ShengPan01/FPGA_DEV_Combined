//*****************************************************************************
// Copyright (c) 2002 ~ 2009 Analogix Semiconductor Incorporated
// All Rights Reserved
//
// THIS IS UNPUBLISHED PROPRIETARY SOURCE CODE of Analogix Semiconductor Inc.
// The copyright notice above does not evidence any actual or intended
// publication of such source code.
//
// No part of this code may be reproduced, stored in a retrieval system,
// or transmitted, in any form or by any means, electronic, mechanical,
// photocopying, recording, or otherwise, without the prior written
// permission of Analogix Semiconductor Inc.
//
//*****************************************************************************

#ifndef _TIMER_H
#define _TIMER_H

#include "mcu.h"
#include "crt0.h"

typedef struct riscv_timer{
	volatile u32 riscv_sys_timer_1;
	volatile u32 riscv_sys_timer_2;
}riscv_sys_timer;

#define TINTVAL_500US   0xf3d3

#define UNIT_MS 0x4cc
#define _MAX_TIMER_TICK (125*500)

#define start_timer() do {  } while (0)
#define stop_timer() do {  } while (0)

typedef u64 sys_time_t;

extern riscv_sys_timer riscv_timer_inst;

//extern u16 timer_tick;
//extern BYTE hh, mm, ss;

void init_timer(u16 intval);
void timer_isr(void);
void timer2_isr(void);
void delay_ms(int n);
sys_time_t get_timer_tick(void);
char *get_str_time(void);
u1 time_gt(sys_time_t t, sys_time_t delay);

#define time_sub(t, d) do {\
    if ((t)<(d)) \
        (t) = (t) + _MAX_TIMER_TICK - (d); \
    else \
        (t) = (t) - (d); \
} while (0)

#define IS_VALID_TIME(x) ((x) < _MAX_TIMER_TICK)
#define INVALID_TIME (_MAX_TIMER_TICK+1)

#define TIME_120ms 15
#define TIME_500ms 63
#define TIME_1s 125
#define TIME_2s 250
#define TIME_4s 500
#define TIME_24ms 3

#define TIME_1ms 27000 //1ms timer, 27M clock.

//20260909. for timer
void set_timer_tick(u64 tick);

#endif
