
////////////////////////////////////////////////////////////////////////////////
// Company: Analogix
// Engineer: Sheng Pan
//
// Create Date: 2026-11-02
// Tool chain: codix-bk3-32IMC-Upid-CORE-3.2.0-8.3.3-2901-windows.10.x86_64
// Description:
//   
// 
// Revision:
//    0.1 Initial version
//    0.2 add lms test
//    
////////////////////////////////////////////////////////////////////////////////

#ifndef _CUSTOM_TEST_H
#define _CUSTOM_TEST_H

#include "sal.h"
#include "cmdline.h"


void i2c_read(char **argv);
void i2c_write(char **argv);
void i2c_test(char **argv);
void show(char **argv);
void test_reg_access(char **argv);//for register address test.
void dummy(char **argv);
void lms_test(char **argv);
void spi_test(char **argv);

extern const cmd_t custom_test_cmds[];
//extern const void (*custom_test_funcs[])(char **argv);
extern  void (*custom_test_funcs[])(char **argv);
extern const u8 custom_test_n_cmds;

#endif
