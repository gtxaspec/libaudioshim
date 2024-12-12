CROSS_COMPILE ?=

CC = $(CROSS_COMPILE)gcc
AR = $(CROSS_COMPILE)ar

CFLAGS += -Wall -Os -fPIC
LDFLAGS_SHARED = -shared -Wl,--version-script=shim.map -Wl,--export-dynamic -fvisibility=hidden -fno-common
LDFLAGS_STATIC =
TARGET_LIB_SHARED = libaudioshim.so
TARGET_LIB_STATIC = libaudioshim.a

SRC_FILES = audioshim.c
OBJ_FILES = $(SRC_FILES:.c=.o)

.PHONY: all clean dynamic static

all: dynamic

ifeq ($(STATIC), 1)
all: static
else
all: dynamic
endif

dynamic: $(TARGET_LIB_SHARED)

static: $(TARGET_LIB_STATIC)

$(TARGET_LIB_SHARED): $(OBJ_FILES)
	$(CC) $(LDFLAGS_SHARED) -o $@ $^

$(TARGET_LIB_STATIC): $(OBJ_FILES)
	$(AR) rcs $@ $^

%.o: %.c
	$(CC) $(CFLAGS) -fPIC -c $< -o $@

clean:
	rm -f $(OBJ_FILES) $(TARGET_LIB_SHARED) $(TARGET_LIB_STATIC)
