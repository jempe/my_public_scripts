#!/bin/bash

# install latest go version

if [[ $EUID -ne 0 ]]; then
	echo "You must be root to run this script." 1>&2
	exit 100
fi

GITEA_LATEST_VERSION=1.12
GITEA_FOLDER=/opt/gitea
GITEA_VERSION_BIN=$GITEA_FOLDER$GITEA_LATEST_VERSION
GITEA_BIN=/usr/local/bin/gitea

# verify binary
#gpg --keyserver keys.openpgp.org --recv 7C9E68152594688862D62AF62D9AE806EC1592E2
#gpg --verify gitea-1.11.5-linux-amd64.asc gitea-1.11.5-linux-amd64

if [ -d $GITEA_VERSION_BIN ];
then
	echo "$GITEA_VERSION_BIN already exists"	
else
	COMPUTER_ARCH=`arch`

	GO_ARCH="NONE"

	if [ "$COMPUTER_ARCH" = "x86_64" ]; 
	then
		GO_ARCH="amd64"
	elif [ "$COMPUTER_ARCH" = "i686" ]; 
	then
		GO_ARCH="386"
	elif [ "$COMPUTER_ARCH" = "armv7l" ]; 
	then
		GO_ARCH="arm-6"
	elif [ "$COMPUTER_ARCH" = "aarch64" ]; 
	then
		GO_ARCH="arm64"
	fi

	if [ "$GO_ARCH" = "NONE" ];
	then
		echo "Unsupported Architecture. Can't install GO"
	else
		GITEA_DOWNLOAD_URL="https://dl.gitea.io/gitea/$GITEA_LATEST_VERSION/gitea-$GITEA_LATEST_VERSION-linux-$GO_ARCH"

		cd /tmp

		if [ -f "gitea" ];
		then
			echo "delete previous GITEA files"
			rm "gitea"
		fi

		wget -O gitea $GITEA_DOWNLOAD_URL && mv gitea $GITEA_VERSION_BIN

		chmod +x $GITEA_VERSION_BIN
	fi
fi

if [ -L $GITEA_BIN ];
then
	echo "removing $GITEA_BIN symlink"
	unlink $GITEA_BIN
fi

ln -s $GITEA_VERSION_BIN $GITEA_BIN

if grep -q git /etc/passwd;
then
	echo "git user already exists"
else
	adduser \
	   --system \
	   --shell /bin/bash \
	   --gecos 'Git Version Control' \
	   --group \
	   --disabled-password \
	   --home /home/git \
	   git

	#mkdir -p /var/lib/gitea/{custom,data,log}
	#chown -R git:git /var/lib/gitea/
	#chmod -R 750 /var/lib/gitea/
	#mkdir /etc/gitea
	#chown root:git /etc/gitea
	#chmod 770 /etc/gitea
fi


