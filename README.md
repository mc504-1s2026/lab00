# lkcampOS

## Lab 0: booting the kernel

Follow the instructions below to prepare your environment to compile
the kernel. You will find the lab instructions in [lab/INSTRUCTIONS.md](./lab/INSTRUCTIONS.md).

## Dependencies

### Ubuntu/Debian

```
sudo apt install qemu-system-riscv64 gdb-multiarch clang meson ninja-build lld
```

### Arch Linux
```
sudo pacman -S qemu-full riscv64-elf-gdb clang meson ninja lld
```

### Fedora
```
sudo dnf install qemu-system-riscv gdb clang meson ninja-build lld
```

## Building and running

This will configure `meson`, our build system, and create a directory called `build`
where all our compiled files will live.

```
meson setup --cross-file=meson-llvm-riscv.ini build
```

To compile, run:

```
meson compile -C build
```

To boot the kernel:

```
meson compile -C build boot
```

To run the autograder tests:

```
build/grader.sh
```
