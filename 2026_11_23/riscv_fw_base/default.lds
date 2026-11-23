/* Almost the same as the default linker script, it only does not use the local data memory 
   because it is too small for normal tests */
/*
OUTPUT_FORMAT("elf32-littleriscv", "elf32-littleriscv",
          "elf32-littleriscv")
OUTPUT_ARCH(riscv)
ENTRY(_start)
SEARCH_DIR("/riscv-gcc32/riscv32-unknown-elf/lib");
OUTPUT_FORMAT ("elf32-littleriscv")
OUTPUT_FORMAT ("elf32-codasip-le", "elf64-codasip-be", "elf64-codasip-le")
*/

OUTPUT_FORMAT ("elf32-codasip-le", "elf64-codasip-be", "elf64-codasip-le")


MEMORY
{
    /*imem ： org = 0x1000, len = (0x1000 + 8_0000) = 4K + 512K = 516 K */
    imem : org = 4096, len = 128K 
    /* CPU DMEM stays 128K; only the first 16K initial values live in Flash. */
    dmem : org = (2147483648 - 524288), len = 128K
    smem : org = 2147483648, len = 65536
}

ENTRY (_start)


_TEXT_START_ADDR = DEFINED(_TEXT_START_ADDR) ? _TEXT_START_ADDR : 4096;
_HEAP_SIZE = DEFINED(_HEAP_SIZE) ? _HEAP_SIZE : 0x0;
_STACK_SIZE = DEFINED(_STACK_SIZE) ? _STACK_SIZE : 0x2000;


SECTIONS
{

/* CODE - as_all (default) */

  .text _TEXT_START_ADDR : {
    _ftext = .;
    KEEP (*(SORT(.crt*)))
    *(.text)
    *(.text.*)
    *($.text)
    *($.text.*)
    *(.gnu.linkonce.t.*)
    *(.text_jump_padding)
    _etext = .;
  } >imem
  .init_location : { } >imem
  . = ADDR(.init_location);
  .init ALIGN(4) : {
    KEEP (*(.init))
  } >imem =0
  .fini_location : { } >imem
  .fini ALIGN(4) : {
    KEEP (*(.fini))
  } >imem =0
  .rodata_location : { } >imem
  . = ADDR(.rodata_location);
  .rodata ALIGN(4) : {
    _frodata = .;
    *(.rodata)
    *(.rodata.*)
    *(.gnu.linkonce.r.*)
    _erodata = .;
  } >imem

/* DATA - as_all (default) */

  .ctors_location : { } >dmem
  . = ADDR(.ctors_location);
  .ctors ALIGN(4) : {
    PROVIDE (__CTOR_LIST__ = .);
    PROVIDE (___CTOR_LIST__ = .);
    KEEP (*(SORT(.ctors.*)))
    KEEP (*(.ctors))
    PROVIDE (__CTOR_END__ = .);
    PROVIDE (___CTOR_END__ = .);
  } >dmem
  .dtors_location : { } >dmem
  . = ADDR(.dtors_location);
  .dtors ALIGN(4) : {
    PROVIDE (__DTOR_LIST__ = .);
    PROVIDE (___DTOR_LIST__ = .);
    KEEP (*(SORT(.dtors.*)))
    KEEP (*(.dtors))
    PROVIDE (__DTOR_END__ = .);
    PROVIDE (___DTOR_END__ = .);
  } >dmem
  .data_location : { } >dmem
  . = ADDR(.data_location);
  .data ALIGN(4) : {
    _fdata = .;
    *(.data)
    *(.data.*)
    *(.gnu.linkonce.d.*)
  } >dmem
  .sdata_location : { } >dmem
  . = ADDR(.sdata_location);
  .sdata ALIGN(4) : {
    *(.sdata)
    *(.sdata.*)
    *(.gnu.linkonce.s.*)
    _edata = .;
  } >dmem
  ASSERT(_edata <= ORIGIN(dmem) + 16K, "DMEM initial values exceed 16 KiB Flash image")
  .sbss_location : { } >dmem
  . = ADDR(.sbss_location);
  .sbss ALIGN(4) : {
    PROVIDE (__sbss_start = .);
    *(.sbss)
    *(.sbss.*)
    *(.gnu.linkonce.sb.*)
    PROVIDE (__sbss_end = .);
  } >dmem
  .bss_location : { } >dmem
  . = ADDR(.bss_location);
  .bss ALIGN(4) : {
    PROVIDE (__bss_start = .);
    *(.bss)
    *(.bss.*)
    *(.gnu.linkonce.b.*)
    *(COMMON)
    . = ALIGN(4);
    PROVIDE (__bss_end = .);
  } >dmem
  .heap_location : { } >dmem
  . = ADDR(.heap_location);
  .heap ALIGN(4) : {
    _heap = .;
    _heap_start = .;
    . += _HEAP_SIZE;
    _heap_end = .;
  } >dmem
  .stack_location : { } >dmem
  . = ADDR(.stack_location);
  .stack ALIGN(8) : {
    _stack_end = .;
    . += _STACK_SIZE;
    . = ALIGN(8);
    _stack = .;
    _end = .;
  } >dmem
}
