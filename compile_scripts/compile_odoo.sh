#!/bin/bash

# compile odoo

sudo apt install postgresql git python3-dev python3-pip build-essential libxslt-dev libzip-dev libldap2-dev libsasl2-dev libssl-dev libpq-dev libjpeg-dev

wget https://raw.githubusercontent.com/odoo/odoo/12.0/requirements.txt

sudo -H pip3 install -r requirements.txt

sudo adduser --disabled-password --gecos "Odoo" odoo
sudo su -c "createuser odoo" postgres
sudo su -c "createdb --owner=odoo odoo-prod" postgres

sudo su -c "git clone https://github.com/odoo/odoo.git /home/odoo/odoo-12 -b 12.0 --depth=1"
sudo su -c "~/odoo-12/odoo-bin -d odoo-prod --db-filter='^odoo-prod$' --without-demo=all -i base --save --stop-after-init" odoo

sudo mkdir /etc/odoo
sudo cp /home/odoo/.odoorc /etc/odoo/odoo.conf
sudo chown -R odoo /etc/odoo
sudo chmod u=r,g=rw,o=r /etc/odoo/odoo.conf

sudo mkdir /var/log/odoo
sudo chown odoo /var/log/odoo

sudo sed -i 's/admin_passwd\s*=\s*.*/admin_passwd = False/' /etc/odoo/odoo.conf
sudo sed -i 's/list_db = True/list_db = False/' /etc/odoo/odoo.conf
sudo sed -i 's/logfile = None/logfile = \/var\/log\/odoo\/odoo-server.log/' /etc/odoo/odoo.conf
sudo sed -i 's/proxy_mode = False/proxy_mode = True/' /etc/odoo/odoo.conf
sudo sed -i 's/workers = 0/workers = 6/' /etc/odoo/odoo.conf

sudo cp odoo.service /lib/systemd/system/odoo.service
sudo systemctl enable odoo.service
