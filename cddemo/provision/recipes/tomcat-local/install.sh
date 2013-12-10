#!/bin/bash
#
# please notice: all provisioning scripts have to be idempotent
#

. /vagrant/provision/config.sh
. /vagrant/provision/common.sh

set -e 
RECIPE='tomcat-local'

echo "# -------------------------------------------------"
echo "# BEGIN Provisioning RECIPE $RECIPE"
echo "# -------------------------------------------------"
TOMCAT_PKG=apache-tomcat-7.0.47.tar.gz

if [ ! -f /home/$CONF_DUSER/Downloads/$TOMCAT_PKG ];then
	[ ! -d  /home/$CONF_DUSER/Downloads ] && install -o $CONF_DUSER -g $CONF_DGROUP -m 0755 -d /home/$CONF_DUSER/Downloads
	wget -q "$CONF_VAGRANTREPO/archives/$TOMCAT_PKG" -O /home/$CONF_DUSER/Downloads/$TOMCAT_PKG
	chown $CONF_DUSER.$CONF_DUSER /home/$CONF_DUSER/Downloads/$TOMCAT_PKG
fi
install -o $CONF_DUSER -g $CONF_DGROUP -m 0755 -d /home/$CONF_DUSER/Apps

if [ ! -d /home/$CONF_DUSER/Apps/apache-tomcat-7.0.47 ];then
	cd /home/$CONF_DUSER/Apps
	sudo -u $CONF_DUSER tar xvfz /home/$CONF_DUSER/Downloads/$TOMCAT_PKG
fi

echo "# -------------------------------------------------"
echo "# END Provisioning RECIPE $RECIPE"
echo "# -------------------------------------------------"