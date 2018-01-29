#!/bin/bash

#########################################
# Run via
#wget https://raw.github.com/owaaa/storm-install/master/storm_install.sh && chmod +x storm_install.sh && sudo ./storm_install.sh all <amazon internal ip> /opt
#########################################

pp() {
	echo -e "\e[00;32m"$1"\e[00m"
}

HOST=`hostname`

#########################################
# Clean up old installation.
#########################################

cleanup() {
	pp "Cleaning up previous installation..."
	rm -rf $BASEDIR
	mkdir $BASEDIR
	echo "#!/bin/bash" > $START_SH
	chmod +x $START_SH
	echo "#!/bin/bash" > $STOP_SH
	chmod +x $STOP_SH
}

#########################################
# System dependencies.
#########################################

deps() {
	pp "Checking system dependencies..."
	echo
	sudo yum install -y screen uuid-devel libuuid-devel git python libtool unzip
    ##Enable EPEL on Amazon
   # sed '0,/enabled=1/s/enabled=1/enabled=0/' /etc/yum.repos.d/epel.repo > /etc/yum.repos.d/epel.repo
   cat << EOF > /etc/yum.repos.d/epel.repo
[epel]
name=Extra Packages for Enterprise Linux 6 - \$basearch
mirrorlist=https://mirrors.fedoraproject.org/metalink?repo=epel-6&arch=\$basearch
failovermethod=priority
enabled=1
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-6

EOF

    sudo yum -y groupinstall "Development Tools"

    sudo yum -y install supervisor #need yum version first for service and other pieces
    sudo easy_install pip 
    sudo pip install supervisor --upgrade
    sudo chkconfig supervisord on
    sudo chmod 600 /etc/supervisord.conf
    
    if [ ! -f ./jdk-7u3-linux-x64.rpm ]; then
    echo "Installing Oracle JDK"

    wget --no-cookies --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2Ftechnetwork%2Fjava%2Fjavase%2Fdownloads%2Fjdk-7u3-download-1501626.html;" http://download.oracle.com/otn-pub/java/jdk/7u3-b04/jdk-7u3-linux-x64.rpm
    fi
    sudo rpm -ivh jdk-7u3-linux-x64.rpm
    sudo /usr/sbin/alternatives --install /usr/bin/java java /usr/java/jdk1.7.0_03/bin/java 20000
    sudo /usr/sbin/alternatives --set java /usr/java/jdk1.7.0_03/bin/java
    
    if grep --quiet JAVA_HOME /etc/profile; 
    then 
        echo JAVA_HOME already set;   
    else  
        sudo sh -c " echo 'export JAVA_HOME=/usr/java/jdk1.7.0_03/' >> /etc/profile" ;  
        sudo sh -c " echo 'export PATH=\$PATH:\$JAVA_HOME/bin' >> /etc/profile" ;
    fi
    source /etc/profile
    export JAVA_HOME=/usr/java/jdk1.7.0_03/
    export PATH=$PATH:$JAVA_HOME/bin
    
}

#########################################
# ZooKeeper.
#########################################

zookeeper() {
	if [ "$HOST" != "$NIMBUS" ]
	then
		pp "Skipping ZooKeeper installation on all hosts but nimbus!"
		return
	fi

	ZK_VERSION="3.3.6"
	ZK_DIR=$BASEDIR"/zookeeper"
	ZK_CONFIGFILE="zoo.conf"
	ZK_CONF=$ZK_DIR"/"$ZK_CONFIGFILE
	ZK_RUN=$ZK_DIR"/run"
	ZK_PURGE=$ZK_DIR"/purge.sh"
	ZK_DATADIR=$ZK_DIR"/data"
	ZK_TARBALL_URL="http://apache.openmirror.de/zookeeper/zookeeper-"$ZK_VERSION"/zookeeper-"$ZK_VERSION".tar.gz"
	ZK_TARBALL=$ZK_DIR/"zookeeper.tar.gz"
	ZK_INSTALLDIR=$ZK_DIR/"zookeeper-"$ZK_VERSION
    ZK_LOG="/var/log/zookeeper"

	pp "Installing ZooKeeper "$ZK_VERSION" on nimbus host '"$HOST"'..."

	mkdir $ZK_DIR &>/dev/null
	mkdir $ZK_DATADIR &>/dev/null
    mkdir $ZK_LOG >/dev/null

	pp "Downloading ZooKeeper..."

	wget $ZK_TARBALL_URL -q -O $ZK_TARBALL
	tar xzf $ZK_TARBALL -C $ZK_DIR
	rm $ZK_TARBALL

	pp "Configuring ZooKeeper..."

	# Cluster config.
	cat << EOF > $ZK_CONF
tickTime=2000
dataDir=$ZK_DATADIR
clientPort=2181
initLimit=5
syncLimit=2
server.1=$NIMBUS:2888:3888
EOF

	# This host's id.
	echo "1" > $ZK_DATADIR/myid

	# Run script.
	ZK_CP=$ZK_INSTALLDIR/zookeeper-$ZK_VERSION.jar:$ZK_INSTALLDIR/lib/log4j-1.2.15.jar:$ZK_INSTALLDIR/conf
    
    ZKRUN_CMD="java -Xmx1024M -Xms1024M -cp "$ZK_CP" org.apache.zookeeper.server.quorum.QuorumPeerMain   "$ZK_CONF
    export ZKRUN_CMD

	# Purge script to cleanup zookeeper log files.
	cat << EOF > $ZK_PURGE
mkdir $ZK_DIR/snap
java -cp $ZK_CP org.apache.zookeeper.server.PurgeTxnLog $ZK_DATADIR $ZK_DATADIR -n 3
rm -r $ZK_DIR/snap
EOF
	chmod +x $ZK_PURGE

	# Run purge.sh via cron job.
	echo "@hourly $ZK_PURGE" | crontab -

	# Update global start/stop scripts.
	echo "supervise $ZK_DIR &" >> $START_SH
	echo "svc -x $ZK_DIR" >> $STOP_SH
}

