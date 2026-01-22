ENTRY(start);

/*
  The special linker variable dot `.' always contains the current output location counter.
  https://ftp.gnu.org/old-gnu/Manuals/ld-2.9.1/html_chapter/ld_3.html
*/
. = 0x80000000;

SECTIONS {
    /* include entry point at the start of the binary */
    .text : ALIGN(4K) {
        *(.init);
        *(.text);
    }

    .bss : ALIGN(4K) {
        PROVIDE(bss_start = .);
        *(.bss);
        /* define a 4096-byte stack */
        . += 4096;
        PROVIDE(stack_top = .);
        /* define a 4096-byte space for global vars */
        . += 4096;
        PROVIDE(global_pointer = .);
        PROVIDE(bss_end = .);
    }

    .rodata : ALIGN(4K) {
        *(.rodata);
        *(.rodata.*);
    }

    .data : ALIGN(4K) {
        *(.data);
    }

    /* These are special compiler-generated sections that we don't really
     * care about, but place at the end of the executable so it doesn't interfere
     * with other sections */

    .eh_frame : { *(.eh_frame); }
    .comment : { *(.comment); }
    .riscv.attributes : { *(.riscv.attributes); }
    .symtab : { *(.symtab); }
    .shstrtab : { *(.shstrtab); }
    .strtab : { *(.strtab); }

}
