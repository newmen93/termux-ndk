#!/bin/bash 


cmake -G "Unix Makefiles" \
	-DCMAKE_C_COMPILER=$HOME/android/aarch64-linux-android/bin/clang \
	-DCMAKE_CXX_COMPILER=$HOME/android/aarch64-linux-android/bin/clang++ \
	-DCMAKE_BUILD_TYPE=Release \
	-DCMAKE_INSTALL_PREFIX=$HOME/libbcc \
	-DCMAKE_CXX_FLAGS="-fno-rtti -fno-exceptions -std=c++11 -fPIC" \
	-DCMAKE_EXE_LINKER_FLAGS="-pie -lstdc++" \
	..
