cmake_minimum_required(VERSION 3.4.3)

project(BitReader_3_0)

set(BitReader_3_0_SRC_FILES
	BitcodeReader.cpp 
	)

add_library(LLVMBitReader_3_0 STATIC ${BitReader_3_0_SRC_FILES})

target_link_libraries(LLVMBitReader_3_0)


