cmake_minimum_required(VERSION 3.14.2)

project(BitWriter_2_9)


set(BitWriter_2_9_SRC_FILES
    BitcodeWriter.cpp                               
    BitcodeWriterPass.cpp
    ValueEnumerator.cpp
	)

set(CMAKE_CXX_FLAGS ${CXXFLAGS})

include_directories(${CMAKE_SOURCE_DIR})

add_library(LLVMBitWriter_2_9 STATIC ${BitWriter_2_9_SRC_FILES})

target_link_libraries(LLVMBitWriter_2_9)
