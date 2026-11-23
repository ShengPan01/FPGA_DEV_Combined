

////////////////////////////////////////////////////////////////////////////////
// Company: Analogix
// Engineer: Sheng Pan
//
// Create Date: 2026-11-02
// Tool chain: codix-bk3-32IMC-Upid-CORE-3.2.0-8.3.3-2901-windows.10.x86_64
// Description:
//   
// 
// Revision:
//    0.1 Initial version
//    0.2 add lms test
//    
////////////////////////////////////////////////////////////////////////////////


#ifndef CUSTOM_TEST_C
#define CUSTOM_TEST_C

#include "config.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "sal.h"
#include "custom_test.h"
#include "cmdline.h"
#include "clk_measure.h"
#include "printf.h"
#include "i2c_master.h"
#include "spi.h"

#include "typedef.h"
#include "lms/lms_selftest.h"
#include "debug.h"
#include "timer.h"

#ifdef CMD_LINE_DEBUG
#ifndef NO_CUSTOM_TEST




void i2c_read(char **argv)
{
    u8 c;

    c = i2cm_read(0x80000000+AL32(hex_to_int(argv[1])), hex_to_int(argv[2]), hex_to_int(argv[3]), NULL);
    debug_printf("Read I2C Register [%s:%s:%s]=%02x\n", argv[1], argv[2], argv[3], c);
}

void i2c_write(char **argv)
{
    i2cm_write(0x80000000+AL32(hex_to_int(argv[1])), hex_to_int(argv[2]), hex_to_int(argv[3]), hex_to_int(argv[4]), NULL);
    debug_printf("Write I2C Register [%s:%s:%s]=%02x\n", argv[1], argv[2], argv[3], hex_to_int(argv[4]));
}

static u8 i2c_test_status_failed(u8 status)
{
    return (status & (I2CM_ST_MASTER_ERR | I2CM_ST_NO_ACK |
                      I2CM_ST_TIMEOUT | I2CM_ST_ERROR)) ||
           ((status & I2CM_ST_OCCUPY) && !(status & I2CM_ST_ON_PROGRESS)) ||
           (status & I2CM_ST_ON_PROGRESS);
}

void i2c_test(char **argv)
{
    const u32 reg_base = 0x80000000 + AL32(0x70);
    u8 mode = hex_to_int(argv[1]);
    u8 dev_addr = hex_to_int(argv[2]);
    u8 offset = hex_to_int(argv[3]);
    u8 data = hex_to_int(argv[4]);
    u8 status;
    u8 readback;

    if (mode > 1) {
        debug_printf("Usage: i2ctest mode dev offset data (mode 0=read, 1=write/readback)\n");
        return;
    }

    i2cm_set_speed(reg_base, I2CM_SPEED_STD_MODE);
    if (mode == 0) {
        readback = i2cm_read(reg_base, dev_addr, offset, &status);
        debug_printf("I2C read dev=%02x offset=%02x status=%02x data=%02x\n",
                     dev_addr, offset, status, readback);
        if (i2c_test_status_failed(status))
            debug_printf("I2C read test FAIL\n");
        else
            debug_printf("I2C read test PASS\n");
        return;
    }

    i2cm_write(reg_base, dev_addr, offset, data, &status);
    debug_printf("I2C write dev=%02x offset=%02x data=%02x status=%02x\n",
                 dev_addr, offset, data, status);
    if (i2c_test_status_failed(status)) {
        debug_printf("I2C write test FAIL\n");
        return;
    }

    readback = i2cm_read(reg_base, dev_addr, offset, &status);
    debug_printf("I2C readback dev=%02x offset=%02x status=%02x data=%02x\n",
                 dev_addr, offset, status, readback);
    if (i2c_test_status_failed(status) || readback != data)
        debug_printf("I2C write/readback test FAIL\n");
    else
        debug_printf("I2C write/readback test PASS\n");
}





