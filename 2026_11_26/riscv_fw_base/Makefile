CODIX_BASE_PATH =  /C/Codasip/codix-bk3-32IMC-Upid-CORE-3.2.0-8.3.3-2901-windows.10.x86_64
#CODIX_BASE_PATH =  /C/Codasip/bk3-analogix-jump-4b-5.0.4-9.4.2-win10
CODIX_BERKELIUM_PATH= $(CODIX_BASE_PATH)/sdk

#CODIX_CC = $(CODIX_BERKELIUM_PATH)/bin/codix_berkelium-ia-gcc
#CODIX_ASM = $(CODIX_BERKELIUM_PATH)/bin/codix_berkelium-ia-assembler
#CODIX_LD = $(CODIX_BERKELIUM_PATH)/bin/codix_berkelium-ia-ld
#CODIX_OBJCOPY = $(CODIX_BERKELIUM_PATH)/bin/codix_berkelium-ia-objcopy
#CODIX_OBJDUMP = $(CODIX_BERKELIUM_PATH)/bin/codix_berkelium-ia-objdump

# Using bk3-32IMC-Upid toolchain for compilation and linking
CODIX_CC = $(CODIX_BERKELIUM_PATH)/bin/bk3-32IMC-Upid-ia-clang
CODIX_LD = $(CODIX_BERKELIUM_PATH)/bin/bk3-32IMC-Upid-ia-ld
CODIX_ASM = $(CODIX_BERKELIUM_PATH)/bin/bk3-32IMC-Upid-ia-assembler
CODIX_OBJCOPY = $(CODIX_BERKELIUM_PATH)/bin/bk3-32IMC-Upid-ia-objcopy
CODIX_OBJDUMP = $(CODIX_BERKELIUM_PATH)/bin/bk3-32IMC-Upid-ia-objdump

#New for bk3-analogix-jump-4b-5.0.4-9.4.2-win10 sdk
#CODIX_CC = $(CODIX_BERKELIUM_PATH)/bin/codix_berkelium-ia-clang
#CODIX_ASM = $(CODIX_BERKELIUM_PATH)/bin/codix_berkelium-ia-llvm-mc
#CODIX_LD = $(CODIX_BERKELIUM_PATH)/bin/codix_berkelium-ia-ld
#CODIX_OBJCOPY = $(CODIX_BERKELIUM_PATH)/bin/codix_berkelium-ia-llvm-objcopy
#CODIX_OBJDUMP = $(CODIX_BERKELIUM_PATH)/bin/codix_berkelium-ia-llvm-objdump

INCLUDE = $(addprefix -I, $(wildcard ./inc/))
INCLUDE += -I./inc/lms
OUTPUT = ./output

vpath %.c ./source ./debug ./source/lms
vpath %.S ./source

OBJS=crt0.o \
	flash_cmd.o \
	flash_verify.o \
	cmd_sys.o \
	cmd_sys_def.o \
	cmdline.o \
	custom_test.o \
	custom_test_def.o \
	main.o \
	mcu.o \
	printf.o \
	reg_acc.o \
	timer.o \
	uart_int.o \
	i2c_master.o \
	spi.o \
	debug.o 

OBJS += $(notdir $(patsubst %.c,%.o,$(wildcard ./source/lms/*.c)))

#CFLAGS= -Os -Wall -march=rv32im
CFLAGS= -O0 -g3 -Wall
#CFLAGS += -DLMS_VERIFY_ONLY=1
LMS_SHA256_ACCEL ?= 0
CFLAGS += -DLMS_SHA256_ACCEL=$(LMS_SHA256_ACCEL)
CFLAGS += $(INCLUDE)

all: $(OBJS)
#	$(CODIX_LD) $(addprefix $(OUTPUT)/, ${OBJS}) -v -o $(OUTPUT)/test.xexe -T default.lds -L$(CODIX_BERKELIUM_PATH)/lib -L$(CODIX_BERKELIUM_PATH)/newlib/lib -lc -lcomp -Map $(OUTPUT)/test.map
	$(CODIX_LD) $(addprefix $(OUTPUT)/, ${OBJS}) -v -o $(OUTPUT)/test.xexe -T default.lds -L$(CODIX_BERKELIUM_PATH)/lib -L$(CODIX_BERKELIUM_PATH)/newlib/lib -lc -lcomp -Map $(OUTPUT)/test.map

	$(CODIX_OBJCOPY) -j .imcode.crt0 -j .imcode.text -j .imcode.rodata -j .dmdata.data \
		-j .ctors -j .dtors -j .rodata -j .data -j .sdata -j .sbss \
		-j .text -j .init -j .fini -j .smcode.text -j .smdata.data \
		-O ihex $(OUTPUT)/test.xexe $(OUTPUT)/test.ihex
	

	$(CODIX_OBJDUMP) -D $(OUTPUT)/test.xexe > $(OUTPUT)/test.s
	@python mapanalysis.py

$(OUTPUT):
		@echo "Create directory $@ ..."
		mkdir -p $(OUTPUT)

.c.o:
	$(CODIX_CC) -c $< -o $(OUTPUT)/$@ $(CFLAGS)

.S.o:
	$(CODIX_ASM) $< -o $(OUTPUT)/$@ -w
#	$(CODIX_ASM) $< -assemble -filetype=obj -o $(OUTPUT)/$@ $(ASMFLAGS)

clean:
	rm -f test.* *.o
	rm -f *.i *.s *.bc *.o *.xexe *hex sim_exit_code cycles $(OUTPUT)/*
