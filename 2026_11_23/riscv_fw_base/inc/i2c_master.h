#ifndef _I2C_MASTER_H
#define _I2C_MASTER_H

#include "mcu.h"

#define I2CM_REG_DEV_ADDR   AL32(0x0)
#define I2CM_REG_SGMT_ADDR  AL32(0x1)
#define I2CM_REG_OFFSET     AL32(0x2)
#define I2CM_REG_CMD        AL32(0x4)
#define I2CM_REG_NUM0       AL32(0x5)
#define I2CM_REG_NUM1       AL32(0x6)
#define I2CM_REG_STATUS     AL32(0x7)
#define I2CM_REG_FIFO       AL32(0x8)
#define I2CM_REG_FIFO_CNT   AL32(0x9)
#define I2CM_REG_INT_ST     AL32(0xa)
#define I2CM_REG_CTRL       AL32(0xb)

#define I2CM_ST_MASTER_ERR  0x80
#define I2CM_ST_OCCUPY      0x40
#define I2CM_ST_NO_ACK      0x08
#define I2CM_ST_TIMEOUT     0x04
#define I2CM_ST_ERROR       0x02
#define I2CM_ST_ON_PROGRESS 0x01

#define I2CM_CMD_ABORT      0x0
#define I2CM_CMD_BYTE_READ  0x1
#define I2CM_CMD_BYTE_WRITE 0x2
#define I2CM_CMD_MSG_READ   0x3
#define I2CM_CMD_E_DDC_READ 0x4
#define I2CM_CMD_CLR_FIFO   0x5
#define I2CM_CMD_BUS_RESET  0x6

#define I2CM_SPEED_MASK         0x07
#define I2CM_SPEED_STD_MODE     0x03
#define I2CM_SPEED_FAST_MODE    0x07

void i2cm_set_speed(u32 reg_base, u8 mode);
u8 i2cm_msg_read(u32 reg_base, u8 dev_addr, u8 *status);
u8 i2cm_read(u32 reg_base, u8 dev_addr, u8 offset, u8 *status);
void i2cm_write(u32 reg_base, u8 dev_addr, u8 offset, u8 dat, u8 *status);
void i2cm_read_block(u32 reg_base, u8 dev_addr, u8 offset, u16 n_bytes, u8 *buf, u8 *status);
void i2cm_bus_reset(u32 reg_base);

#define DP130_REG_BASE (0x80000000 + AL32(0X20))
#define DP130_I2C_ADDR 0x5c

#endif
