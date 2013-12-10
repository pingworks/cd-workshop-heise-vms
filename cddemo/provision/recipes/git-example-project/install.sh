#!/bin/bash
#
# please notice: all provisioning scripts have to be idempotent
#

. /vagrant/provision/config.sh
. /vagrant/provision/common.sh

set -e 
RECIPE='git-example-project'

echo "# -------------------------------------------------"
echo "# BEGIN Provisioning RECIPE $RECIPE"
echo "# -------------------------------------------------"

GIT_USER=git1

apt-get --yes install git

[ ! -d /srv/git-repo ] && mkdir /srv/git-repo
if [ -z "$(cat /etc/passwd | grep git-repo)" ];then
	useradd -d /srv/git-repo -M -s /usr/bin/git-shell -U $GIT_USER
	git config --system user.name "git-repo user"
	git config --system user.email "git@localhost"
	install -o $GIT_USER -g $GIT_USER -m 0700 -d /srv/git-repo/.ssh
	echo /home/$CONF_DUSER/.ssh/id_rsa.pub >> /srv/git-repo/.ssh/authorized_keys
fi

chown -R $GIT_USER.$GIT_USER /srv/git-repo
if [ ! -d /srv/git-repo/cd-workshop-heise-vms.git ];then
	sudo -u $GIT_USER git clone --bare https://github.com/pingworks/cd-workshop-heise.git /srv/git-repo/cd-workshop-heise.git
fi

echo "# -------------------------------------------------"
echo "# END Provisioning RECIPE $RECIPE"
echo "# -------------------------------------------------"