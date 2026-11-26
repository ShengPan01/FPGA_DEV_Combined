/**********************************************************
 * crt0.h
 * Header file for CRT0 functions
 **********************************************************/

#ifndef _CRT0_H
#define _CRT0_H

void dead_loop(void);
void restart(void);
void disable_ext_intr(void);
void enable_ext_intr(void);

void enable_timer_intr(void);
void disable_timer_intr(void);

void delay_10us(void);

#endif /* _CRT0_H */