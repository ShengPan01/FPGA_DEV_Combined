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
    /********************************************/
    /* filename:Uart_int.c                                             */
    /********************************************/

    #include "uart_int.h"
    #include "mcu.h"
    #include "reg_acc.h"

    //extern unsigned char volatile xdata dprx_regs[];
    unsigned char uart_buf[7];
    int rx_count;
    int tx_left;
    bit cmd_valid;
    bit ret_valid;
    bit term_cmd_valid;
    bit fetching_term_cmd;
    char command_buf[TERM_CMD_SIZE];
    int command_buf_len;
    char output_ring_buffer[RB_SIZE];
    volatile int rb_start, rb_stop;
    bit serial_idle;



void init_serial(unsigned char baud)
{

    //reg_write(UART_INT_EN, 0x0/*0x2*/);

#ifdef CMD_LINE_DEBUG
    //bit 0, rx int enable; bit 1, tx int enable
    reg_write(UART_INT_EN, 0x3);
    
    rx_count = 0;
    tx_left = 0;
    cmd_valid = 0;
    ret_valid = 0;
    term_cmd_valid = 0;
    fetching_term_cmd = 0;

    rb_start = 0;
    rb_stop = 0;
    serial_idle = 1;
#endif
}

#ifdef CMD_LINE_DEBUG

void putchar_local(char c)
{
//  EA = 0;
//    if (!serial_idle)
    while (reg_read(UART_TX_ST) & 0x01) ;
    if (c == '\n')
    {
        reg_write(UART_TX_BUF, 0x0d);
        while (reg_read(UART_TX_ST) & 0x01) ;
        reg_write(UART_INT, 0x02);  // clear UART TX int
    }
    reg_write(UART_TX_BUF, c);
    //while (reg_read(UART_TX_ST) & 0x01) ;
    //reg_write(UART_INT, 0x02);  // clear UART TX int
//  EA = 1;
}

void add_char_to_ring_buffer(char c)
{
    int next_rb_stop, t;

    disable_ext_intr();
    if (fetching_term_cmd) {
        rb_stop = 0;
        rb_start = 0;
    } else {
        if (serial_idle) {
            putchar_local(c);//reg_write(UART_TX_BUF, c);
            serial_idle = 0;
        } else {
            if (rb_stop == RB_SIZE-1)
                next_rb_stop = 0;
            else
                next_rb_stop = rb_stop+1;
            t = rb_start;
            if (next_rb_stop == t) { // buffer full
                enable_ext_intr();
                while (t == rb_start && !fetching_term_cmd)
                    ;
                disable_ext_intr();
            }
            if (!fetching_term_cmd) {
                output_ring_buffer[rb_stop] = c;
                rb_stop = next_rb_stop;
            }
        }
    }
    enable_ext_intr();
}

#endif

    //renamed to proc_serial_isr//void prot_isr(void)
    void proc_serial_isr(void)
    {
#ifdef CMD_LINE_DEBUG
        unsigned char c;

        if (reg_read(UART_INT) & 0x02) {//bit 0, Rx int, bit 1, tx int
            reg_write(UART_INT, 0x02);  // clear UART TX int
            serial_idle = 1;
            if (ret_valid) {
                if (tx_left) {
                    reg_write(UART_TX_BUF, uart_buf[--tx_left]);
                    serial_idle = 0;
                } else
                    ret_valid = 0;
            } else if (rb_start != rb_stop) {
                reg_write(UART_TX_BUF, output_ring_buffer[rb_start++]);
                if (rb_start == RB_SIZE)
                    rb_start = 0;
                serial_idle = 0;
            }
        }

        if (reg_read(UART_INT) & 0x01) {
            enable_debug_output = 0;
            reg_write(UART_INT, 0x01);  // clear UART RX int
            c = reg_read(UART_RX_BUF);
            if (fetching_term_cmd) {
                if (c == '\n' || c == '\r') { //end of term_cmd indicator
                    term_cmd_valid = 1;
                    fetching_term_cmd = 0;
                    //c= 0x41; 
                    //putchar_local(0x41);
                } else if (c == 0x08 || c == 0x7f) {
                    if (command_buf_len > 0) command_buf_len--;
                }
                else if (command_buf_len < (TERM_CMD_SIZE-1)) {
                    command_buf[command_buf_len++] = c;
                } else
                    c = '*'; //replace extra characters (> TERM_CMD_SIZE) by '*'
                if (c == '\r')
                    putchar_local('\n'); //replace CR by LF, and TX back
                else
                    putchar_local(c); //TX back
            } else {
                if ((rx_count != 0) || (c == CMD_READ) || (c == CMD_WRITE))
                   uart_buf[rx_count++] = c;
                if (rx_count == 7) {
                    cmd_valid = 1;
                    rx_count = 0;
                }
                //if (c == '\\') { // '\' is the start of term_cmd indicator
                if (c== '\\' && !rx_count && !cmd_valid) {
                    fetching_term_cmd = 1;
                    command_buf_len = 0;
                    putchar_local(c);
                }
            }
        }
#endif
    }



