#!/bin/bash

rm -f vtoytool/00/*

x86_64-linux-musl-gcc -DVTOY_X86_64 -D_FILE_OFFSET_BITS=64 *.c BabyISO/*.c -IBabyISO -Wall -DBUILD_VTOY_TOOL -DUSE_DIET_C -o vtoytool_64 --include stdint.h -Os -static
i386-linux-musl-gcc -DVTOY_I386 -D_FILE_OFFSET_BITS=64 *.c BabyISO/*.c -IBabyISO -Wall -DBUILD_VTOY_TOOL -DUSE_DIET_C -o vtoytool_32 --include stdint.h -Os -static

aarch64-linux-musl-gcc -Os -static -DVTOY_AA64 -D_FILE_OFFSET_BITS=64  *.c BabyISO/*.c -IBabyISO -Wall -DBUILD_VTOY_TOOL -DUSE_DIET_C -o vtoytool_aa64 --include stdint.h

mips64el-linux-musl-gcc -mips64r2 -mabi=64 -Os -static -DVTOY_MIPS64 -D_FILE_OFFSET_BITS=64  *.c BabyISO/*.c -IBabyISO -Wall -DBUILD_VTOY_TOOL -o vtoytool_m64e

#gcc -D_FILE_OFFSET_BITS=64 -static -Wall -DBUILD_VTOY_TOOL  *.c BabyISO/*.c -IBabyISO  -o  vtoytool_64
#gcc -D_FILE_OFFSET_BITS=64  -Wall -DBUILD_VTOY_TOOL -m32  *.c BabyISO/*.c -IBabyISO  -o  vtoytool_32

if [ -e vtoytool_64 ] && [ -e vtoytool_32 ] && [ -e vtoytool_aa64 ] && [ -e vtoytool_m64e ]; then
    echo -e '\n############### SUCCESS ###############\n'
    
    aarch64-linux-gnu-strip --strip-all vtoytool_aa64
    mips64el-linux-gnuabi64-strip --strip-all vtoytool_m64e
    mv vtoytool_m64e vtoytool/00/
    mv vtoytool_aa64 vtoytool/00/
    mv vtoytool_64 vtoytool/00/
    mv vtoytool_32 vtoytool/00/
else
    echo -e '\n############### FAILED ################\n'
    exit 1
fi
