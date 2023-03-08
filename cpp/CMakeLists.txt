project(cpp)
message(STATUS "[${PROJECT_NAME} 系列子库]开始:此库主要用于纯C++编译!")
############################# 公共库 ########################################################

find_package(Open3D REQUIRED)
if (Open3D_FOUND)
    include_directories( ${Open3D_INCLUDE_DIRS}/open3d/3rdparty ${Open3D_INCLUDE_DIRS} )#最高优先级，防止open3d依赖跟vcpkg冲突
    message(STATUS "open3d  Version:     ${Open3D_VERSION} 以[Open3D::Open3D] 导出!  ")
else()
    message(STATUS "open3d         :     配置失败，请检查相关设置!")
endif()
find_package(XtensorALL REQUIRED)
#get_property( dirs DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR} PROPERTY INCLUDE_DIRECTORIES )
#foreach( dir ${dirs} )
#    message( STATUS "include dir=${dir}" )
#endforeach()


############################# 子库 ########################################################
#add_subdirectory(gco)
add_subdirectory(2DSegmentation)
add_subdirectory(3DTeethSeg)
add_subdirectory(3DGenerate)
add_subdirectory(vtk_demo)
#add_subdirectory(MeshFix)
message(STATUS "[${PROJECT_NAME}系列子库]成功!")
message(STATUS "")

