.PHONY: build run clean

QEMU_BIN = qemu-system-x86_64
KERNEL_FILE = build-x86/images/kernel-x86_64-pc99
INITRD_FILE = build-x86/images/sel4test-driver-image-x86_64-pc99
CPU_OPTIONS = -cpu Nehalem,-vme,+pdpe1gb,-xsave,-xsaveopt,-xsavec,-fsgsbase,-invpcid,+syscall,+lm,enforce
GRAPHIC_OPTIONS = -nographic
SERIAL_OPTIONS = -serial mon:stdio
MEM_SIZE = -m size=3G

build: clean
	mkdir build-x86
	cd build-x86 && ../init-build.sh -DPLATFORM=x86_64 -DSIMULATION=TRUE
	cd build-x86 && ninja

run:
	$(QEMU_BIN) -kernel $(KERNEL_FILE) -initrd $(INITRD_FILE) $(CPU_OPTIONS) $(GRAPHIC_OPTIONS) $(SERIAL_OPTIONS) $(MEM_SIZE)

clean:
	rm -rf build-x86
