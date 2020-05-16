#!/bin/bash

WP_DIR=`pwd`"/wp"
UPLOADS_DIR="$WP_DIR/wp-content/uploads"


WP_LATEST_VERSION='5.4.1'

read -p "Do you want to install worpress in $WP_DIR (N/y)" INSTALL_RESPONSE

if [ "$INSTALL_RESPONSE" != "y" ];
then
	echo "Canceling installation"
	exit 100
fi

if [ -d $WP_DIR ];
then
        echo "$WP_DIR already exists, trying to update Wordpress"

	svn sw http://core.svn.wordpress.org/tags/$WP_LATEST_VERSION/ $WP_DIR 
else
	echo "Downloading Wordpress"

	svn co http://core.svn.wordpress.org/tags/$WP_LATEST_VERSION/ $WP_DIR

	cp $WP_DIR/wp-config-sample.php $WP_DIR/wp-config.php	

	mkdir -p $UPLOADS_DIR

	chmod 0700 $UPLOADS_DIR
	setfacl -m u:www-data:rwx $UPLOADS_DIR

	echo "Edit the file $WP_DIR/wp-config.php by following the instructions of https://wordpress.org/support/article/editing-wp-config-php/" 
fi
