#!/bin/bash

# compile opencv

read -p "We need root permissions to install dependencies. Press any key to continue"

sudo apt update
sudo apt install unzip wget build-essential cmake curl git libgtk2.0-dev pkg-config libavcodec-dev libavformat-dev libswscale-dev libtbb2 libtbb-dev libjpeg-dev libpng-dev libtiff-dev libdc1394-22-dev

sudo apt install system76-cudnn-11.1

OPENCV_RELEASE="4.5.0"

OPENCV_FOLDER="$HOME/bin/opencv"
OPENCV_CONTRIB_FOLDER="$HOME/bin/opencv_contrib"
CORES=$(nproc)


if [ -d $OPENCV_FOLDER ];
then
	echo "$OPENCV_FOLDER already exists"	
else
	git clone https://github.com/opencv/opencv.git $OPENCV_FOLDER
fi

cd $OPENCV_FOLDER

git checkout tags/$OPENCV_RELEASE

if [ -d $OPENCV_CONTRIB_FOLDER ];
then
	echo "$OPENCV_CONTRIB_FOLDER already exists"	
else
	git clone https://github.com/opencv/opencv_contrib.git $OPENCV_CONTRIB_FOLDER
fi

cd $OPENCV_CONTRIB_FOLDER

git checkout tags/$OPENCV_RELEASE

cd $OPENCV_FOLDER
mkdir build
cd build

cmake -j $(CORES) -D CMAKE_BUILD_TYPE=RELEASE -D CMAKE_INSTALL_PREFIX=/opt -D BUILD_SHARED_LIBS=ON -D OPENCV_EXTRA_MODULES_PATH=$(OPENCV_CONTRIB_FOLDER)/modules -D BUILD_DOCS=ON -D BUILD_EXAMPLES=ON -D BUILD_TESTS=OFF -D BUILD_PERF_TESTS=OFF -D BUILD_opencv_java=NO -D BUILD_opencv_python=YES -D BUILD_opencv_python2=NO -D BUILD_opencv_python3=YES -D WITH_JASPER=OFF -DOPENCV_GENERATE_PKGCONFIG=ON -DWITH_CUDA=ON -DENABLE_FAST_MATH=1 -DCUDA_FAST_MATH=1 -DWITH_CUBLAS=1 -DCUDA_TOOLKIT_ROOT_DIR=/usr/lib/cuda-11.1 -DCUDNN_LIBRARIES=/usr/lib/cuda-11.1/lib64 -DCUDNN_INCLUDE_DIR=/usr/lib/cuda-11.1/include -DBUILD_opencv_cudacodec=OFF -D WITH_CUDNN=ON -D OPENCV_DNN_CUDA=ON -D CUDA_GENERATION=Auto ..

make -j "$CORES"

read -p "We need root permissions to install dependencies. Press any key to continue"

sudo make install

sudo ldconfig # update ldconfig to make sure the system is aware of opencv libraries
