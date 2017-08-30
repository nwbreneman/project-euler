# project-euler

Just my solutions to Project Euler problems. More than likely I will work these sporadically between school quarters.

The NASM files are 64-bit, and use the `printf` and `exit` C-library calls for expediency. They can be linked and compiled like:
```
nasm -f elf64 {filename.nasm}
gcc -o {outputfile} {filename.o}
```

On Arch Linux, I was getting compilation errors related to the `.data` section. I had to add the `-static` flag to gcc.

![euler-profile](https://projecteuler.net/profile/nwbreneman.png)