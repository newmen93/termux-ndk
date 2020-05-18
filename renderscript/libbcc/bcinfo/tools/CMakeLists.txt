cmake_minimum_required(VERSION 3.14.2)

project(bcinfo_exe)

set(BCINFO_SRC_FILES
	main.cpp
	)

include_directories(${CMAKE_CURRENT_SOURCE_DIR}/../include)

#set(CMAKE_EXE_LINKER_FLAGS "-static")

add_executable(bcinfo_exe  ${BCINFO_SRC_FILES})
target_link_libraries(bcinfo_exe bcinfo clang_static LLVM_static -lm -llog)


