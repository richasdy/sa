#!/bin/bash -e
clear

echo "============================================"
echo "Donni Richasdy Basic Server Installation"
echo "============================================"


# create user

# primitive syntax
# useradd -m richasdy
# passwd richasdy
# adduser richasdy sudo

adduser richasdy
adduser richasdy sudo

# cat ~/.ssh/id_rsa.pub | ssh root@[your.ip.address.here] "cat >> ~/.ssh/authorized_keys"
# cat ~/richasdymbp | ssh richasdy@128.199.92.178 "cat >> ~/.ssh/authorized_keys"


cd ~

echo "========================="
echo "Installation is complete."
echo "========================================"
echo "copyright Donni Richasdy | richasdy.com"
echo "========================================"
echo "========================="

