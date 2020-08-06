#!/bin/bash

# install latest raspberry pi tools version

RPITOOLS_REPO="https://github.com/raspberrypi/tools"
RPITOOLS_DIR="$HOME/bin/rpitools"

if [ -d $RPITOOLS_DIR ];
then
	echo "Updating tools"
	cd $RPITOOLS_DIR
	git pull
else
	mkdir -p $HOME/bin

	echo "downloading tools"
	git clone $RPITOOLS_REPO $RPITOOLS_DIR
fi

echo "Tools are located in $RPITOOLS_DIR/arm-bcm2708/gcc-linaro-arm-linux-gnueabihf-raspbian/bin Please add it to your path"
