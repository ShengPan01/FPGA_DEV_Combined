/*
 * Copyright (c) 2026 . All rights reserved.
 *
 * Unauthorized copying, modification, distribution, or use
 * of this software is strictly prohibited without prior
 * written permission from the copyright owner.
 *
 * Author:
 * Date: 2026-11-11
 */

#include "debug.h"
#include "reg_acc.h"



void put_digit(u8 c)
{
    if (c < 10) { // 0~9
        putchar_local('0' + c);
    } else { // A~F
        putchar_local('A' + (c - 10));
    }
}

void simple_printf_no_arg(char* ori_string)
{
    u8 cCount = 0;
    u8 ch;

    cCount = 0;
    while ((ch = (u8)ori_string[cCount++])) {
        putchar_local(ch);
    }
}

void simple_printf(char* ori_string,  ...)
{
    u8 cCount = 0;
    u8 ch;
    u32 a,b;
    signed char j;

    va_list va;
    va_start(va, ori_string);

    cCount = 0;
    while ((ch = (u8)ori_string[cCount++])) {
        if (ch != '%')
            putchar_local(ch);
        else {
            ch = (u8)ori_string[cCount++];

            switch (ch) {
            case 'd':
            case 'u':
                a = 1;
                b= va_arg(va, unsigned int);
                while(( b / a ) !=0) {
                    a*=10;
                    if (a==10000 ) break;
                }
                if (a!=1) a/=10;

                while(a>0){
                    put_digit(( b / a ) % 10 );
                    a/=10;
                }

                break;
            case 'x':
            case 'X':
                b= va_arg(va, unsigned int);
                if (b >>16){//
                    a = 0xf0000000; // 8 digit
                    j = 28;
                }else{
                    a = 0xf000; // 4 digit
                    j = 12;
                }
                while((a & b) ==0) {
                    a>>=4;
                    j-=4;
                    if (j==0) break;
                }
                if ((j%8)==0) put_digit(0);//align bytes

                while(j>=0){
                    put_digit((b>>j) & 0x0F);
                    j-=4;
                }
                break;
            default:
                break;
            }
        }
    }

}

void TraceArray(u8 array[], u8 len)
{
    u8 i;

    i = 0;
    while(i < len) {
        put_digit((array[i]>>4) & 0x0F);
        put_digit(array[i] & 0x0F);
        i++;
        if (i != len) {
            if (i%16 == 0)
                putchar_local('\n');
            else
                putchar_local(' ');
        } else {
            putchar_local('\n');
        }
    }
}