building openjdk-11 for Android with Termux

download the source code from [AdoptOpenJDK/openjdk-jdk11u](https://github.com/AdoptOpenJDK/openjdk-jdk11u) release

##### install X11 packages from x11-repo
```bash
apt install x11-repo
apt install libx11 libxext libxrender libxrandr libxtst libxt xorgproto fontconfig pulseaudio

```

##### building cups
```bash
git clone https://github.com/apple/cups
cd cups 
./configure --prefix=/path/to/libcups
make -j16
```

##### building alsa-lib
```bash
git clone https://github.com/alsa-project/alsa-lib
cd alsa-lib
./gitcompile
./configure --prefix=/path/to/alsa-lib
make -j16
```

##### building openjdk-11
```bash
# I downloaded openjdk-jdk11u-jdk-11.0.8-10_adopt from AdoptOpenJDK
# you can also download other versions

FLAGS="-fdiagnostics-color -fPIC -fno-emulated-tls"

./configure \
    CC=clang \
    CXX=clang++ \
    --with-debug-level=release \
    --with-extra-cflags="$FLAGS" \
    --with-extra-cxxflags="$FLAGS -std=c++11" \
    --with-extra-ldflags="-fuse-ld=lld" \
    --with-toolchain-type="clang" \
    --with-x \
    --with-cups=/path/to/libcups \
    --with-alsa=/path/to/alsa-lib \
    --disable-warnings-as-errors

```
##### building finish
![image](/storage/emulated/0/DCIM/Screenshots/IMG_20201223_212301.jpg)

 **** 

#### Issues
1. jdk/lib/libxxx.so has unsupported flags DT_FLAGS_1=0x81, please using termux-elf-cleaner to remove it. for example: termux-elf-cleaner *.so


2. jshell has segmentation fault
![image](/storage/emulated/0/DCIM/Screenshots/IMG_20201223_161621.jpg)


3. Android TLS(thread local storage) seems to have a bug, so add cxxflags -fno-emulated-tls to disable TLS supports, please refer [android-elf-tls](xxx) for more information
>ld.lld: error: libjvm.so: undefined reference to Thread::_thr_current , or libjvm.so: undefined reference to _ZN6Thread12_thr_currentE
>
>Thread::_thr_current defined in src/hotspot/share/utilities/thread.hpp
>
>_ZN6Thread12_thr_currentE defined in src/hotspot/os_cpu/linux_aarch64/threadLS_linux_aarch64.s


4. Test if TLS working
```bash
cd openjdk-build/tls-test
./build.sh
```
**On Android Failure**
![image](/storage/emulated/0/DCIM/Screenshots/IMG_20201223_161641.jpg)
**On TermuxArch (ArchLinux) Success**
![image](/storage/emulated/0/DCIM/Screenshots/IMG_20201223_210119.jpg)

5. If anyone knows, please submit an issue

