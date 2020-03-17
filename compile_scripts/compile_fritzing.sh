#!/bin/bash

# compile fritzing

LIBGIT2_RELEASE="v0.28.4"
LIBGIT2_FOLDER="$HOME/bin/libgit2"

FRITZING_RELEASE="CD-498"
FRITZING_FOLDER="$HOME/bin/fritzing-app"

FRITZINGPARTS_RELEASE="0.9.3b"
FRITZINGPARTS_FOLDER="$HOME/bin/fritzing-parts"

if [ -d $FRITZING_FOLDER ];
then
	echo "$FRITZING_FOLDER already exists"	
else
	git clone git://github.com/fritzing/fritzing-app.git $FRITZING_FOLDER
fi

if [ -d $LIBGIT2_FOLDER ];
then
	echo "$LIBGIT2_FOLDER already exists"	
else
	git clone git://github.com/libgit2/libgit2.git $LIBGIT2_FOLDER
fi

if [ -d $LIBGIT2_FOLDER/build ];
then
	echo "$LIBGIT2_FOLDER/build already exists"	
else
	mkdir $LIBGIT2_FOLDER/build
fi



if [ -d $FRITZINGPARTS_FOLDER ];
then
	echo "$FRITZINGPARTS_FOLDER already exists"	
else
	git clone git://github.com/fritzing/fritzing-parts.git $FRITZINGPARTS_FOLDER
fi

read -p "We need root permissions to install libgit2 dependencies. Press any key to continue"
sudo apt install libssl-dev libgit2-26

cd $LIBGIT2_FOLDER
git checkout tags/$LIBGIT2_RELEASE

cd build
cmake -DOPENSSL_CRYPTO_LIBRARY=/usr/lib/x86_64-linux-gnu/libcrypto.so.1.1 -DOPENSSL_INCLUDE_DIR=/usr/include/openssl/ -DBUILD_SHARED_LIBS=OFF -DUSE_EXT_HTTP_PARSER=OFF ..
cmake --build .

cd $FRITZING_FOLDER
git checkout tags/$FRITZING_RELEASE

read -p "We need root permissions to install fritzing dependencies. Press any key to continue"
sudo apt install build-essential git cmake libssl-dev libudev-dev qt5-default libqt5serialport5-dev libqt5svg5-dev

sed -i 's/LIBGIT_STATIC = true/LIBGIT_STATIC = false/' phoenix.pro

qmake phoenix.pro
make

cd $FRITZINGPARTS_FOLDER

git checkout tags/$FRITZINGPARTS_RELEASE


#sudo apt install libqt5printsupport5 libqt5xml5 libqt5sql5 libqt5serialport5 libqt5sql5-sqlite
