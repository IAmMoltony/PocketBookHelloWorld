SRCDIR := source
INCDIR := include
OBJDIR := build
BINDIR := bin

CFILES := $(wildcard $(SRCDIR)/*.c)

ifeq ($(strip $(PLATFORM)),)
$(error Please set the PLATFORM variable)
endif

ifeq ($(strip $(SDKPATH)),)
$(error Please set the SDKPATH variable for your platform (e.g. ~/pocketbook-sdk/<SDK>))
endif

ifneq ($(strip $(PLATFORM)),Linux)
# Not Linux, checking if ARM
ifneq ($(strip $(PLATFORM)),ARM)
# Neither Linux nor ARM
$(error Please set the PLATFORM variable)
else
# ARM

ifeq ($(strip $(ARCH)),)
# Architecture not set
$(error Please set the appropriate architecture. If you are using PBSDK, set ARCH to arm-linux, if you are using FRSCSDK, set ARCH to arm-none-linux-gnueabi, if you are using SDK_481, set ARCH to arm-obreey-linux-gnueabi)
endif

ifeq ($(strip $(SDKLIBDIR)),)
# Lib dir not set
$(error Please set the SDKLIBDIR variable (see makearm.sh for more info))
endif

CC := $(SDKPATH)/bin/$(ARCH)-gcc
LD := $(CC)
PLATFORM_OBJDIR := $(OBJDIR)/arm

CFLAGS := -iquote $(INCDIR) -Wall -Wextra -c
LDFLAGS := -linkview

COBJS := $(patsubst $(SRCDIR)/%.c,$(PLATFORM_OBJDIR)/%_c.o,$(CFILES))
OBJS := $(COBJS)

LIBINKVIEW := $(SDKPATH)/$(SDKLIBDIR)/libinkview.so

APP := $(BINDIR)/arm/$(notdir $(CURDIR)).app
endif
else
# Linux

CC := gcc
LD := $(CC)
PLATFORM_OBJDIR := $(OBJDIR)/linux

CFLAGS := -iquote $(INCDIR) -isystem $(SDKPATH)/include -Wall -Wextra -m32 $(shell pkg-config --cflags freetype2) -c
LDFLAGS := -m32 -linkview -lcurl

COBJS := $(patsubst $(SRCDIR)/%.c,$(PLATFORM_OBJDIR)/%_c.o,$(CFILES))
OBJS := $(COBJS)

LIBINKVIEW := /lib32/libinkview.so

APP := $(BINDIR)/linux/$(notdir $(CURDIR))
endif

$(APP): $(OBJS) $(LIBINKVIEW)
	@mkdir -p $(@D)
	$(LD) $(OBJS) -o $@ $(LDFLAGS)

ifeq ($(strip $(PLATFORM)),Linux)
# Copy libinkview.so from SDK to /lib32
$(LIBINKVIEW): $(SDKPATH)/lib/libinkview.so
	sudo cp $< /lib32/
endif

$(PLATFORM_OBJDIR)/%_c.o: $(SRCDIR)/%.c
	@mkdir -p $(@D)
	$(CC) $(CFLAGS) $< -o $@

.PHONY: app clean run install

app: $(APP)

clean:
	rm -rf $(BINDIR) $(OBJDIR)

ifeq ($(strip $(PLATFORM)),ARM)
run:
	@echo "You can't run the app if platform is set to ARM. Maybe you meant \`PLATFORM=Linux'?"
	@exit 1

install: 
	@[ -d $(INSTALLPATH) ] || { echo "Please set INSTALLPATH to a valid folder."; exit 1; }
	cp $(APP) $(INSTALLPATH)/
else
run:
	cp $(SDKPATH)/../system . -r
	$(APP)

install:
	@echo "You can't install the app if the platform is set to Linux. Maybe you meant \`PLATFORM=ARM'?"
	@exit 1
endif