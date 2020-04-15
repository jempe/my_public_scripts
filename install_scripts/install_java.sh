#!/bin/bash

# install java

if [[ $EUID -ne 0 ]]; then
	echo "You must be root to run this script." 1>&2
	exit 100
fi

apt install default-jdk
