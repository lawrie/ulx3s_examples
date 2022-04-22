all: firmware.hex

clean:
	rm -f firmware.hex firmware.elf firmware.bin

firmware.elf: sections.lds firmware.s
	riscv-none-embed-gcc -mabi=ilp32 -march=rv32i -Wl,-Bstatic,-T,sections.lds,--strip-debug -ffreestanding -nostdlib -o firmware.elf firmware.s

firmware.bin: firmware.elf
	riscv-none-embed-objcopy -O binary firmware.elf firmware.bin

firmware.hex: firmware.bin
	python3 makehex.py $^ 8192 > $@

