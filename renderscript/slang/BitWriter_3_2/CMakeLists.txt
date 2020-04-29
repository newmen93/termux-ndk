cmake_minimum_required(VERSION 3.4.3)

project(BitWriter_3_2)


set(BitWriter_3_2_SRC_FILES
    BitcodeWriter.cpp                               
    BitcodeWriterPass.cpp
    ValueEnumerator.cpp
	)


include_directories(${CMAKE_SOURCE_DIR})

add_library(LLVMBitWriter_3_2 STATIC ${BitWriter_3_2_SRC_FILES})

target_link_libraries(LLVMBitWriter_3_2)
