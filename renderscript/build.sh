#!/bin/bash 

# check llvm headers and libs
if [ ! -d "llvm" ];then
  tar -xJvf ../archives/llvm-3.9.tar.xz -C .
fi

# check build directory
if [ ! -d "build" ];then
  mkdir build && cd build
else
  cd build
fi

# /path/to/android-ndk-r21d
TOOLCHAIN=$HOME/proj/android-ndk-r21d/toolchains/llvm/prebuilt/linux-aarch64

cmake -G "Unix Makefiles" \
	-DCMAKE_C_COMPILER=${TOOLCHAIN}/bin/aarch64-linux-android30-clang \
	-DCMAKE_CXX_COMPILER=${TOOLCHAIN}/bin/aarch64-linux-android30-clang++ \
	-DCMAKE_BUILD_TYPE=Release \
	..

make -j4
