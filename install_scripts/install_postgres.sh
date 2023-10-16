#!/bin/bash

# install postgresql

if [[ $EUID -ne 0 ]]; then
	echo "You must be root to run this script." 1>&2
	exit 100
fi

sudo apt update

sudo apt install postgresql postgresql-contrib

#CREATE THE user and db with the command

#sudo -u postgres createuser --interactive
#sudo -u postgres createdb username

#set password for username with the command
#psql
#then type the query
#ALTER ROLE username WITH PASSWORD 'userpass';
#logout from psql with the command
#\q
