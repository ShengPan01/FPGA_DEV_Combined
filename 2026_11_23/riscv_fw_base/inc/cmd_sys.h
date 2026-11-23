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

#ifndef _CMD_SYS_H
#define _CMD_SYS_H

#include "cmdline.h"

void set_debug_mode(char **argv);
void read_register(char **argv);
void write_register(char **argv);
void dump_registers(char **argv);
void show_time(char **argv);
void exit_proc(char **argv);

extern const cmd_t sys_cmds[];
//extern const void (*sys_funcs[])(char **argv);
extern void (* sys_funcs[])(char **argv);
extern const u8 sys_n_cmds;

#endif
