#!/bin/bash -e
clear
echo "============================================"
echo "Donni Richasdy Parse Installation"
echo "============================================"

echo "Installing mongoDB..."
echo "Installing Node..."
echo "Installing Example Parse Server App..."
cd ~

# git clone https://github.com/ParsePlatform/parse-server-example.git
# cd ~/parse-server-example
# npm install
# npm start

sudo npm install -g parse-server mongodb-runner
sudo mongodb-runner start
parse-server --appId APPLICATION_ID --masterKey MASTER_KEY &

# parse dashboard harus https
# sudo npm install -g parse-dashboard
# parse-dashboard --appId APPLICATION_ID --masterKey MASTER_KEY --serverURL "http://localhost:1337/parse" --appName helloApp &