#########################################
# Storm dependency: ZeroMQ
#########################################

zeromq() {
	ZMQ_VERSION="2.1.7"
	ZMQ_DIR=$BASEDIR"/zeromq"
	ZMQ_TARBALL_URL="http://download.zeromq.org/zeromq-"$ZMQ_VERSION".tar.gz"
	ZMQ_TARBALL=$ZMQ_DIR"/zeromq.tar.gz"

	pp "Installing ZeroMQ "$ZMQ_VERSION" (storm dependency)..."
	mkdir $ZMQ_DIR

	pp "Downloading ZeroMQ..."
	wget $ZMQ_TARBALL_URL -q -O $ZMQ_TARBALL
	tar zxf $ZMQ_TARBALL -C $ZMQ_DIR
	rm $ZMQ_TARBALL

	pp "Compiling ZeroMQ..."
	echo
	pushd $ZMQ_DIR/zeromq-$ZMQ_VERSION
	./configure && make && sudo make install
	popd
	echo
}

#########################################
# Storm dependency 2: JZMQ,
# Java bindings for ZeroMQ.
#
# This is where things get tricky.
# Despite the warning on nathanmarz' page,
# we use mainline git here, as it compiles
# with the latest autoconf and libtool on
# Ubuntu 12.04.
#########################################

jzmq() {
	JZMQ_DIR=$BASEDIR"/jzmq"
	JZMQ_REPO="https://github.com/zeromq/jzmq.git"
	JZMQ_COMMIT="e2dd66"

	pp "Installing JZMQ (Java bindings for ZeroMQ) from Github..."

	git clone -q $JZMQ_REPO $JZMQ_DIR

	pp "Compiling JZMQ..."

	echo
	pushd $JZMQ_DIR
	git checkout $JZMQ_COMMIT
	./autogen.sh && ./configure --with-zeromq=/usr/local/lib && make && sudo make install
	popd
	echo
}

#########################################
# Storm itself.
#########################################

