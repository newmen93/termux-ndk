cmake_minimum_required(VERSION 3.4.3)

project(libbcinfo)

set(LIBBCINFO_SRC_FILES
	BitcodeTranslator.cpp 
	BitcodeWrapper.cpp 
	MetadataExtractor.cpp 
	)


add_subdirectory(BitReader_2_7)
add_subdirectory(BitReader_3_0)
add_subdirectory(Wrap)
add_subdirectory(tools)


include_directories(${CMAKE_CURRENT_SOURCE_DIR}/../lib)
include_directories(${CMAKE_CURRENT_SOURCE_DIR}/rs)
include_directories(${CMAKE_CURRENT_SOURCE_DIR}/include)


add_library(bcinfo SHARED ${LIBBCINFO_SRC_FILES})
target_link_libraries(bcinfo LLVMWrap LLVMBitReader_2_7 LLVMBitReader_3_0 LLVMBitWriter_3_2 StripUnkAttr LLVMBitReader LLVMCore LLVMSupport log)





