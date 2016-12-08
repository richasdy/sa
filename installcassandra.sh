# error, service terminate imediately

echo "Installing cassandra..."

# https://www.digitalocean.com/community/tutorials/how-to-install-cassandra-and-run-a-single-node-cluster-on-ubuntu-14-04
echo "deb http://www.apache.org/dist/cassandra/debian 35x main" | sudo tee -a /etc/apt/sources.list.d/cassandra.sources.list
echo "deb-src http://www.apache.org/dist/cassandra/debian 35x main" | sudo tee -a /etc/apt/sources.list.d/cassandra.sources.list

# To avoid package signature warnings during package updates
# add the first key:
gpg --keyserver pgp.mit.edu --recv-keys F758CE318D77295D
gpg --export --armor F758CE318D77295D | sudo apt-key add -
# add the second key:
gpg --keyserver pgp.mit.edu --recv-keys 2B5C1B00
gpg --export --armor 2B5C1B00 | sudo apt-key add -
# add the third key:
gpg --keyserver pgp.mit.edu --recv-keys 0353B12C
gpg --export --armor 0353B12C | sudo apt-key add -

sudo apt-get update
sudo apt-get install -y cassandra

dpkg-buildpackage -uc -us

# edit /etc/init.d/cassandra
# CMD_PATT="cassandra"
# reboot


# /etc/cassandra.yaml
# start_rpc: true

# chmod 775 /var/lib/cassandra/data
# chmod 777 /var/lib/cassandra/data
# chmod 777 /var/lib/cassandra/commitlog
# chmod 777 /var/lib/cassandra/saved_caches
# chmod 777 /var/lib/cassandra/hints

# run cassandra from other user
