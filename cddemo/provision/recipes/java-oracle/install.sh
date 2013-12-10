#!/bin/bash
#
# please notice: all provisioning scripts have to be idempotent
#

. /vagrant/provision/config.sh
. /vagrant/provision/common.sh

set -e 
RECIPE='java-oracle'

echo "# -------------------------------------------------"
echo "# BEGIN Provisioning RECIPE $RECIPE"
echo "# -------------------------------------------------"

ORACLE_JAVA_DEB=oracle-j2sdk1.7_1.7.0+update45_amd64.deb

[ ! -d /usr/local/src/oracle-java ] && mkdir /usr/local/src/oracle-java
if [ ! -f /usr/local/src/oracle-java/$ORACLE_JAVA_DEB ];then
	wget -q "$CONF_VAGRANTREPO/archives/$ORACLE_JAVA_DEB" -O /usr/local/src/oracle-java/$ORACLE_JAVA_DEB
fi

dpkg -i /usr/local/src/oracle-java/$ORACLE_JAVA_DEB

#ORACLE_JAVA_SRC=jdk-7u45-linux-x64.tar.gz
#apt-get --yes install java-package
# make-jpkg works only interactively so we can't use it here
#if [ ! -f /usr/local/src/oracle-java/$ORACLE_JAVA_SRC ];then
#  wget "$CONF_VAGRANTREPO/archives/$ORACLE_JAVA_SRC" -O /usr/local/src/oracle-java/$ORACLE_JAVA_SRC
#fi
#chmod 777 /usr/local/src/oracle-java/
#cd /usr/local/src/oracle-java/
#sudo -u $CONF_DUSER fakeroot make-jpkg $ORACLE_JAVA_SRC


echo "# -------------------------------------------------"
echo "# END Provisioning RECIPE $RECIPE"
echo "# -------------------------------------------------"