

<div align="center">

# CMAKE 模板
<a href="https://cmake.org/"><img alt="Config: Cmake" src="https://img.shields.io/badge/config-cmake-brightgreen"></a>
[![Conference](https://img.shields.io/badge/User-Sindre-orange)]()
[![Conference](https://img.shields.io/badge/Update-2023-blue)]()

</div>


# 简介
提供良好的cmake配置，减少配置时间，同时提供常用cpp配置选项

1. 头文件与源文件分离原则；
2. 公共配置与项目配置分离；
3. 更好的生成目录，加载目录统一原则；
4. 提供C++调用python多线程实例；


# 建议使用库
1. CUDA(11.6) --------------------> 用于cuda编程。
2. xtensor（vcpkg安装)------------->  用于替代python的numpy，可以直接npy交换数据。
3. python3.9  --------------------> 用于混合编程，torch扩展。
4. pybind11 --------------------> 用于混合编程，torch扩展。
5.  vtk（vcpkg安装)------------->  3D渲染，图片网格点云操作。
6.  open3d（官网安装)------------->  3D渲染，图片网格点云操作。
7.  onnxruntime（官网安装)------------->  AI多后端推理。


# 目录结构

```
├─.
│  CMakeLists.txt        --> 全局公共配置
│  
│      
├─3rdparty               --> 第三方包编译目录
│  └─pybind11
│    
│              
├─CMake                  --> 编译配置，以及自定义的Findxxxx.cmake
│      CompileConfig.cmake
│      FindXtensorAll.cmake
│      
├─cpp                     -->  C++编译空间
│  │  CMakeLists.txt       -->  公共配置及子项目选择
│  │  
│  └─vtk_demo
│      │  CMakeLists.txt  --> 针对该项目特定编译配置
│      │  
│      ├─include
│      └─src
│              
├─cu                       -->  cuda编译空间      
│  │  CMakeLists.txt       -->  公共配置及子项目选择     
│  │                                        
│  └─Add                                    
│      │  CMakeLists.txt    --> 针对该项目特定编译配置 
│      │  
│      ├─include
│      │      
│      └─src
│              
└─pycpp                      -->  C++/Py混合编程空间     
    │  CMakeLists.txt        -->  公共配置及子项目选择   
    │                                          
    └─CppCallPy                                
        │  CMakeLists.txt     --> 针对该项目特定编译配置  
        │  
        ├─include
        │      
        └─src
                

```
# 使用指南
1. 首先配置最外层**CMakeLists.txt**,这里决定全局配置，默认建议从**vcpkg安装C++库**。
   1. 由**add_subdirectory(cpp)** 来选择需要编译的子库。
   2. 由CMake目录下的**CompileConfig.cmake**开启优化选项 。
2. 其次，针对子库进行配置，子库的**CMakeLists.txt**用于配置该空间下公共库及配置，以及各性化择取需要编译的子子库。


