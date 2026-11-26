#ifndef CHIP_VERSION_H
#define CHIP_VERSION_H

#include "typedef.h"
#include "reg_acc.h"

/* MCU register 0xC0, mapped with a 4-byte stride on the CPU MMIO bus. */
#define CHIP_VERSION_ADDR (0x80000000UL + (0x00C0UL << 2))
#define GPIO_0_ADDR       (0x80000000UL + (0x00C1UL << 2))
#define GPIO_0_MASK       0x01U

#define MODE_GPIO_ADDR    (0x80000000UL + (0x00C2UL << 2))

static inline uint8_t chip_version_read(void)
{
    return (uint8_t)reg_read(CHIP_VERSION_ADDR);
}

/* Read back the output register, not the physical pin. */
static inline uint8_t gpio_0_read(void)
{
    return (uint8_t)(reg_read(GPIO_0_ADDR) & GPIO_0_MASK);
}

/* Use bit 0 of value and preserve the other bits in the register. */
static inline void gpio_0_write(uint8_t value)
{
    uint8_t reg = (uint8_t)reg_read(GPIO_0_ADDR);
    reg = (uint8_t)((reg & ~GPIO_0_MASK) | (value & GPIO_0_MASK));
    reg_write(GPIO_0_ADDR, reg);
}

/* Read back the output register, not the physical pin. */
static inline uint8_t mode_gpio_read(uint8_t gpio_num)
{
    return (reg_read(MODE_GPIO_ADDR) >> gpio_num) & 0x01;
}

/* Use bit 0 of value and preserve the other bits in the register. */
static inline void mode_gpio_write(uint8_t gpio_num, uint8_t value)
{
    uint8_t reg = (uint8_t)reg_read(MODE_GPIO_ADDR);
    reg = (uint8_t)((reg & ~(0x01U << gpio_num)) | ((value & 0x01U) << gpio_num));
    reg_write(MODE_GPIO_ADDR, reg);
}

#endif
