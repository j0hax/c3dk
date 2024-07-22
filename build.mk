PROG        ?= firmware
SDK         ?= $(realpath $(dir $(lastword $(MAKEFILE_LIST)))/..)
CFLAGS      ?= -W -Wall -Wextra -Werror -Wundef -Wshadow -pedantic \
               -Wdouble-promotion -fno-common -Wconversion \
               -march=rv32imc_zicsr -mabi=ilp32 \
               -Os -ffunction-sections -fdata-sections \
               -I. -I$(SDK)/ $(EXTRA_CFLAGS)
LINKFLAGS   ?= -T$(SDK)/link.ld -nostdlib -nostartfiles -Wl,--gc-sections $(EXTRA_LINKFLAGS)
CWD         ?= $(realpath $(CURDIR))
DOCKER_CMD  ?= podman
DOCKER_TAG  ?= c3dk
DOCKER      ?= $(DOCKER_CMD) run -it --rm -v $(CWD):$(CWD) -v $(SDK):$(SDK) -w $(CWD) $(DOCKER_TAG)
TOOLCHAIN   ?= $(DOCKER) riscv-none-elf
SRCS        ?= $(SDK)/boot.c $(SOURCES)

buildimage:
	$(DOCKER_CMD) build -t $(DOCKER_TAG) $(SDK)

build: buildimage $(PROG).elf

$(PROG).elf: $(SRCS)
	$(TOOLCHAIN)-gcc  $(CFLAGS) $(SRCS) $(LINKFLAGS) -o $@

clean:
	@rm -rf *.{bin,elf,map,lst,tgz,zip,hex} $(PROG)*
	$(DOCKER_CMD) rmi -i $(DOCKER_TAG)
