/* Advisory power-on authentication of the physical signed Flash image. */
#include "flash_verify.h"
#include "spi.h"
#include "reg_acc.h"
#include "mcu.h"
#include "lms.h"
#include "endian.h"

#define FW_FLASH_START 0x1000UL
#define FW_FLASH_BYTES 0x24000UL
#define CERT_FLASH_START 0x25000UL
#define CERT_FLASH_BYTES 0x1000UL
#define PUBLIC_FLASH_START 0x26000UL

/* BSS, rather than the 8 KiB stack. Never read beyond the certificate sector. */
static unsigned char signature[CERT_FLASH_BYTES];
static int read_failed;

/* Unlike the command-line SPI helper, startup must return if SPI stalls.
 * A finite polling budget also works if the hardware timer is unavailable. */
static int transfer(unsigned char op, unsigned char cs, unsigned tx, unsigned rx)
{
    unsigned long polls = 1000000UL;
    reg_write(SPI_TX_BYTE_NUM0, tx);
    reg_write(SPI_TX_BYTE_NUM1, tx >> 8);
    reg_write(SPI_RX_BYTE_NUM0, rx);
    reg_write(SPI_RX_BYTE_NUM1, rx >> 8);
    reg_write(SPI_CTRL, cs | op | SPI_OP_EN);
    while (polls--) {
        if (reg_read(SPI_CTRL) & SPI_OP_DONE) return 1;
    }
    /* Best-effort release CS; do not wait again on a stalled controller. */
    reg_write(SPI_CTRL, SPI_SET_CS | SPI_CS_END_HIGH | SPI_OP_EN);
    read_failed = 1;
    return 0;
}

static int flash_read_bytes(unsigned long address, unsigned char* dst, size_t len)
{
    while (len) {
        unsigned i, n = len > 256 ? 256 : (unsigned)len;
        spi_buf_wr(0, 0x03);
        spi_buf_wr(1, address >> 16);
        spi_buf_wr(2, address >> 8);
        spi_buf_wr(3, address);
        if (!transfer(SPI_CMD_WR, 0, 4, 0) ||
            !transfer(SPI_CMD_RD, SPI_CS_DEFAULT | SPI_RD_NO_WAIT, 0, n)) return 0;
        for (i = 0; i < n; ++i) dst[i] = spi_buf_rd(i);
        address += n;
        dst += n;
        len -= n;
    }
    return 1;
}

static int read_message(void* user, size_t offset, unsigned char* dst, size_t len)
{
    (void)user;
    if (offset > FW_FLASH_BYTES || len > FW_FLASH_BYTES - offset) return 0;
    return flash_read_bytes(FW_FLASH_START + offset, dst, len);
}

void flash_verify_on_boot(void)
{
    unsigned char pub[LMS_PUBLIC_BYTES];
    unsigned char saved_speed = reg_read(SPI_SET);
    lms_parameters p;
    read_failed = 0;
    spi_set_speed(SPI_SPEED_4);
    debug_printf("LMS Flash verify: start (FW 001000..024fff)\n");
    if (!flash_read_bytes(PUBLIC_FLASH_START, pub, sizeof pub)) goto io_error;
    if (!lms_params_from_types((uint32_t)get_bigendian(pub, 4),
                              (uint32_t)get_bigendian(pub + 4, 4), &p) ||
        p.signature_bytes > sizeof signature) {
        debug_printf("LMS Flash verify: FAIL (invalid public key/unsupported certificate size); continuing\n");
        goto done;
    }
    if (!flash_read_bytes(CERT_FLASH_START, signature, p.signature_bytes)) goto io_error;
    if (lms_verify_stream(pub, sizeof pub, read_message, 0, FW_FLASH_BYTES,
                          signature, p.signature_bytes)) {
        debug_printf("LMS Flash verify: PASS; continuing\n");
    } else {
        if (read_failed) goto io_error;
        debug_printf("LMS Flash verify: FAIL (signature mismatch or malformed certificate); continuing\n");
    }
    goto done;
io_error:
    debug_printf("LMS Flash verify: FAIL (SPI read timeout); continuing\n");
done:
    reg_write(SPI_SET, saved_speed);
}
