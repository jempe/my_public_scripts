#!/bin/bash

# download golang source code
GOSOURCE_FOLDER=~/bin/go

if [ -d $GOSOURCE_FOLDER ];
then
	echo "Pulling latest golang changes"
	cd $GOSOURCE_FOLDER
	git pull
else
	echo "Cloning golang source code"
	git clone https://github.com/golang/go.git $GOSOURCE_FOLDER
fi


