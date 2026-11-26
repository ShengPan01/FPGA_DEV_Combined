////////////////////////////////////////////////////////////////////////////////
// 
// Author: Sheng Pan
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


#include <stdio.h>
#include "custom_test.h"

#ifdef CMD_LINE_DEBUG

#ifndef NO_CUSTOM_TEST
const cmd_t custom_test_cmds[] = {
    {"show", "n", 0, "show clock frequency"},
    {"i2crd", "base dev offset", 3, "I2C read"},
    {"i2cwr", "base dev offset data", 4, "I2C write"},
    {"i2ctest", "mode dev offset data", 4, "IMU I2C test (0=read, 1=write/readback)"},
    {"testreg", "testnum", 1, "test register access"},//for register address test.
    {"lms", "n", 1, "LMS test (0=self-test, 1=benchmark)"},//for LMS self-test  function
    {"spi", "n", 1, "SPI test (0=read, 1=write)"},//for SPI self-test  function
    {"dummy", "n", 0, "dummy"}
    };

//const void (*custom_test_funcs[])(char **argv) = {
void (*custom_test_funcs[])(char **argv) = {    
    show,
    i2c_read,
    i2c_write,
    i2c_test,
    test_reg_access,
    lms_test,
    spi_test,
    dummy
};

const u8 custom_test_n_cmds = sizeof(custom_test_cmds)/sizeof(cmd_t);

#else
const cmd_t custom_test_cmds[1];
const void (*custom_test_funcs[1])(char **argv);
const u8 custom_test_n_cmds = 0;
#endif

#endif
