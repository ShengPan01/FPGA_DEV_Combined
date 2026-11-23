#ifndef CHIP_VERSION_H
#define CHIP_VERSION_H

#include "typedef.h"
#include "reg_acc.h"

/* MCU register 0xC0, mapped with a 4-byte stride on the CPU MMIO bus. */
#define CHIP_VERSION_ADDR (0x80000000UL + (0x00C0UL << 2))

static inline uint8_t chip_version_read(void)
{
    return (uint8_t)reg_read(CHIP_VERSION_ADDR);
}

#endif
