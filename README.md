This is the Google standard NDK and supports Termux and aarch64 host devices.

clang version: 11.0.1
##### download [android-ndk-r21](https://github.com/Lzhiyong/termux-ndk/releases)


####  How to build
At first, we don‘t need to rebuild the whole NDK, since google already built most of it.
we only need to build llvm toolchain, then replace the llvm in the NDK.
Of course you can build the whole NDK, use checkbuild.py, but the source code is too huge.

dowload llvm-toolchain source code, 
I recommend using [TermuxArch](https://github.com/SDRausty/TermuxArch)
, ArchLinux only downloads source code, we are not using it to compile
```bash
# I assume that you have installed the ArchLinux
# install repo
pacman -S repo 

cd /data/data/com.termux/files/home # cd ~
mkdir llvm-toolchain && cd llvm-toolchain

repo init -u https://android.googlesource.com/platform/manifest -b llvm-toolchain

# for china
repo init -u https://aosp.tuna.tsinghua.edu.cn/platform/manifest -b llvm-toolchain

repo sync -c -j4

# download finish, exit ArchLinux
exit

python toolchain/llvm_android/build.py
```
You need to make some changes to it before performing build.py, 
download the toolchain [aarch64-linux-android](https://github.com/Lzhiyong/termux-ndk/releases)
 (toolchain from NDK, make_standalone_toolchain.py)
```bash
# remove prebuilt clang, CLANG_PREBUILT_VERSION is defined in ~/llvm-toolchain/toolchain/llvm_android/constants.py

rm -vrf ~/llvm-toolchain/prebuilts/clang/host/linux-x86/CLANG_PREBUILT_VERSION/*

tar -xJvf aarch64-linux-android.tar.xz -C ~/llvm-toolchain/prebuilts/clang/host/linux-x86/CLANG_PREBUILT_VERSION

# you have installed cmake via apt install cmake
ln -sf ~/../usr/bin/cmake ~/llvm-toolchain/prebuilts/cmake/linux-x86/bin/cmake

# you have installed ninja via apt install ninja
ln -sf ~/../usr/bin/ninja ~/llvm-toolchain/prebuilts/ninja/linux-x86/bin/ninja

# remove prebuilt python
rm -vrf ~/llvm-toolchain/prebuilts/python/linux-x86/*

# you have installed python3 via apt install python

# extract /data/data/com.termux/files/usr/var/cache/apt/archives/python_3.8.2_aarch64.deb to ~/llvm-toolchain/prebuilts/python/linux-x86
# or modify ~/llvm-toolchain/toolchain/llvm_android/py3_utils.py 

# go is the same

# apt install libedit and cpoy libedit to prebuilt dirctory
cp ~/../usr/lib/libedit* ~/llvm-toolchain/prebuilts/libedit/linux-x86/lib

# apt install swig and copy swig to prebuilt directory
cp ~/../usr/bin/swig ~/llvm-toolchain/prebuilts/swig/linux-x86/bin

# modify ~/llvm-toolchain/toolchain/llvm_android/configs.py 
# sysroot:~/llvm-toolchain/prebuilts/clang/host/linux-x86/CLANG_PREBUILT_VERSION/sysroot
```
There are some that need to be modified, please see llvm_android for details
###### Please note that aarch64-linux-android/bin/clang++ does not link libstdc++ by default, so add the link parameter -lstdc++ in do_build.py

 **** 
###  OK start compile now!
```bash
python toolchain/llvm_android/build.py
```

 **** 
#### Building binutils
```bash
python toolchain/binutils/build.py
```

 **** 
#### Simpleperf no need to compile
```bash
cd android-ndk-r21/simpleperf/bin/linux/aarch64

ln -sf ../../android/arm64/simpleperf ./simpleperf

```

 **** 
#### Building shader-tools
```bash
cd /data/data/com.termux/files/home

mkdir shader-tools && cd shader-tools

git clone https://github.com/google/shaderc

cd shaderc/third_party

git clone https://github.com/KhronosGroup/SPIRV-Tools.git   spirv-tools

git clone https://github.com/KhronosGroup/SPIRV-Headers.git spirv-tools/external/spirv-headers
    
git clone https://github.com/google/googletest.git

git clone https://github.com/google/effcee.git

git clone https://github.com/google/re2.git

git clone https://github.com/KhronosGroup/glslang.git


# start building...

mkdir build && cd build

cmake -G "Ninja" 
	-DCMAKE_BUILD_TYPE=Release \
	-DCMAKE_INSTALL_PREFIX=your_install_path \
	..

ninja install -j16
```

 **** 
#### Building renderscript (bcc_compat llvm-rs-cc)
build bcc_compat and llvm-rs-cc need older version clang, download [clang-3.9](https://github.com/Lzhiyong/termux-ndk/releases)
 or you can download the source code and compile it yourself

```bash
# slang source code
# git clone https://android.googlesource.com/platform/frameworks/compile/slang
# libbcc source code
# git clone https://android.googlesource.com/platform/frameworks/compile/libbcc
# rs souce code
# git clone https://android.googlesource.com/platform/frameworks/rs
# clang-3.9 source code
# git clone https://android.googlesource.com/platform/external/llvm
# git clone https://android.googlesource.com/platform/external/clang


# I assume you have clang-3.9
git clone https://github.com/Lzhiyong/termux-ndk.git

tar -xJvf clang-3.9.tar.xz -C renderscript

# build llvm-rs-cc
cd renderscript/slang/build
./build.sh

#build bcc_compat
cd renderscript/libbcc/build
./build.sh


# I rewrote the code of rs_cc_options.cpp
# because RSCCOptions.inc compilation error, this may have bugs, 
# if anyone knows how to compile RSCCOptions.inc, please tell me, thank you
```
 **** 
#### Building finish!
llvm-toolchain stage1 and stage2 compilation takes about 10 hours 

My Phone: Xiao Mi6 

RAM: 6G

ROM: 128G

Snapdragon 835 processor

There may be some errors during the compilation process, please solve it yourself

 **** 
#### Test app with NDK cmake
```bash
cd termux-ndk/cmake-example && gradle build
```

Screenshot_01.jpg
![image](https://github.com/Lzhiyong/termux-ndk/blob/master/screenshot/Screenshot_01.jpg)

Screenshot_02.jpg
![image](https://github.com/Lzhiyong/termux-ndk/blob/master/screenshot/Screenshot_02.jpg)


