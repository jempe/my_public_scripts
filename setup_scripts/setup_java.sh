#!/bin/bash
BASHRC_FILE=~/.bashrc

if grep -q "JAVA_HOME=" "$BASHRC_FILE";
then
	echo "JAVA_HOME variable already setup"
else
	echo "setting up java enviroment variables"
	echo " " >> $BASHRC_FILE
	echo "#JAVA environment variables" >> $BASHRC_FILE
	echo 'export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/' >> $BASHRC_FILE
fi

