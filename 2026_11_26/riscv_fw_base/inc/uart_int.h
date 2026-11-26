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

/*********************************************/
/* filename: Uart_int.h                                              */
/*********************************************/
#ifndef _UART_INT_H
#define _UART_INT_H

#include "mcu.h"

#define CMD_READ 0x19
#define CMD_WRITE 0x2a
#define RET_ID  0x5b
#define ST_SUCCESS  0x00
#define ST_DEV_UNKNOWN  0xa0
#define ST_REG_UNKNOWN  0xa1
#define ST_CMD_UNKNOWN  0xa6

#define BAUD115200 0

#define TERM_CMD_SIZE   128
#define RB_SIZE 256

extern char command_buf[];
extern int command_buf_len;
extern bit term_cmd_valid;
extern bit fetching_term_cmd;
extern int rx_count;
extern int tx_left;
extern bit cmd_valid;
extern bit ret_valid;

void init_serial(unsigned char th1_value);
void proc_serial_isr(void);
void add_char_to_ring_buffer(char c);
void putchar_local(char c);

#define UART_BASE 0x20000000
#define UART_TX_BUF ((UART_BASE + 0x0000)<<2)
#define UART_TX_ST  ((UART_BASE + 0x0001)<<2)
#define UART_RX_BUF ((UART_BASE + 0x0002)<<2)
#define UART_INT    ((UART_BASE + 0x0003)<<2)
#define UART_INT_EN ((UART_BASE + 0x0004)<<2)

extern void enable_ext_intr(void);
extern void disable_ext_intr(void);

#endif
