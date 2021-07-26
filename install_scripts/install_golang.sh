#!/bin/bash

# install latest go version

if [[ $EUID -ne 0 ]]; then
	echo "You must be root to run this script." 1>&2
	exit 100
fi

GO_LATEST_VERSION=1.16.6
GOROOT_FOLDER=/opt/go
GOROOT_VERSION_FOLDER=$GOROOT_FOLDER$GO_LATEST_VERSION

if [ -d $GOROOT_VERSION_FOLDER ];
then
	echo "$GOROOT_VERSION_FOLDER already exists"	
else
	COMPUTER_ARCH=`arch`

	GO_ARCH="NONE"

	if [ "$COMPUTER_ARCH" = "x86_64" ]; 
	then
		GO_ARCH="amd64"
	elif [ "$COMPUTER_ARCH" = "i686" ]; 
	then
		GO_ARCH="386"
	elif [ "$COMPUTER_ARCH" = "armv6l" ]; 
	then
		GO_ARCH="armv6l"
	elif [ "$COMPUTER_ARCH" = "armv7l" ]; 
	then
		GO_ARCH="armv6l"
	elif [ "$COMPUTER_ARCH" = "aarch64" ]; 
	then
		GO_ARCH="arm64"
	fi

	if [ "$GO_ARCH" = "NONE" ];
	then
		echo "Unsupported Architecture. Can't install GO"
	else
		GO_DOWNLOAD_URL="https://dl.google.com/go/go$GO_LATEST_VERSION.linux-$GO_ARCH.tar.gz"

		cd /tmp

		if [ -f "go$GO_LATEST_VERSION.linux-$GO_ARCH.tar.gz" ];
		then
			echo "delete previous GO files"
			rm "go$GO_LATEST_VERSION.linux-$GO_ARCH.tar.gz"
		fi

		wget $GO_DOWNLOAD_URL && tar -xvf "go$GO_LATEST_VERSION.linux-$GO_ARCH.tar.gz" && mv go $GOROOT_VERSION_FOLDER
	fi
fi

if [ -L $GOROOT_FOLDER ];
then
	echo "removing $GOROOT_FOLDER symlink"
	unlink $GOROOT_FOLDER
fi

ln -s $GOROOT_VERSION_FOLDER $GOROOT_FOLDER

