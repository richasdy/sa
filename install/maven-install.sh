# DONE
echo "Installing maven..."

axel http://mirror.wanxp.id/apache/maven/maven-3/3.3.9/binaries/apache-maven-3.3.9-bin.tar.gz
tar xzvf apache-maven-3.3.9-bin.tar.gz
export PATH=~/apache-maven-3.3.9/bin/:$PATH