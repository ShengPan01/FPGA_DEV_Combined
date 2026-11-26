#!/usr/bin/env python3
"""Host test of actual startup verifier with a simulated SPI register interface."""
import ctypes as c
from pathlib import Path
import subprocess
import tempfile
from sign_ihex import padded_image

root = Path(__file__).resolve().parents[1]
with tempfile.TemporaryDirectory() as tmp:
    work = Path(tmp)
    # Preserve actual register constants, replacing only target hardware access.
    spi = (root / 'inc/spi.h').read_text().replace('#include "sal.h"',
        '#include <stdint.h>\ntypedef uint8_t u8;\ntypedef uint16_t u16;\n#define AL32(x) ((x)*4)')
    (work / 'spi.h').write_text(spi)
    (work / 'reg_acc.h').write_text('''
void mock_write(unsigned long a, unsigned char d);
unsigned char mock_read(unsigned long a);
#define reg_write(a,d) mock_write(a,d)
#define reg_read(a) mock_read(a)
''')
    (work / 'mcu.h').write_text('void debug_printf(const char *fmt, ...);\n')
    (work / 'mock.c').write_text('''
#include <assert.h>
#include <stdarg.h>
#include <stdio.h>
#include <string.h>
#include "spi.h"
unsigned char flash[0x400000], regs[32], tx[256], rx[256];
char logs[1024];
unsigned short spi_reg_base=0, spi_buf_base=0;
unsigned address;
int stuck;
void debug_printf(const char *fmt, ...) {
    va_list args;
    va_start(args,fmt);
    vsnprintf(logs+strlen(logs), sizeof logs-strlen(logs),fmt,args);
    va_end(args);
}
void spi_buf_wr(u16 offset,u8 value) { assert(offset<256); tx[offset]=value; }
u8 spi_buf_rd(u16 offset) { assert(offset<256); return rx[offset]; }
unsigned char mock_read(unsigned long a) {
    unsigned index=(a-0x80000000UL)/4;
    if (a==SPI_CTRL) return stuck ? 0 : SPI_OP_DONE;
    return regs[index];
}
void mock_write(unsigned long a,unsigned char value) {
    unsigned index=(a-0x80000000UL)/4;
    regs[index]=value;
    if (a!=SPI_CTRL || stuck) return;
    if ((value&SPI_CMD_MASK)==SPI_CMD_WR) {
        assert(tx[0]==3);
        address=((unsigned)tx[1]<<16)|((unsigned)tx[2]<<8)|tx[3];
    } else if ((value&SPI_CMD_MASK)==SPI_CMD_RD) {
        unsigned n=regs[6]|((unsigned)regs[7]<<8);
        assert(n<=256 && address+n<=sizeof flash);
        assert((address>=0x1000 && address+n<=0x25000) ||
               (address>=0x25000 && address+n<=0x26000) ||
               (address>=0x26000 && address+n<=0x26030));
        memcpy(rx,flash+address,n);
    }
}
''')
    output = work / 'boot.so'
    subprocess.run(['gcc', '-shared', '-fPIC', '-O2', '-Wall', '-Wextra', '-Werror',
                    '-I'+tmp, '-I'+str(root/'inc'), '-I'+str(root/'inc/lms'),
                    str(root/'source/flash_verify.c'), str(work/'mock.c'),
                    *[str(root/'source/lms'/f) for f in ('lms.c','sha256.c','endian.c')],
                    '-o', str(output)], check=True)
    lib = c.CDLL(str(output))
    flash = (c.c_ubyte * 0x400000).in_dll(lib, 'flash')
    logs = (c.c_char * 1024).in_dll(lib, 'logs')
    regs = (c.c_ubyte * 32).in_dll(lib, 'regs')
    message, _ = padded_image(root/'output/test.ihex')
    pub = (root/'output/test_signed.pub.bin').read_bytes()
    sig = (root/'output/test_signed.sig.bin').read_bytes()
    flash[:] = b'\xff' * len(flash)
    flash[0x1000:0x25000] = message
    flash[0x25000:0x25000+len(sig)] = sig
    flash[0x26000:0x26030] = pub

    def run(expected):
        logs.value = b''
        regs[2] = 0x17
        lib.flash_verify_on_boot()  # Must return for every result.
        assert expected in logs.value and b'continuing' in logs.value, logs.value
        assert regs[2] == 0x17, 'SPI configuration not restored'

    run(b'PASS')
    for address in (0x1000, 0x21000, 0x24fff, 0x25000, 0x2602f):
        flash[address] ^= 1
        run(b'FAIL')
        flash[address] ^= 1
    flash[0x26000:0x26030] = b'\xff'*48
    run(b'invalid public key')
    flash[0x26000:0x26030] = pub
    # Valid W1 key type but a signature larger than the certificate partition.
    flash[0x26007] = 5
    run(b'unsupported certificate size')
    flash[0x26000:0x26030] = pub
    c.c_int.in_dll(lib, 'stuck').value = 1
    run(b'SPI read timeout')
    c.c_int.in_dll(lib, 'stuck').value = 0
    run(b'PASS')
print('PASS: boot verifier, Flash bounds, PASS/FAIL return, tampering, erased key, oversize signature, SPI timeout, configuration restore')
