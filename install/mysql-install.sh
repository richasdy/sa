#!/bin/bash -e
clear

echo "============================================"
echo "Donni Richasdy Mysql Server Installation"
echo "============================================"


sudo apt-get update
sudo apt-get install mysql-server
sudo mysql_secure_installation
sudo mysql_install_db


cd ~

echo "========================="
echo "Installation is complete."
echo "========================================"
echo "copyright Donni Richasdy | richasdy.com"
echo "========================================"
echo "========================="

