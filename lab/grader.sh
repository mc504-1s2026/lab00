#!/usr/bin/env bash

set -e
set -o nounset
set -o pipefail

# run with TRACE=1 grader.sh to get traces
if [[ ${TRACE-0} == "1" ]]; then
    set -o xtrace;
fi

if [[ ! -f "./meson-llvm-riscv.ini" || ! -f "./meson.build" ]]; then
    echo "Script must be run from the project root!"
    exit 1
fi

# figure out what distro we're running on to work around a stupid ubuntu quirk
. /etc/os-release
if [[ "$ID" = "ubuntu" ]]; then
    GDB=gdb-multiarch
else
    GDB=gdb
fi

KERNEL_PATH=build/src/kernel.elf

if [[ -d build ]]; then
    rm -r build
fi

echo "-------------------------------"
echo "[grader] building the kernel..."
echo "-------------------------------"


meson setup --cross-file=meson-llvm-riscv.ini build
meson compile -C build

echo "[grader] running the kernel in QEMU and capturing the value of mepc..."
echo "-------------------------------"

# check value of the `mepc` register
qemu-system-riscv64 -nographic -machine virt -bios none -kernel $KERNEL_PATH -s > qemu_log.txt &
# ugly hack, but we wait 5s for the machine to complete the setup into S-mode
sleep 5
QEMU_PID=$!
MEPC_ADDR=$($GDB -batch -nx -ex "file $KERNEL_PATH" -ex "target remote localhost:1234" -ex "b kmain" -ex "info all-registers" | grep "mepc" | awk '{print $2}')

echo "[grader] killing QEMU..."
echo "-------------------------------"

kill -INT $QEMU_PID

# extract address of kmain from the kernel ELF
KMAIN_ADDR=$(riscv64-unknown-elf-objdump -t build/src/kernel.elf | grep kmain | awk '{print $1}')

MEPC_ADDR_DECIMAL=$(printf "%d\n" $MEPC_ADDR)
KMAIN_ADDR_DECIMAL=$(printf "%d\n" "0x$KMAIN_ADDR")

echo "[grader] comparing the value stored in mepc and the address of kmain()..."
echo "-------------------------------"

if [[ "$MEPC_ADDR_DECIMAL" != "$KMAIN_ADDR_DECIMAL" ]]; then
    echo "[grader] failed"
    echo "[grader] kmain() does not seem to be loaded in the mepc CSR. Are we really in S-mode?"
    echo "-------------------------------"
    exit 1
fi

set +e
QEMU_LOG_FLAG=$(grep "successfully entered S-mode" qemu_log.txt)
set -e

if [[ -z "$QEMU_LOG_FLAG" ]]; then
    echo "[grader] failed"
    echo "[grader] couldn't find the 'successfully entered S-mode' message in the VM logs. Did we really enter S-mode?"
    echo "-------------------------------"
    exit 1
fi

rm qemu_log.txt

echo "[grader] passed"
echo "-------------------------------"
exit 0
