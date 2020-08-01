#!/bin/bash

# compile openscad

LIBGPHOTO2_RELEASE="libgphoto2-2_5_24-release"
LIBGPHOTO2_FOLDER="$HOME/bin/libgphoto2"
GPHOTO2_RELEASE="gphoto2-2_5_23-release"
GPHOTO2_FOLDER="$HOME/bin/gphoto2"

CORES=$(nproc)

read -p "We need root permissions to install dependencies. Press any key to continue"

sudo apt install build-essential libltdl-dev libusb-dev libexif-dev libpopt-dev libudev-dev pkg-config git automake autoconf autopoint gettext libtool wget

if [ -d $LIBGPHOTO2_FOLDER ]
then
	echo "$LIBGPHOTO2_FOLDER already exists"	
else
	git clone git@github.com:jempe/libgphoto2.git $LIBGPHOTO2_FOLDER
fi

cd $LIBGPHOTO2_FOLDER

git checkout tags/$LIBGPHOTO2_RELEASE

autoreconf --install --symlink
./configure

make -j "$CORES"

read -p "We need root permissions to install libgphoto2. Press any key to continue"
sudo make install

if [ -d $GPHOTO2_FOLDER ]
then
	echo "$GPHOTO2_FOLDER already exists"	
else
	git clone git@github.com:jempe/gphoto2.git $GPHOTO2_FOLDER
fi

cd $GPHOTO2_FOLDER

git checkout tags/$PHOTO2_RELEASE

autoreconf --install --symlink
./configure

make -j "$CORES"

read -p "We need root permissions to install photo2. Press any key to continue"
sudo make install

