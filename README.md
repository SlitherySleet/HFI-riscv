Implementing HFI in RISC-V


## How to Run Tests

## Prerequisites 

- `riscv64-unknown-elf-as` — GNU assembler for RISC-V  
- `riscv64-unknown-elf-ld` — GNU linker for RISC-V  
- `qemu-system-riscv64` — QEMU emulator with RISC-V support  
  _(expected to be in the root folder as `./qemu-system-riscv64`)_

### 1. Build Tests (Optional)

```bash
make tests
```

Assembles and links all `.s` files in the `tests/` directory into `.elf` executables.

---

### 2. Run Tests

```bash
make run-tests
```

Runs each `.elf` in QEMU with debug output. Logs are saved to `tests/output/*.log`.

---

### 3. Clean Build Artifacts

```bash
make clean
```

Removes all `.o`, `.elf`, and the `tests/output/` folder.

---