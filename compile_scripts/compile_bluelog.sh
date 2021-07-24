#!/bin/bash

# compile bluelog

read -p "We need root permissions to proceed. Press any key to continue"

sudo apt update
sudo apt install git libbluetooth-dev

git clone https://github.com/MS3FGX/Bluelog.git

cd Bluelog

make

sudo make install
