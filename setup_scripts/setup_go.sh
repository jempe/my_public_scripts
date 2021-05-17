#!/bin/bash
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
	BASHRC_FILE=~/.bashrc
elif [[ "$OSTYPE" == "darwin"* ]]; then
	BASHRC_FILE=~/.zprofile
fi

GO_PATH=~/go

if [ -d $GO_PATH ];
then
	echo "$GO_PATH already exists"
else
	echo "creating $GO_PATH"

	mkdir -p $GO_PATH
fi

if grep -q "GOPATH=" "$BASHRC_FILE";
then
	echo "GOPATH variable already setup"
else
	echo "setting up go enviroment variables"
	echo " " >> $BASHRC_FILE
	echo "#GOLANG environment variables" >> $BASHRC_FILE

	if [[ "$OSTYPE" == "linux-gnu"* ]]; then
		echo 'export GOROOT=/opt/go' >> $BASHRC_FILE
		echo 'export PATH=$GOROOT/bin:$PATH' >> $BASHRC_FILE
	fi

	echo "export GOPATH=$GO_PATH" >> $BASHRC_FILE
	echo 'export GOBIN=$GOPATH/bin' >> $BASHRC_FILE
	echo 'export PATH=$PATH:$GOBIN' >> $BASHRC_FILE
fi

