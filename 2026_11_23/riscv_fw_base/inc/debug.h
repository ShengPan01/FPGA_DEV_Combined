/******************************************************************************
Copyright (c) 2026, Analogix Semiconductor, Inc.
Filename :
Project  :
Created  : 2026/09/10, span@analogixsemi.com
Devices  :
Toolchain:
Description:
Revision History:
******************************************************************************/

#ifndef __DEBUG__
#define __DEBUG__

#include <stdarg.h>
#include "uart_int.h"

#define DEBUG   

#ifdef DEBUG

void simple_printf(char* ori_string,  ...);
void simple_printf_no_arg(char* ori_string);
void TraceArray(u8 array[], u8 len);
/*New printf function*/
//#define CPRINTF simple_printf
//#define CPUTSTR(format) simple_printf_no_arg(format)

#define SYS_DBG_MSG0(format)   simple_printf_no_arg(format)
#define SYS_DBG_MSG1           simple_printf
#define SYS_DBG_MSG2           simple_printf

#else
#define CPRINTF(format, ...)
#define CPUTSTR(format)

#endif

#endif
