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

# /path/to/android-ndk-r23
TOOLCHAIN=$HOME/toolchain/android-ndk-r23/toolchains/llvm/prebuilt/linux-aarch64

# check toolchain
if [ ! -d "$TOOLCHAIN" ];then
  echo "The toolchain cannot be found, please set the toolchain path correctly."
  exit 1
fi

cmake -G "Ninja" \
	-DCMAKE_C_COMPILER=${TOOLCHAIN}/bin/aarch64-linux-android28-clang \
	-DCMAKE_CXX_COMPILER=${TOOLCHAIN}/bin/aarch64-linux-android28-clang++ \
	-DCMAKE_BUILD_TYPE=Release \
	..

ninja -j16