void show(char **argv)
{
    u8 i;
    u8 regval;
    u32 regaddr;

    debug_printf("       0  1  2  3  4  5  6  7    8  9  a  b  c  d  e  f\n");
	debug_printf("-------------------------------------------------------\n");

    for(i=0;i<10;i++){
        //regaddr = 0x80000280 + AL32(i);
        regaddr = 0x80000100 + AL32(i);
        debug_printf("Reading register [%08x]: ", regaddr);
        regval = reg_read(regaddr);
        
        //regval = reg_read(0x80000280 + AL32(i));
        debug_printf("%02x ", regval);
        debug_printf("\n");
        //if ((i & 0xf) == 0xf)
        //    debug_printf("\n");
    }
    debug_printf("\n");


    //show_clk_freq("pixel clock", "link clock (x10)", "lane0 clock (x20)", NULL);
    show_clk_freq(NULL, NULL, NULL, NULL);
    
    /*
    
    {
        const u32 dpcd_addr[] = {0x100, 0x101, 0x103, 0x104, 0x105, 0x106, 0x600};
        int i;
        u8 c;
        
        debug_printf("   --- DP130 DPCD registers ---\n");
        for (i=0; i<(sizeof(dpcd_addr)/sizeof(u32)); i++) {
            i2cm_write(0x80000000+AL32(0x20), 0x5c, 0x1c, (dpcd_addr[i]>>16)&0xff, NULL);
            i2cm_write(0x80000000+AL32(0x20), 0x5c, 0x1d, (dpcd_addr[i]>>8)&0xff, NULL);
            i2cm_write(0x80000000+AL32(0x20), 0x5c, 0x1e, dpcd_addr[i]&0xff, NULL);
            c = i2cm_read(0x80000000+AL32(0x20), 0x5c, 0x1f, NULL);
            debug_printf("  [%05x]=%02x\n", dpcd_addr[i], c);
        }
        debug_printf("\n");
    }
    
    dptx_co3_show();
    */
}



void test_reg_access(char **argv)//for register address test.
{
    u8 index;
    u8 buf[64];

    for (index=0; index<64; index++)
        buf[index] = index;

    index = hex_to_long(argv[1]);
    
    switch (index)
    {
        case 0:
            debug_printf("Write to AXI register \n");

            break;
        case 1:

            debug_printf("Write to DP register \n");
            break;
    
        default:
            break;
    }

 
}

void dummy(char **argv)
{

	REF_VAR(argv);

    debug_printf("%s call dummy()\n", get_str_time());
}

static uint64_t read_lms_ticks(void)
{
    return get_timer_tick();
}

static void log_lms_verify_time(uint64_t ticks)
{
    uint64_t elapsed_us = ticks / (TIME_1ms / 1000UL);
    char digits[21];
    unsigned int position = sizeof digits - 1;

    SYS_DBG_MSG2("LMS verify ticks: high=0x%x low=0x%x\n",
                 (unsigned int)(ticks >> 32), (unsigned int)ticks);
    if (ticks == 0) {
        SYS_DBG_MSG0("LMS timing unavailable: timer counter did not advance\n");
        return;
    }

    digits[position] = '\0';
    do {
        digits[--position] = (char)('0' + elapsed_us % 10);
        elapsed_us /= 10;
    } while (elapsed_us != 0);

    SYS_DBG_MSG0("LMS verify time (us): ");
    SYS_DBG_MSG0(&digits[position]);
    SYS_DBG_MSG0("\nLMS verify time (ms): ");
    if (position < sizeof digits - 4) {
        unsigned int decimal_position = sizeof digits - 4;
        char saved_digit = digits[decimal_position];
        digits[decimal_position] = '\0';
        SYS_DBG_MSG0(&digits[position]);
        digits[decimal_position] = saved_digit;
        SYS_DBG_MSG0(".");
        SYS_DBG_MSG0(&digits[decimal_position]);
    } else {
        unsigned int padding;
        SYS_DBG_MSG0("0.");
        for (padding = sizeof digits - 4; padding < position; padding++) {
            SYS_DBG_MSG0("0");
        }
        SYS_DBG_MSG0(&digits[position]);
    }
    SYS_DBG_MSG0("\n");
}

static void log_lms_benchmark(const lms_benchmark_result *result)
{
    SYS_DBG_MSG2("LMS H%u/W%u: ", result->height, result->width);
    SYS_DBG_MSG2("message=%u B signature=%u B\n",
                 (unsigned int)result->message_bytes, (unsigned int)result->signature_bytes);
    SYS_DBG_MSG1("Repetitions: %u\n", result->repetitions);
    if (!result->verified)
        SYS_DBG_MSG0("Verification: FAIL\n");
    else
        SYS_DBG_MSG0("Verification: PASS\n");
    if (!result->timer_valid) {
        SYS_DBG_MSG0("Timing unavailable: timer counter did not advance\n");
        return;
    }
    SYS_DBG_MSG0("Minimum:\n");
    log_lms_verify_time(result->minimum_ticks);
    SYS_DBG_MSG0("Average:\n");
    log_lms_verify_time(result->total_ticks / result->repetitions);
    SYS_DBG_MSG0("Maximum:\n");
    log_lms_verify_time(result->maximum_ticks);
}

#define W25Q32_CMD_READ             0x03
#define W25Q32_CMD_READ_STATUS1     0x05
#define W25Q32_CMD_READ_JEDEC_ID    0x9f
#define W25Q32_CMD_WRITE_ENABLE     0x06
#define W25Q32_CMD_PAGE_PROGRAM     0x02
#define W25Q32_CMD_SECTOR_ERASE_4K  0x20
#define W25Q32_JEDEC_MFG_ID         0x20
#define W25Q32_JEDEC_MEMORY_TYPE    0x40
#define W25Q32_JEDEC_CAPACITY       0x16
#define W25Q32_TEST_ADDRESS         0x003ff000UL
#define W25Q32_TEST_VALUE           0xa5

