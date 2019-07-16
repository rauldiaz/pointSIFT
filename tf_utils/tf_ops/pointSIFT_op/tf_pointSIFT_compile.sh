#/bin/bash

CUDA_PATH=/usr/local/cuda
TF_PATH=~/miniconda3/envs/point-sift/lib/python3.6/site-packages/tensorflow
INCLUDE_PATH=$TF_PATH/include


$CUDA_PATH/bin/nvcc pointSIFT.cu -o pointSIFT_g.cu.o -c -O2 -DGOOGLE_CUDA=1 -x cu -Xcompiler -fPIC

# TF1.4
g++ -std=c++11 main.cpp pointSIFT_g.cu.o -o tf_pointSIFT_so.so -shared -fPIC -I $INCLUDE_PATH -I $CUDA_PATH/include -I $INCLUDE_PATH/external/nsync/public -lcudart -L $CUDA_PATH/lib64/ -L $TF_PATH -ltensorflow_framework -O2 -D_GLIBCXX_USE_CXX11_ABI=0
