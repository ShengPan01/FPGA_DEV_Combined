/*
 * Copyright (c) 2026 . All rights reserved.
 *
 * Unauthorized copying, modification, distribution, or use
 * of this software is strictly prohibited without prior
 * written permission from the copyright owner.
 *
 * Author: Sheng Pan
 * Date: 2026-11-11
 */
    
#include "reg_acc.h"
#include "i2c_master.h"

void i2cm_set_speed(u32 reg_base, u8 mode)
{   
    u8 c;
    c = reg_read(reg_base+I2CM_REG_CTRL);                                    
    reg_write(reg_base+I2CM_REG_CTRL, (c & ~I2CM_SPEED_MASK) | mode);
}

u8 i2cm_check_state(u32 reg_base, u8 dev_addr, u8 offset, u8 st)
{
    if ((st & I2CM_ST_OCCUPY) && !(st & I2CM_ST_ON_PROGRESS)) {
        debug_printf("I2C bus busy (reg_base=%x, dev=%02bx, ofs=%02bx)\n", reg_base, dev_addr, offset);
        return 1;
    }
    if (st & I2CM_ST_NO_ACK) {
        debug_printf("I2C bus no ACK (reg_base=%x, dev=%02bx, ofs=%02bx)\n", reg_base, dev_addr, offset);
        return 1;
    }
     if (st & I2CM_ST_TIMEOUT) {
        debug_printf("I2C bus no ACK (reg_base=%x, dev=%02bx, ofs=%02bx)\n", reg_base, dev_addr, offset);
        return 1;
    }
   return 0;
}

u8 i2cm_msg_read(u32 reg_base, u8 dev_addr, u8 *status)
{
    u8 st, result;

    result = 0;
    reg_write(reg_base+I2CM_REG_DEV_ADDR, dev_addr);
    reg_write(reg_base+I2CM_REG_NUM0, 0x01); // byte number 0
    reg_write(reg_base+I2CM_REG_NUM1, 0x00); // byte number 1
    reg_write(reg_base+I2CM_REG_CMD, I2CM_CMD_CLR_FIFO); // clear FIFO command
    reg_write(reg_base+I2CM_REG_CMD, I2CM_CMD_MSG_READ); // start read command
    asm volatile ("nop;nop;nop;nop;");
    st = I2CM_ST_ON_PROGRESS;
    while (st & I2CM_ST_ON_PROGRESS) {
        st = reg_read(reg_base+I2CM_REG_STATUS);
        if (i2cm_check_state(reg_base, dev_addr, 0, st))
            break;
    }
    if (status)
        *status = st;
    st = reg_read(reg_base+I2CM_REG_FIFO_CNT);
    if (st) {
        result = reg_read(reg_base+I2CM_REG_FIFO);
    }
    delay_ms(1);
    return result;
} 

u8 i2cm_read(u32 reg_base, u8 dev_addr, u8 offset, u8 *status)
{
    u8 st, result;

    result = 0;
    reg_write(reg_base+I2CM_REG_DEV_ADDR, dev_addr);
    reg_write(reg_base+I2CM_REG_OFFSET, offset);
    reg_write(reg_base+I2CM_REG_NUM0, 0x01); // byte number 0
    reg_write(reg_base+I2CM_REG_NUM1, 0x00); // byte number 1
    reg_write(reg_base+I2CM_REG_CMD, I2CM_CMD_CLR_FIFO); // clear FIFO command
    reg_write(reg_base+I2CM_REG_CMD, I2CM_CMD_BYTE_READ); // start read command
    asm volatile ("nop;");
    st = I2CM_ST_ON_PROGRESS;
    while (st & I2CM_ST_ON_PROGRESS) {
        st = reg_read(reg_base+I2CM_REG_STATUS);
        if (i2cm_check_state(reg_base, dev_addr, offset, st))
            break;
    }
    if (status)
        *status = st;
    st = reg_read(reg_base+I2CM_REG_FIFO_CNT);
    if (st) {
        result = reg_read(reg_base+I2CM_REG_FIFO);
    }
    delay_ms(1);
    return result;
} 

void i2cm_write(u32 reg_base, u8 dev_addr, u8 offset, u8 dat, u8 *status)
{
    u8 st;

    reg_write(reg_base+I2CM_REG_DEV_ADDR, dev_addr);
    reg_write(reg_base+I2CM_REG_OFFSET, offset);
    reg_write(reg_base+I2CM_REG_NUM0, 0x01); // byte number 0
    reg_write(reg_base+I2CM_REG_NUM1, 0x00); // byte number 1
    reg_write(reg_base+I2CM_REG_CMD, I2CM_CMD_CLR_FIFO); // clear FIFO command
    reg_write(reg_base+I2CM_REG_CMD, I2CM_CMD_BYTE_WRITE); // start write command
    reg_write(reg_base+I2CM_REG_FIFO, dat); // write data to FIFO
    asm volatile ("nop;nop;");
    st = I2CM_ST_ON_PROGRESS;
    while (st & I2CM_ST_ON_PROGRESS) {
        st = reg_read(reg_base+I2CM_REG_STATUS);
        //if (i2cm_check_state(reg_base, dev_addr, offset, st))
        //    break;
    }
    if (status)
        *status = st;
    delay_ms(1);
} 

/*
void i2cm_bus_reset(u32 reg_base)
{
    u8 st;

    reg_write(reg_base+I2CM_REG_CMD, I2CM_CMD_BUS_RESET); // start I2C reset command
    st = I2CM_ST_ON_PROGRESS;
    while (st & I2CM_ST_ON_PROGRESS)
        st = reg_read(reg_base+I2CM_REG_STATUS);
}
*/

void i2cm_read_block(u32 reg_base, u8 dev_addr, u8 offset, u16 n_bytes, u8 *buf, u8 *status)
{
    u8 st, i;

    reg_write(reg_base+I2CM_REG_DEV_ADDR, dev_addr);
    reg_write(reg_base+I2CM_REG_OFFSET, offset);
    reg_write(reg_base+I2CM_REG_NUM0, n_bytes); // byte number 0
    reg_write(reg_base+I2CM_REG_NUM1, n_bytes>>8); // byte number 1
    reg_write(reg_base+I2CM_REG_CMD, I2CM_CMD_CLR_FIFO); // clear FIFO command
    reg_write(reg_base+I2CM_REG_CMD, I2CM_CMD_BYTE_READ); // start read command
    while (n_bytes > 0) {
        st = reg_read(reg_base+I2CM_REG_FIFO_CNT);
        if (n_bytes < st)
            st = n_bytes;
        if (st) {
            for (i=0; i<st; i++)
                *buf++ = reg_read(reg_base+I2CM_REG_FIFO);
            n_bytes = n_bytes - st;
        } else {
            st = reg_read(reg_base+I2CM_REG_STATUS);
            if (st & I2CM_ST_TIMEOUT)
                break;
        }
    }
    st = I2CM_ST_ON_PROGRESS;
    while (st & I2CM_ST_ON_PROGRESS) {
        st = reg_read(reg_base+I2CM_REG_STATUS);
        if (st & I2CM_ST_TIMEOUT)
            break;
    }
    if (status)
        *status = st;
    delay_ms(1);
    return;
} 

