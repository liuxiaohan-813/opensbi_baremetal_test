# 源文件和输出目录
SRCS    := entry.s sbi.c main.c
OBJS    := $(SRCS:.c=.o)
OBJS    := $(OBJS:.s=.o)
TARGET  := helloworld.elf

# 编译和链接选项
CFLAGS  += -nostdlib -Wall -Os -fno-builtin
LDFLAGS += -Tlink.ld -nostdlib -static

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
