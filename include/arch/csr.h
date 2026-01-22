#ifndef __CSR_H__
#define __CSR_H__

#include <stdint.h>

/*
 * lab00: Your code goes here. You should #define macros for CSR numbers,
 * masks, etc that you're gonna use.
 */

/*
 * CSR access helper macros
 */

/*
 * this "stringifies" the CSR_* macros so that they can be
 * appended to the asm string inside the __asm__ sections below
 * (C moment)
 * https://stackoverflow.com/questions/2751870/how-exactly-does-the-double-stringize-trick-work
 */
#ifdef __ASSEMBLER__
#define __ASM_STR(x)	x
#else
#define __ASM_STR(x)	#x
#endif

#define csr_read(csr)						\
({								\
	register uint64_t __v;					\
	__asm__ __volatile__ ("csrr %0, " __ASM_STR(csr)	\
			: "=r" (__v)				\
			:					\
			: "memory");				\
	__v;							\
})

#define csr_write(csr, val)					\
({								\
	register uint64_t __v = (uint64_t) val;			\
	__asm__ __volatile__ ("csrw " __ASM_STR(csr) ", %0"		\
		 :						\
		 : "rK" (__v)					\
		 : "memory");					\
})

#endif
