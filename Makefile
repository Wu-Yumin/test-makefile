CROSS_COMPILE =
AS = $(CROSS_COMPILE)as
CC = $(CROSS_COMPILE)gcc
LD = $(CROSS_COMPILE)ld
AR = $(CROSS_COMPILE)ar
CPP = $(CC) -E
NM = $(CROSS_COMPILE)nm

STRIP = $(CROSS_COMPILE)strip
OBJCOPY = $(CROSS_COMPILE)objcopy
OBJDUMP = $(CROSS_COMPILE)objdump

export AS CC LD AR CPP NM
export STRIP OBJCOPY OBJDUMP

# 编译选项
CFLAGS := -Wall -O2 -g
CFLAGS += -I $(shell pwd)/include
LDFLAGS := -lpthread

export CFLAGS LDFLAGS

# 指定顶层目录，并导出
# 这是因为在递归编译过程中多次调用顶层 Makefile.build
# 所以要把顶层路径导出
TOPDIR := $(shell pwd)
export TOPDIR

# 目标文件
TARGET := test_makefile

# 顶层依赖文件
obj-y += main.o
obj-y += a.o
obj-y += sub-dir-1/
obj-y += sub-dir-2/

# 第一个规则
all:
	make -f Makefile.build
	$(CC) -o $(TARGET) built-in.o $(LDFLAGS)

# clean
clean:
	rm -f $(shell find -name '*.o')
	rm -f $(TARGET)

distclean:
	rm -f $(shell find -name '*.o')
	rm -f $(shell find -name '*.d')
	rm -f $(TARGET)