static u8 w25q32_read_status1(void)
{
    spi_buf_wr(0, W25Q32_CMD_READ_STATUS1);
    spi_send_cmd(SPI_CMD_WR, 0, 1, 0);
    spi_send_cmd(SPI_CMD_RD, SPI_RD_NO_WAIT | SPI_CS_DEFAULT, 0, 1);
    return spi_buf_rd(0);
}

static u1 w25q32_wait_ready(u32 timeout_ms)
{
    u64 start_ticks = get_timer_tick();
    u64 timeout_ticks = (u64)timeout_ms * TIME_1ms;

    while (get_timer_tick() - start_ticks < timeout_ticks) {
        if ((w25q32_read_status1() & 0x01) == 0)
            return TRUE;
    }
    return FALSE;
}

static u1 w25q32_write_enable(void)
{
    spi_buf_wr(0, W25Q32_CMD_WRITE_ENABLE);
    spi_send_cmd(SPI_CMD_WR, SPI_CS_DEFAULT, 1, 0);
    return (w25q32_read_status1() & 0x02) != 0;
}

static void w25q32_read_byte(u32 address, u8 *value)
{
    spi_buf_wr(0, W25Q32_CMD_READ);
    spi_buf_wr(1, (u8)(address >> 16));
    spi_buf_wr(2, (u8)(address >> 8));
    spi_buf_wr(3, (u8)address);
    spi_send_cmd(SPI_CMD_WR, 0, 4, 0);
    spi_send_cmd(SPI_CMD_RD, SPI_RD_NO_WAIT | SPI_CS_DEFAULT, 0, 1);
    *value = spi_buf_rd(0);
}

static void w25q32_read_jedec_id(u8 *manufacturer, u8 *memory_type, u8 *capacity)
{
    spi_buf_wr(0, W25Q32_CMD_READ_JEDEC_ID);
    spi_send_cmd(SPI_CMD_WR, 0, 1, 0);
    spi_send_cmd(SPI_CMD_RD, SPI_RD_NO_WAIT | SPI_CS_DEFAULT, 0, 3);
    *manufacturer = spi_buf_rd(0);
    *memory_type = spi_buf_rd(1);
    *capacity = spi_buf_rd(2);
}

static u1 w25q32_erase_test_sector(u32 address)
{
    if (!w25q32_write_enable())
        return FALSE;

    spi_buf_wr(0, W25Q32_CMD_SECTOR_ERASE_4K);
    spi_buf_wr(1, (u8)(address >> 16));
    spi_buf_wr(2, (u8)(address >> 8));
    spi_buf_wr(3, (u8)address);
    spi_send_cmd(SPI_CMD_WR, SPI_CS_DEFAULT, 4, 0);
    return w25q32_wait_ready(2000);
}

static u1 w25q32_program_byte(u32 address, u8 value)
{
    if (!w25q32_write_enable())
        return FALSE;

    spi_buf_wr(0, W25Q32_CMD_PAGE_PROGRAM);
    spi_buf_wr(1, (u8)(address >> 16));
    spi_buf_wr(2, (u8)(address >> 8));
    spi_buf_wr(3, (u8)address);
    spi_buf_wr(4, value);
    spi_send_cmd(SPI_CMD_WR, SPI_CS_DEFAULT, 5, 0);
    return w25q32_wait_ready(100);
}

void lms_test(char **argv)
{
    u8 index;
    uint64_t verification_ticks = 0;
    int selftest_passed;
    int benchmark_passed;

    index = hex_to_int(argv[1]);
    
    switch (index)
    {
        case 0:
            debug_printf("LMS Self test! \n");


            SYS_DBG_MSG0("LMS SHA256/192 self-test start\n");
            selftest_passed = lms_verify_selftest_timed(read_lms_ticks, &verification_ticks);
            log_lms_verify_time(verification_ticks);
            if (!selftest_passed) {
                SYS_DBG_MSG0("LMS SHA256/192 self-test FAIL\n");

            }else {
                SYS_DBG_MSG0("LMS SHA256/192 self-test PASS\n");
            }

            break;
        case 1:

            SYS_DBG_MSG0("LMS parameter benchmark start (20 combinations)\n");
            benchmark_passed = lms_verify_benchmark(read_lms_ticks, log_lms_benchmark);
            if (!benchmark_passed) {
                SYS_DBG_MSG0("LMS parameter benchmark FAIL\n");
            }
            SYS_DBG_MSG0("LMS parameter benchmark PASS\n");
            break;
    
        default:
            SYS_DBG_MSG0("invalid argument!\n");
            break;
    }

}

