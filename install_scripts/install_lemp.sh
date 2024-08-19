#!/bin/bash

# install mariadb nginx php7

if [[ $EUID -ne 0 ]]; then
	echo "You must be root to run this script." 1>&2
	exit 100
fi

sudo apt update

sudo apt install nginx mariadb-server php-mysql php-fpm php-cli php-xml php-gd

sudo mysql_secure_installation

PHPVERSION='7.2'

if grep -q "DISTRIB_RELEASE=20.04" /etc/lsb-release;
then
	PHPVERSION='7.4'

	echo "Ubuntu 20.04 detected, changing PHP version to $PHPVERSION"
fi

if grep -q "DISTRIB_RELEASE=24.04" /etc/lsb-release;
then
	PHPVERSION='8.3'

	echo "Ubuntu 24.04 detected, changing PHP version to $PHPVERSION"
fi

echo "Trying to fix CGI pathinfo vulnerability. Plese check that cgi.fix_pathinfo equals 0 in PHP info page"
sudo sed -i 's/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g' /etc/php/$PHPVERSION/fpm/php.ini

sudo systemctl restart php$PHPVERSION-fpm.service
