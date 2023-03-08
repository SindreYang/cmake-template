#include <iostream>
#include "add.h"
//
// Created by sindre on 2023/1/28.
//

// ���������ӷ�kernel��grid��block��Ϊһά
__global__ void add(float* x, float * y, float* z, int n)
{
    // ��ȡȫ������
    int index = threadIdx.x + blockIdx.x * blockDim.x;
    // ����
    int stride = blockDim.x * gridDim.x;
    for (int i = index; i < n; i += stride)
    {
        z[i] = x[i] + y[i];
    }
}


void get_cuda_info(){
    int dev=0;
    cudaDeviceProp devProp;
    cudaGetDeviceProperties(&devProp, dev);
    std::cout << "ʹ��GPU device " << dev << ": " << devProp.name << std::endl;
    std::cout << "�Դ��С��"  << devProp.totalGlobalMem / 1024.0 / 1024.0/ 1024.0<< " GB" << std::endl;
    std::cout << "SM��������" << devProp.multiProcessorCount << std::endl;
    std::cout << "ÿ���߳̿�Ĺ����ڴ��С��"  << devProp.sharedMemPerBlock / 1024.0 << " KB" << std::endl;
    std::cout << "ÿ���߳̿������߳�����" << devProp.maxThreadsPerBlock << std::endl;
    std::cout << "ÿ��EM������߳�����" << devProp.maxThreadsPerMultiProcessor << std::endl;
    std::cout << "ÿ��SM������߳�������" << devProp.maxThreadsPerMultiProcessor / 32 << std::endl;

}

void add_test()
{
    system("mode con cp select=936"); // 65001   UTF-8����ҳ  936��������Ĭ�ϵ�GBK
    get_cuda_info();
    int N = 1 << 20;
    int nBytes = N * sizeof(float);

    // �����й��ڴ�
    float *x, *y, *z;
    cudaMallocManaged((void**)&x, nBytes);
    cudaMallocManaged((void**)&y, nBytes);
    cudaMallocManaged((void**)&z, nBytes);

    // ��ʼ������
    for (int i = 0; i < N; ++i)
    {
        x[i] = 10.0;
        y[i] = 20.0;
    }

    // ����kernel��ִ������
    dim3 blockSize(256);
    dim3 gridSize((N + blockSize.x - 1) / blockSize.x);
    // ִ��kernel
    add << < gridSize, blockSize >> >(x, y, z, N);

    // ͬ��device ��֤�������ȷ����
    cudaDeviceSynchronize();
    // ���ִ�н��
    float maxError = 0.0;
    for (int i = 0; i < N; i++)
        maxError = fmax(maxError, fabs(z[i] - 30.0));
    std::cout << "������: " << maxError << std::endl;

    // �ͷ��ڴ�
    cudaFree(x);
    cudaFree(y);
    cudaFree(z);


    system("pause");
}