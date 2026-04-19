TARGET = air-vmm
SUBDIRS = core
ENTITLEMENTS = entitlements.plist

CC = clang
INC = -I./include
CFLAGS = $(INC) -Wall -Wextra -O2
LDFLAGS = -framework Hypervisor

SRCS = $(foreach dir,$(SUBDIRS),$(wildcard $(dir)/*.c))
OBJS = $(SRCS:%.c=build/%.o)

all: $(TARGET)

$(TARGET): $(OBJS)
	$(CC) $(OBJS) $(LDFLAGS) -o $(TARGET)
	codesign -s - --entitlements $(ENTITLEMENTS) $(TARGET)

build/%.o: %.c | build_dir
	@mkdir -p $(dir $@)
	$(CC) $(CFLAGS) -c $< -o $@

build_dir:
	@mkdir -p build

run: all
	./$(TARGET)

clean:
	rm -rf build $(TARGET)

.PHONY: all run clean build_dir