/**
 * SPI test function
 * @param argv Command line arguments
 *        argv[1] - test index (0 for read test, 1 for write test)
SPI 寄存器应该访问 0x00080000 + AL32(0x50) = 0x00080140，
经 RTL 的地址转换后对应 SPI 寄存器索引 0x0050。
TX 缓冲区应该访问 0x00080000 + AL32(0x800) = 0x00082000，
转换后对应 RTL 映射的 0x0800。
 */

void spi_test(char **argv)
{
    u8 index;
    u8 i;

    index = hex_to_int(argv[1]);
    switch (index)
    {
        case 0:
            SYS_DBG_MSG0("SPI read test start\n");
                SYS_DBG_MSG2("SPI pin status=0x%x, config=0x%x\n",
                         reg_read(TX_REG_BASE), reg_read(SPI_SET));
                SYS_DBG_MSG1("SPI control=0x%x\n", reg_read(SPI_CTRL));
            SYS_DBG_MSG0("SPI RX buffer[0..3]: ");
            for (i = 0; i < 4; i++)
                SYS_DBG_MSG1("%x ", spi_buf_rd(i));
            SYS_DBG_MSG0("\n");
            SYS_DBG_MSG0("SPI read test done\n");
            break;
        case 1:
            SYS_DBG_MSG0("SPI write test start\n");
            {
                static const u8 test_data[] = {0xa5, 0x5a, 0xc3, 0x3c};
                u8 readback;
                u8 test_passed = TRUE;

                for (i = 0; i < sizeof test_data; i++)
                    spi_buf_wr(i, test_data[i]);

                for (i = 0; i < sizeof test_data; i++) {
                    readback = reg_read(0x80000000 + spi_buf_base +
                                        SPI_TX_BUF_OFFSET + AL32(i));
                        SYS_DBG_MSG2("TX buffer[%u]: wrote 0x%x, read 0x%x\n",
                                 i, test_data[i], readback);
                    if (readback != test_data[i])
                        test_passed = FALSE;
                }

                if (test_passed)
                    SYS_DBG_MSG0("SPI TX buffer write/readback PASS\n");
                else
                    SYS_DBG_MSG0("SPI TX buffer write/readback FAIL\n");
            }
            SYS_DBG_MSG0("SPI write test done\n");
            break;
        case 2:
        {
            u8 manufacturer;
            u8 memory_type;
            u8 capacity;
            u8 original_value;
            u8 erased_value;
            u8 readback;

            SYS_DBG_MSG0("W25Q32FV read/write test start\n");
            spi_set_speed(SPI_SPEED_4);
            w25q32_read_jedec_id(&manufacturer, &memory_type, &capacity);
            SYS_DBG_MSG1("JEDEC ID: manufacturer=0x%x, type=0x%x, capacity=0x%x\n",
                         manufacturer, memory_type, capacity);
            if (manufacturer != W25Q32_JEDEC_MFG_ID ||
                memory_type != W25Q32_JEDEC_MEMORY_TYPE ||
                capacity != W25Q32_JEDEC_CAPACITY) {
                SYS_DBG_MSG0("Unexpected SPI Flash JEDEC ID; test aborted\n");
                //break;
            }

            w25q32_read_byte(W25Q32_TEST_ADDRESS, &original_value);
            SYS_DBG_MSG2("Original [0x%x]=0x%x\n",
                         W25Q32_TEST_ADDRESS, original_value);

            if (!w25q32_erase_test_sector(W25Q32_TEST_ADDRESS)) {
                SYS_DBG_MSG0("W25Q32 sector erase failed or timed out\n");
                break;
            }
            w25q32_read_byte(W25Q32_TEST_ADDRESS, &erased_value);
            if (erased_value != 0xff) {
                SYS_DBG_MSG1("W25Q32 erase verify failed: 0x%x\n", erased_value);
                break;
            }

            if(original_value == W25Q32_TEST_VALUE)
                original_value = ~original_value;
            else
                original_value = W25Q32_TEST_VALUE;

            if (!w25q32_program_byte(W25Q32_TEST_ADDRESS, original_value)) {
                SYS_DBG_MSG0("W25Q32 page program failed or timed out\n");
                break;
            }
            w25q32_read_byte(W25Q32_TEST_ADDRESS, &readback);
            SYS_DBG_MSG2("Readback [0x%x]=0x%x\n",
                         W25Q32_TEST_ADDRESS, readback);
            if (readback == original_value)
                SYS_DBG_MSG0("W25Q32 read/write verify PASS\n");
            else
                SYS_DBG_MSG0("W25Q32 read/write verify FAIL\n");
            break;
        }
            break;
        default:
            SYS_DBG_MSG0("invalid argument!\n");
            break;
    }
}

#endif

#endif
#endif

