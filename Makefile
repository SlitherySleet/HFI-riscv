# Directories
TEST_DIR := tests
OUT_DIR := $(TEST_DIR)/output


# Source, object, and binary files
SRC := $(wildcard $(TEST_DIR)/*.s)
OBJ := $(SRC:.s=.o)
ELF := $(SRC:.s=.elf)

# Compiler tools and flags
AS := riscv64-unknown-elf-as
LD := riscv64-unknown-elf-ld
LDFLAGS := -Ttext=0x80000000

# QEMU path and flags
QEMU := ./qemu-system-riscv64
QEMU_FLAGS := -M virt -bios none -nographic -d in_asm,cpu,unimp

# Assembling flags and includes
INCLUDES := -I includes/

# Default phony targets
.PHONY: tests run-tests clean

# Check for QEMU before doing anything else
check-qemu:
	@if [ ! -x $(QEMU) ]; then \
		echo "QEMU binary '$(QEMU)' not found or not executable."; \
		echo "Please build QEMU first before running tests."; \
		exit 1; \
	fi

# Build all tests (after checking for QEMU)
tests: check-qemu $(ELF)

# Rule to assemble .s to .o
$(TEST_DIR)/%.o: $(TEST_DIR)/%.s
	$(AS) $(INCLUDES) -o $@ $<

# Rule to link .o to .elf
$(TEST_DIR)/%.elf: $(TEST_DIR)/%.o
	$(LD) $(LDFLAGS) -o $@ $<

# Run all tests through QEMU and save logs
run-tests: tests
	@mkdir -p $(OUT_DIR)
	@for elf in $(ELF); do \
		name=$$(basename $$elf .elf); \
		echo "Running $$elf..."; \
		$(QEMU) $(QEMU_FLAGS) -kernel $$elf -D $(OUT_DIR)/$$name.log; \
	done

# Clean up all generated files and output
clean:
	rm -f $(OBJ) $(ELF)
	rm -rf $(OUT_DIR)
