#!/bin/bash
#
# please notice: all provisioning scripts have to be idempotent
#

. /vagrant/provision/config.sh
. /vagrant/provision/common.sh

set -e 
RECIPE='x-desktop'

echo "# -------------------------------------------------"
echo "# BEGIN Provisioning RECIPE $RECIPE"
echo "# -------------------------------------------------"

#apt-get update 

echo
echo "Installing XFCE Desktop..."
apt-get --yes install task-xfce-desktop

/etc/init.d/lightdm start

cd /opt/${CONF_VM_PROVISIONING_MODULE}
sudo -u $CONF_DUSER git pull

cd /home/$CONF_DUSER
[ -d /home/$CONF_DUSER/.config.old ] && rm -Rf /home/$CONF_DUSER/.config.old
[ -d /home/$CONF_DUSER/.config ] && mv /home/$CONF_DUSER/.config /home/$CONF_DUSER/.config.old
[ -L /home/$CONF_DUSER/.config ] && rm /home/$CONF_DUSER/.config
ln -s /opt/${CONF_VM_PROVISIONING_MODULE}/${DEPLOY_ENV_HOSTNAME}/$CONF_PHOME/recipes/$RECIPE/_config /home/$CONF_DUSER/.config

echo "# -------------------------------------------------"
echo "# END Provisioning RECIPE $RECIPE"
echo "# -------------------------------------------------"