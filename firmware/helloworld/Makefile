# submodle path
TINYPRINTF 	:= tinyprintf

# source and target
SRCS    := entry.s sbi.c main.c
OBJS    := $(SRCS:.c=.o)
OBJS    := $(OBJS:.s=.o)
TARGET  := helloworld.elf

# compile and link args
CFLAGS  += -nostdlib -Wall -Os -fno-builtin -mcmodel=medany
LDFLAGS += -Tlink.ld -nostdlib -static

.PHONY: all clean

all: $(TARGET)

# rules of compile
%.o: %.c
	$(MAKE) -C $(TINYPRINTF) CFLAGS="$(filter-out -Wextra,$(CFLAGS))" compiletests
	$(CC) $(CFLAGS) -c $< -o $@

%.o: %.s
	$(CC) $(CFLAGS) -c $< -o $@

# rules of link
$(TARGET): $(OBJS) 
	$(LD) $(LDFLAGS) -o $@ $^ $(TINYPRINTF)/tinyprintf_only_tfp_printf.o
	$(SIZE) $@

# rules of clean
clean:
	$(MAKE) -C $(TINYPRINTF) clean
	rm -f $(OBJS) $(TARGET)
