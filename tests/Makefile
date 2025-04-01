AS = riscv64-unknown-elf-as
LD = riscv64-unknown-elf-ld
OBJDUMP = riscv64-unknown-elf-objdump

SRC = test_hfi.S
OBJ = test.o
ELF = test.elf
DUMP = test.dump

all: $(ELF) $(DUMP)

$(OBJ): $(SRC)
	$(AS) -o $@ $<

$(ELF): $(OBJ)
	$(LD) -o $@ $<

$(DUMP): $(ELF)
	$(OBJDUMP) -D $< > $@

clean:
	rm -f $(OBJ) $(ELF) $(DUMP)

.PHONY: all clean
