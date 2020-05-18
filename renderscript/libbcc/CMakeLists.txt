cmake_minimum_required(VERSION 3.14.2)

project(bcc)

set(HOME "/data/data/com.termux/files/home")

set(TOOLCHAIN "${HOME}/android/android-ndk-r21/llvm/prebuilt/linux-aarch64")

set(CMAKE_C_COMPILE "${TOOLCHAIN}/bin/aarch64-linux-android29-clang")
set(CMAKE_CXX_COMPILE "${TOOLCHAIN}/bin/aarch64-linux-android29-clang++")

set(CXXFLAGS " \
    -fno-rtti -fno-exceptions \
    -fPIC -std=c++11 \
    -Wno-deprecated-declarations \
    -D__DISABLE_ASSERTS \
    -DFORCE_ARM64_CODEGEN \
    -DARCH_ARM_HAVE_NEON \
    -DARCH_ARM_HAVE_VFP \
    -DARCH_ARM_HAVE_VFP_D32 \
    -DDISABLE_CLCORE_NEON \
    ")

set(CMAKE_CXX_FLAGS ${CXXFLAGS})

include_directories(${CMAKE_SOURCE_DIR}/../llvm/include)
include_directories(${CMAKE_SOURCE_DIR}/../slang)

link_directories(${CMAKE_SOURCE_DIR}/../slang/build/StripUnkAttr)                   
link_directories(${CMAKE_SOURCE_DIR}/../slang/build/BitWriter_3_2)                   
link_directories(${CMAKE_SOURCE_DIR}/../llvm/lib)

add_subdirectory(bcinfo)
add_subdirectory(lib)
add_subdirectory(tools)


