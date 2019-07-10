#/bin/bash

CUDA_PATH=/usr/local/cuda-10.0
TF_PATH=~/miniconda3/envs/point-sift/lib/python3.6/site-packages/tensorflow
INCLUDE_PATH=$TF_PATH/include

$CUDA_PATH/bin/nvcc tf_sampling_g.cu -o tf_sampling_g.cu.o -c -O2 -DGOOGLE_CUDA=1 -x cu -Xcompiler -fPIC

# TF1.2
#g++ -std=c++11 tf_sampling.cpp tf_sampling_g.cu.o -o tf_sampling_so.so -shared -fPIC -I /usr/local/lib/python2.7/dist-packages/tensorflow/include -I /usr/local/cuda-8.0/include -lcudart -L /usr/local/cuda-8.0/lib64/ -O2 -D_GLIBCXX_USE_CXX11_ABI=0

# TF1.4
g++ -std=c++11 tf_sampling.cpp tf_sampling_g.cu.o -o tf_sampling_so.so -shared -fPIC -I $INCLUDE_PATH -I $CUDA_PATH/include -I $INCLUDE_PATH/external/nsync/public -lcudart -L $CUDA_PATH/lib64/ -L $TF_PATH -ltensorflow_framework -O2 -D_GLIBCXX_USE_CXX11_ABI=0
