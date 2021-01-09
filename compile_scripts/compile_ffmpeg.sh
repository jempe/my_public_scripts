#!/bin/bash

# compile ffmpeg with cuda support


if grep -q "Pop!_OS 20.04 LTS" /etc/os-release;
then
	echo "Local OS is POP! OS 20.04"
else
	echo "unsupported OS"
	exit 1
fi

read -p "We need root permissions to proceed. Press any key to continue"

sudo apt update
sudo apt install git nvidia-cuda-toolkit system76-cuda-latest build-essential yasm cmake libtool libc6 libc6-dev unzip wget libnuma1 libnuma-dev

# clone and install ffnvcodec
git clone https://git.videolan.org/git/ffmpeg/nv-codec-headers.git

read -p "We need root permissions to proceed. Press any key to continue"

cd nv-codec-headers && sudo make install && cd –

#clone and install FFMPEG
git clone https://git.ffmpeg.org/ffmpeg.git ffmpeg/
cd ffmpeg

./configure --enable-nonfree --enable-cuda-nvcc --enable-libnpp --extra-cflags=-I/usr/lib/cuda/include --extra-ldflags=-L/usr/lib/cuda/lib64/

CORES=$(nproc)
make -j "$CORES"

read -p "We need root permissions to proceed. Press any key to continue"

sudo make install
