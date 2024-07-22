# c3dk

A bare metal, single header make-based SDK for the ESP32-C3 chip.

This code was adapted from [cpq/MDK](https://github.com/cpq/mdk/tree/e2c1d4e4bd9b152dfa32b48a7c0ae5f5a8b8276d) and extebded to be used in the bachelor's thesis "[On the Power Estimation of a RISC-V Platform using Performance Monitoring Counters and RTOS Events](https://www.sra.uni-hannover.de/Theses/2024/BA-AHA-energy-pmc.html)."

The file structure is as follows:

link.ld
: linker script file
: allows registers to be memory mapped.

boot.c
: simple startup code
: sets up a stack
: calls `main()`

c3dk.h
: primary header that implements API

build.mk
: helper Makefile for building projects

## Toolchain

c3dk builds images in an Alpine Linux container. The toolchain in use is `gcc-riscv-none-elf` in conjunction with the `newlib` C library.

## Differences from MDK

I am very appreciative of the hard work that has been done in MDK. The project has, however, seen little maintenance over the past two years. I have opened some Pull Requests without response, prompting me to hard-fork and rebrand the project. Some notable differences include that:

- This fork focusses on the ESP32-C3 exclusively.
- [cpq/esputil](https://github.com/cpq/esputil/tree/master) is *not* used: The utility did not support flashing over JTAG, and the images built did not have headers adapted to the ESP32-C3. As a result, I recommend using ESP's official [esptool](https://github.com/espressif/esptool).
- Extended API
- Extended linker script

Aside from changed variable names, the project should mostly be backward-compatible with MDK. Windows and macOS support is untested.
