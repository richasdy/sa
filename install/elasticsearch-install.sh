DONE

echo "Installing elastic search..."
# https://www.digitalocean.com/community/tutorials/how-to-install-and-configure-elasticsearch-on-ubuntu-14-04

axel https://download.elastic.co/elasticsearch/elasticsearch/elasticsearch-1.7.2.deb
sudo dpkg -i elasticsearch-1.7.2.deb
update-rc.d elasticsearch defaults


# for single node edit /etc/elasticsearch/elasticsearch.yml
# index.number_of_shards: 1
# index.number_of_replicas: 0
# network.bind_host: localhost

service elasticsearch start

