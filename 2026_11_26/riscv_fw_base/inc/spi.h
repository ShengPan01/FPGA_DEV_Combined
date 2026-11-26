#ifndef _SPI_H
#define _SPI_H

#include "sal.h"

#define TX_REG_BASE     (0x80000000 + spi_reg_base) // spi_reg_base is defined in spi.c

#define SPI_SET             TX_REG_BASE + AL32(0x2)
#define SPI_CTRL            TX_REG_BASE + AL32(0x3)
#define SPI_TX_BYTE_NUM0    TX_REG_BASE + AL32(0x4)
#define SPI_TX_BYTE_NUM1    TX_REG_BASE + AL32(0x5)
#define SPI_RX_BYTE_NUM0    TX_REG_BASE + AL32(0x6)
#define SPI_RX_BYTE_NUM1    TX_REG_BASE + AL32(0x7)

/*
当前FPGA的 spi_clk 配置为 60 MHz，因此对应速率为：

选项	    编码	SCK 频率
SPI_SPEED_0	0x0	    30 MHz
SPI_SPEED_1	0x2	    15 MHz
SPI_SPEED_2	0x4	    7.5 MHz
SPI_SPEED_3	0x6	    3.75 MHz
SPI_SPEED_4	0x8	    1.875 MHz
SPI_SPEED_5	0xA	    937.5 kHz
SPI_SPEED_6	0xC	    468.75 kHz
SPI_SPEED_7	0xE	    234.375 kHz
*/

#define SPI_SPEED_0  0x0
#define SPI_SPEED_1  0x2
#define SPI_SPEED_2  0x4
#define SPI_SPEED_3  0x6
#define SPI_SPEED_4  0x8
#define SPI_SPEED_5  0xa
#define SPI_SPEED_6  0xc
#define SPI_SPEED_7  0xe

#define SPI_OP_DONE  0x80

#define SPI_RD_NO_WAIT 0x40

#define SPI_CS_END_HIGH  0x20
#define SPI_CS_START_HIGH  0x10
#define SPI_CS_DEFAULT  SPI_CS_END_HIGH

#define SPI_CMD_MASK 0xe
#define SPI_CMD_WR  0x2
#define SPI_CMD_RD  0x4
#define SPI_CMD_WR_RD  0x6
#define SPI_SET_CS  0x8
#define SPI_OP_EN  0x1

#define SPI_TX_BUF_OFFSET AL32(0x0000)
#define SPI_RX_BUF_OFFSET AL32(0x0280)

#define spi_set_speed(x) do { reg_write(SPI_SET, (x|0x1)); } while (0)

extern u16 spi_reg_base;
extern u16 spi_buf_base;
//extern u8 *spi_tx_buffer;
//extern u8 *spi_rx_buffer;

void spi_init(u16 reg_base, u16 buf_base);
void spi_buf_wr(u16 offset, u8 d);
u8 spi_buf_rd(u16 offset);
char spi_send_cmd(unsigned char op, unsigned char cs_state, unsigned short tx_count, unsigned short rx_count);

#endif
