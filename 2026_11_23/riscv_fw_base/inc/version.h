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

#ifndef _VERSION_H
#define _VERSION_H

#include "config.h"

#define VERSION_MAJOR   1
#define VERSION_MINOR   66
#define REVISION        0

#define PRINT_BANNER() do {\
    debug_printf("ANX9836 B0/B1 Firmware (%s) Version %d.%02d.%d", FW_TYPE_STR, \
        (unsigned int)VERSION_MAJOR, \
        (unsigned int)VERSION_MINOR, \
        (unsigned int)REVISION); \
    debug_printf(", Build at: %s,%s\n", __DATE__, __TIME__); \
} while(0)

#endif
