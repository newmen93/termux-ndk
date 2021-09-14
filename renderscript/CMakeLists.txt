cmake_minimum_required(VERSION 3.14.2)

project(renderscript)

set(CMAKE_C_FLAGS "-fcolor-diagnostics -fPIC -std=c11")
set(CMAKE_CXX_FLAGS "-fcolor-diagnostics -fPIC -Wno-inconsistent-missing-override -Wno-deprecated-declarations -fno-rtti -fno-exceptions -std=c++11")
set(CMAKE_EXE_LINKER_FLAGS "-static")

include(CMakeLists.slang.txt)
include(CMakeLists.liblog.txt)
include(CMakeLists.libbcc.txt)
