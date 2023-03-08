project(vtk_demo LANGUAGES C CXX)
message(STATUS "[${PROJECT_NAME}子库] 开始!")


####################### 编译设置 ############################

find_package(VTK REQUIRED)
include_directories(${VTK_USE_FILE})
if (NOT VTK_FOUND)
    message(FATAL_ERROR " 找不到 VTK ")
endif()

# 防止 Windows 中出现“命令行太长”故障。
set(CMAKE_NINJA_FORCE_RESPONSE_FILE "ON" CACHE BOOL "Force Ninja to use response files.")
add_executable(${PROJECT_NAME} MACOSX_BUNDLE src/demo.cpp )
target_link_libraries(${PROJECT_NAME} PRIVATE ${VTK_LIBRARIES})
# 需要vtk_module_autoinit
vtk_module_autoinit(TARGETS ${PROJECT_NAME} MODULES ${VTK_LIBRARIES})




