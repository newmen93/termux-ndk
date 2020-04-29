cmake_minimum_required(VERSION 3.4.3)

project(bcc)


set(CMAKE_C_COMPILE ${HOME}/android/aarch64-linux-android/bin/clang)
set(CMAKE_CXX_COMPILE ${HOME}/android/aarch64-linux-android/bin/clang++)

set(CXXFLAGS, "-fno-rtti -fno-exceptions -Wall -Werror -std=c++11 -D__DISABLE_ASSERTS -DFORCE_ARM64_CODEGEN -DARCH_ARM_HAVE_NEON -DARCH_ARM_HAVE_VFP -DARCH_ARM_HAVE_VFP_D32 -DDISABLE_CLCORE_NEON")

set(CMAKE_CXX_FLAGS ${CXXFLAGS})

include_directories(${CMAKE_SOURCE_DIR}/../clang-3.9/include)
include_directories(${CMAKE_SOURCE_DIR}/../slang)

link_directories(${CMAKE_CURRENT_SOURCE_DIR}/../slang/build/StripUnkAttr)                   
link_directories(${CMAKE_CURRENT_SOURCE_DIR}/../slang/build/BitWriter_3_2)                   
link_directories(${CMAKE_CURRENT_SOURCE_DIR}/../clang-3.9/lib)


add_subdirectory(bcinfo)
add_subdirectory(lib)
add_subdirectory(tools)


