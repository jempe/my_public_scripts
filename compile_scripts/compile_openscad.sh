#!/bin/bash

# compile openscad

OPENSCAD_RELEASE="openscad-2019.05"

OPENSCAD_FOLDER="$HOME/bin/openscad"



if [ -d $OPENSCAD_FOLDER ];
then
	echo "$OPENSCAD_FOLDER already exists"	
else
	git clone git://github.com/openscad/openscad.git $OPENSCAD_FOLDER
fi

cd $OPENSCAD_FOLDER

git checkout tags/$OPENSCAD_RELEASE

git submodule update --init

read -p "We need root permissions to install dependencies. Press any key to continue"

sudo ./scripts/uni-get-dependencies.sh

./scripts/check-dependencies.sh

qmake openscad.pro

make

read -p "We need root permissions to install openscad. Press any key to continue"

sudo make install
