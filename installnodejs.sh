# Bash
echo "Installing Node..."
cd ~
curl -sL https://deb.nodesource.com/setup_5.x -o nodesource_setup.sh
sudo -E bash ./nodesource_setup.sh
sudo apt-fast install -y nodejs build-essential git