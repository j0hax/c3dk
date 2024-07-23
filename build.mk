# Variables
PROG        ?= firmware
SDK         ?= $(realpath $(dir $(lastword $(MAKEFILE_LIST)))/..)
CWD         ?= $(realpath $(CURDIR))
DOCKER_CMD  ?= podman
DOCKER_TAG  ?= c3dk
DOCKER      ?= $(DOCKER_CMD) run -it --rm -v $(CWD):$(CWD) -v $(SDK):$(SDK) \
               -w $(CWD) $(DOCKER_TAG)
TOOLCHAIN   ?= $(DOCKER) riscv-none-elf
SRCS        ?= $(SDK)/src/boot.c $(SOURCES)
CFLAGS      ?= -W -Wall -Wextra -Werror -Wundef -Wshadow -pedantic \
               -Wdouble-promotion -fno-common -Wconversion -std=gnu17 \
               -fno-builtin -march=rv32imc_zicsr -mabi=ilp32 -O2 \
               -ffunction-sections -fdata-sections -I. -I$(SDK)/src/ \
               $(EXTRA_CFLAGS)
LINKFLAGS   ?= -T$(SDK)/src/link.ld -nostdlib -nostartfiles \
               -Wl,--gc-sections $(EXTRA_LINKFLAGS)
ESPTOOL     ?= esptool.py
PORT        ?= /dev/ttyACM0
BAUD        ?= 460800
FLASH_ADDR  ?= 0x0

# Default target
.PHONY: all
all: build

# Build Docker image
.PHONY: buildimage
buildimage:
	$(DOCKER_CMD) build -t $(DOCKER_TAG) $(SDK)

# Build the project
.PHONY: build
build: buildimage $(PROG).elf

# Link the final executable
$(PROG).elf: $(SRCS)
	@mkdir -p build
	$(TOOLCHAIN)-gcc $(CFLAGS) $(SRCS) $(LINKFLAGS) -o build/$@

# Generate ESP32-C3 image
.PHONY: image
image: $(PROG).elf
	$(ESPTOOL) --chip esp32c3 elf2image -o build/$(PROG).bin \
		build/$(PROG).elf

# Flash the image to ESP32-C3
.PHONY: flash
flash: image
	$(ESPTOOL) --port $(PORT) --baud $(BAUD) write_flash $(FLASH_ADDR) \
		build/$(PROG).bin

# Clean the project
.PHONY: clean
clean:
	@rm -rf *.{bin,elf,map,lst,tgz,zip,hex} $(PROG)*
	@rm -rf build
	$(DOCKER_CMD) rmi -i $(DOCKER_TAG)

