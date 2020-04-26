#!/bin/bash

# nginx should be already installed

# install php

sudo apt install mariadb-server php-mysql php-fpm php-zip php-curl php-gd php-xml php-mbstring php-bcmath

# folders that needs permissions
setfacl -R -m u:www-data:rwx storage/
