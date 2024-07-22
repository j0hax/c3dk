MEMORY {
  iache  (rwx)  : ORIGIN = 0X4037c000, LENGTH = 16k
  iram   (rwx)  : ORIGIN = 0x40380400, LENGTH = 32k 
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

PROVIDE(memset = 0x40000354);
PROVIDE(memcpy = 0x40000358);
PROVIDE(memmove = 0x4000035c);
PROVIDE(memcmp = 0x40000360);
PROVIDE(strcpy = 0x40000364);
PROVIDE(strncpy = 0x40000368);
PROVIDE(strcmp = 0x4000036c);
PROVIDE(strncmp = 0x40000370);
PROVIDE(strlen = 0x40000374);
PROVIDE(strstr = 0x40000378);
PROVIDE(bzero = 0x4000037c);
PROVIDE(isalnum = 0x40000388);
PROVIDE(isalpha = 0x4000038c);
PROVIDE(isascii = 0x40000390);
PROVIDE(isblank = 0x40000394);
PROVIDE(iscntrl = 0x40000398);
PROVIDE(isdigit = 0x4000039c);
PROVIDE(islower = 0x400003a0);
PROVIDE(isgraph = 0x400003a4);
PROVIDE(isprint = 0x400003a8);
PROVIDE(ispunct = 0x400003ac);
PROVIDE(isspace = 0x400003b0);
PROVIDE(isupper = 0x400003b4);
PROVIDE(toupper = 0x400003b8);
PROVIDE(tolower = 0x400003bc);
PROVIDE(toascii = 0x400003c0);
PROVIDE(memccpy = 0x400003c4);
PROVIDE(memchr = 0x400003c8);
PROVIDE(memrchr = 0x400003cc);
PROVIDE(strcasecmp = 0x400003d0);
PROVIDE(strcasestr = 0x400003d4);
PROVIDE(strcat = 0x400003d8);
PROVIDE(strdup = 0x400003dc);
PROVIDE(strchr = 0x400003e0);
PROVIDE(strcspn = 0x400003e4);
PROVIDE(strcoll = 0x400003e8);
PROVIDE(strlcat = 0x400003ec);
PROVIDE(strlcpy = 0x400003f0);
PROVIDE(strlwr = 0x400003f4);
PROVIDE(strncasecmp = 0x400003f8);
PROVIDE(strncat = 0x400003fc);
PROVIDE(strndup = 0x40000400);
PROVIDE(strnlen = 0x40000404);
PROVIDE(strrchr = 0x40000408);
PROVIDE(strsep = 0x4000040c);
PROVIDE(strspn = 0x40000410);
PROVIDE(strtok_r = 0x40000414);
PROVIDE(strupr = 0x40000418);
PROVIDE(longjmp = 0x4000041c);
PROVIDE(setjmp = 0x40000420);
PROVIDE(abs = 0x40000424);
PROVIDE(div = 0x40000428);
PROVIDE(labs = 0x4000042c);
PROVIDE(ldiv = 0x40000430);
PROVIDE(qsort = 0x40000434);
PROVIDE(rand_r = 0x40000438);
PROVIDE(rand = 0x4000043c);
PROVIDE(srand = 0x40000440);
PROVIDE(utoa = 0x40000444);
PROVIDE(itoa = 0x40000448);
PROVIDE(atoi = 0x4000044c);
PROVIDE(atol = 0x40000450);
PROVIDE(strtol = 0x40000454);
PROVIDE(strtoul = 0x40000458);
PROVIDE(printf = 0x40000040); 
PROVIDE(__udivdi3 = 0x400008ac);
PROVIDE(__umoddi3 = 0x400008bc);

/*
PROVIDE(__sprint_r = 0x40000480);
PROVIDE(_fiprintf_r = 0x40000484);
PROVIDE(_fprintf_r = 0x40000488);
PROVIDE(_printf_common = 0x4000048c);
PROVIDE(_printf_i = 0x40000490);
PROVIDE(_vfiprintf_r = 0x40000494);
PROVIDE(_vfprintf_r = 0x40000498);
PROVIDE(fiprintf = 0x4000049c);
PROVIDE(fprintf = 0x400004a0);
PROVIDE(XXXprintf = 0x400004a4);
PROVIDE(vfiprintf = 0x400004a8);
PROVIDE(vfprintf = 0x400004ac);
*/
PROVIDE(uart_tx_one_char = 0x40000068);
PROVIDE(uart_tx_one_char2 = 0x4000006c);
PROVIDE(uart_rx_one_char = 0x40000070);
PROVIDE(uart_rx_one_char_block = 0x40000074);
PROVIDE(uart_rx_readbuff = 0x40000078);

/* GCC coroutine functions */
__absvdi2 = 0x40000764;
__absvsi2 = 0x40000768;
__adddf3 = 0x4000076c;
__addsf3 = 0x40000770;
__addvdi3 = 0x40000774;
__addvsi3 = 0x40000778;
__ashldi3 = 0x4000077c;
__ashrdi3 = 0x40000780;
__bswapdi2 = 0x40000784;
__bswapsi2 = 0x40000788;
__clear_cache = 0x4000078c;
__clrsbdi2 = 0x40000790;
__clrsbsi2 = 0x40000794;
__clzdi2 = 0x40000798;
__clzsi2 = 0x4000079c;
__cmpdi2 = 0x400007a0;
__ctzdi2 = 0x400007a4;
__ctzsi2 = 0x400007a8;
__divdc3 = 0x400007ac;
__divdf3 = 0x400007b0;
__divdi3 = 0x400007b4;
__divsc3 = 0x400007b8;
__divsf3 = 0x400007bc;
__divsi3 = 0x400007c0;
__eqdf2 = 0x400007c4;
__eqsf2 = 0x400007c8;
__extendsfdf2 = 0x400007cc;
__ffsdi2 = 0x400007d0;
__ffssi2 = 0x400007d4;
__fixdfdi = 0x400007d8;
__fixdfsi = 0x400007dc;
__fixsfdi = 0x400007e0;
__fixsfsi = 0x400007e4;
__fixunsdfsi = 0x400007e8;
__fixunssfdi = 0x400007ec;
__fixunssfsi = 0x400007f0;
__floatdidf = 0x400007f4;
__floatdisf = 0x400007f8;
__floatsidf = 0x400007fc;
__floatsisf = 0x40000800;
__floatundidf = 0x40000804;
__floatundisf = 0x40000808;
__floatunsidf = 0x4000080c;
__floatunsisf = 0x40000810;
__gcc_bcmp = 0x40000814;
__gedf2 = 0x40000818;
__gesf2 = 0x4000081c;
__gtdf2 = 0x40000820;
__gtsf2 = 0x40000824;
__ledf2 = 0x40000828;
__lesf2 = 0x4000082c;
__lshrdi3 = 0x40000830;
__ltdf2 = 0x40000834;
__ltsf2 = 0x40000838;
__moddi3 = 0x4000083c;
__modsi3 = 0x40000840;
__muldc3 = 0x40000844;
__muldf3 = 0x40000848;
__muldi3 = 0x4000084c;
__mulsc3 = 0x40000850;
__mulsf3 = 0x40000854;
__mulsi3 = 0x40000858;
__mulvdi3 = 0x4000085c;
__mulvsi3 = 0x40000860;
__nedf2 = 0x40000864;
__negdf2 = 0x40000868;
__negdi2 = 0x4000086c;
__negsf2 = 0x40000870;
__negvdi2 = 0x40000874;
__negvsi2 = 0x40000878;
__nesf2 = 0x4000087c;
__paritysi2 = 0x40000880;
__popcountdi2 = 0x40000884;
__popcountsi2 = 0x40000888;
__powidf2 = 0x4000088c;
__powisf2 = 0x40000890;
__subdf3 = 0x40000894;
__subsf3 = 0x40000898;
__subvdi3 = 0x4000089c;
__subvsi3 = 0x400008a0;
__truncdfsf2 = 0x400008a4;
__ucmpdi2 = 0x400008a8;
__udivdi3 = 0x400008ac;
__udivmoddi4 = 0x400008b0;
__udivsi3 = 0x400008b4;
__udiv_w_sdiv = 0x400008b8;
__umoddi3 = 0x400008bc;
__umodsi3 = 0x400008c0;
__unorddf2 = 0x400008c4;
__unordsf2 = 0x400008c8;

/*__errno = 0x40000670;*/
