#!/bin/bash

# compile opencv

read -p "Please download this file to Downloads folder: https://developer.download.nvidia.com/compute/machine-learning/cudnn/secure/8.0.5/11.1_20201106/cudnn-11.1-linux-x64-v8.0.5.39.tgz and press any key to continue"

cd ~/Downloads
tar -xvf cudnn-11.1-linux-x64-v8.0.5.39.tgz

sudo mkdir -p /usr/local/cuda/lib64
sudo mkdir -p /usr/local/cuda/include

cd ~/Downloads/cuda/lib64/
sudo cp * /usr/local/cuda/lib64/

cd ~/Downloads/cuda/include/
sudo cp * /usr/local/cuda/include/

read -p "We need root permissions to install dependencies. Press any key to continue"

sudo apt update
sudo apt install unzip wget build-essential cmake curl git libgtk2.0-dev libgtk-3-dev pkg-config libavcodec-dev libavformat-dev libswscale-dev libtbb2 libtbb-dev libjpeg-dev libpng-dev libtiff-dev libdc1394-22-dev

sudo apt install system76-cudnn-11.1

OPENCV_RELEASE="4.5.3"

OPENCV_FOLDER="$HOME/bin/opencv"
OPENCV_CONTRIB_FOLDER="$HOME/bin/opencv_contrib"
CORES=$(nproc)

if [ -d $OPENCV_FOLDER ];
then
	echo "$OPENCV_FOLDER already exists"
	git pull	
else
	git clone https://github.com/opencv/opencv.git $OPENCV_FOLDER
fi

cd $OPENCV_FOLDER

git checkout tags/$OPENCV_RELEASE

if [ -d $OPENCV_CONTRIB_FOLDER ];
then
	echo "$OPENCV_CONTRIB_FOLDER already exists"
	git pull	
else
	git clone https://github.com/opencv/opencv_contrib.git $OPENCV_CONTRIB_FOLDER
fi

cd $OPENCV_CONTRIB_FOLDER

git checkout tags/$OPENCV_RELEASE

cd $OPENCV_FOLDER
mkdir build
cd build

#cmake -j $(CORES) -D CMAKE_BUILD_TYPE=RELEASE -D CMAKE_INSTALL_PREFIX=/opt -D BUILD_SHARED_LIBS=ON -D OPENCV_EXTRA_MODULES_PATH=$(OPENCV_CONTRIB_FOLDER)/modules -D BUILD_DOCS=ON -D BUILD_EXAMPLES=ON -D BUILD_TESTS=OFF -D BUILD_PERF_TESTS=OFF -D BUILD_opencv_java=NO -D BUILD_opencv_python=YES -D BUILD_opencv_python2=NO -D BUILD_opencv_python3=YES -D WITH_JASPER=OFF -DOPENCV_GENERATE_PKGCONFIG=ON -DWITH_CUDA=ON -DENABLE_FAST_MATH=1 -DCUDA_FAST_MATH=1 -DWITH_CUBLAS=1 -DCUDA_TOOLKIT_ROOT_DIR=/usr/lib/cuda-11.1 -DCUDNN_LIBRARIES=/usr/lib/cuda-11.1/lib64 -DCUDNN_INCLUDE_DIR=/usr/lib/cuda-11.1/include -DBUILD_opencv_cudacodec=OFF -D WITH_CUDNN=ON -D OPENCV_DNN_CUDA=ON -D CUDA_GENERATION=Auto ..

# -D CUDA_ARCH_BIN=7.5 this parameter is really important. Check supported CUDA version for the card here https://developer.nvidia.com/cuda-gpus

cmake -D CMAKE_BUILD_TYPE=RELEASE \
-D CUDA_TOOLKIT_ROOT_DIR=/usr/lib/cuda-11.1 \
-D INSTALL_PYTHON_EXAMPLES=ON \
-D INSTALL_C_EXAMPLES=OFF \
-D ENABLE_CXX11=ON \
-D CMAKE_C_COMPILER=/usr/bin/gcc-9 \
-D CMAKE_INSTALL_PREFIX=/usr/local \
-D BUILD_opencv_python2=OFF \
-D BUILD_opencv_python3=ON \
-D BUILD_opencv_cudacodec=OFF \
-D CUDA_ARCH_BIN=7.5 \
-D CUDA_ARCH_PTX= \
-D CUDNN_VERSION='8.0.5' \
-D CUDNN_LIBRARY=/usr/local/cuda/lib64/libcudnn.so.8.0.5 \
-D CUDNN_INCLUDE_DIR=/usr/local/cuda/include \
-D CUDA_FAST_MATH=1 \
-D ENABLE_FAST_MATH=1 \
-D OPENCV_DNN_CUDA=ON \
-D OPENCV_ENABLE_NONFREE=ON \
-D OPENCV_EXTRA_MODULES_PATH=$(OPENCV_CONTRIB_FOLDER)/modules \
-D OPENCV_GENERATE_PKGCONFIG=ON \
-D OPENCV_PC_FILE_NAME=opencv.pc \
-D PYTHON_EXECUTABLE=~/.virtualenvs/cv/bin/python \
-D WITH_QT=OFF \
-D WITH_TBB=ON \
-D WITH_CUBLAS=1 \
-D WITH_CUDA=ON \
-D WITH_CUDNN=ON \
-D WITH_GSTREAMER=ON \
-D WITH_LIBV4L=ON \
-D WITH_OPENGL=ON \
-D BUILD_EXAMPLES=ON .. \
-D BUILD_PERF_TESTS=OFF \
-D BUILD_TESTS=OFF \

make -j "$CORES"

read -p "We need root permissions to install dependencies. Press any key to continue"

sudo make install

sudo ldconfig # update ldconfig to make sure the system is aware of opencv libraries
