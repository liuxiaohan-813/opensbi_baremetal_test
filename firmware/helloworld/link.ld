OUTPUT_ARCH( "riscv" )
OUTPUT_FORMAT("elf64-littleriscv")
ENTRY( _start )
SECTIONS
{
  /* stratup addr */
  . = 0x80200000;
  PROVIDE(start = .);

  .text : {
    *(.text.unlikely .text.unlikely.*)
    *(.text.startup .text.startup.*)
    *(.text .text.*)
    . = ALIGN(4);
  }

  .data : {
    *(.rdata)
    *(.rodata .rodata.*)
    *(.data .data.*)
    . = ALIGN(4);
  }

  .bss : {
    *(.sbss*)
    *(.bss .bss.*)
    . = ALIGN(4);
  }

  PROVIDE(end = .);

  PROVIDE(__STACK_SIZE = 2K);
  PROVIDE(__HEAP_SIZE = 2K);

  .heap : {
    . = ALIGN(16);
    PROVIDE( __heap_start = . );
    . += __HEAP_SIZE;
    . = ALIGN(16);
    PROVIDE( __heap_end = . );
  }

  .stack : {
    . = ALIGN(16);
    PROVIDE( __StackBottom = . );
    . += (__HEAP_SIZE+__STACK_SIZE);
    . = ALIGN(16);
    PROVIDE( _sp = . );
  }
}
