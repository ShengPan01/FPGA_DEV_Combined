/* Runtime W25Q32FV programmer. Commands use stop-and-wait acknowledgements. */
#include <string.h>
#include "flash_cmd.h"
#include "spi.h"
#include "reg_acc.h"
#include "timer.h"
#include "mcu.h"

static u8 erased[128];
static u1 active;
static u32 upper;
static u32 written;

static void transfer(u8 op, u16 tx, u16 rx)
{
    spi_send_cmd(op, SPI_CS_DEFAULT | (rx ? SPI_RD_NO_WAIT : 0), tx, rx);
}
static void address(u8 cmd, u32 a)
{
    spi_buf_wr(0, cmd);
    spi_buf_wr(1, a >> 16);
    spi_buf_wr(2, a >> 8);
    spi_buf_wr(3, a);
}
static u8 status(void)
{
    spi_buf_wr(0, 5);
    spi_send_cmd(SPI_CMD_WR, 0, 1, 0);
    transfer(SPI_CMD_RD, 0, 1);
    return spi_buf_rd(0);
}
static int ready(unsigned ms)
{
    u64 start = get_timer_tick();
    do {
        if (!(status() & 1)) return 1;
    } while (get_timer_tick() - start < (u64)ms * TIME_1ms);
    return 0;
}
static int wen(void)
{
    spi_buf_wr(0, 6);
    transfer(SPI_CMD_WR, 1, 0);
    return (status() & 2) != 0;
}
static u8 read_byte(u32 a)
{
    address(3, a);
    spi_send_cmd(SPI_CMD_WR, 0, 4, 0);
    transfer(SPI_CMD_RD, 0, 1);
    return spi_buf_rd(0);
}
static int nibble(char c)
{
    if (c >= '0' && c <= '9') return c-'0';
    if (c >= 'a' && c <= 'f') return c-'a'+10;
    if (c >= 'A' && c <= 'F') return c-'A'+10;
    return -1;
}
static int number(const char *s, u32 *v)
{
    unsigned n = 0;
    *v = 0;
    if (s[0]=='0' && (s[1]=='x' || s[1]=='X')) s += 2;
    while (*s) {
        int d = nibble(*s++);
        if (d < 0 || ++n > 8) return 0;
        *v = (*v << 4) | d;
    }
    return n != 0;
}
static void fail(void)
{
    active = 0;
    debug_printf("FLASH ERROR (session aborted; image may be partial)\n");
}
void flash_begin(char **argv)
{
    (void)argv;
    active = 0;
    spi_set_speed(SPI_SPEED_4);
    if (!ready(2000)) { fail(); return; }
    spi_buf_wr(0, 0x9f);
    spi_send_cmd(SPI_CMD_WR, 0, 1, 0);
    transfer(SPI_CMD_RD, 0, 3);
    if (spi_buf_rd(0)!=0x20 || spi_buf_rd(1)!=0x40 || spi_buf_rd(2)!=0x16) {
        fail(); return;
    }
    memset(erased, 0, sizeof erased);
    upper = written = 0;
    active = 1;
    debug_printf("FLASH READY\n");
}
void flash_abort(char **argv)
{
    (void)argv;
    active = 0;
    debug_printf("FLASH ABORTED\n");
}
void flash_hex(char **argv)
{
    u8 b[53], sum = 0;
    unsigned i, n, len = strlen(argv[1]);
    u32 a, end, sector;
    if (!active || len < 11 || argv[1][0]!=':' || !(len & 1) || len > 107) {
        fail(); return;
    }
    n = (len-1)/2;
    for (i=0; i<n; ++i) {
        int h = nibble(argv[1][1+2*i]), l = nibble(argv[1][2+2*i]);
        if (h < 0 || l < 0) { fail(); return; }
        b[i] = (h<<4)|l;
        sum += b[i];
    }
    if (sum || n != (unsigned)b[0]+5) { fail(); return; }
    a = ((u32)b[1]<<8)|b[2];
    switch (b[3]) {
    case 0:
        if (!b[0] || a+b[0]>0x10000UL) { fail(); return; }
        a += upper;
        end = a+b[0];
        /* Physical signed image: IMEM, 16 KiB DRAM, then LMS signature.
         * Also accept legacy CPU-addressed DMEM records. */
        if (a>=0x1000 && end<=0x26000) { }
        /* Separate 4 KiB sector; only the 48-byte raw LMS key is writable. */
        else if (a>=0x26000 && end<=0x26030) { }
        else if (a>=0x7ff80000UL && end<=0x7ff84000UL) a = a-0x7ff80000UL+0x21000;
        else { fail(); return; }
        for (i=0; i<b[0]; ++i) {
            u32 p = a+i;
            sector = p>>12;
            if (!(erased[sector>>3] & (1<<(sector&7)))) {
                if (!wen()) { fail(); return; }
                address(0x20, p & ~0xfffUL);
                transfer(SPI_CMD_WR, 4, 0);
                if (!ready(2000)) { fail(); return; }
                erased[sector>>3] |= 1<<(sector&7);
            }
            /* Reject conflicting overlapping records rather than silently corrupt. */
            if ((read_byte(p) & b[4+i]) != b[4+i] || !wen()) { fail(); return; }
            address(2, p);
            spi_buf_wr(4, b[4+i]);
            transfer(SPI_CMD_WR, 5, 0);
            if (!ready(100) || read_byte(p)!=b[4+i]) { fail(); return; }
        }
        written += b[0];
        break;
    case 1:
        if (b[0] || a || !written) { fail(); return; }
        active = 0;
        debug_printf("FLASH DONE %x bytes\n", written);
        return;
    case 2:
    case 4:
        if (b[0]!=2 || a) { fail(); return; }
        upper = (((u32)b[4]<<8)|b[5]) << (b[3]==2 ? 4 : 16);
        break;
    case 3:
    case 5:
        if (b[0]!=4 || a) { fail(); return; }
        break; /* Execution entry metadata is not Flash payload. */
    default: fail(); return;
    }
    debug_printf("FLASH OK\n");
}
void flash_read(char **argv)
{
    u32 a, count, i;
    if (active || !number(argv[1], &a) || !number(argv[2], &count) ||
        !count || count>0x1000 || a>=0x400000 || count>0x400000-a) {
        debug_printf("FLASH ERROR: idle required; address <400000, length 1..1000 (hex)\n");
        return;
    }
    spi_set_speed(SPI_SPEED_4);
    if (!ready(2000)) { fail(); return; }
    for (i=0; i<count; ++i) {
        if (!(i&15)) debug_printf("%08x: ", a+i);
        debug_printf("%02x ", read_byte(a+i));
        if ((i&15)==15 || i+1==count) debug_printf("\n");
    }
    debug_printf("FLASH READ DONE\n");
}