storm() {
	STORM_VERSION="0.8.3-wip3"
	STORM_DIR=$BASEDIR"/storm"
    STORM_ZIP_URL="https://www.dropbox.com/s/9682bqfez5vgejd/storm-"$STORM_VERSION".zip"
	#STORM_ZIP_URL="https://dl.dropboxusercontent.com/s/t8m516l2kadt7c6/storm-"$STORM_VERSION".zip"
	STORM_ZIP=$STORM_DIR"/storm.zip"
	STORM_INSTALLDIR=$STORM_DIR"/storm-"$STORM_VERSION
    STORM_BINDIR=$STORM_INSTALLDIR"/bin"
	STORM_DATADIR=$STORM_DIR"/data"
	STORM_CONF=$STORM_INSTALLDIR"/conf/storm.yaml"
	#STORM_RUN=$STORM_DIR"/run"
    STORM_LOG="/var/log/storm"
    SUPERVISOR_CONFIG="/etc/supervisord.conf"
    STORM_HOME="/app/home/storm"

	pp "Installing Storm "$STORM_VERSION"..."
	mkdir $STORM_DIR >/dev/null
	mkdir $STORM_DATADIR >/dev/null
    mkdir -p $STORM_LOG >/dev/null
    sudo mkdir -p $STORM_HOME >/dev/null
    
    sudo groupadd -g 53001 storm    
    sudo useradd -u 53001 -g 53001 -d $STORM_HOME -s /bin/bash storm -c "Storm service account"
    sudo chmod 700 $STORM_HOME
    sudo chage -I -1 -E -1 -m -1 -M -1 -W -1 -E -1 storm
    
	pp "Downloading Storm..."
	wget $STORM_ZIP_URL -q -O $STORM_ZIP
	unzip -qq $STORM_ZIP -d $STORM_DIR
	rm $STORM_ZIP

	pp "Configuring Storm..."
	echo "storm.local.dir: \""$STORM_DATADIR"\"" > $STORM_CONF
	echo "storm.zookeeper.servers:" >> $STORM_CONF
	echo " - \""$NIMBUS"\"" >> $STORM_CONF
	if [ "$HOST" != "$NIMBUS" ]
	then
		echo "nimbus.host: \""$NIMBUS"\"" >> $STORM_CONF
	fi
    
    sudo chown -R storm:storm $STORM_DIR
    sudo chown -R storm:storm $STORM_LOG
    sudo chown -R storm:storm $STORM_HOME
    sudo chmod 750 $STORM_HOME

	# Supervisor directories/scripts + global start/stop scripts.
	# Note: If we're NIMBUS, we run the 'nimbis' action instead.
	if [ "$HOST" = "$NIMBUS" ]; then 
    
    #Put storm under supervision
        cat << EOF > $SUPERVISOR_CONFIG
[unix_http_server]
file=/var/tmp/supervisor.sock ;
 
[supervisord]
logfile=/var/log/supervisor/supervisord.log 
logfile_maxbytes=50MB
logfile_backups=10
loglevel=info
pidfile=/var/run/supervisord.pid
nodaemon=false
minfds=1024
minprocs=200

[rpcinterface:supervisor]
supervisor.rpcinterface_factory = supervisor.rpcinterface:make_main_rpcinterface

[supervisorctl]
serverurl=unix:///var/tmp/supervisor.sock

[program:storm-nimbus]
command=$STORM_BINDIR/storm nimbus
user=storm
autostart=true
autorestart=true
startsecs=10
startretries=999
log_stdout=true
log_stderr=true
stdout_logfile=$STORM_LOG/nimbus.out
stdout_logfile_maxbytes=20MB
stdout_logfile_backups=10

[program:storm-ui]
command=$STORM_BINDIR/storm ui
user=storm
autostart=true
autorestart=true
startsecs=10
startretries=999
log_stdout=true
log_stderr=true
stdout_logfile=$STORM_LOG/ui.out
stdout_logfile_maxbytes=20MB
stdout_logfile_backups=10

[program:storm-supervisor]
command=$STORM_BINDIR/storm supervisor
user=storm
autostart=true
autorestart=true
startsecs=10
startretries=999
log_stdout=true
log_stderr=true
stdout_logfile=$STORM_LOG/supervisor.out
stdout_logfile_maxbytes=20MB
stdout_logfile_backups=10

[program:zookeeper]
command =$ZKRUN_CMD
stdout_logfile = $ZK_LOG/zookeeper.out
stderr_logfile = $ZK_LOG/zookeeper.err
autorestart = true
EOF
	
    else
    
cat << EOF > $SUPERVISOR_CONFIG
[unix_http_server]
file=/var/tmp/supervisor.sock ;

[supervisord]
logfile=/var/log/supervisor/supervisord.log 
logfile_maxbytes=50MB
logfile_backups=10
loglevel=info
pidfile=/var/run/supervisord.pid
nodaemon=false
minfds=1024
minprocs=200

[rpcinterface:supervisor]
supervisor.rpcinterface_factory = supervisor.rpcinterface:make_main_rpcinterface

[supervisorctl]
serverurl=unix:///var/tmp/supervisor.sock ;

[program:storm-supervisor]
command=$STORM_BINDIR/storm supervisor
user=storm
autostart=true
autorestart=true
startsecs=10
startretries=999
log_stdout=true
log_stderr=true
stdout_logfile=$STORM_LOG/supervisor.out
stdout_logfile_maxbytes=20MB
stdout_logfile_backups=10
EOF
    fi

    #sudo service supervisord start
}

#########################################
# Main app.
#########################################

PHASES=("cleanup" "deps" "zookeeper" "zeromq" "jzmq" "storm")

execute() {
	case "$1" in
	"0")
		cleanup
		;;
	"1")
		deps
		;;
	"2")
		zookeeper
		;;
	"3")
		zeromq
		;;
	"4")
		jzmq
		;;
	"5")
		storm
		;;
	esac
}

if [ $# -eq 3 ]
then

	NIMBUS=$2
	BASEDIR=$3
	START_SH=$BASEDIR"/start.sh"
	STOP_SH=$BASEDIR"/stop.sh"

	if [ "$1" = "all" ]
	then
		# Run everything.
		for ((p=0;p<${#PHASES[@]};p++))
		do
			execute $p
		done

		pp "Installation complete."
		pp "Be sure to carefully read the log."
		pp "Now, to run the storm cluster, use the 'sudo service supervisord start' to execute"
		pp "\t\$ "$START_SH
		pp "and detach from the screen session using Ctrl+A Ctrl+D."
	else
		execute $1

		pp "Phase installation complete."
	fi
else
	echo "Usage: ./install_storm <number_of_phase>/all <nimbus> <installdir>"
	echo "Phases:"
	for ((i=0;i<${#PHASES[@]};i++))
	do
		echo -e "\t"$i": "${PHASES[$i]}
	done
fi
