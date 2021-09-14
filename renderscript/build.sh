#!/bin/bash 

# slang source code
if [ ! -d "slang" ];then
  git clone --depth=1 https://android.googlesource.com/platform/frameworks/compile/slang
fi

# libbcc source code
if [ ! -d "libbcc" ];then
  git clone --depth=1 https://android.googlesource.com/platform/frameworks/compile/libbcc
fi

if [ ! -f "slang/RSCCOptions.inc" ];then            
    cp prebuilt/RSCCOptions.inc slang
fi

# rs souce code
#git clone --depth=1 https://android.googlesource.com/platform/frameworks/rs

# llvm and clang source code
# git clone --depth=1 https://android.googlesource.com/platform/external/llvm
# git clone --depth=1 https://android.googlesource.com/platform/external/clang


# check llvm headers and libs
if [ ! -d "llvm" ];then
  tar -xJvf prebuilt/llvm-3.9-aarch64.tar.xz -C .
fi

# check build directory
if [ ! -d "build" ];then
  mkdir build && cd build
else
  cd build
fi

# /path/to/android-ndk-r23
TOOLCHAIN=$HOME/android/android-ndk-r23/toolchains/llvm/prebuilt/linux-x86_64

# check toolchain
if [ ! -d "$TOOLCHAIN" ];then
  echo "The toolchain cannot be found, please set the toolchain path correctly."
  exit 1
fi

cmake -G "Ninja" \
	-DCMAKE_C_COMPILER=$TOOLCHAIN/bin/aarch64-linux-android30-clang \
	-DCMAKE_CXX_COMPILER=$TOOLCHAIN/bin/aarch64-linux-android30-clang++ \
	-DCMAKE_SYSROOT=$TOOLCHAIN/sysroot \
	-DCMAKE_BUILD_TYPE=Release \
	..

ninja -j16
