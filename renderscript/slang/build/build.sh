#!/bin/bash 


cmake -G "Unix Makefiles" \
	-DCMAKE_C_COMPILER=$HOME/android/aarch64-linux-android/bin/clang \
	-DCMAKE_CXX_COMPILER=$HOME/android/aarch64-linux-android/bin/clang++ \
	-DCMAKE_BUILD_TYPE=Release \
	-DCMAKE_INSTALL_PREFIX=/data/data/com.termux/files/home/slang \
	-DCMAKE_CXX_FLAGS="-std=c++11 -fPIC -fno-rtti -fno-exceptions" \
	-DCMAKE_EXE_LINKER_FLAGS="-pie -lstdc++" \
	..
