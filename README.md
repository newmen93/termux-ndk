This is the Google standard NDK and supports Termux and aarch64 host devices.

clang version: 11.0.1
##### [download r21](https://github.com/Lzhiyong/termux-ndk/releases)


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

# no build windows
python toolchain/llvm_android/build.py --no-build windows
```
 ****
You need to download the prebuilt ndk-r21, before performing build.py

```bash
# remove prebuilt clang, CLANG_PREBUILT_VERSION is defined in ~/llvm-toolchain/toolchain/llvm_android/constants.py

rm -vrf ~/llvm-toolchain/prebuilts/clang/host/linux-x86/CLANG_PREBUILT_VERSION/*

# extract android-ndk-r21.tar.xz to your path
tar -xJvf android-ndk-r21.tar.xz -C /path/to/android-ndk-r21

# copy ndk llvm to prebuilt clang directory
 cp -r android-ndk-r21/toolchains/llvm/prebuilt/linux-aarch64/* ~/llvm-toolchain/prebuilts/clang/host/linux-x86/CLANG_PREBUILT_VERSION

# you have installed cmake via apt install cmake
ln -sf /data/data/com.termux/files/usr/bin/cmake ~/llvm-toolchain/prebuilts/cmake/linux-x86/bin/cmake

# you have installed ninja via apt install ninja
ln -sf /data/data/com.termux/files/usr/bin/ninja ~/llvm-toolchain/prebuilts/ninja/linux-x86/bin/ninja

# remove prebuilt python
rm -vrf ~/llvm-toolchain/prebuilts/python/linux-x86/*

# you have installed python3 via apt install python

# extract /data/data/com.termux/files/usr/var/cache/apt/archives/python_3.8.2_aarch64.deb to ~/llvm-toolchain/prebuilts/python/linux-x86
# or modify ~/llvm-toolchain/toolchain/llvm_android/py3_utils.py 

# go is the same

# apt install libedit and cpoy libedit to prebuilt dirctory
cp /data/data/com.termux/files/usr/lib/libedit* ~/llvm-toolchain/prebuilts/libedit/linux-x86/lib

# apt install swig and copy swig to prebuilt directory
cp /data/data/com.termux/files/usr/bin/swig ~/llvm-toolchain/prebuilts/swig/linux-x86/bin

# modify llvm-toolchain/toolchain/llvm_android/configs.py 
# sysroot: llvm-toolchain/prebuilts/clang/host/linux-x86/CLANG_PREBUILT_VERSION/sysroot
```
There are some that need to be modified, please see llvm_android for details

 **** 
###  OK start compile now!
```bash
# no build windows
python toolchain/llvm_android/build.py --no-build windows
```

 **** 
#### Building binutils
```bash
python toolchain/binutils/build.py

# or compile it yourself
# host is aarch64-linux-android
# target: arm-linux-androideabi 
#         aarch64-linux-android
#         i686-linux-android
#         x86_64-linux-android

cd binutils && mkdir build && cd build

TOOLCHAIN=/path/to/android-ndk-r21/toolchains/llvm/prebuilt/linux-aarch64

../configure \                                      
    CC=$TOOLCHAIN/bin/aarch64-linux-android29-clang \                                              
    CXX=$TOOLCHAIN/bin/aarch64-linux-android29-clang++ \                                           
    CFLAGS="-fPIC -std=c11" \                       
    CXXFLAGS="-fPIC -std=c++17" \                   
    --prefix=$HOME/binutils/x86_64 \                
    --host=aarch64-linux-android \                  
    --target=x86_64-linux-android \
    --enable-initfini-array \                       
    --enable-plugins \                              
    --enable-gold \
    --enable-lto \
    --enable-libada \
    --enable-liboffloadmic=target \
    --enable-libssp \
    --enable-threads \
    --enable-new-dtags
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

git clone https://github.com/google/shaderc

cd shaderc/third_party

git clone https://github.com/KhronosGroup/SPIRV-Tools.git   spirv-tools

git clone https://github.com/KhronosGroup/SPIRV-Headers.git spirv-tools/external/spirv-headers
    
git clone https://github.com/google/googletest.git

git clone https://github.com/google/effcee.git

git clone https://github.com/google/re2.git

git clone https://github.com/KhronosGroup/glslang.git


# start building...

cd ~/shaderc && mkdir build && cd build

TOOLCHAIN=/path/to/android-ndk-r21/toolchains/llvm/prebuilt/linux-aarch64

cmake -G "Ninja" \
    -DCMAKE_C_COMPILER=$TOOLCHAIN/bin/aarch64-linux-android29-clang \
    -DCMAKE_CXX_COMPILER=$TOOLCHAIN/bin/aarch64-linux-android29-clang++ \
    -DCMAKE_SYSROOT=$TOOLCHAIN/sysroot \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/path/to/shader-tools \
    ..

ninja install -j16
```

 **** 
#### Building renderscript (bcc_compat llvm-rs-cc)
build bcc_compat and llvm-rs-cc need older version llvm and clang, download [llvm](https://github.com/Lzhiyong/termux-ndk/releases)
 or you can download the source code and compile it yourself

```bash
# slang source code
# git clone https://android.googlesource.com/platform/frameworks/compile/slang
# libbcc source code
# git clone https://android.googlesource.com/platform/frameworks/compile/libbcc
# rs souce code
# git clone https://android.googlesource.com/platform/frameworks/rs
# llvm and clang source code
# git clone https://android.googlesource.com/platform/external/llvm
# git clone https://android.googlesource.com/platform/external/clang


# I assume you have llvm
git clone https://github.com/Lzhiyong/termux-ndk.git

tar -xJvf llvm.tar.xz -C renderscript

# build llvm-rs-cc
cd renderscript/slang/build
./build.sh

# build bcc_compat
cd renderscript/libbcc/build
./build.sh


# I rewrote the code of rs_cc_options.cpp, this may have bugs.
# because RSCCOptions.inc compilation error, I can't solve it yet.
# RSCCOptions.inc is generated by llvm-tblgen, But I don’t know why there is an error
# llvm-tblgen -I=../llvm/include RSCCOptions.tb -o RSCCOptions.inc
# if you don't want to compile liblog, modify <log/log.h> to <android/log>
```
 **** 
#### Building finish!
llvm-toolchain stage1 and stage2 compilation takes about 10 hours.

If your phone performance is good, the time may be shorter, but it still takes a lot of time to compile.

There may be some errors during the compilation process, please solve it yourself!

 **** 
#### Test app with NDK cmake
using termux to build termux.

download the necessary tools, [gradle](https://gradle.org) and [openjdk](https://github.com/Lzhiyong/termux-ndk/releases)

update [aapt2](https://github.com/Lzhiyong/build-tools) is here.

================ Please note!!! ===============

when you execute the gradle build command finish, some errors will occur.

this is because the gradle plugin will download a corresponding aapt2.

We need to replace the aapt2, aapt2 in /data/data/com.termux/files/home/.gradle (aapt2-3.6.1-6040484-linux.jar)

execute the find command to search for aapt2, for example: find . -type f -name "\*aapt2\*.jar"

extract the jar file, aapt2 in this jar file, replace it with [android-sdk](https://github.com/Lzhiyong/termux-ndk/releases)/build-tools/aapt2

if there are errors, continue to replace！


```bash
# set build tools version
buildToolsVersion "30.0.0-rc1"

# update the cmake version
......

externalNativeBuild {
    cmake {
        // specify the cmake version
        version "3.17.2"
        arguments "-DANDROID_APP_PLATFORM=android-21", "-DANDROID_STL=c++_static", "-fuse-ld=lld"
        abiFilters 'armeabi-v7a', 'arm64-v8a', 'x86', 'x86_64'
    }
}

......

# modify local.properties file
# sdk.dir=/path/to/android-sdk
# ndk.dir=/path/to/ndk
# cmake.dir=/path/to/cmake

cd termux-ndk/cmake-example && gradle build
```

Screenshot_01.jpg
![image](https://github.com/Lzhiyong/termux-ndk/blob/master/screenshot/Screenshot_01.jpg)

Screenshot_02.jpg
![image](https://github.com/Lzhiyong/termux-ndk/blob/master/screenshot/Screenshot_02.jpg)


