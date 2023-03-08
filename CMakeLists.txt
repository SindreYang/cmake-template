cmake_minimum_required(VERSION 3.15...3.28)
project(My_CMakeProject LANGUAGES C CXX)
############################# 基础配置 ########################################################
set(CMAKE_CXX_STANDARD 14)
set(CMAKE_BUILD_TYPE RelWithDebInfo) #既能优化速度又能调试
#set(CMAKE_BUILD_TYPE Release)

# 路径设置
set(EXECUTABLE_OUTPUT_PATH 	${CMAKE_CURRENT_SOURCE_DIR}/bin/)
set(LIBRARY_OUTPUT_PATH  ${CMAKE_CURRENT_SOURCE_DIR}/bin/lib)
set(PROJECT_BINARY_DIR  ${CMAKE_CURRENT_SOURCE_DIR}/build/)
message(STATUS "[exe生成路径]：${EXECUTABLE_OUTPUT_PATH} ")
set(CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/CMake/)
include(CompileConfig) # 交叉编译配置

############################# 交叉编译配置 ########################################################
if (CMAKE_SYSTEM_NAME STREQUAL "Windows" )
    message(STATUS "[系统为windows]")
    # CMake 模块路径
    include(D:/software/develop/CompileLibrary/vcpkg/scripts/buildsystems/vcpkg.cmake)# 因为指定了工具链，不能使用CMAKE_TOOLCHAIN_FILE，否则不生效
    #set (CMAKE_TOOLCHAIN_FILE D:/software/develop/CompileLibrary/vcpkg/scripts/buildsystems/vcpkg.cmake)
    set(3RDPARTY_DIR ${CMAKE_CURRENT_SOURCE_DIR}/3rdparty/)
    list(APPEND CMAKE_PREFIX_PATH "${3RDPARTY_DIR}/open3d/cpu/CMake")

elseif (CMAKE_SYSTEM_NAME MATCHES "Linux")
    message(STATUS "[系统为linux]")
    set(3RDPARTY_DIR ${CMAKE_CURRENT_SOURCE_DIR}/3rdparty_linux/)
    # CMake 模块路径
    list(APPEND CMAKE_PREFIX_PATH
            "${3RDPARTY_DIR}/open3d/lib/cmake/"
            "${conda_cmake_dir}/lib/cmake/xtensor"
            "${conda_cmake_dir}/lib/cmake/xtensor-blas"
            "${conda_cmake_dir}/lib/cmake/xsimd"
            "${conda_cmake_dir}/share/cmake/xtl")
else()
    MESSAGE(STATUS "不受支持的系统: ${CMAKE_SYSTEM_NAME}")
endif()
############################# 全局第三方库配置 ########################################################
message(STATUS "[第三方库配置]开始:")
find_package(OpenMP REQUIRED)
if (OpenMP_FOUND)
    message(STATUS "OpenMP_C   Version:      ${OpenMP_C_VERSION}   以[OpenMP::OpenMP_C] 导出!")
    message(STATUS "OpenMP_CXX Version:      ${OpenMP_CXX_VERSION} 以[OpenMP::OpenMP_CXX] 导出!")
else()
    message(STATUS "OpenMP            :      配置失败，请检查相关设置!")
endif()

message(STATUS "[第三方库配置]成功!")
############################# 编译子库 ########################################################
message(STATUS "[配置子库]开始:")
add_subdirectory(cpp)
#add_subdirectory(test)
#add_subdirectory(pycpp)
#add_subdirectory(cu)
message(STATUS "[配置子库]成功!")