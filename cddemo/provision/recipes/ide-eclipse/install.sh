#!/bin/bash
#
# please notice: all provisioning scripts have to be idempotent
#

. /vagrant/provision/config.sh
. /vagrant/provision/common.sh

set -e 
RECIPE='ide-eclipse'

echo "# -------------------------------------------------"
echo "# BEGIN Provisioning RECIPE $RECIPE"
echo "# -------------------------------------------------"

ECLIPSE_PKG=eclipse-jee-kepler-SR1-subversion-linux-gtk-x86_64.tar.gz

if [ ! -f /home/$CONF_DUSER/Downloads/$ECLIPSE_PKG ];then
	[ ! -d  /home/$CONF_DUSER/Downloads ] && install -o $CONF_DUSER -g $CONF_DGROUP -m 0755 -d /home/$CONF_DUSER/Downloads
	wget -q "$CONF_VAGRANTREPO/archives/$ECLIPSE_PKG" -O /home/$CONF_DUSER/Downloads/$ECLIPSE_PKG
	chown $CONF_DUSER.$CONF_DUSER /home/$CONF_DUSER/Downloads/$ECLIPSE_PKG
fi

install -o $CONF_DUSER -g $CONF_DGROUP -m 0755 -d /home/$CONF_DUSER/Apps
install -o $CONF_DUSER -g $CONF_DGROUP -m 0755 -d /home/$CONF_DUSER/workspace		

if [ ! -d /home/$CONF_DUSER/Apps/eclipse ];then
	cd /home/$CONF_DUSER/Apps
	sudo -u $CONF_DUSER tar xvfz /home/$CONF_DUSER/Downloads/$ECLIPSE_PKG
  
  cd /opt/${CONF_VM_PROVISIONING_MODULE}
	sudo -u $CONF_DUSER git pull
  
  [ -d /home/$CONF_DUSER/workspace/.metadata ] && rm -Rf /home/$CONF_DUSER/workspace/.metadata
  [ -d /home/$CONF_DUSER/workspace/Servers ] && rm -Rf /home/$CONF_DUSER/workspace/Servers
  ln -s /opt/${CONF_VM_PROVISIONING_MODULE}/${DEPLOY_ENV_HOSTNAME}/provision/recipes/$RECIPE/_metadata /home/$CONF_DUSER/workspace/.metadata
  ln -s /opt/${CONF_VM_PROVISIONING_MODULE}/${DEPLOY_ENV_HOSTNAME}/provision/recipes/$RECIPE/Servers /home/$CONF_DUSER/workspace/Servers
fi

echo "# -------------------------------------------------"
echo "# END Provisioning RECIPE $RECIPE"
echo "# -------------------------------------------------"