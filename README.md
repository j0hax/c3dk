# c3dk

A bare metal, single header make-based SDK for the ESP32-C3 chip.

This code was adapted from [cpq/mdk](https://github.com/cpq/mdk/tree/e2c1d4e4bd9b152dfa32b48a7c0ae5f5a8b8276d) and extended to be used in my bachelor's thesis "[On the Power Estimation of a RISC-V Platform using Performance Monitoring Counters and RTOS Events](https://www.sra.uni-hannover.de/Theses/2024/BA-AHA-energy-pmc.html)."

## File overview

c3dk consists of the following files:

- **link.ld:** linker script file, allows registers to be memory mapped.
- **boot.c:** simple startup code. Sets up a stack, calls `main()`
- **c3dk.h:** primary header that implements API
- **build.mk:** helper Makefile for building projects

## Installation & Usage

A Linux System with Podman or Docker is required.

To build software, create a `Makefile` with at least the following contents:
```makefile
SOURCES = main.c, other.c
SDK = /path/to/c3dk
include $(SDK)/build.mk
```

### Toolchain

c3dk builds images in a custom Debian container which contains a GCC multilib toolchain[^tc] tailored specifically to the ESP32-C3's application binary interface (ABI), allowing, for example, for complete softfloat and `math.h` support.

The toolchain resides in `/opt` in conjunction with the `newlib` C library.

> [!NOTE]
> The initial local build may take considerable time and disk space, but will be efficiently cached thanks to multi-stage builds.
> 
> A pre-built container on GitHub is hosted via `ghcr.io/j0hax/c3dk:nightly`. 

## Differences from MDK

I am very appreciative of the hard work that has been done in MDK. The project has, however, seen little maintenance over the past two years. I have opened some Pull Requests without response, prompting me to hard-fork and rebrand the project. Some notable differences include that:

- This fork focusses on the ESP32-C3 exclusively.
- [cpq/esputil](https://github.com/cpq/esputil/tree/master) is *not* used: The utility did not support flashing over JTAG, and the images built did not have headers adapted to the ESP32-C3. As a result, I recommend using ESP's official [esptool](https://github.com/espressif/esptool).
- Extended API
- Extended linker script

Aside from changed variable names, the project should mostly be backward-compatible with MDK. Windows and macOS support is untested.

[^tc]: The ESP32-C3 needs a `rv32imc_zicsr/ilp32` multilib, a combination which is not built in most GCC RISC-V distributions as of August 2024.
