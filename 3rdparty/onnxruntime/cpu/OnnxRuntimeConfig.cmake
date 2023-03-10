set(OnnxRuntime_INCLUDE_DIRS "${CMAKE_CURRENT_LIST_DIR}/include")
file(GLOB_RECURSE OnnxRuntime_LIBS ${CMAKE_CURRENT_LIST_DIR}/lib/*.lib)
include_directories(${OnnxRuntime_INCLUDE_DIRS})
link_directories(${CMAKE_CURRENT_LIST_DIR}/lib)

