cmake_minimum_required(VERSION 3.4.3)

project(Wrap)

set(Wrap_SRC_FILES
	bitcode_wrapperer.cpp
    file_wrapper_input.cpp
    file_wrapper_output.cpp
    in_memory_wrapper_input.cpp
    wrapper_output.cpp
	)

include_directories(${CMAKE_CURRENT_SOURCE_DIR}/../include)

add_library(LLVMWrap STATIC ${Wrap_SRC_FILES})

target_link_libraries(LLVMWrap)


