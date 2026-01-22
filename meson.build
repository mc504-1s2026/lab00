project('riscv-barebones', 'c',
  # default_options: ['buildtype=plain'],
)

linker_script = meson.current_source_dir() + '/linker.ld'
kernel_include_dir = include_directories('include')

subdir('src')

run_target('boot',
  command : ['qemu.sh', kernel_img],
  depends : kernel_img,
)
