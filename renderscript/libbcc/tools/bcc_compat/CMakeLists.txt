cmake_minimum_required(VERSION 3.4.3)

project(bcc_compat)

set(BCC_COMPAT_SRC_FILES Main.cpp)


include_directories(${CMAKE_CURRENT_SOURCE_DIR}/../../include)
include_directories(${CMAKE_CURRENT_SOURCE_DIR}/../../bcinfo/include)

add_executable(bcc_compat ${BCC_COMPAT_SRC_FILES})
target_link_libraries(bcc_compat bcc bcinfo LLVM_static -lz -lm)
