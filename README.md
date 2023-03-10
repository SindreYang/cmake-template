

<div align="center">

# CMAKE 模板
<a href="https://cmake.org/"><img alt="Config: Cmake" src="https://img.shields.io/badge/config-cmake-brightgreen"></a>
[![Conference](https://img.shields.io/badge/User-Sindre-orange)]()
[![Conference](https://img.shields.io/badge/Update-2023-blue)]()

</div>


# 简介
提供良好的cmake配置，减少配置时间，同时提供常用cpp配置选项。

**使用场景：**
1. 从Visual Studio 转换到Cmake,但不熟悉cmake指令的，如openmp；
2. 多平台cmake编译配置；
3. 建立统一C++环境，且每个项目之间不互相依赖，需要啥配啥；
4. 需要借助C++调用python,提供一定函数封装(pywarp.cpp)；
5. 一个目录，开发所有项目，不再配置环境；


**优势：**
1. 头文件与源文件分离原则；
2. 公共配置与项目配置分离；
3. 更好的生成目录，加载目录统一原则；
4. 提供C++调用python多线程实例；
5. 提供pybind11配置，onnxruntime1.13静态编译包。


# 提问
1. 为什么部署需要这么复杂？
   1. 答 :这不是单纯部署框架，这是编程规范。
      1. 一个良好的目录结构有助于编程者的逻辑梳理，同时减少冗余代码问题。
      2. 有很多特定环境下指令，如cmake指令，msvc指令，clang指令，多平台指令等等，有时往往需花费大量时间查询，甚至不可能面面俱到。
      3. 很多用vs2019的开发人员，习惯gui配置指令，一用到cmake就无从下手。

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


