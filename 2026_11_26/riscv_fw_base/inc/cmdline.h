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

#ifndef _CMDLINE_H
#define _CMDLINE_H

#include "sal.h"

#define hex_to_int hex_to_long

long hex_to_long(char *s);

typedef struct _cmd_t {
    char *cmd_name;
    char *arguments;
    u8 n_argument;
    char *help;
} cmd_t;

void CommandProcess(void);

#endif
