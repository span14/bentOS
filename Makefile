OUTPUT = kernel

CFLAGS+=-Wall -fno-builtin -fno-stack-protector -nostdlib
LDFLAGS+=-nostdlib -static
CC=gcc

CPPFLAGS+=-nostdinc -g -I./include

SRC= $(wildcard src/*.S) $(wildcard src/*.c) $(wildcard src/*/*.c) $(wildcard src/*/*.S)
OBJS=src/boot/boot.o
OBJS+=$(filter-out src/boot/boot.o,$(patsubst %.S,%.o,$(filter %.S,$(SRC))))
OBJS+=$(patsubst %.c,%.o,$(filter %.c,$(SRC)))


kernel: Makefile $(OBJS)
	rm -f kernel
	$(CC) $(LDFLAGS) $(OBJS) -Ttext=0x400000 -o kernel
	sudo ./update_image.sh

dep: Makefile.dep

Makefile.dep: $(SRC)
	$(CC) -MM $(CPPFLAGS) $(SRC) > $@

.PHONY: clean
clean:
	rm -f *.o */*.o Makefile.dep

ifneq ($(MAKECMDGOALS),dep)
ifneq ($(MAKECMDGOALS),clean)
include Makefile.dep
endif
endif



