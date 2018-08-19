# termux-ndk
This is google android ndk,it only support arm64 and  aarch64 device

NDK version: android-ndk-r17 [download](https://github.com/Lzhiyong/termux-ndk/releases)


### How to use
to edit your bash.bashrc file 

add PATH environment variables

export NDK="your path"

export PATH=$PATH:$NDK

source bash.bashrc

OK,now you can execute ndk-build command!

termux-ndk_01.png

![image](https://raw.githubusercontent.com/Lzhiyong/termux-ndk/master/termux-ndk_01.png)



====================================================


termux-ndk_02.png

![image](https://raw.githubusercontent.com/Lzhiyong/termux-ndk/master/termux-ndk_02.png)

====================================================

If you want to create a standard toolchain,you need install a linux,for example [TermuxArch](https://github.com/sdrausty/TermuxArch.git)

termux-ndk_03.png

![image](https://raw.githubusercontent.com/Lzhiyong/termux-ndk/master/termux-ndk_03.png)
