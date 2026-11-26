#ifndef _REG_ACC_H
#define _REG_ACC_H

//void reg_write(u16 addr, u8 dat);
//u8 reg_read(u16 addr);

#define reg_write(a, d) do {*(volatile unsigned char *)((unsigned int)(a)) = (d);} while (0)
//#define reg_read(a) (*(volatile unsigned char *)((unsigned int)(a)))

inline static unsigned char reg_read(unsigned long a)
{
    unsigned char ret;
    
    ret = (*(volatile unsigned char *)(a));
    asm volatile (" nop; ");    // current register read don't support pipiline operation, it must add NOP after register read
    asm volatile (" nop; "); 
    return ret;
}

//#define reg_bit_clr(a, bm) do {(*(volatile unsigned char *)(a)) = (*(volatile unsigned char *)(a)) & ~bm;} while (0)
//#define reg_bit_set(a, bm) do {(*(volatile unsigned char *)(a)) = (*(volatile unsigned char *)(a)) | bm;} while (0)

#define reg_write_align32(a, d) do {*(volatile unsigned char *)((unsigned int)(a)<<2) = (d);} while (0)
//#define reg_read_align32(a) (*(volatile unsigned char *)((a)<<2))

inline static unsigned char reg_read_align32(unsigned long a)
{
    unsigned char ret;
    
    ret = (*(volatile unsigned char *)((a)<<2));
    asm volatile (" nop; ");    // current register read don't support pipiline operation, it must add NOP after register read
    asm volatile (" nop; "); 
    return ret;
}

#endif
