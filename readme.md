# This is my OS Ceazy. Just starting off.

Pre-requisities:
x86 ASM, C, OS (Theory)

This is the place where I'll write how I made the OS following the book "A little book on OS development."

1. Essentials: (Don't ast me why)
sudo apt-get install build-essential nasm genisoimage bochs bochs-sdl

__attribute__((packed)): This attribute allows us 
to ensure that the compiler uses a memory layout 
for a struct exactly as we define it in the code. 

For writing assembly code, 
I choose NASM [11] as the assembler, since this is only followed in the book.

Build system GNU Make 4.3
Built for x86_64-pc-linux-gnu.  
I am using Linux and GCC compiler.

We have the BIOS -> [GRUB1 -> GRUB2] -> After which our OS takes over.

Bootloader[GRUB] it's task is to give us the control to the system.

Starting the project!
---------------------
loader.s can be compiled into a 32 bits Executable and Linker Format [18] object file with the following command:

Compile Using:
--------------
nasm -f elf32 loader.s

code up the link.ld
because

we want GRUB to load the kernel at a memory address larger than or equal to 0x00100000 (1 megabyte (MB)), because addresses lower than 1 MB are used by GRUB itself, BIOS and memory-mapped I/O. 


and compile using:

ld -T link.ld -melf_i386 loader.o -o kernel.elf

download the stage2_eltorito for bootloader.

Now we build the kernel ISO Image using genisoimage 
mkdir -p iso/boot/grub              # create the folder structure
cp stage2_eltorito iso/boot/grub/   # copy the bootloader
cp kernel.elf iso/boot/  # copy the kernel
now a config file for GRUB is needed to tell where the kernel is located.
name it menu.lst and move it to the location shown below.


Current Folder Structure 
    iso
    |-- boot
      |-- grub
      | |-- menu.lst
      | |-- stage2_eltorito
      |-- kernel.elf


Now generate the ISO Image:
    genisoimage -R                              \
                -b boot/grub/stage2_eltorito    \
                -no-emul-boot                   \
                -boot-load-size 4               \
                -A os                           \
                -input-charset utf8             \
                -quiet                          \
                -boot-info-table                \
                -o os.iso                       \
                iso

image os.iso now contains the kernel executable, the GRUB bootloader and the configuration file.

Now we can run and test using the BOCHs Emulator

create a config file for boch (bochsrc.txt).

