#!/bin/bash
BASHRC_FILE=~/.bashrc
GO_PATH=~/go

if [ -d $GO_PATH ];
then
	echo "$GO_PATH already exists"
else
	echo "creating $GO_PATH"

	mkdir -p $GO_PATH
fi

if grep -q "GOROOT=" "$BASHRC_FILE";
then
	echo "GOROOT variable already setup"
else
	echo "setting up go enviroment variables"
	echo " " >> $BASHRC_FILE
	echo "#GOLANG environment variables" >> $BASHRC_FILE
	echo 'export GOROOT=/opt/go' >> $BASHRC_FILE
	echo 'export PATH=$GOROOT/bin:$PATH' >> $BASHRC_FILE
	echo "export GOPATH=$GO_PATH" >> $BASHRC_FILE
	echo 'export GOBIN=$GOPATH/bin' >> $BASHRC_FILE
	echo 'export PATH=$PATH:$GOBIN' >> $BASHRC_FILE
fi

