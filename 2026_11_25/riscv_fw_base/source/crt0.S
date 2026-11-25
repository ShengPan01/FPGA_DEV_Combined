#=========================================================================
# crt0.S : Entry point for RISC-V user programs
#=========================================================================

  .text
  .global _start
  .global enable_ext_intr
  .global disable_ext_intr
  .global enable_timer_intr
  .global disable_timer_intr
  .global dead_loop
  .global restart
  .global delay_10us
_start:
    j _reset_handler # 0x1000 - reset vector
    j _nmi_handler   # 0x1004 - NMI
_nmi_handler:
    ebreak

_trap_handler:
    add sp, sp, -120
    sw ra, 0(sp)
    sw gp, 4(sp)
    sw tp, 8(sp)
    sw t0, 12(sp)
    sw t1, 16(sp)
    sw t2, 20(sp)
    sw t3, 24(sp)
    sw t4, 28(sp)
    sw t5, 32(sp)
    sw t6, 36(sp)
    sw a0, 40(sp)
    sw a1, 44(sp)
    sw a2, 48(sp)
    sw a3, 52(sp)
    sw a4, 56(sp)
    sw a5, 60(sp)
    sw a6, 64(sp)
    sw a7, 68(sp)
    sw s0, 72(sp)
    sw s1, 76(sp)
    sw s2, 80(sp)
    sw s3, 84(sp)
    sw s4, 88(sp)
    sw s5, 92(sp)
    sw s6, 96(sp)
    sw s7, 100(sp)
    sw s8, 104(sp)
    sw s9, 108(sp)
    sw s10, 112(sp)
    sw s11, 116(sp)

  _check_interrupt0:
    csrr a0, mcause
    li t1, 0x80000007
    bne a0, t1, _check_interrupt1
    call mtime_isr
    j _end_of_trap

  _check_interrupt1:
    #csrr a0, mcause
    li t1, 0x8000000b
    bne a0, t1, _unknown_exception
    call external_interrupt
    j _end_of_trap
    
_unknown_exception:
    csrr a1, mtval
    mv a2, ra
    call exception_handler
_end_of_trap:
    lw s11, 116(sp)
    lw s10, 112(sp)
    lw s9, 108(sp)
    lw s8, 104(sp)
    lw s7, 100(sp)
    lw s6, 96(sp)
    lw s5, 92(sp)
    lw s4, 88(sp)
    lw s3, 84(sp)
    lw s2, 80(sp)
    lw s1, 76(sp)
    lw s0, 72(sp)
    lw a7, 68(sp)
    lw a6, 64(sp)
    lw a5, 60(sp)
    lw a4, 56(sp)
    lw a3, 52(sp)
    lw a2, 48(sp)
    lw a1, 44(sp)
    lw a0, 40(sp)
    lw t6, 36(sp)
    lw t5, 32(sp)
    lw t4, 28(sp)
    lw t3, 24(sp)
    lw t2, 20(sp)
    lw t1, 16(sp)
    lw t0, 12(sp)
    sw tp, 8(sp)
    sw gp, 4(sp)
    lw ra, 0(sp)
    add sp, sp, 120

    mret

enable_ext_intr:
    csrr t0, mie
    li t1, 0x800
    or t0, t0, t1        # set MEIE
    csrw mie, t0
    ret

enable_timer_intr:
    csrr t0, mie
    li t1, 0x080
    or t0, t0, t1        # set MTIE
    csrw mie, t0
    ret

disable_ext_intr:
    csrr t0, mie
    li t1, 0xfffff7ff
    and t0, t0, t1        # clear MEIE
    csrw mie, t0
    ret

disable_timer_intr:
    csrr t0, mie
    li t1, 0xffffff7f
    and t0, t0, t1        # clear MEIE
    csrw mie, t0
    ret

_reset_handler:
    # Initial stack pointer
    la sp, _stack

    # set trap vector
    la t0, _trap_handler
    csrw mtvec, t0

    # enable external interrupt
    csrr t0, mstatus
    ori t0, t0, 0x8     
    csrw mstatus, t0    # set MIE
    call enable_ext_intr

    # Clear the bss segment
    la      a0, _edata
    la      a2, _end
    sub     a2, a2, a0
    li      a1, 0
    call    memset

    call    main
dead_loop:
    nop
    nop
    nop
    nop
    nop
    nop
    j dead_loop
    #tail    exit

restart:
    j _start

delay_10us:
    li t0, 131
_delay_us_0:
    addi t0, t0, -1
    bnez t0, _delay_us_0
    ret

  .global _init
  .global _fini
_init:
_fini:
  # These don't have to do anything since we use init_array/fini_array.
  ret
