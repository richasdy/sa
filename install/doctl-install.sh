# https://github.com/digitalocean/doctl
# sesuaikan seri
cd ~
curl -OL https://github.com/digitalocean/doctl/releases/download/v1.7.0/doctl-1.7.0-linux-amd64.tar.gz
tar xf ~/doctl-1.7.0-linux-amd64.tar.gz
sudo mv ~/doctl /usr/local/bin
doctl auth init