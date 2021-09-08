Android ndk for termux, that only support aarch64 architecture

The source code from AOSP llvm-toolchain master branch, because llvm is cross-platform, so we can recompile it to Android

At first, we don‘t need to rebuild the whole NDK, since google already built most of it.
so we only need to build the llvm toolchain, then replace the llvm inside NDK.

For more details information, please refer to [toolchain readme docs](https://github.com/Lzhiyong/termux-ndk/tree/master/docs)

##### [download r23](https://github.com/Lzhiyong/termux-ndk/releases)

####  How to build

Termux needs to install aarch64 version of Linux to download the source code, we are not using it to compile

In order to save storage , there are some pre-compiled tools that do not need to be downloaded. 
comment out them in the llvm-toolchain/.repo/manifests/default.xml file, click [here](https://github.com/Lzhiyong/termux-ndk/blob/master/patches/default.xml.patch) for example.

```bash
pkg install proot-distro
proot-distro install archlinux

# I assume that you have installed the ArchLinux
# install repo
pacman -S repo 

cd /data/data/com.termux/files/home 
mkdir llvm-toolchain && cd llvm-toolchain

# download the source code
repo init -u https://android.googlesource.com/platform/manifest -b llvm-toolchain

# for china
repo init -u https://aosp.tuna.tsinghua.edu.cn/platform/manifest -b llvm-toolchain

repo sync -c -j4

# sync finish, exit ArchLinux
exit

```
 ****

Termux needs to install some build-essential packages, then copy or soft link it to llvm-toolchain/prebuilts

I recommend compiling on PC, because compiling on device will take a long time</br>
If compiling on PC, we only replece the prebuilt clang toolchain

```bash

# remove clang-bootstrap 
rm -vrf llvm-toolchain/prebuilts/clang/host/linux-x86/clang-bootstrap

# extract android-ndk-r23.tar.xz to /path/to/clang-bootstrap
tar -xJvf android-ndk-r23.tar.xz -C llvm-toolchain/prebuilts/clang/host/linux-x86/clang-bootstrap

# soft link cmake to llvm-toolchain/prebuilts
ln -sf /data/data/com.termux/files/usr/bin/cmake llvm-toolchain/prebuilts/cmake/linux-x86/bin/cmake

# soft link make to llvm-toolchain/prebuilts
ln -sf /data/data/com.termux/files/usr/bin/make llvm-toolchain/prebuilts/build-tools/linux-x86/bin/make

# soft link ninja to llvm-toolchain/prebuilts
ln -sf /data/data/com.termux/files/usr/bin/ninja llvm-toolchain/prebuilts/build-tools/linux-x86/bin/ninja

# remove prebuilt python
rm -vrf llvm-toolchain/prebuilts/python/linux-x86/*
# apt download python3
# extract python_3.9.x_aarch64.deb to llvm-toolchain/prebuilts/python/linux-x86

# building golang
apt install golang
cd llvm-toolchain/prebuilts/go/linux-x86/src
./make.bash

```

 **** 
####  Building start!

```bash
# no build for windows
# If it is not the first time to build, you can add options --skip-source-setup to save time
python toolchain/llvm_android/build.py --enable-assertions --no-build windows
```

llvm-toolchain stage1 and stage2 compilation will take a long time.

there may be some errors during the compilation process, please solve it by yourself!

 **** 
 
#### Building finish!
```bash
# test the ndk clang
NDK_TOOLCHAIN=/path/to/android-ndk-r23/toolchains/llvm/prebuilt/linux-aarch64
$NDK_TOOLCHAIN/bin/aarch64-linux-android28-clang++ test.cpp -o test

# if you want to use clang alone, you need to specify --target=<arch_api_level>
# for example android api 28 --target=aarch64-linux-android28
$NDK_TOOLCHAIN/bin/clang++ --target=aarch64-linux-android28 test.cpp -o test

# Note: <arch_api_level>-clang is recommended, instead of clang alone

```
 **** 
 
#### Building simpleperf
```bash
# simpleperf no need to compile
cd android-ndk-r23/simpleperf/bin/linux/aarch64

ln -sf ../../android/arm64/simpleperf ./simpleperf

```

 **** 
#### Building shader-tools
```bash
cd /data/data/com.termux/files/home
git clone https://github.com/google/shaderc
cd shaderc/third_party
git clone https://github.com/KhronosGroup/SPIRV-Tools.git   spirv-tools
git clone https://github.com/KhronosGroup/SPIRV-Headers.git spirv-tools/external/spirv-headers
git clone https://github.com/google/googletest.git
git clone https://github.com/google/effcee.git
git clone https://github.com/google/re2.git
git clone https://github.com/KhronosGroup/glslang.git

# start building shaderc...

cd ~/shaderc && mkdir build && cd build

# setting android ndk toolchain
TOOLCHAIN=/path/to/android-ndk-r23/toolchains/llvm/prebuilt/linux-aarch64

cmake -G "Ninja" \
    -DCMAKE_C_COMPILER=$TOOLCHAIN/bin/aarch64-linux-android28-clang \
    -DCMAKE_CXX_COMPILER=$TOOLCHAIN/bin/aarch64-linux-android28-clang++ \
    -DCMAKE_SYSROOT=$TOOLCHAIN/sysroot \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/path/to/shader-tools \
    ..

ninja -j16
```

 **** 
#### Building renderscript 

```bash
# llvm-rs-cc and bcc_compat
# slang source code
# git clone https://android.googlesource.com/platform/frameworks/compile/slang
# libbcc source code
# git clone https://android.googlesource.com/platform/frameworks/compile/libbcc
# rs souce code
# git clone https://android.googlesource.com/platform/frameworks/rs
# llvm and clang source code
# git clone https://android.googlesource.com/platform/external/llvm
# git clone https://android.googlesource.com/platform/external/clang

cd termux-ndk/renderscript
./build.sh

```
 **** 

#### Building app
**building android app with termux-ndk, please refer to [build-app](https://github.com/Lzhiyong/termux-ndk/tree/master/build-app)**

#### Building cocos2d game
**building cocos2d game for android with termux-ndk, please refer to [cocos2d-game](https://github.com/Lzhiyong/termux-ndk/tree/master/cocos2d-game)**

## Known issues

* each ndk version has a lot of changes, direct compilation will fail, 
the build script are not generic, so please solve the error by yourself.

* llvm-rs-cc may have bugs, I rewrote the rs_cc_options.cpp file.