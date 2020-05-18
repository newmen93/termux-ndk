#!/bin/bash 

TOOLCHAIN=$HOME/android/android-ndk-r21/toolchains/llvm/prebuilt/linux-aarch64


cmake -G "Unix Makefiles" \
	-DCMAKE_C_COMPILER=$TOOLCHAIN/bin/aarch64-linux-android29-clang \
	-DCMAKE_CXX_COMPILER=$TOOLCHAIN/bin/aarch64-linux-android29-clang++ \
	-DCMAKE_BUILD_TYPE=Release \
	-DCMAKE_INSTALL_PREFIX=/data/data/com.termux/files/home/slang \
	-DCMAKE_CXX_FLAGS="-std=c++17 -fPIC -fno-rtti -fno-exceptions --sysroot=${TOOLCHAIN}/sysroot" \
	-DCMAKE_EXE_LINKER_FLAGS="-static" \
	..
