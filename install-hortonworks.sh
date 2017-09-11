#!/bin/bash


#FQDN : fully qualified domain name
hostname -f 

#​Prepare the Environment
#1. SET UP PASSWORD-LESS SSH

#@server host
ssh-keygen
#@target host
cat id_rsa.pub >> authorized_keys

#depend on ssh version
#@target host
chmod 700 ~/.ssh
chmod 600 ~/.ssh/authorized_keys

#@server host --> kasih flag yes? -y
ssh root@<remote.target.host>

#2. ENABLE NTP ON THE CLUSTER AND ON THE BROWSER HOST
#@server and target host
apt-get install ntp
update-rc.d ntp defaults

#3. CHECK DNS AND NSCD
# All hosts in your system must be configured for both forward and and reverse DNS.
# If you are unable to configure DNS in this way, you should edit the /etc/hosts file on every host in your cluster to contain the IP address and Fully Qualified Domain Name of each of your hosts
# it's highly recommended to use the Name Service Caching Daemon (NSCD) on cluster nodes running Linux

#4. ​CONFIGURING IPTABLES
#disable iptables during instalation, or certain ports must be open and available.
sudo iptables -X
sudo iptables -t nat -F
sudo iptables -t nat -X
sudo iptables -t mangle -F
sudo iptables -t mangle -X
sudo iptables -P INPUT ACCEPT
sudo iptables -P FORWARD ACCEPT
sudo iptables -P OUTPUT ACCEPT

#5. ​DISABLE SELINUX AND PACKAGEKIT AND CHECK THE UMASK VALUE
#@server and target host
#Note PackageKit is not enabled by default on Debian, SLES, or Ubuntu systems.

#temporary
umask 0022
#permanently
echo umask 0022 >> /etc/profile
# STEPS


#OBTAINING PUBLIC REPOSITORY
#Ambari
#Base URL	http://public-repo-1.hortonworks.com/ambari/ubuntu16/2.x/updates/2.5.2.0
#Repo File	http://public-repo-1.hortonworks.com/ambari/ubuntu16/2.x/updates/2.5.2.0/ambari.list
#Tarball md5 | asc	http://public-repo-1.hortonworks.com/ambari/ubuntu16/2.x/updates/2.5.2.0/ambari-2.5.2.0-ubuntu16.tar.gz

#HDP
#HDP-2.6.2.0	HDP	Version Definition File (VDF)	http://public-repo-1.hortonworks.com/HDP/ubuntu16/2.x/updates/2.6.2.0/HDP-2.6.2.0-205.xml
#HDP-2.6.2.0	HDP Base URL	http://public-repo-1.hortonworks.com/HDP/ubuntu16/2.x/updates/2.6.2.0/
#HDP-2.6.2.0	HDP Repo File	http://public-repo-1.hortonworks.com/HDP/ubuntu16/2.x/updates/2.6.2.0/hdp.list
#HDP-2.6.2.0	HDP Tarball md5 | asc	http://public-repo-1.hortonworks.com/HDP/ubuntu16/2.x/updates/2.6.2.0/HDP-2.6.2.0-ubuntu16-deb.tar.gz
#HDP-2.6.2.0 HDP-UTILS	Base URL	http://public-repo-1.hortonworks.com/HDP-UTILS-1.1.0.21/repos/ubuntu16
#HDP-2.6.2.0 Tarball md5 | asc	http://public-repo-1.hortonworks.com/HDP-UTILS-1.1.0.21/repos/ubuntu16/HDP-UTILS-1.1.0.21-ubuntu16.tar.gz

# 1. Log in to your host as root.

# 2. Download the Ambari repository file to a directory on your installation host.
wget -O /etc/apt/sources.list.d/ambari.list http://public-repo-1.hortonworks.com/ambari/ubuntu16/2.x/updates/2.5.2.0/ambari.list
apt-key adv --recv-keys --keyserver keyserver.ubuntu.com B9733A7A07513CAD
apt-get update

# 3. Confirm that Ambari packages downloaded successfully by checking the package name list. --> postgre available
apt-cache showpkg ambari-server
apt-cache showpkg ambari-agent
apt-cache showpkg ambari-metrics-assembly

# 4. ​Set Up the Ambari Server --> jdk install??
ambari-server setup