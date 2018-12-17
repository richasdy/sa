#!/bin/bash
grep "multiverse" /etc/apt/sources.list
echo "deb http://archive.ubuntu.com/ubuntu/ xenial multiverse" | sudo tee -a /etc/apt/sources.list
sudo apt-get update
sudo apt-get dist-upgrade -y
sudo apt-get install haveged -y
wget https://ubuntu.bigbluebutton.org/repo/bigbluebutton.asc -O- | sudo apt-key add -
echo "deb https://ubuntu.bigbluebutton.org/xenial-110/ bigbluebutton-xenial main" | sudo tee /etc/apt/sources.list.d/bigbluebutton.list
sudo apt-get install bigbluebutton -y
sudo bbb-conf --restart
sudo bbb-conf --setip HOSTNAME
sudo bbb-conf --secret