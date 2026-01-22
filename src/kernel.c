#include <stdint.h>
#include <stdint.h>
#include <stddef.h>
#include <kernel/printf.h>
#include <arch/csr.h>

// The entry point for the kernel once we enter S-mode.
void kmain()
{
	printk("successfully entered S-mode\n");

	while (1) {

	}
}
