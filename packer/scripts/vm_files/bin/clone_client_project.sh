#! /bin/bash

echo ***!!! This script will clone the Python and Postman code from git. Are you sure you want to do that? !!!***

read -p "If so, press any key to continue, or Ctrl-c to quit ... " -n1 -s

echo " "

# Git clone the ODL Learning Labs
mkdir -p /home/odldev/git
cd /home/odldev/git
git clone https://github.com/CiscoDevNet/cosc-learning-labs.git

read -p "Done. Press any key to continue... " -n1 -s
