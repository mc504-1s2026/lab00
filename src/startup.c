#include <stdint.h>
#include <stdint.h>
#include <stddef.h>
#include <kernel/printf.h>
#include <arch/csr.h>

// the kernel entry point once we get to S-mode, implemented in kernel.c
extern void kmain();

void mmode_startup(void)
{
	printk("[M] booting in M-mode\n");
	printk("[M] starting early kernel boot\n");

	/*
	 * lab00: Your code goes here.
	 * Set up the appropriate registers and call the "mret"
	 * instruction when you're ready to switch over to S-mode.
	 */

	while (1) {

	}
	return;
}
