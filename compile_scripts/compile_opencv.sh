#!/bin/bash

# compile opencv

OPENCV_RELEASE="4.3.0"

OPENCV_FOLDER="$HOME/bin/opencv"
OPENCV_CONTRIB_FOLDER="$HOME/bin/opencv_contrib"

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

cmake -D CMAKE_BUILD_TYPE=RELEASE \
            -D CMAKE_INSTALL_PREFIX=/usr/local \
            -D INSTALL_C_EXAMPLES=ON \
            -D INSTALL_PYTHON_EXAMPLES=ON \
            -D WITH_TBB=ON \
            -D WITH_V4L=ON \
            -D OPENCV_PYTHON3_INSTALL_PATH=$cwd/OpenCV-$OPENCV_RELEASE-py3/lib/python3.6/site-packages \
        -D WITH_QT=ON \
        -D WITH_OPENGL=ON \
        -D OPENCV_EXTRA_MODULES_PATH=../../opencv_contrib/modules \
        -D BUILD_EXAMPLES=ON ..

make

read -p "We need root permissions to install dependencies. Press any key to continue"

sudo make install
