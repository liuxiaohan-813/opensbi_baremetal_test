# toolchain
CROSS_COMPILE ?= riscv64-unknown-linux-gnu-
CC      := $(CROSS_COMPILE)gcc
LD      := $(CROSS_COMPILE)ld
OBJDUMP := $(CROSS_COMPILE)objdump
OBJCOPY := $(CROSS_COMPILE)objcopy
GDB     := $(CROSS_COMPILE)gdb
SIZE    := $(CROSS_COMPILE)size

export CC LD OBJDUMP OBJCOPY GDB SIZE

# dir
TARGET		  ?= helloworld
FW_NEXT		  := firmware/$(TARGET)
OPENSBI  	  := opensbi

# QEMU
QEMU    := qemu-system-riscv64
PLATFORM      ?= generic
RISCV_XLEN    ?= 64
FW_TEXT_START ?= 0x80000000
QEMU_FLAGS    := -M virt -m 256M -nographic
QEMU_CMD      = $(QEMU) $(QEMU_FLAGS) -bios $(FW_JUMP) -kernel $(FW_NEXT)/$(TARGET).elf

# fw_jump path
FW_JUMP       = $(OPENSBI)/build/platform/$(PLATFORM)/firmware/fw_jump.elf

.PHONY: all opensbi firmware run clean distclean

all: firmware opensbi

# build opensbi
opensbi:
	$(MAKE) -C $(OPENSBI) \
		PLATFORM=$(PLATFORM) \
		CROSS_COMPILE=$(CROSS_COMPILE) \
		FW_TEXT_START=$(FW_TEXT_START)	\
		PLATFORM_RISCV_XLEN=$(RISCV_XLEN) \
		all

# build firmware
firmware: $(FW_NEXT)
	$(MAKE) -C $(FW_NEXT) all

# check opensbi is build or not
check_opensbi:
	@test -f $(FW_JUMP) || { \
		echo "Error: OpenSBI firmware not found at $(FW_JUMP)"; \
		echo "Run 'make opensbi' first"; \
		exit 1; \
	}

# run QEMU
run_qemu: $(FW_NEXT)
	$(QEMU_CMD)

# clean target
clean:
	$(MAKE) -C $(FW_NEXT) clean
	$(MAKE) -C $(OPENSBI) \
		PLATFORM=$(PLATFORM) \
		CROSS_COMPILE=$(CROSS_COMPILE) \
		FW_TEXT_START=$(FW_TEXT_START)	\
		PLATFORM_RISCV_XLEN=$(RISCV_XLEN) \
		clean

# clean all
distclean: clean
	$(MAKE) -C $(OPENSBI) \
		PLATFORM=$(PLATFORM) \
		CROSS_COMPILE=$(CROSS_COMPILE) \
		FW_TEXT_START=$(FW_TEXT_START)	\
		PLATFORM_RISCV_XLEN=$(RISCV_XLEN) \
		distclean

# help
help:
	@echo "Build targets:"
	@echo "  opensbi    - Build OpenSBI firmware"
	@echo "  firmware   - Build your application"
	@echo "  all        - Default target (builds firmware and opensbi)"
	@echo "  run_qemu   - Run in QEMU"
	@echo "Clean targets:"
	@echo "  clean      - Clean compile file"
	@echo "  distclean  - Clean all compile file and rm opensbi/build path"
