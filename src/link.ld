MEMORY {
  iache  (rwx)  : ORIGIN = 0X4037c000, LENGTH = 16k
  iram   (rwx)  : ORIGIN = 0x40380400, LENGTH = 64k
  dram   (rw)   : ORIGIN = 0x3fc80000 + LENGTH(iram), LENGTH = 128k
}

_eram = ORIGIN(dram) + LENGTH(dram);
ENTRY(_reset)

SECTIONS {
  .text     : { *(.text) *(.text*) } > iram

  .data : {
    . = ALIGN(16);
    _sdata = .;
    *(.data)
    *(.data*)
    *(.sdata)
    *(.sdata*)
    *(.srodata)
    *(.srodata*)
    *(.rodata)
    *(.rodata*)
    *(.gnu.linkonce.r.*)
    *(.rodata1)
    *(.riscv.*)
    . = ALIGN(16);
    _edata = .;
  } > dram

  .bss (NOLOAD): {
    . = ALIGN(16);
    _sbss = .;
    *(.bss)
    *(.bss*)
    *(.sbss)
    *(.sbss*)
    *(COMMON)
    . = ALIGN(16);
    _ebss = .;
  } > dram

  . = ALIGN(16);
  PROVIDE(end = .);
  PROVIDE(_end = .);
}
