#ifndef _AXI_BRDG_H
#define _AXI_BRDG_H

#include "sal.h"

#define AXI_WADDR0  AL32(0x0)
#define AXI_WADDR1  AL32(0x1)
#define AXI_WADDR2  AL32(0x2)
#define AXI_WADDR3  AL32(0x3)
#define AXI_WDATA   AL32(0x4)
#define AXI_WR_CTRL0    AL32(0x5)
#define AXI_WR_CTRL1    AL32(0x6)
#define AXI_WR_CTRL2    AL32(0x7)
#define AXI_RADDR0  AL32(0x8)
#define AXI_RADDR1  AL32(0x9)
#define AXI_RADDR2  AL32(0xa)
#define AXI_RADDR3  AL32(0xb)
#define AXI_RDATA   AL32(0xc)
#define AXI_RD_CTRL0    AL32(0xd)
#define AXI_RD_CTRL1    AL32(0xe)
#define AXI_RD_CTRL2    AL32(0xf)

#define RESP_OK     0x0
#define RESP_EXOK   0x1
#define RESP_SLVERR 0x2
#define RESP_DECERR 0x3

u8 axi_write(u32 axi_brdg_base, u8 id, u32 addr, u8 *buf, u8 len);
u8 axi_read(u32 axi_brdg_base, u8 id, u32 addr, u8 *buf, u8 len);

#endif
