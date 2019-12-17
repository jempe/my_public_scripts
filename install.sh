#!/bin/bash

SCRIPTS_FOLDER=`pwd`

function install_help() {
	echo "install helper script"
	echo "Usage:"
	echo "./install.sh go"
	echo "	install golang"
	echo "./install.sh vim"
	echo "	install vim mercurial git meld"
	echo "./install.sh git"
	echo "	install git and git lfs support"
	echo "./install.sh qt"
	echo "	install qt (raspbian only)"
	echo "./install.sh adb"
	echo "	install adb (raspbian only)"
	echo "./install.sh nvidia"
	echo "	install nvidia drivers and cuda toolkit"
}

function install_git() {
	read -p "We need root permissions to proceed. Press any key to continue"

	sudo bash ./install_scripts/install_git_lfs.sh
}

function install_go() {
	read -p "We need root permissions to proceed. Press any key to continue"

	sudo bash ./install_scripts/install_golang.sh
}


COMMAND="$1"

case "$1" in
	go) shift;		install_go ;;
	vim) shift;		install_vim ;;
	git) shift;		install_git ;;
	qt) shift;		install_qt ;;
	adb) shift;		install_adb ;;
	nvidia) shift;		install_nvidia ;;
	*)		install_help ;;
esac

exit 0

