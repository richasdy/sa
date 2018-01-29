
echo "Installing tomcat7..."

# https://www.digitalocean.com/community/tutorials/how-to-install-apache-tomcat-7-on-ubuntu-14-04-via-apt-get
sudo apt-get install -y tomcat7

# edit /etc/default/tomcat7
# JAVA_OPTS="-Djava.security.egd=file:/dev/./urandom -Djava.awt.headless=true -Xmx512m -XX:MaxPermSize=256m -XX:+UseConcMarkSweepGC"
# service tomcat7 restart