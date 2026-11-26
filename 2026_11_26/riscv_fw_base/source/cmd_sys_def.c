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

#include <stdio.h>
#include "cmd_sys.h"
#include "flash_cmd.h"

#ifdef CMD_LINE_DEBUG

const cmd_t sys_cmds[] = {
    {"flashbegin", NULL, 0, "Begin IHEX upload (erases touched sectors)"},
    {"flashhex", "record", 1, "Upload one Intel HEX record (max 48 data bytes)"},
    {"flashread", "address length", 2, "Read Flash physical bytes (hex arguments)"},
    {"flashabort", NULL, 0, "Abort upload"},
    {"debugon", NULL, 0, "Enter debugging mode"},
    {"debugoff", NULL, 0, "Exit debugging mode"},
    {"rd", "reg_addr", 1, "Read register"},
    {"wr", "reg_addr data", 2, "Write register"},
    {"dump", "reg_addr_base", 1, "Dump all registers"},
    {"time", NULL, 0, "Show current time stamp"},
    {"exit", NULL, 0, "Exit"}
    };

//void (* const sys_funcs[])(char **) = {
//const void (*sys_funcs[])(char **argv) = {
void (*sys_funcs[])(char **argv) = {
    flash_begin,
    flash_hex,
    flash_read,
    flash_abort,
    set_debug_mode,
    set_debug_mode,
    read_register,
    write_register,
    dump_registers,
    show_time,
    exit_proc
};

const u8 sys_n_cmds = sizeof(sys_cmds)/sizeof(cmd_t);

#endif
