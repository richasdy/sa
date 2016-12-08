#!/bin/bash -e
clear
echo "============================================"
echo "Donni Richasdy Usergrid Installation"
echo "============================================"

echo "Installing java..."
# apt-get install -y default-jre
sudo add-apt-repository -y ppa:webupd8team/java
sudo apt-get update
sudo apt-get install -y oracle-java8-set-default

echo "Installing maven... OK"
echo "Installing tomcat7... OK"
echo "Installing elastic search...OK"
echo "Installing cassandra... NOT OK"

echo "Installing usergrid..."
