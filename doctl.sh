#digitalocean command line interface
#doctl

#user info + droplet limit
doctl account get

#list all droplet
doctl compute droplet list -o json

#list image
doctl compute image list -o json
#why your list is not display in doctl but in --trace?
#ubuntu server lts 
{
	"id": 27663881,
	"name": "16.04.3 x64",
	"distribution": "Ubuntu",
	"slug": "ubuntu-16-04-x64",
	"public": true,
	"regions": ["nyc1", "sfo1", "nyc2", "ams2", "sgp1", "lon1", "nyc3", "ams3", "fra1", "tor1", "sfo2", "blr1"],
	"created_at": "2017-09-08T14:33:39Z",
	"min_disk_size": 20,
	"type": "snapshot",
	"size_gigabytes": 0.35
},

#list region
doctl compute region list -o json

#list all size + price
doctl compute size list -o json

#list ssh key
doctl compute ssh-key list -o json

#list all firewall
doctl compute firewall list -o json


#single node
#create droplet
doctl compute droplet create ubuntu-512mb-sgp1-01 \
--size 512mb \
--image ubuntu-16-04-x64 \
--region sgp1 \
--ssh-keys 0c:f5:03:1d:45:d7:1a:0f:9d:2f:16:31:85:da:c9:d5
--tag-name telkom-demo \
--user-data-file install-hortonworks.sh
# --format ID,Name,PublicIPv4,PrivateIPv4,PublicIPv6,Memory,VCPUs,Disk,Region,Image,Status,Tags
# --format null,ubuntu-512mb-sgp1-master,PublicIPv4,PrivateIPv4,PublicIPv6,Memory,VCPUs,Disk,Region,Image,Status,Tags
--verbose

#master slave node
#create droplet master
doctl compute droplet create ubuntu-512mb-sgp1-master \
--size 512mb \
--image ubuntu-16-04-x64 \
--region sgp1 \
--ssh-keys 0c:f5:03:1d:45:d7:1a:0f:9d:2f:16:31:85:da:c9:d5
--tag-name telkom-demo \
--user-data-file install-hortonworks-master.sh

#create droplet slave
doctl compute droplet create [\
	"ubuntu-512mb-sgp1-slave-01",\
    "ubuntu-512mb-sgp1-slave-02",\
    "ubuntu-512mb-sgp1-slave-03",\
    "ubuntu-512mb-sgp1-slave-04"] \
--size 512mb \
--image ubuntu-16-04-x64 \
--region sgp1 \
--ssh-keys 0c:f5:03:1d:45:d7:1a:0f:9d:2f:16:31:85:da:c9:d5
--tag-name telkom-demo \
--user-data-file install-hortonworks-slave.sh


#delete droplet
#doctl compute droplet delete droplet_id/droplet_name
doctl compute droplet delete 123412341234

#do api
#create droplet
curl -X POST \
-H "Content-Type: application/json" \
-H "Authorization: Bearer b7d03a6947b217efb6f3ec3bd3504582" \
-d '{"name":"example.com","region":"nyc3","size":"512mb","image":"ubuntu-14-04-x64","ssh_keys":null,"backups":false,"ipv6":true,"user_data":null,"private_networking":null,"volumes": null,"tags":["web"]}' "https://api.digitalocean.com/v2/droplets"

#todo
#0 try image list with api
#1 try do user data + do user data file
#2 try do user data with doctl


#case study
#deploy hadoop cluster HORTONWORKS
#1 create 99 droplet with "doctl compute droplet create" and "user data file"? --> automatic install hortonworks?
#2 assign 1 droplet as master
#3 assigh other droplet as slave
#4 install hortonworks --> using ambary
#5 realtime indexing solr
#6 import data to hbase --> using flume? sqoop? --> data apa yang cukup besar?
#7 etl script to hive
#8 demo data analytics with pig
#9 demo in memery analytics --> congnito? massive paralel processing (mpp)

#1 private network?
#1 ssh key
#1 tag telkomdemo
#1 apply firewall?