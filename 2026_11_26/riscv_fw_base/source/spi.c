
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
#include "spi.h"

u16 spi_reg_base;
u16 spi_buf_base;
u32 spi_tx_buffer;
u32 spi_rx_buffer;


void spi_init(u16 reg_base, u16 buf_base)
{
    spi_reg_base = reg_base;
    spi_buf_base = buf_base;
    spi_tx_buffer = spi_buf_base + SPI_TX_BUF_OFFSET;
    spi_rx_buffer = spi_buf_base + SPI_RX_BUF_OFFSET;
}

char spi_send_cmd(unsigned char op, unsigned char cs_state, unsigned short tx_count, unsigned short rx_count)
{                               
//    int i;
    unsigned char c;

//    debug_printf("spi_send_cmd(%x, txc=%d, rxc=%d)\n", op, tx_count, rx_count);
    reg_write(SPI_TX_BYTE_NUM0, tx_count);
    reg_write(SPI_TX_BYTE_NUM1, tx_count>>8);
    reg_write(SPI_RX_BYTE_NUM0, rx_count);
    reg_write(SPI_RX_BYTE_NUM1, rx_count>>8);
    reg_write(SPI_CTRL, cs_state | op | SPI_OP_EN);
    c = reg_read(SPI_CTRL);
    while ((c & SPI_OP_DONE) != SPI_OP_DONE)
        c = reg_read(SPI_CTRL);
    return 0;
}

void spi_buf_wr(u16 offset, u8 d)
{
//    debug_printf("spi_buf_wr(%x, %x)\n", spi_tx_buffer + AL32(offset), d);
    reg_write(0x80000000 + spi_tx_buffer + AL32(offset), d);
}

u8 spi_buf_rd(u16 offset)
{
    u8 c;
    u32 a;
    
    a = 0x80000000 + spi_rx_buffer + AL32(offset);
    c = reg_read(a);
//    debug_printf("spi_buf_rd(%x)=%02x\n", a, c);
    return c;
}

