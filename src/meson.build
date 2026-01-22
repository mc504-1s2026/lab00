add_project_arguments([
  # set all compiler warnings to errors (avoid future headaches)
  '-Werror',
  # tell the compiler to be very thorough and emit warnings for lots
  # of different things (some of which are nitpicky, but nevertheless
  # important to keep in mind when working with C)
  '-Wall', '-Wextra',
  # tell the compiler to emit warnings for potentially problematic
  # integer conversions (e.g. signed-unsigned, etc.)
  '-Wconversion', '-Wsign-conversion',
  # tell the compiler that this is a freestanding project, e.g., does
  # *not* run on top of an operating system and cannot link against libc
  # or use the C standard library
  '-ffreestanding', '-nostdlib',
  # use the C11 standard for the project (same as the Linux kernel)
  '-std=c11',
  ],
  language : 'c')

sources = [
  'startup.c',
  'kernel.c',
  'entry.S',
  'printf.c'
]

kernel_img = executable('kernel.elf',
  sources,
  link_args : ['-T' + linker_script],
  link_depends: [linker_script],
  include_directories: kernel_include_dir,
)
