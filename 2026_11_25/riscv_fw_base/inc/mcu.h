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

/***************************************/
/*   filename:MCU.h                                       */
/***************************************/
#ifndef _MCU_H
#define _MCU_H

#include "config.h"

typedef unsigned char bit;
typedef unsigned char u1;
typedef unsigned char u8;
typedef unsigned int u16;
typedef unsigned long u32;
typedef unsigned long long u64;
//typedef bit b;

//typedef unsigned char *pu8;

#define TRUE 1
#define FALSE 0

#define COLOR_BLUE "\033[1;34m"
#define COLOR_RED "\033[1;31m"
#define COLOR_NORMAL "\033[37m"


#define DELAY_FACTOR    1300
                        //222

extern bit enable_debug_output;
extern bit debug_mode;
extern u8 debug_verbose_level;

void InitMCU (void);
void put_char(void *p, char c);

void delay_10us(void);
void delay_ms(int n);
void delay_half_ms(void);
void _debug_printf(char *s, ...);
void debug_puts(char *s);
//void calibrate_delay();
#define debug_printf _debug_printf
#define L2(x) do { \
    if (debug_verbose_level >=2) { \
        x; \
    } \
} while (0)

//#define disable_interrupt() do {EA = 0;} while(0)
//#define enable_interrupt() do {EA = 1;} while(0)

#define AL32(x) ((x)<<2)

#endif
