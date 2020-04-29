cmake_minimum_required(VERSION 3.4.3)

project(bcinfo_exe)

set(BCINFO_SRC_FILES
	main.cpp
	)

include_directories(${CMAKE_CURRENT_SOURCE_DIR}/../include)

add_executable(bcinfo_exe  ${BCINFO_SRC_FILES})

target_link_libraries(bcinfo_exe bcinfo LLVMBitReader LLVMBitWriter LLVMCore LLVMSupport -lm)


