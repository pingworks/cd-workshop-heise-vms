#!/bin/bash
#
# please notice: all provisioning scripts have to be idempotent
#

. /vagrant/provision/config.sh
. /vagrant/provision/common.sh

set -e 
RECIPE='subversion-example-project'

echo "# -------------------------------------------------"
echo "# BEGIN Provisioning RECIPE $RECIPE"
echo "# -------------------------------------------------"

apt-get --yes install apache2-mpm-worker subversion libapache2-svn git rsync

if [ -z "$(grep 'SVNServerConfig' /etc/apache2/mods-available/dav_svn.conf )" ];then
	cat $CONF_PHOME/recipes/$RECIPE/apache2_mods-avail_dav_svn.conf >> /etc/apache2/mods-available/dav_svn.conf
fi
a2enmod dav_svn

htpasswd -bc /etc/apache2/dav_svn.passwd $CONF_DUSER $CONF_DUSER
/etc/init.d/apache2 restart

[ ! -d /srv/svn-repo ] && mkdir /srv/svn-repo
chown www-data.www-data /srv/svn-repo/	
	
if [ ! -d /srv/svn-repo/musicDB ];then
	svnadmin create --fs-type fsfs /srv/svn-repo/musicDB
  chown -R www-data.www-data /srv/svn-repo/	
  		
	[ -d /tmp/tmp.checkout ] && rm -R /tmp/tmp.checkout
	sudo -u $CONF_DUSER mkdir /tmp/tmp.checkout
	sudo -u $CONF_DUSER svn co --username $CONF_DUSER --password $CONF_DUSER --non-interactive http://cddemo/svn/musicDB /tmp/tmp.checkout/musicDB
	sudo -u $CONF_DUSER mkdir /tmp/tmp.checkout/musicDB/{trunk,branches,tags}
	sudo -u $CONF_DUSER svn add /tmp/tmp.checkout/musicDB/{trunk,branches,tags}
	sudo -u $CONF_DUSER svn ci --username $CONF_DUSER --password $CONF_DUSER --non-interactive -m 'default svn folders' /tmp/tmp.checkout/musicDB/{trunk,branches,tags}
		
	if [ ! -d /opt/cd-workshop-heise/.git ];then
		mkdir -p /opt/cd-workshop-heise
		chown $CONF_DUSER.$CONF_DGROUP /opt/cd-workshop-heise
		sudo -u $CONF_DUSER git clone $CONF_GITHUB_EXAMPLE_PROJECT_URL /opt/cd-workshop-heise
	fi
	
	sudo -u $CONF_DUSER rsync -avx /opt/cd-workshop-heise/musicDB/ /tmp/tmp.checkout/musicDB/trunk/
	sudo -u $CONF_DUSER svn add /tmp/tmp.checkout/musicDB/trunk/*
	sudo -u $CONF_DUSER svn ci --username $CONF_DUSER --password $CONF_DUSER -m 'initial import' /tmp/tmp.checkout/musicDB/{trunk,branches,tags}
		
fi 



echo "# -------------------------------------------------"
echo "# END Provisioning RECIPE $RECIPE"
echo "# -------------------------------------------------"