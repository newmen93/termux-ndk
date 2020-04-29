cmake_minimum_required(VERSION 3.4.3)

project(libbcc)


set(LIBBCC_SRC_FILES 
	BCCContext.cpp
	BCCContextImpl.cpp
    Compiler.cpp
    CompilerConfig.cpp
    FileBase.cpp
    Initialization.cpp
    RSAddDebugInfoPass.cpp
    RSCompilerDriver.cpp
    RSEmbedInfo.cpp
    RSGlobalInfoPass.cpp
    RSInvariant.cpp
    RSInvokeHelperPass.cpp
    RSIsThreadablePass.cpp
    RSKernelExpand.cpp
    RSScreenFunctionsPass.cpp
    RSScriptGroupFusion.cpp
    RSStubsWhiteList.cpp
    RSX86CallConvPass.cpp
    RSX86TranslateGEPPass.cpp
    Script.cpp
    Source.cpp
	)


include_directories(${CMAKE_CURRENT_SOURCE_DIR}/../include)
include_directories(${CMAKE_CURRENT_SOURCE_DIR}/../libbcc/bcinfo/include)
include_directories(${CMAKE_CURRENT_SOURCE_DIR}/../bcinfo/include)
include_directories(${CMAKE_CURRENT_SOURCE_DIR}/../bcinfo/rs)


add_library(bcc SHARED ${LIBBCC_SRC_FILES})
target_link_libraries(bcc bcinfo)





