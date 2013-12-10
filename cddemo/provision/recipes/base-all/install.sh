#!/bin/bash
#
# please notice: all provisioning scripts have to be idempotent
#

. /vagrant/provision/config.sh
. /vagrant/provision/common.sh

set -e 
RECIPE='base-all'

echo "# -------------------------------------------------"
echo "# BEGIN Provisioning RECIPE $RECIPE"
echo "# -------------------------------------------------"

install -m 0644 $CONF_PHOME/recipes/$RECIPE/apt_sources.list /etc/apt/sources.list

apt-get update 
apt-get upgrade --yes 

echo "Europe/Berlin" > /etc/timezone

echo "Installing basic system tools..."
apt-get --yes install git less htop vim curl unzip ncdu telnet

echo
echo "Installing .vimrc for root and $CONF_DUSER..."
install -m 0644 $CONF_PHOME/recipes/$RECIPE/dot_vimrc /root/.vimrc
install -o $CONF_DUSER -g $CONF_DGROUP -m 0644 $CONF_PHOME/recipes/$RECIPE/dot_vimrc /home/$CONF_DUSER/.vimrc

if [ -z "$(grep 'EDITOR=vi' /home/$CONF_DUSER/.bashrc)" ];then
    echo "export EDITOR=vi" >> /home/$CONF_DUSER/.bashrc
fi
if [ -z "$(grep 'EDITOR=vi' /root/.bashrc)" ];then
    echo "export EDITOR=vi" >> /root/.bashrc
fi

if [ -z "$(cat /etc/ssh/sshd_config | grep UseDNS )" ];then
    echo "UseDNS no" >> /etc/ssh/sshd_config
fi

/etc/init.d/ssh restart

if [ ! -d /opt/${CONF_VM_PROVISIONING_MODULE}/.git ];then
	install -o $CONF_DUSER -g $CONF_DUSER -m 0755 -d /opt/${CONF_VM_PROVISIONING_MODULE}
	sudo -u $CONF_DUSER git clone $CONF_VM_PROVISIONING_MODULE_GITHUB_URL /opt/${CONF_VM_PROVISIONING_MODULE}
fi

echo "# -------------------------------------------------"
echo "# END Provisioning RECIPE $RECIPE"
echo "# -------------------------------------------------"