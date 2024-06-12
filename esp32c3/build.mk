PROG        ?= firmware
ARCH        ?= esp32c3
MDK         ?= $(realpath $(dir $(lastword $(MAKEFILE_LIST)))/..)
ESPUTIL     ?= $(MDK)/esputil/esputil
CFLAGS      ?= -W -Wall -Wextra -Werror -Wundef -Wshadow -pedantic \
               -Wdouble-promotion -fno-common -Wconversion \
               -march=rv32imc_zicsr -mabi=ilp32 \
               -Os -ffunction-sections -fdata-sections \
               -I. -I$(MDK)/$(ARCH) $(EXTRA_CFLAGS)
LINKFLAGS   ?= -T$(MDK)/$(ARCH)/link.ld -nostdlib -nostartfiles -Wl,--gc-sections $(EXTRA_LINKFLAGS)
CWD         ?= $(realpath $(CURDIR))
FLASH_ADDR  ?= 0  # 2nd stage bootloader flash offset
DOCKER_CMD  ?= docker
DOCKER_TAG  ?= mdk
DOCKER      ?= $(DOCKER_CMD) run -it --rm -v $(CWD):$(CWD) -v $(MDK):$(MDK) -w $(CWD) $(DOCKER_TAG)
TOOLCHAIN   ?= $(DOCKER) riscv-none-elf
SRCS        ?= $(MDK)/$(ARCH)/boot.c $(SOURCES)

buildimage:
	$(DOCKER_CMD) build -t $(DOCKER_TAG) $(MDK)/esp32c3/

build: buildimage $(PROG).bin

$(PROG).elf: $(SRCS)
	$(TOOLCHAIN)-gcc  $(CFLAGS) $(SRCS) $(LINKFLAGS) -o $@
#	$(TOOLCHAIN)-size $@

$(PROG).bin: $(PROG).elf $(ESPUTIL)
	$(ESPUTIL) mkbin $(PROG).elf $@

flash: $(PROG).bin $(ESPUTIL)
	$(ESPUTIL) flash $(FLASH_ADDR) $(PROG).bin

monitor: $(ESPUTIL)
	$(ESPUTIL) monitor

$(MDK)/esputil/esputil.c:
	git submodule update --init --recursive

$(ESPUTIL): $(MDK)/esputil/esputil.c
	make -C $(MDK)/esputil esputil

clean:
	@rm -rf *.{bin,elf,map,lst,tgz,zip,hex} $(PROG)*
	$(DOCKER_CMD) rmi -i $(DOCKER_TAG)
