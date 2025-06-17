# 工具链配置
COMPILE_PREFIX ?= riscv64-unknown-linux-gnu-
CC      := $(COMPILE_PREFIX)gcc
LD      := $(COMPILE_PREFIX)ld
OBJDUMP := $(COMPILE_PREFIX)objdump
OBJCOPY := $(COMPILE_PREFIX)objcopy
GDB     := $(COMPILE_PREFIX)gdb
SIZE    := $(COMPILE_PREFIX)size
QEMU    := qemu-system-riscv64

# 源文件和输出目录
SRCS    := entry.s main.c
OBJS    := $(SRCS:.c=.o)
OBJS    := $(OBJS:.s=.o)
TARGET  := hello.elf
SBI_ROOT:= ../opensbi
FW_JUMP := $(SBI_ROOT)/build/platform/generic/firmware/fw_jump.elf

# 编译和链接选项
CFLAGS  += -nostdlib -Wall -Os -fno-builtin
LDFLAGS += -Tlink.ld -nostdlib -static

# QEMU 参数
QEMU_FLAGS := -M virt -m 256M -nographic
QEMU_BIOS  := -bios $(FW_JUMP)
QEMU_KERNEL:= -kernel $(TARGET)

# 定义所有目标
.PHONY: all clean

all: $(TARGET)

# 编译规则
%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

%.o: %.s
	$(CC) $(CFLAGS) -c $< -o $@

# 链接规则
$(TARGET): $(OBJS)
	$(LD) $(LDFLAGS) -o $@ $^
	$(SIZE) $@

# 清理规则
clean:
	rm -f $(OBJS) $(TARGET)

# 调试目标
disasm: $(TARGET)
	$(OBJDUMP) -D $(TARGET) > $(TARGET:.elf=.dis)

objdump: $(TARGET)
	$(OBJDUMP) -x $(TARGET)

size: $(TARGET)
	$(SIZE) $(TARGET)

# 运行 QEMU
run: $(TARGET) check_firmware
	$(QEMU) $(QEMU_FLAGS) $(QEMU_BIOS) $(QEMU_KERNEL)

# 检查固件是否存在
check_firmware:
	@test -f $(FW_JUMP) || { \
		echo "Error: OpenSBI firmware not found at $(FW_JUMP)"; \
		echo "Run 'make opensbi to gen $(FW_JUMP)' first"; \
		exit 1; \
	}
