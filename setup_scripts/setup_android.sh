#!/bin/bash
BASHRC_FILE=~/.bashrc
ANDROID_SDK=/opt/android-sdk

if grep -q "ANDROID_HOME=" "$BASHRC_FILE";
then
	echo "ANDROID_HOME variable already setup"
else
	echo "setting up android enviroment variables"
	echo " " >> $BASHRC_FILE
	echo "#ANDROID environment variables" >> $BASHRC_FILE
	echo "export PATH=$ANDROID_SDK/platform-tools:\$PATH" >> $BASHRC_FILE
	echo "export ANDROID_HOME=$ANDROID_SDK/" >> $BASHRC_FILE
	echo "export ANDROID_NDK_HOME=$ANDROID_SDK/ndk/21.0.6113669/" >> $BASHRC_FILE
fi

